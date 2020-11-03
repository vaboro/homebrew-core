class Ola < Formula
  desc "Open Lighting Architecture for lighting control information"
  homepage "https://www.openlighting.org/ola/"
  url "https://github.com/OpenLightingProject/ola/releases/download/0.10.7/ola-0.10.7.tar.gz"
  sha256 "8a65242d95e0622a3553df498e0db323a13e99eeb1accc63a8a2ca8913ab31a0"
  license "GPL-2.0"
  revision 4
  head "https://github.com/OpenLightingProject/ola.git"

  bottle do
    sha256 "350f7200c8bf51cc0d71e6088142a14104b4574f1968faa61acf3a0fa56ac267" => :catalina
    sha256 "56e441f86ce6fc1a13281ceed57d02083704f68a5cbae19df80ac96e9f685f2e" => :mojave
    sha256 "27661bfe7dcc570ba2eee7fc92be48c8bb740daed4aa4e7a4dfda395a141c99f" => :high_sierra
  end

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "libtool" => :build
  depends_on "pkg-config" => :build
  depends_on "liblo"
  depends_on "libmicrohttpd"
  depends_on "libusb"
  depends_on "numpy"
  depends_on "protobuf@3.6"
  depends_on "python@3.8"

  # remove in version 0.11
  patch do
    url "https://raw.githubusercontent.com/macports/macports-ports/89b697d200c7112839e8f2472cd2ff8dfa6509de/net/ola/files/patch-protobuf3.diff"
    sha256 "bbbcb5952b0bdcd01083cef92b72a747d3adbe7ca9e50d865a0c69ae31a8fb4a"
  end

  def install
    xy = Language::Python.major_minor_version Formula["python@3.8"].bin/"python3"
    protobuf_pth = Formula["protobuf@3.6"].opt_lib/"python#{xy}/site-packages/homebrew-protobuf.pth"
    (buildpath/".brew_home/Library/Python/#{xy}/lib/python/site-packages").install_symlink protobuf_pth

    args = %W[
      --disable-fatal-warnings
      --disable-dependency-tracking
      --disable-silent-rules
      --prefix=#{prefix}
      --disable-unittests
      --enable-python-libs
      --enable-rdm-tests
    ]

    ENV["PYTHON"] = Formula["python@3.8"].bin/"python3"
    system "autoreconf", "-fvi"
    system "./configure", *args
    system "make", "install"
  end

  test do
    system bin/"ola_plugin_info"
  end
end
