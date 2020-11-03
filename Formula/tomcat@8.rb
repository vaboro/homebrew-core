class TomcatAT8 < Formula
  desc "Implementation of Java Servlet and JavaServer Pages"
  homepage "https://tomcat.apache.org/"
<<<<<<< HEAD
<<<<<<< HEAD
<<<<<<< HEAD
  url "https://www.apache.org/dyn/closer.cgi?path=tomcat/tomcat-8/v8.5.43/bin/apache-tomcat-8.5.43.tar.gz"
  sha256 "5352ab0cc4b6e71caf9161da8c4316e9cd8691bc9f5ac3e8d8b3d259ca2bae03"
=======
  url "https://www.apache.org/dyn/closer.cgi?path=tomcat/tomcat-8/v8.5.45/bin/apache-tomcat-8.5.45.tar.gz"
  sha256 "d9b58d12979243fba01bbbbb33c140c8593940c005ec9acef1b2f54ce9b3d0fc"
>>>>>>> upstream/master
=======
  url "https://www.apache.org/dyn/closer.cgi?path=tomcat/tomcat-8/v8.5.46/bin/apache-tomcat-8.5.46.tar.gz"
  sha256 "adbab85f95662bada9330a4ac4d2e89250444b19bf09c17eda608717a895b136"
>>>>>>> upstream/master
=======
  url "https://www.apache.org/dyn/closer.lua?path=tomcat/tomcat-8/v8.5.57/bin/apache-tomcat-8.5.57.tar.gz"
  mirror "https://archive.apache.org/dist/tomcat/tomcat-8/v8.5.57/bin/apache-tomcat-8.5.57.tar.gz"
  sha256 "2615839daf1899cd705f9b82f2df6bd21adb29a93a05afdea0a6192ce54025c4"
  license "Apache-2.0"

  livecheck do
    url :stable
  end
>>>>>>> upstream/master

  bottle :unneeded

  keg_only :versioned_formula

  depends_on "openjdk"

  def install
    # Remove Windows scripts
    rm_rf Dir["bin/*.bat"]

    # Install files
    prefix.install %w[NOTICE LICENSE RELEASE-NOTES RUNNING.txt]
    libexec.install Dir["*"]
    (bin/"catalina").write_env_script "#{libexec}/bin/catalina.sh", JAVA_HOME: Formula["openjdk"].opt_prefix
  end

  plist_options manual: "catalina run"

  def plist
    <<~EOS
      <?xml version="1.0" encoding="UTF-8"?>
      <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
      <plist version="1.0">
        <dict>
          <key>Disabled</key>
          <false/>
          <key>Label</key>
          <string>#{plist_name}</string>
          <key>ProgramArguments</key>
          <array>
            <string>#{opt_bin}/catalina</string>
            <string>run</string>
          </array>
          <key>KeepAlive</key>
          <true/>
        </dict>
      </plist>
    EOS
  end

  test do
    ENV["CATALINA_BASE"] = testpath
    cp_r Dir["#{libexec}/*"], testpath
    rm Dir["#{libexec}/logs/*"]

    pid = fork do
      exec bin/"catalina", "start"
    end
    sleep 3
    begin
      system bin/"catalina", "stop"
    ensure
      Process.wait pid
    end
    assert_predicate testpath/"logs/catalina.out", :exist?
  end
end
