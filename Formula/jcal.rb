class Jcal < Formula
  desc "UNIX-cal-like tool to display Jalali calendar"
  homepage "https://savannah.nongnu.org/projects/jcal/"
  url "https://download.savannah.gnu.org/releases/jcal/jcal-0.4.1.tar.gz"
  sha256 "e8983ecad029b1007edc98458ad13cd9aa263d4d1cf44a97e0a69ff778900caa"
  license "GPL-3.0"

  livecheck do
    url "https://download.savannah.gnu.org/releases/jcal/"
    regex(/href=.*?jcal[._-]v?(\d+(?:\.\d+)+)\.t/i)
  end

  bottle do
    sha256 cellar: :any, catalina:    "0544ee162b480d5999a312cf721b40007901f964b20edbdd8e062b2e95c64157"
    sha256 cellar: :any, mojave:      "4274c678ae3c2110c94b474aa56fcbb6b121645f9a91352b7c24bf028750f3d9"
    sha256 cellar: :any, high_sierra: "348fdd02ce58859bf75ebe00feaf5c90e1f4f052d531e7667343f4c220d8e7bb"
    sha256 cellar: :any, sierra:      "d6f50844723751f0de8181f751ffc0912013b518b5ac60777a3ade7e1aaa3179"
    sha256 cellar: :any, el_capitan:  "4d876e18cb50c7aa31211b60b66e42637ca3c9eeed9c688c1945dc4755977597"
    sha256 cellar: :any, yosemite:    "3640b058b034b519a5aa3bb1dde36b4efb2ec7bb8124bdbd106617202bf87b22"
    sha256 cellar: :any, mavericks:   "f3c61ee0a88644c66be60de5d0d0c3ec0118aa4762797baab398363c948a0536"
  end

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "libtool" => :build

  def install
    system "/bin/sh", "autogen.sh"
    system "./configure", "--prefix=#{prefix}",
                          "--disable-debug",
                          "--disable-dependency-tracking"
    system "make"
    system "make", "install"
  end

  test do
    system "#{bin}/jcal", "-y"
    system "#{bin}/jdate"
  end
end
