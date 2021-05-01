class Beansdb < Formula
  desc "Yet another distributed key-value storage system"
  homepage "https://github.com/douban/beansdb"
  url "https://github.com/douban/beansdb/archive/v0.7.1.4.tar.gz"
  sha256 "c89f267484dd47bab272b985ba0a9b9196ca63a9201fdf86963b8ed04f52ccdb"
  license "BSD-3-Clause"
  head "https://github.com/douban/beansdb.git"

  bottle do
    sha256 cellar: :any_skip_relocation, catalina:    "9838cb03ef9bdaa895e5ceddeb32be9d3895d8f2d055394cce822e6c44262ee7"
    sha256 cellar: :any_skip_relocation, mojave:      "895c915b759be757dede0375aaf5abaf05a0f5f981d869c6c61367645fd2a564"
    sha256 cellar: :any_skip_relocation, high_sierra: "a8afd6d03a43a317c306f1de555edc6f804ddb4798ab88d93d9cfb3705887d8f"
    sha256 cellar: :any_skip_relocation, sierra:      "0c93cb38fd445baab2c301b3cb76ce0b6c7af9d3e879113d4c78bf761756bc08"
    sha256 cellar: :any_skip_relocation, el_capitan:  "5bb5311949ba21cde40848d1c1f58cf3317d8e8d604d3d0590dab2e9953a5ece"
    sha256 cellar: :any_skip_relocation, yosemite:    "e3c0bfa02e012ef1b0935fe13be8286dce080e8898b6519f5bf8c886ea77b9bc"
  end

  depends_on "autoconf" => :build
  depends_on "automake" => :build

  def install
    system "./autogen.sh"
    system "./configure", "--disable-dependency-tracking", "--prefix=#{prefix}"
    system "make"
    system "make", "install"

    (var/"db/beansdb").mkpath
    (var/"log").mkpath
  end

  plist_options manual: "beansdb"

  def plist
    <<~EOS
      <?xml version="1.0" encoding="UTF-8"?>
      <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
      <plist version="1.0">
      <dict>
        <key>KeepAlive</key>
        <dict>
          <key>SuccessfulExit</key>
          <false/>
        </dict>
        <key>Label</key>
        <string>#{plist_name}</string>
        <key>ProgramArguments</key>
        <array>
          <string>#{opt_bin}/beansdb</string>
          <string>-p</string>
          <string>7900</string>
          <string>-H</string>
          <string>#{var}/db/beansdb</string>
          <string>-T</string>
          <string>1</string>
          <string>-vv</string>
        </array>
        <key>RunAtLoad</key>
        <true/>
        <key>WorkingDirectory</key>
        <string>#{var}</string>
        <key>StandardErrorPath</key>
        <string>#{var}/log/beansdb.log</string>
        <key>StandardOutPath</key>
        <string>#{var}/log/beansdb.log</string>
      </dict>
      </plist>
    EOS
  end

  test do
    system "#{bin}/beansdb", "-h"
  end
end
