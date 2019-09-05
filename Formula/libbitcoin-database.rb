class LibbitcoinDatabase < Formula
  desc "Bitcoin High Performance Blockchain Database"
  homepage "https://github.com/libbitcoin/libbitcoin-database"
  url "https://github.com/libbitcoin/libbitcoin-database/archive/v3.6.0.tar.gz"
<<<<<<< HEAD
  sha256 "2f60bdd96fb811e500858a4cee0008eb9b8f3ba9ac3a1ec6b010f01d4b38547f"

  bottle do
    cellar :any
    sha256 "29ca252dfe19a99afe8c51eae0304ddee0285579dd3ce087632e833640ab3ead" => :mojave
    sha256 "6f74f21f6d8929dbb0b7aa5aa6f1bac17249f8b5f5088bcd2ec0ce67954c36b3" => :high_sierra
    sha256 "0f1606469d75448c54f64822dea7670f5b0e7de71bdb423f9c2f6a93222bfd45" => :sierra
=======
  sha256 "d65b35745091b93feed61c5665b5a07b404b578e2582640e93c1a01f6b746f5a"
  revision 1

  bottle do
    cellar :any
    sha256 "fe18418b3e78225ccddb6cfe254472203fe738eb3a017be989a8d946591dea06" => :mojave
    sha256 "bc255c8b65b73c1b3d8f88deb484501287f39ff72513f6ea5e12d5ac6e494b8e" => :high_sierra
    sha256 "8d9e51707d54aa7df20b81602dc489bcea2d851416d9187ba9f297ced969123b" => :sierra
>>>>>>> upstream/master
  end

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "libtool" => :build
  depends_on "pkg-config" => :build
  depends_on "libbitcoin"

  def install
    ENV.prepend_path "PKG_CONFIG_PATH", Formula["libbitcoin"].opt_libexec/"lib/pkgconfig"

    system "./autogen.sh"
    system "./configure", "--disable-dependency-tracking",
                          "--disable-silent-rules",
                          "--prefix=#{prefix}"
    system "make", "install"
  end

  test do
    (testpath/"test.cpp").write <<~EOS
      #include <bitcoin/database.hpp>
      using namespace libbitcoin::database;
      using namespace libbitcoin::chain;
      int main() {
        static const transaction tx{ 0, 0, input::list{}, output::list{ output{} } };
        unspent_outputs cache(42);
        cache.add(tx, 0, 0, false);
        assert(cache.size() == 1u);
        return 0;
      }
    EOS
    system ENV.cxx, "-std=c++11", "test.cpp", "-o", "test",
                    "-L#{Formula["libbitcoin"].opt_lib}", "-lbitcoin",
                    "-L#{lib}", "-lbitcoin-database",
                    "-L#{Formula["boost"].opt_lib}", "-lboost_system"
    system "./test"
  end
end
