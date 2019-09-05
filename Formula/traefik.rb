class Traefik < Formula
  desc "Modern reverse proxy"
  homepage "https://traefik.io/"
<<<<<<< HEAD
  url "https://github.com/containous/traefik/releases/download/v1.7.13/traefik-v1.7.13.src.tar.gz"
  version "1.7.13"
  sha256 "d607f42431e6a3738786ade53052066018fbbb3c9fe8383e288e7343148ce655"
=======
  url "https://github.com/containous/traefik/releases/download/v1.7.14/traefik-v1.7.14.src.tar.gz"
  version "1.7.14"
  sha256 "a2454381b4a6720f3190ec720b90a21b82a709b70aa550aff8e502f2cae7c6ea"
>>>>>>> upstream/master
  head "https://github.com/containous/traefik.git"

  bottle do
    cellar :any_skip_relocation
<<<<<<< HEAD
    sha256 "238572d445eea3775b44b96ffc75446096d58befc51f26a0009746747ab06aee" => :mojave
    sha256 "3f338f58265c04b93f39f6c7d6fb27246423afb9fa726041bb1bcc8a659940ad" => :high_sierra
    sha256 "d43370175a0f423c94aed791cf82542166d39a6a9bbd01671bc7ff2f90a57bcb" => :sierra
=======
    sha256 "745aa9c190ae49ee9eceee5868b306b74f05d6ebaf040fe9cd92d007809abdb3" => :mojave
    sha256 "36400009cd9f4462eb3ec44fc3d42920c2eb4984aaa83f4200bd2033eb4f267f" => :high_sierra
    sha256 "1ad3204de9e585c5babf576213291c7c4ce5575bb81dd53fe90edadb9d3fbe60" => :sierra
>>>>>>> upstream/master
  end

  depends_on "go" => :build
  depends_on "go-bindata" => :build
  depends_on "node" => :build
  depends_on "yarn" => :build

  def install
    ENV["GOPATH"] = buildpath
    (buildpath/"src/github.com/containous/traefik").install buildpath.children

    cd "src/github.com/containous/traefik" do
      cd "webui" do
        system "yarn", "upgrade"
        system "yarn", "install"
        system "yarn", "run", "build"
      end
      system "go", "generate"
      system "go", "build", "-o", bin/"traefik", "./cmd/traefik"
      prefix.install_metafiles
    end
  end

  plist_options :manual => "traefik"

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
            <string>#{opt_bin}/traefik</string>
            <string>--configfile=#{etc/"traefik/traefik.toml"}</string>
          </array>
          <key>EnvironmentVariables</key>
          <dict>
          </dict>
          <key>RunAtLoad</key>
          <true/>
          <key>WorkingDirectory</key>
          <string>#{var}</string>
          <key>StandardErrorPath</key>
          <string>#{var}/log/traefik.log</string>
          <key>StandardOutPath</key>
          <string>#{var}/log/traefik.log</string>
        </dict>
      </plist>
    EOS
  end

  test do
    require "socket"

    web_server = TCPServer.new(0)
    http_server = TCPServer.new(0)
    web_port = web_server.addr[1]
    http_port = http_server.addr[1]
    web_server.close
    http_server.close

    (testpath/"traefik.toml").write <<~EOS
      [web]
      address = ":#{web_port}"

      [entryPoints.http]
      address = ":#{http_port}"
    EOS

    begin
      pid = fork do
        exec bin/"traefik", "--configfile=#{testpath}/traefik.toml"
      end
      sleep 5
      cmd = "curl -sIm3 -XGET http://localhost:#{web_port}/dashboard/"
      assert_match /200 OK/m, shell_output(cmd)
    ensure
      Process.kill("HUP", pid)
    end
  end
end
