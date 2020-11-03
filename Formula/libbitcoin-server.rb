class LibbitcoinServer < Formula
  desc "Bitcoin Full Node and Query Server"
  homepage "https://github.com/libbitcoin/libbitcoin-server"
  url "https://github.com/libbitcoin/libbitcoin-server/archive/v3.6.0.tar.gz"
<<<<<<< HEAD
  sha256 "7280e6995f2a2123356e8ee6a5913f4a5fa6d0fd473ff2277145e55ba7104920"

  bottle do
    sha256 "6aeaa77667d55c81618fae9f326036a8e748141cb542c8896d8030e9b9fd1a9e" => :mojave
    sha256 "0bc088ef96cbf8e0278a0eea4936ffda9ce94ad0190d72c4da34e8a4d578f35a" => :high_sierra
    sha256 "b14ca3951d8b5cd6d7285302c04932ed31d92e6eb822abfdc3300d8a2e72d4b0" => :sierra
=======
  sha256 "283fa7572fcde70a488c93e8298e57f7f9a8e8403e209ac232549b2c433674e1"
  license "AGPL-3.0"
  revision 4

  bottle do
<<<<<<< HEAD
<<<<<<< HEAD
    sha256 "4c9b616832fa7083b809ef912a5c147a298ed5b1e9cc3dcb6080f881c39ad4f2" => :mojave
    sha256 "5df6c725d671fcc589104afddd0cc7f20368ed12593a98978193acf3f190410f" => :high_sierra
    sha256 "07e5cb2e67e3cf0248eeaa6efc17cac7c6bf1ed4639c3c50b24d854321e79f0a" => :sierra
>>>>>>> upstream/master
=======
    sha256 "89f68bb7f63d8607fedf7d43ef649cb9dea5e3aeed46de0761f3490ec6438e85" => :mojave
    sha256 "a41b76159482bb9e10e6a43f1b63ccbbdf9cd8330334918c4961a095a849d74b" => :high_sierra
    sha256 "be860f7ccc38400930cd9995a03e38f3ea3c3ce6d5fca54410941c92cd71c7e3" => :sierra
>>>>>>> upstream/master
=======
    sha256 "2a5f06eaeb8ad0cb95f121186d7a9799846c1723628af1c6fce8da0478bc20ce" => :catalina
    sha256 "6ec0f8733b2abcbfaba25768d0b712d77e5bfe35244c11d76ab6dcf670fc53ec" => :mojave
    sha256 "99a9628d248e7cce8c4fd5ec3f8379a61be0f5d84254897de1509a58e835e82e" => :high_sierra
>>>>>>> upstream/master
  end

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "libtool" => :build
  depends_on "pkg-config" => :build
  depends_on "libbitcoin-node"
  depends_on "libbitcoin-protocol"

  def install
    ENV.prepend_path "PKG_CONFIG_PATH", Formula["libbitcoin"].opt_libexec/"lib/pkgconfig"

    system "./autogen.sh"
    system "./configure", "--disable-dependency-tracking",
                          "--disable-silent-rules",
                          "--prefix=#{prefix}"
    system "make", "install"

    bash_completion.install "data/bs"
  end

  test do
    (testpath/"test.cpp").write <<~EOS
      #include <bitcoin/server.hpp>
      int main() {
          libbitcoin::server::message message(true);
          assert(message.secure() == true);
          return 0;
      }
    EOS
    system ENV.cxx, "-std=c++11", "test.cpp", "-o", "test",
                    "-L#{Formula["libbitcoin"].opt_lib}", "-lbitcoin",
                    "-L#{lib}", "-lbitcoin-server",
                    "-L#{Formula["boost"].opt_lib}", "-lboost_system"
    system "./test"
  end
end
