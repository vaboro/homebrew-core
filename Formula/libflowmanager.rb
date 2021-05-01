class Libflowmanager < Formula
  desc "Flow-based measurement tasks with packet-based inputs"
  homepage "https://research.wand.net.nz/software/libflowmanager.php"
  url "https://research.wand.net.nz/software/libflowmanager/libflowmanager-3.0.0.tar.gz"
  sha256 "0866adfcdc223426ba17d6133a657d94928b4f8e12392533a27387b982178373"
  revision 1

  livecheck do
    url :homepage
    regex(/href=.*?libflowmanager[._-]v?(\d+(?:\.\d+)+)\.t/i)
  end

  bottle do
    sha256 cellar: :any, catalina:    "41c5f69289236b3362062b471654f0cc9446f93d90066c001a1bda56d9b9b4f3"
    sha256 cellar: :any, mojave:      "64843e32762b175f497e00e332bee33dbe2c5e77384ccb64a0957e9a6c2bd40b"
    sha256 cellar: :any, high_sierra: "156b302b5feade664f79f10358bc7888f9db14da53bd3549f90864b1bd9056f5"
  end

  depends_on "libtrace"

  def install
    system "./configure", "--disable-debug", "--disable-dependency-tracking",
                          "--prefix=#{prefix}"
    system "make", "install"
  end
end
