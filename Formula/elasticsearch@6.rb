class ElasticsearchAT6 < Formula
  desc "Distributed search & analytics engine"
  homepage "https://www.elastic.co/products/elasticsearch"
  url "https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-oss-6.8.11.tar.gz"
  sha256 "2d136743072ca810f1af982f1c5a270b9fcc970be923ca1ee967aa7b9836cd3e"
  license "Apache-2.0"

  bottle do
    cellar :any_skip_relocation
    sha256 "216e813f6a02fd87a7eb8fc19052cf99c7c6357a5977c5d15f35edbecfed5625" => :catalina
    sha256 "dccf4a7e06e585eb81769211286ee183bc34721338970389a7adf29e8d910f5a" => :mojave
    sha256 "dccf4a7e06e585eb81769211286ee183bc34721338970389a7adf29e8d910f5a" => :high_sierra
  end

  keg_only :versioned_formula

  depends_on java: "1.8"

  def cluster_name
    "elasticsearch_#{ENV["USER"]}"
  end

  def install
    if build.head?
      # Build the package from source
      system "gradle", "clean", ":distribution:tar:assemble"
      # Extract the package to the tar directory
      mkdir "tar"
      cd "tar"
      system "tar", "--strip-components=1", "-xf",
        Dir["../distribution/tar/build/distributions/elasticsearch-*.tar.gz"].first
    end

    # Remove Windows files
    rm_f Dir["bin/*.bat"]
    rm_f Dir["bin/*.exe"]

    # Install everything else into package directory
    libexec.install "bin", "config", "lib", "modules"

    inreplace libexec/"bin/elasticsearch-env",
              "if [ -z \"$ES_PATH_CONF\" ]; then ES_PATH_CONF=\"$ES_HOME\"/config; fi",
              "if [ -z \"$ES_PATH_CONF\" ]; then ES_PATH_CONF=\"#{etc}/elasticsearch\"; fi"

    # Set up Elasticsearch for local development:
    inreplace "#{libexec}/config/elasticsearch.yml" do |s|
      # 1. Give the cluster a unique name
      s.gsub!(/#\s*cluster\.name: .*/, "cluster.name: #{cluster_name}")

      # 2. Configure paths
      s.sub!(%r{#\s*path\.data: /path/to.+$}, "path.data: #{var}/lib/elasticsearch/")
      s.sub!(%r{#\s*path\.logs: /path/to.+$}, "path.logs: #{var}/log/elasticsearch/")
    end

    # Move config files into etc
    (etc/"elasticsearch").install Dir[libexec/"config/*"]
    (libexec/"config").rmtree

    bin.install libexec/"bin/elasticsearch",
                libexec/"bin/elasticsearch-keystore",
                libexec/"bin/elasticsearch-plugin",
                libexec/"bin/elasticsearch-translog"
    bin.env_script_all_files(libexec/"bin", Language::Java.java_home_env("1.8"))
  end

  def post_install
    # Make sure runtime directories exist
    (var/"lib/elasticsearch").mkpath
    (var/"log/elasticsearch").mkpath
    ln_s etc/"elasticsearch", libexec/"config" unless (libexec/"config").exist?
    (var/"elasticsearch/plugins").mkpath
    ln_s var/"elasticsearch/plugins", libexec/"plugins" unless (libexec/"plugins").exist?
    # fix test not being able to create keystore because of sandbox permissions
    system bin/"elasticsearch-keystore", "create" unless (etc/"elasticsearch/elasticsearch.keystore").exist?
  end

  def caveats
    <<~EOS
      Data:    #{var}/lib/elasticsearch/
      Logs:    #{var}/log/elasticsearch/#{cluster_name}.log
      Plugins: #{var}/elasticsearch/plugins/
      Config:  #{etc}/elasticsearch/
    EOS
  end

  plist_options manual: "elasticsearch"

  def plist
    <<~EOS
      <?xml version="1.0" encoding="UTF-8"?>
      <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
      <plist version="1.0">
        <dict>
          <key>KeepAlive</key>
          <false/>
          <key>Label</key>
          <string>#{plist_name}</string>
          <key>ProgramArguments</key>
          <array>
            <string>#{opt_bin}/elasticsearch</string>
          </array>
          <key>EnvironmentVariables</key>
          <dict>
          </dict>
          <key>RunAtLoad</key>
          <true/>
          <key>WorkingDirectory</key>
          <string>#{var}</string>
          <key>StandardErrorPath</key>
          <string>#{var}/log/elasticsearch.log</string>
          <key>StandardOutPath</key>
          <string>#{var}/log/elasticsearch.log</string>
        </dict>
      </plist>
    EOS
  end

  test do
    assert_includes(stable.url, "-oss-")

    port = free_port
    system "#{bin}/elasticsearch-plugin", "list"
    pid = testpath/"pid"
    begin
      system "#{bin}/elasticsearch", "-d", "-p", pid, "-Epath.data=#{testpath}/data", "-Ehttp.port=#{port}"
      sleep 10
      system "curl", "-XGET", "localhost:#{port}/"
    ensure
      Process.kill(9, pid.read.to_i)
    end

    port = free_port
    (testpath/"config/elasticsearch.yml").write <<~EOS
      path.data: #{testpath}/data
      path.logs: #{testpath}/logs
      node.name: test-es-path-conf
      http.port: #{port}
    EOS

    cp etc/"elasticsearch/jvm.options", "config"
    cp etc/"elasticsearch/log4j2.properties", "config"

    ENV["ES_PATH_CONF"] = testpath/"config"
    pid = testpath/"pid"
    begin
      system "#{bin}/elasticsearch", "-d", "-p", pid
      sleep 10
      system "curl", "-XGET", "localhost:#{port}/"
      output = shell_output("curl -s -XGET localhost:#{port}/_cat/nodes")
      assert_match "test-es-path-conf", output
    ensure
      Process.kill(9, pid.read.to_i)
    end
  end
end
