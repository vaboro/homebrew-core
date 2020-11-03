class Traefik < Formula
  desc "Modern reverse proxy"
  homepage "https://traefik.io/"
<<<<<<< HEAD
<<<<<<< HEAD
<<<<<<< HEAD
  url "https://github.com/containous/traefik/releases/download/v1.7.13/traefik-v1.7.13.src.tar.gz"
  version "1.7.13"
  sha256 "d607f42431e6a3738786ade53052066018fbbb3c9fe8383e288e7343148ce655"
=======
  url "https://github.com/containous/traefik/releases/download/v1.7.14/traefik-v1.7.14.src.tar.gz"
  version "1.7.14"
  sha256 "a2454381b4a6720f3190ec720b90a21b82a709b70aa550aff8e502f2cae7c6ea"
>>>>>>> upstream/master
=======
  url "https://github.com/containous/traefik/releases/download/v2.0.1/traefik-v2.0.1.src.tar.gz"
  version "2.0.1"
  sha256 "5f0101f5cec6c132f612083d4e4307050fbdcf9cdf4c8059fcc1ea9e5148063e"
>>>>>>> upstream/master
=======
  url "https://github.com/containous/traefik/releases/download/v2.2.11/traefik-v2.2.11.src.tar.gz"
  sha256 "7948a2f875cb8091c73d32d2dd6fe6de40be53edd092dad718b49e41f2ca7702"
  license "MIT"
>>>>>>> upstream/master
  head "https://github.com/containous/traefik.git"

  bottle do
    cellar :any_skip_relocation
<<<<<<< HEAD
<<<<<<< HEAD
<<<<<<< HEAD
    sha256 "238572d445eea3775b44b96ffc75446096d58befc51f26a0009746747ab06aee" => :mojave
    sha256 "3f338f58265c04b93f39f6c7d6fb27246423afb9fa726041bb1bcc8a659940ad" => :high_sierra
    sha256 "d43370175a0f423c94aed791cf82542166d39a6a9bbd01671bc7ff2f90a57bcb" => :sierra
=======
    sha256 "745aa9c190ae49ee9eceee5868b306b74f05d6ebaf040fe9cd92d007809abdb3" => :mojave
    sha256 "36400009cd9f4462eb3ec44fc3d42920c2eb4984aaa83f4200bd2033eb4f267f" => :high_sierra
    sha256 "1ad3204de9e585c5babf576213291c7c4ce5575bb81dd53fe90edadb9d3fbe60" => :sierra
>>>>>>> upstream/master
=======
    sha256 "1c029ac472b0798961a2a46d00998eeb9f32d9cda8ed7166ef8e27efe16c0165" => :catalina
    sha256 "d6abe6a4bcecb01efc4ff8ad24da2624696597a49c16f6a6b78478a1a53c5a1f" => :mojave
    sha256 "5d264b7d19babc536e83abfabce4f051b2cd624a7ad74175d0d9ccd79db632d7" => :high_sierra
>>>>>>> upstream/master
=======
    rebuild 1
    sha256 "a7d2e00dcd6111b1cbcc878868968b0b9f236193fca9ec553d84769933a64161" => :catalina
    sha256 "d8b2309947014160bcb600e208eedf320d0f1efece4e10251a362f65a9d72c08" => :mojave
    sha256 "35990a9c1fe18a78cef64ce17146faf25b4f068640d42b95a2e72ca0788f3086" => :high_sierra
>>>>>>> upstream/master
  end

  depends_on "go" => :build
  depends_on "go-bindata" => :build

  def install
    system "go", "generate"
    system "go", "build",
      "-ldflags", "-s -w -X github.com/containous/traefik/v#{version.major}/pkg/version.Version=#{version}",
      "-trimpath", "-o", bin/"traefik", "./cmd/traefik"
  end

  plist_options manual: "traefik"

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
    ui_port = free_port
    http_port = free_port

    (testpath/"traefik.toml").write <<~EOS
      [entryPoints]
        [entryPoints.http]
          address = ":#{http_port}"
        [entryPoints.traefik]
          address = ":#{ui_port}"
      [api]
        insecure = true
        dashboard = true
    EOS

    begin
      pid = fork do
        exec bin/"traefik", "--configfile=#{testpath}/traefik.toml"
      end
      sleep 5
      cmd_ui = "curl -sIm3 -XGET http://127.0.0.1:#{http_port}/"
      assert_match /404 Not Found/m, shell_output(cmd_ui)
      sleep 1
      cmd_ui = "curl -sIm3 -XGET http://127.0.0.1:#{ui_port}/dashboard/"
      assert_match /200 OK/m, shell_output(cmd_ui)
    ensure
      Process.kill(9, pid)
      Process.wait(pid)
    end

    assert_match version.to_s, shell_output("#{bin}/traefik version 2>&1")
  end
end
