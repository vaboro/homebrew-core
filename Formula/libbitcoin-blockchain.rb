class LibbitcoinBlockchain < Formula
  desc "Bitcoin Blockchain Library"
  homepage "https://github.com/libbitcoin/libbitcoin-blockchain"
  url "https://github.com/libbitcoin/libbitcoin-blockchain/archive/v3.6.0.tar.gz"
<<<<<<< HEAD
  sha256 "d0cd036a1ec10063e9eb6fe4b198b0acecbbda73aa78c7d314f924866907ff0a"

  bottle do
    cellar :any
    sha256 "381c63f70509cd74addd5981dd6f5ef48cc3fa0dcbe3153b205f408f196376d5" => :mojave
    sha256 "ebd3efe29001f1c4e74877ab0267d8ebdc43e3222c6bc8df2e10b489b886c141" => :high_sierra
    sha256 "cf2845efcd1676bd16ac497537915296bd6d3e7bfa6b32cf970b32d0a0ccf69d" => :sierra
=======
  sha256 "18c52ebda4148ab9e6dec62ee8c2d7826b60868f82710f21e40ff0131bc659e0"
  revision 1

  bottle do
    cellar :any
    sha256 "ef3b880069ae513b2cc91e702f7e28920acd9f24b0264049138037d692a83b6a" => :mojave
    sha256 "0ab52ee6e7c204c4948468e551b00042cf4a3118ddc7f6eb20f71999b3be9861" => :high_sierra
    sha256 "a399e9b0540b8a41176d852f06222f6b6e831def5618fe4cbd2555c8f2708b32" => :sierra
>>>>>>> upstream/master
  end

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "libtool" => :build
  depends_on "pkg-config" => :build
  depends_on "libbitcoin-consensus"
  depends_on "libbitcoin-database"

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
      #include <bitcoin/blockchain.hpp>
      int main() {
        static const auto default_block_hash = libbitcoin::hash_literal("14508459b221041eab257d2baaa7459775ba748246c8403609eb708f0e57e74b");
        const auto block = std::make_shared<const libbitcoin::message::block>();
        libbitcoin::blockchain::block_entry instance(block);
        assert(instance.block() == block);
        assert(instance.hash() == default_block_hash);
        return 0;
      }
    EOS
    system ENV.cxx, "-std=c++11", "test.cpp", "-o", "test",
                    "-I#{libexec}/include",
                    "-L#{Formula["libbitcoin"].opt_lib}", "-lbitcoin",
                    "-L#{lib}", "-L#{libexec}/lib", "-lbitcoin-blockchain",
                    "-L#{Formula["boost"].opt_lib}", "-lboost_system"
    system "./test"
  end
end
