class Gwenhywfar < Formula
  desc "Utility library required by aqbanking and related software"
  homepage "https://www.aquamaniac.de/"
  url "https://www.aquamaniac.de/sites/download/download.php?package=01&release=208&file=02&dummy=gwenhywfar-4.20.0.tar.gz"
  sha256 "5a88daabba1388f9528590aab5de527a12dd44a7da4572ce48469a29911b0fb0"
  revision 2

  bottle do
    sha256 "605edc60c3ce3b79933d80491db2d64ded5dc27acd93be50cb445f14a720ba10" => :mojave
    sha256 "f738c100042894d7601927ab47d2b5eb81abf461693a16026b87e60b6b757952" => :high_sierra
    sha256 "f0df3064284d1157147958c9c875a45702cd67e20f69fc3869444360816a55b4" => :sierra
  end

  depends_on "pkg-config" => :build
  depends_on "gettext"
  depends_on "gnutls"
  depends_on "libgcrypt"
  depends_on "openssl@1.1"

  def install
    system "autoreconf", "-fiv" if build.head?
    system "./configure", "--disable-debug",
                          "--disable-dependency-tracking",
                          "--prefix=#{prefix}",
                          "--with-guis=cocoa"
    system "make", "install"
  end

  test do
    (testpath/"test.c").write <<~EOS
      #include <gwenhywfar/gwenhywfar.h>

      int main()
      {
        GWEN_Init();
        return 0;
      }
    EOS
    system ENV.cc, "test.c", "-I#{include}/gwenhywfar4", "-L#{lib}", "-lgwenhywfar", "-o", "test"
    system "./test"
  end
end
