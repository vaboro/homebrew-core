class X11vnc < Formula
  desc "VNC server for real X displays"
  homepage "https://github.com/LibVNC/x11vnc"
  url "https://github.com/LibVNC/x11vnc/archive/0.9.16.tar.gz"
  sha256 "885e5b5f5f25eec6f9e4a1e8be3d0ac71a686331ee1cfb442dba391111bd32bd"
  license "GPL-2.0"

  bottle do
    sha256 cellar: :any, catalina:    "66ddb190e2e2a183ba662d4c7ac2de508b6ebe3c3c827078a5eec5b550477e5e"
    sha256 cellar: :any, mojave:      "cd3d5d0047a8fb2e7b66ac94baf08c2da16aa8e135b8180acacce2d1bf366e58"
    sha256 cellar: :any, high_sierra: "2660aa48f9545eef71c5a42f9985720629d0391eaef37155264ec4c71cf13b29"
    sha256 cellar: :any, sierra:      "4e974a6cbc6bd9c03e90ed2f991a40c4589489ccbd01bd20552bf0a66773f924"
  end

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "pkg-config" => :build
  depends_on "libvncserver"
  depends_on "openssl@1.1"

  def install
    ENV.prepend_path "PKG_CONFIG_PATH", Formula["openssl@1.1"].opt_lib/"pkgconfig"

    args = %W[
      --disable-dependency-tracking
      --prefix=#{prefix}
      --mandir=#{man}
      --without-x
    ]

    system "./autogen.sh", *args
    system "make", "install"
  end

  test do
    system bin/"x11vnc", "--version"
  end
end
