class Nghttp2 < Formula
  desc "HTTP/2 C Library"
  homepage "https://nghttp2.org/"
  url "https://github.com/nghttp2/nghttp2/releases/download/v1.39.1/nghttp2-1.39.1.tar.xz"
  sha256 "679160766401f474731fd60c3aca095f88451e3cc4709b72306e4c34cf981448"

  bottle do
    sha256 "927d1c581966fc68c3c69c4a165b3f406d83fa1048dd870d6eeb55d16b92d7d9" => :mojave
    sha256 "7e2b180ce21aa6e93255bb70175f112a06d4e1d89216eb3ef9df8a542c6b9ed7" => :high_sierra
    sha256 "91de55238ea6571f6059507684827549da393e026b6f0e528a25ca3954a7fb39" => :sierra
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
  depends_on "openssl"

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

