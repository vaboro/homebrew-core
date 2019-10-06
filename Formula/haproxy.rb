class Haproxy < Formula
  desc "Reliable, high performance TCP/HTTP load balancer"
  homepage "https://www.haproxy.org/"
<<<<<<< HEAD
<<<<<<< HEAD
  url "https://www.haproxy.org/download/2.0/src/haproxy-2.0.4.tar.gz"
  sha256 "e2680696032c8b957cd26fd948fff239d2cfc17b00964e6d2dc5adf8155fcef1"

  bottle do
    cellar :any
    sha256 "c8556b54a53a351f40108c70f95422fd1f3df37ec73bb21537d390f7fdbf114d" => :mojave
    sha256 "c0143d9e9757a8cafd87e1c26b9b86f5628d95db5f16dbb810bff061647b5e22" => :high_sierra
    sha256 "6846003f9d4788e46a6c564882f0ca84abb1e3eb77e20f402f4706c6fc83cdb9" => :sierra
=======
  url "https://www.haproxy.org/download/2.0/src/haproxy-2.0.5.tar.gz"
  sha256 "3f2e0d40af66dd6df1dc2f6055d3de106ba62836d77b4c2e497a82a4bdbc5422"
  revision 1

  bottle do
    cellar :any
    sha256 "f656d34d07291a6738c647c9fdc07019ceeadeed3841c81d9604442bd527880e" => :mojave
    sha256 "6b2d7abae3dc8ccbd2d997d9966bd2086f37d38e3948456271c54b103c7ef5b8" => :high_sierra
    sha256 "93820d418a650dae699163f547940cb9c116287a385cc4fce54bf4f1651498b3" => :sierra
>>>>>>> upstream/master
=======
  url "https://www.haproxy.org/download/2.0/src/haproxy-2.0.7.tar.gz"
  sha256 "3873cd72028ed1bd2506dd174e01a92620e92683092f34234c96e067dcb113dc"

  bottle do
    cellar :any
    sha256 "7d173ed59879d255c5bb8aef347caf75c6246b8203198c02e121175988fc2140" => :catalina
    sha256 "7cbb2a35dfcc612a1c1ee5b0236a5427c87c4d76cb340f84e43c240a4d57c5e7" => :mojave
    sha256 "a5f0c4b210ad14a0d4e3882560b7a78e4c5566f60f4914e1bbbcb4d1768d24d4" => :high_sierra
>>>>>>> upstream/master
  end

  depends_on "openssl@1.1"
  depends_on "pcre"

  def install
    args = %w[
      TARGET=generic
      USE_KQUEUE=1
      USE_POLL=1
      USE_PCRE=1
      USE_OPENSSL=1
      USE_THREAD=1
      USE_ZLIB=1
      ADDLIB=-lcrypto
    ]

    # We build generic since the Makefile.osx doesn't appear to work
    system "make", "CC=#{ENV.cc}", "CFLAGS=#{ENV.cflags}", "LDFLAGS=#{ENV.ldflags}", *args
    man1.install "doc/haproxy.1"
    bin.install "haproxy"
  end

  plist_options :manual => "haproxy -f #{HOMEBREW_PREFIX}/etc/haproxy.cfg"

  def plist; <<~EOS
    <?xml version="1.0" encoding="UTF-8"?>
    <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
    <plist version="1.0">
      <dict>
        <key>Label</key>
        <string>#{plist_name}</string>
        <key>KeepAlive</key>
        <true/>
        <key>ProgramArguments</key>
        <array>
          <string>#{opt_bin}/haproxy</string>
          <string>-f</string>
          <string>#{etc}/haproxy.cfg</string>
        </array>
        <key>StandardErrorPath</key>
        <string>#{var}/log/haproxy.log</string>
        <key>StandardOutPath</key>
        <string>#{var}/log/haproxy.log</string>
      </dict>
    </plist>
  EOS
  end

  test do
    system bin/"haproxy", "-v"
  end
end
