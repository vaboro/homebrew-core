class Libssh2 < Formula
  desc "C library implementing the SSH2 protocol"
  homepage "https://libssh2.org/"
  url "https://libssh2.org/download/libssh2-1.9.0.tar.gz"
  sha256 "d5fb8bd563305fd1074dda90bd053fb2d29fc4bce048d182f96eaa466dfadafd"
  license "BSD-3-Clause"
  revision 1

  livecheck do
    url "https://libssh2.org/download/"
    regex(/href=.*?libssh2[._-]v?(\d+(?:\.\d+)+)\./i)
  end

  bottle do
    sha256 cellar: :any, catalina:    "2c4dcf8149663f9a133deac5bc42ce308d1ced90227cac391ca30b0ab2d381f9"
    sha256 cellar: :any, mojave:      "327c56ad6a54894e5ef9aa3019d2444d32f1d0fba80925940100e517dd3109c9"
    sha256 cellar: :any, high_sierra: "ee29f44ef6fb59242fc7ee1747f02df2287722af4a45319289c9ee224367ba06"
    sha256 cellar: :any, sierra:      "769fbbdc4e67b8de15c269f66a6efe86c5b0195df56e7e46b44377a572800efa"
  end

  head do
    url "https://github.com/libssh2/libssh2.git"

    depends_on "autoconf" => :build
    depends_on "automake" => :build
    depends_on "libtool" => :build
  end

  depends_on "openssl@1.1"

  uses_from_macos "zlib"

  def install
    args = %W[
      --prefix=#{prefix}
      --disable-debug
      --disable-dependency-tracking
      --disable-silent-rules
      --disable-examples-build
      --with-openssl
      --with-libz
      --with-libssl-prefix=#{Formula["openssl@1.1"].opt_prefix}
    ]

    system "./buildconf" if build.head?
    system "./configure", *args
    system "make", "install"
  end

  test do
    (testpath/"test.c").write <<~EOS
      #include <libssh2.h>

      int main(void)
      {
      libssh2_exit();
      return 0;
      }
    EOS

    system ENV.cc, "test.c", "-L#{lib}", "-lssh2", "-o", "test"
    system "./test"
  end
end
