class Gmp < Formula
  desc "GNU multiple precision arithmetic library"
  homepage "https://gmplib.org/"
  url "https://gmplib.org/download/gmp/gmp-6.2.0.tar.xz"
  mirror "https://ftp.gnu.org/gnu/gmp/gmp-6.2.0.tar.xz"
  sha256 "258e6cd51b3fbdfc185c716d55f82c08aff57df0c6fbd143cf6ed561267a1526"
  license "GPL-3.0"

  livecheck do
    url "https://gmplib.org/download/gmp/"
    regex(/href=.*?gmp[._-]v?(\d+(?:\.\d+)+)\.t/i)
  end

  bottle do
    cellar :any
    sha256 "2e6acd6e62d1b8ef0800061e113aea30a63f56b32b99c010234c0420fd6d3ecf" => :catalina
    sha256 "1bbea4983a4c883c8eb8b7e19df9fab52f0575be8a34b629fc7df79895f48937" => :mojave
    sha256 "63f220c9ac4ebc386711c8c4c5e1f955cfb0a784bdc41bfd6c701dc789be7fcc" => :high_sierra
  end

  uses_from_macos "m4" => :build

  patch do
    # Remove when upstream fix is released
    # https://gmplib.org/list-archives/gmp-bugs/2020-July/004837.html
    # arm64-darwin patch
    url "https://raw.githubusercontent.com/Homebrew/formula-patches/c53834b4/gmp/6.2.0-arm.patch"
    sha256 "4c5b926f47c78f9cc6f900130d020e7f3aa6f31a6e84246e8886f6da04f7424c"
  end

  if Hardware::CPU.arm?
    depends_on "autoconf" => :build
    depends_on "automake" => :build
    depends_on "libtool" => :build
  end

  def install
    # Work around macOS Catalina / Xcode 11 code generation bug
    # (test failure t-toom53, due to wrong code in mpn/toom53_mul.o)
    ENV.append_to_cflags "-fno-stack-check"

    # Enable --with-pic to avoid linking issues with the static library
    args = %W[--prefix=#{prefix} --enable-cxx --with-pic]

    if Hardware::CPU.arm?
      args << "--build=aarch64-apple-darwin#{OS.kernel_version.major}"
      system "autoreconf", "-fiv"
    else
      args << "--build=#{Hardware.oldest_cpu}-apple-darwin#{OS.kernel_version.major}"
    end
    system "./configure", *args
    system "make"
    system "make", "check"
    system "make", "install"
  end

  test do
    (testpath/"test.c").write <<~EOS
      #include <gmp.h>
      #include <stdlib.h>

      int main() {
        mpz_t i, j, k;
        mpz_init_set_str (i, "1a", 16);
        mpz_init (j);
        mpz_init (k);
        mpz_sqrtrem (j, k, i);
        if (mpz_get_si (j) != 5 || mpz_get_si (k) != 1) abort();
        return 0;
      }
    EOS

    system ENV.cc, "test.c", "-L#{lib}", "-lgmp", "-o", "test"
    system "./test"

    # Test the static library to catch potential linking issues
    system ENV.cc, "test.c", "#{lib}/libgmp.a", "-o", "test"
    system "./test"
  end
end
