class TigerVnc < Formula
  desc "High-performance, platform-neutral implementation of VNC"
  homepage "https://tigervnc.org/"
  url "https://github.com/TigerVNC/tigervnc/archive/v1.11.0.tar.gz"
  sha256 "3648eca472a92a4e8fe55b27cd397b1bf16bad0b24a3a1988661f44553f5e2c3"
  license "GPL-2.0-or-later"

  bottle do
    sha256 "b9a09483c45610c81dd29fc20a41b4fa8120e1353f736bb637732d4788e4bb28" => :catalina
    sha256 "c90bdf1ac012129c5d4caecd3e5acf2d110ca8cd68a8bcff6de07373149424db" => :mojave
    sha256 "2370d829c67ca1df886e47aca162c68034e138a10a93b846c31f1c927d84c435" => :high_sierra
  end

  depends_on "cmake" => :build
  depends_on "fltk"
  depends_on "gettext"
  depends_on "gnutls"
  depends_on "jpeg-turbo"
  depends_on "pixman"
  depends_on :x11

  def install
    turbo = Formula["jpeg-turbo"]
    args = std_cmake_args + %W[
      -DJPEG_INCLUDE_DIR=#{turbo.include}
      -DJPEG_LIBRARY=#{turbo.lib}/libjpeg.dylib
      .
    ]
    system "cmake", *args
    system "make", "install"
  end

  test do
    output = shell_output("#{bin}/vncviewer -h 2>&1", 1)
    assert_match "TigerVNC Viewer 64-bit v#{version}", output
  end
end
