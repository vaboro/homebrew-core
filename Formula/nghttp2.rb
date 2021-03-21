class Nghttp2 < Formula
  desc "HTTP/2 C Library"
  homepage "https://nghttp2.org/"
  url "https://github.com/nghttp2/nghttp2/releases/download/v1.41.0/nghttp2-1.41.0.tar.xz"
  sha256 "abc25b8dc601f5b3fefe084ce50fcbdc63e3385621bee0cbfa7b57f9ec3e67c2"
  license "MIT"
  revision 1

  bottle do
    sha256 "ae423161fb662dbd308578a9d20917392ee019878eb59e39779ab7e852b3fd21" => :catalina
    sha256 "2f79858dc2901da2c314468d39b07506f10c9d8f543a95308f8610f2f00888a4" => :mojave
    sha256 "34f66d7f13b502faa96a34cf936710ed8910e7d789d430eaeb452d011a0842df" => :high_sierra
  end

  head do
    url "https://github.com/nghttp2/nghttp2.git"

    depends_on "autoconf" => :build
    depends_on "automake" => :build
    depends_on "libtool" => :build
  end

  depends_on "cunit" => :build
  depends_on "pkg-config" => :build
  depends_on "sphinx-doc" => :build
  depends_on "c-ares"
  depends_on "jansson"
  depends_on "jemalloc"
  depends_on "libev"
  depends_on "libevent"
  depends_on "openssl@1.1"

  patch :DATA

  def install
    ENV.cxx11

    args = %W[
      --prefix=#{prefix}
      --disable-silent-rules
      --enable-app
      --disable-python-bindings
      --with-xml-prefix=/usr
    ]

    # requires thread-local storage features only available in 10.11+
    args << "--disable-threads" if MacOS.version < :el_capitan

    system "autoreconf", "-ivf" if build.head?
    system "./configure", *args
    system "make"
    system "make", "check"
    system "make", "install"
  end

  test do
    system bin/"nghttp", "-nv", "https://nghttp2.org"
  end
end

__END__
diff --git a/src/shrpx_client_handler.cc b/src/shrpx_client_handler.cc
index 6266c5f..3c5946e 100644
--- a/src/shrpx_client_handler.cc
+++ b/src/shrpx_client_handler.cc
@@ -994,7 +994,7 @@ ClientHandler::get_downstream_connection(int &err, Downstream *downstream) {
   auto http2session = get_http2_session(group, addr);
   auto dconn = std::make_unique<Http2DownstreamConnection>(http2session);
   dconn->set_client_handler(this);
-  return dconn;
+  return std::move(dconn);
 }
 
 MemchunkPool *ClientHandler::get_mcpool() { return worker_->get_mcpool(); }

