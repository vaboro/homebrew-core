class Rtags < Formula
  desc "Source code cross-referencer like ctags with a clang frontend"
  homepage "https://github.com/Andersbakken/rtags"
  url "https://github.com/Andersbakken/rtags.git",
      :tag      => "v2.33",
      :revision => "a5fa0951c92b4e5423d4ce95adafdca6ea30f254"
  revision 1
  head "https://github.com/Andersbakken/rtags.git"

  bottle do
    cellar :any
    sha256 "683daa433515422da4e4d05c19b3d135aa89ddc596b2be9cde40636c40ca165b" => :mojave
    sha256 "10a6ba5305f4706a33508c0c59274c26bc8b2367053e640e2a446fa884874a67" => :high_sierra
    sha256 "75c330a355842b1b3b30cde4e02424529b57c05c117d2dc8dbb65b3db070e1ff" => :sierra
  end

  depends_on "cmake" => :build
  depends_on "emacs"
  depends_on "llvm"
  depends_on "openssl@1.1"

  def install
    # Homebrew llvm libc++.dylib doesn't correctly reexport libc++abi
    ENV.append("LDFLAGS", "-lc++abi")

    args = std_cmake_args << "-DRTAGS_NO_BUILD_CLANG=ON"

    if MacOS.version == "10.11" && MacOS::Xcode.version >= "8.0"
      args << "-DHAVE_CLOCK_MONOTONIC_RAW:INTERNAL=0"
      args << "-DHAVE_CLOCK_MONOTONIC:INTERNAL=0"
    end

    mkdir "build" do
      system "cmake", "..", *args
      system "make"
      system "make", "install"
    end
  end

  plist_options :manual => "#{HOMEBREW_PREFIX}/bin/rdm --verbose --inactivity-timeout=300 --log-file=#{HOMEBREW_PREFIX}/var/log/rtags.log"

  def plist; <<~EOS
    <?xml version="1.0" encoding="UTF-8"?>
    <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
    <plist version="1.0">
    <dict>
      <key>Label</key>
      <string>#{plist_name}</string>
      <key>ProgramArguments</key>
      <array>
        <string>#{bin}/rdm</string>
        <string>--verbose</string>
        <string>--launchd</string>
        <string>--inactivity-timeout=300</string>
        <string>--log-file=#{var}/log/rtags.log</string>
      </array>
      <key>Sockets</key>
      <dict>
        <key>Listener</key>
        <dict>
          <key>SockPathName</key>
          <string>#{ENV["HOME"]}/.rdm</string>
        </dict>
      </dict>
    </dict>
    </plist>
  EOS
  end

  test do
    mkpath testpath/"src"
    (testpath/"src/foo.c").write <<~EOS
      void zaphod() {
      }

      void beeblebrox() {
        zaphod();
      }
    EOS
    (testpath/"src/README").write <<~EOS
      42
    EOS

    rdm = fork do
      $stdout.reopen("/dev/null")
      $stderr.reopen("/dev/null")
      exec "#{bin}/rdm", "--exclude-filter=\"\"", "-L", "log"
    end

    begin
      sleep 1
      pipe_output("#{bin}/rc -c", "clang -c #{testpath}/src/foo.c", 0)
      sleep 1
      assert_match "foo.c:1:6", shell_output("#{bin}/rc -f #{testpath}/src/foo.c:5:3")
      system "#{bin}/rc", "-q"
    ensure
      Process.kill 9, rdm
      Process.wait rdm
    end
  end
end
