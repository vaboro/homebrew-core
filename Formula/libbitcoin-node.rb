class LibbitcoinNode < Formula
  desc "Bitcoin Full Node"
  homepage "https://github.com/libbitcoin/libbitcoin-node"
  url "https://github.com/libbitcoin/libbitcoin-node/archive/v3.6.0.tar.gz"
<<<<<<< HEAD
  sha256 "3803e8dcf70dd1e7043e98bb4a78e9f2007288297f0046c5ed43c7a75058dcb5"

  bottle do
    sha256 "168268e2f8f832fe1dca3b911c4b3e553bc028504107f60e682833b23f0547ed" => :mojave
    sha256 "5be74517e2cca30a4224b6b1f2f50e20f8c55c09eb2d82e0a8c10a8e08ce822d" => :high_sierra
    sha256 "e8e1cc3be334b9cc10502d54243299f07b349a2314e692e68a0a351e9c4c3b52" => :sierra
=======
  sha256 "9556ee8aab91e893db1cf343883034571153b206ffbbce3e3133c97e6ee4693b"
  license "AGPL-3.0"
  revision 1

  bottle do
    sha256 "653e045b09c85d70bcc454f6a2fb7c7cbd5fcfdd77eb0f4d376699c5bde730e8" => :catalina
    sha256 "d80c4711180ca3046edfad49d380a434f3dee07232ab3171483a5f135ebe41d2" => :mojave
    sha256 "d0e3c6d9bcd6db9b2275aadafd8c15ad086da4f4b43cb3e2b25ed76239841d8d" => :high_sierra
    sha256 "982ed6da5589239636751f909765d7ddc744fbfe29ed8a6f73cf6b8f62546e3f" => :sierra
>>>>>>> upstream/master
  end

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "libtool" => :build
  depends_on "pkg-config" => :build
  depends_on "libbitcoin-blockchain"
  depends_on "libbitcoin-network"

  def install
    ENV.prepend_path "PKG_CONFIG_PATH", Formula["libbitcoin"].opt_libexec/"lib/pkgconfig"

    system "./autogen.sh"
    system "./configure", "--disable-dependency-tracking",
                          "--disable-silent-rules",
                          "--prefix=#{prefix}"
    system "make", "install"

    bash_completion.install "data/bn"
  end

  test do
    (testpath/"test.cpp").write <<~EOS
      #include <bitcoin/node.hpp>
      int main() {
        libbitcoin::node::settings configuration;
        assert(configuration.sync_peers == 0u);
        assert(configuration.sync_timeout_seconds == 5u);
        assert(configuration.refresh_transactions == true);
        return 0;
      }
    EOS
    system ENV.cxx, "-std=c++11", "test.cpp", "-o", "test",
                    "-L#{Formula["libbitcoin"].opt_lib}", "-lbitcoin",
                    "-L#{lib}", "-lbitcoin-node",
                    "-L#{Formula["boost"].opt_lib}", "-lboost_system"
    system "./test"
  end
end
