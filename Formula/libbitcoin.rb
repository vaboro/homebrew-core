class Libbitcoin < Formula
  desc "Bitcoin Cross-Platform C++ Development Toolkit"
  homepage "https://github.com/libbitcoin/libbitcoin-system"
  url "https://github.com/libbitcoin/libbitcoin-system/archive/v3.6.0.tar.gz"
<<<<<<< HEAD
  sha256 "fcd61f31fd5e6734ef4d673f643a5afac2304cd8061dc7c23ac60ec261b68d4e"

  bottle do
    cellar :any
    sha256 "bcec895e8c13a2ce2a8d504444d9528e890ab3c13e3f77c8a02c472bb36995f9" => :mojave
    sha256 "f0a0c5631de02ce4fc73ab62722e237a77edc61131512e64a8b2321629c4d81c" => :high_sierra
    sha256 "73af3ed27d4ba51fe4863ce30405141b90a24b034ceffc1a286d4668661e2535" => :sierra
=======
  sha256 "5bcc4c31b53acbc9c0d151ace95d684909db4bf946f8d724f76c711934c6775c"
  revision 2

  bottle do
    cellar :any
<<<<<<< HEAD
    sha256 "1cb73cc7c259fb733bf0db315b62ae9ec555bff79202eee3485fdc744250d30f" => :mojave
    sha256 "bd50578d7006f7caf00203bb0c4ff2359e010fa2e54c49e43a2f5b993c2c66f7" => :high_sierra
    sha256 "99a4275be13140f30688d8cc59c07ec3eac1e4720e7623bdfc6615b1941f7ecf" => :sierra
>>>>>>> upstream/master
=======
    sha256 "b4d07453eea2f3a98468cd2fc1e7dc36337b3c8a4cc3fc677b21d60faf802cf4" => :mojave
    sha256 "3ff7c0fea4e15397508bdf7c8b932538861182527d626e8c71759976fc4492b5" => :high_sierra
    sha256 "07c6712043428e303e13216f59c3a4e576605d7ba03e39f24b92ddf1dfe4b73f" => :sierra
>>>>>>> upstream/master
  end

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "libtool" => :build
  depends_on "pkg-config" => :build
  depends_on "boost"
  depends_on "libpng"
  depends_on "qrencode"

  resource "secp256k1" do
    url "https://github.com/libbitcoin/secp256k1/archive/v0.1.0.13.tar.gz"
    sha256 "9e48dbc88d0fb5646d40ea12df9375c577f0e77525e49833fb744d3c2a69e727"
  end

  def install
    resource("secp256k1").stage do
      system "./autogen.sh"
      system "./configure", "--disable-dependency-tracking",
                            "--disable-silent-rules",
                            "--prefix=#{libexec}",
                            "--enable-module-recovery",
                            "--with-bignum=no"
      system "make", "install"
    end

    ENV.prepend_path "PKG_CONFIG_PATH", "#{libexec}/lib/pkgconfig"

    system "./autogen.sh"
    system "./configure", "--disable-dependency-tracking",
                          "--disable-silent-rules",
                          "--prefix=#{prefix}",
                          "--with-png",
                          "--with-qrencode"
    system "make", "install"
  end

  test do
    (testpath/"test.cpp").write <<~EOS
      #include <bitcoin/bitcoin.hpp>
      int main() {
        const auto block = bc::chain::block::genesis_mainnet();
        const auto& tx = block.transactions().front();
        const auto& input = tx.inputs().front();
        const auto script = input.script().to_data(false);
        std::string message(script.begin() + sizeof(uint64_t), script.end());
        std::cout << message << std::endl;
        return 0;
      }
    EOS
    system ENV.cxx, "-std=c++11", "test.cpp", "-L#{lib}", "-lbitcoin",
                    "-L#{Formula["boost"].opt_lib}", "-lboost_system",
                    "-o", "test"
    system "./test"
  end
end
