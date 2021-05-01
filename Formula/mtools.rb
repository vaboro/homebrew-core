class Mtools < Formula
  desc "Tools for manipulating MSDOS files"
  homepage "https://www.gnu.org/software/mtools/"
  url "https://ftp.gnu.org/gnu/mtools/mtools-4.0.24.tar.gz"
  mirror "https://ftpmirror.gnu.org/mtools/mtools-4.0.24.tar.gz"
  sha256 "3483bdf233e77d0cf060de31df8e9f624c4bf26bd8a38ef22e06ca799d60c74e"
  license "GPL-3.0"

  livecheck do
    url :stable
  end

  bottle do
    sha256 cellar: :any_skip_relocation, catalina:    "a5229fbfcd666abf4c79cd065be6a58801228460f999319a0234319ccb8aba3a"
    sha256 cellar: :any_skip_relocation, mojave:      "3a9d80e7a7e9a6dd377d0030a5fbc29e509ca6dd598e24943b36169ed1512670"
    sha256 cellar: :any_skip_relocation, high_sierra: "ebed9be10002c3a8a68089ff43702b24f1f2c451be9e14778eaece3ad4e0cdc0"
  end

  conflicts_with "multimarkdown", because: "both install `mmd` binaries"

  def install
    # Prevents errors such as "mainloop.c:89:15: error: expected ')'"
    # Upstream issue https://lists.gnu.org/archive/html/info-mtools/2014-02/msg00000.html
    if ENV.cc == "clang"
      inreplace "sysincludes.h",
        "#  define UNUSED(x) x __attribute__ ((unused));x",
        "#  define UNUSED(x) x"
    end

    args = %W[
      LIBS=-liconv
      --disable-debug
      --prefix=#{prefix}
      --sysconfdir=#{etc}
      --without-x
    ]

    system "./configure", *args
    system "make"
    ENV.deparallelize
    system "make", "install"
  end

  test do
    assert_match(/#{version}/, shell_output("#{bin}/mtools --version"))
  end
end
