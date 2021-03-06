class LibbitcoinProtocol < Formula
  desc "Bitcoin Blockchain Query Protocol"
  homepage "https://github.com/libbitcoin/libbitcoin-protocol"
  url "https://github.com/libbitcoin/libbitcoin-protocol/archive/v3.6.0.tar.gz"
<<<<<<< HEAD
  sha256 "dc3ed57512c1de68ec76838e41380ee03417c916c84d44ef3d5ef18e1b93bd72"

  bottle do
    cellar :any
    sha256 "75dc4affb508e9188b64a63be1190c4bd1302f3ef4e6b5a62ca471d3e4c5c285" => :mojave
    sha256 "d9d5e091c8064f96c5779ed191f73db4531326204cb3660dc69a4574aabc0747" => :high_sierra
    sha256 "9220a0b4e3e08dae2aa33c53d63d7829f354aecb94c0a7d2d2eab08a86cce1d7" => :sierra
=======
  sha256 "fc41c64f6d3ee78bcccb63fd0879775c62bba5326f38c90b4c6804e2b9e8686e"
  license "AGPL-3.0"
  revision 4

  bottle do
    cellar :any
<<<<<<< HEAD
<<<<<<< HEAD
    sha256 "8d65c20524c08d390117e733ee88225bd324f66d5bf0b08e401062cf2785d5dc" => :mojave
    sha256 "491b213a911931ff3a1df05fd078526d86344127695ea9666672f42021f189e0" => :high_sierra
    sha256 "bffd35d9c52f56cf2bfd59d18a258acc2fbafdfa19d605ad8715ce02d76ea471" => :sierra
>>>>>>> upstream/master
=======
    sha256 "e7dad4f664f27dc5fe89df604daf5e55289133fc99a7a67303869216ab9848fe" => :mojave
    sha256 "aa121e23ea64bdcedfefeecc296fda96b9c3025cef17227d5b8fa2a7f2867abc" => :high_sierra
    sha256 "a3fc6e2486cc3f5bdc6fd45c3fac16ab2b6a282e0128bd29904ddcadb937b11f" => :sierra
>>>>>>> upstream/master
=======
    sha256 "e4ace943dc279f2314805e724e18cfe8d7f1f5c4b6bc908dd714bcf2bfa150f9" => :catalina
    sha256 "4ac63f7dfac4955b5682dd3342aaec9e28cd14f2f4e6271104aa76f48c32d6f2" => :mojave
    sha256 "54c5ebea35a3140641a108856b66c2e09a0e7e8ac385af231cd9de8fd33255aa" => :high_sierra
>>>>>>> upstream/master
  end

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "libtool" => :build
  depends_on "pkg-config" => :build
  depends_on "libbitcoin"
  depends_on "zeromq"

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
      #include <bitcoin/protocol.hpp>
      int main() {
        libbitcoin::protocol::zmq::message instance;
        instance.enqueue();
        assert(!instance.empty());
        assert(instance.size() == 1u);
      }
    EOS
    system ENV.cxx, "-std=c++11", "test.cpp", "-o", "test",
                    "-L#{Formula["libbitcoin"].opt_lib}", "-lbitcoin",
                    "-L#{lib}", "-lbitcoin-protocol",
                    "-L#{Formula["boost"].opt_lib}", "-lboost_system"
    system "./test"
  end
end
