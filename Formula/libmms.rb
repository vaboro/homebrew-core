class Libmms < Formula
  desc "Library for parsing mms:// and mmsh:// network streams"
  homepage "https://sourceforge.net/projects/libmms/"
  url "https://downloads.sourceforge.net/project/libmms/libmms/0.6.4/libmms-0.6.4.tar.gz"
  sha256 "3c05e05aebcbfcc044d9e8c2d4646cd8359be39a3f0ba8ce4e72a9094bee704f"

  livecheck do
    url :stable
  end

  bottle do
    rebuild 2
    sha256 cellar: :any, catalina:    "15016ca7557449405339f310e6feeccbc04094702fcc7d4be53909fc738b05f4"
    sha256 cellar: :any, mojave:      "4ac527e54af063a3fa760b1e4d43b56dd51ade89cbb971ac9bea9dd3500dfc70"
    sha256 cellar: :any, high_sierra: "adc24aaa1656c02f41b20b4453f6a2deda8f3597c919eed1ae8befb732fc920f"
    sha256 cellar: :any, sierra:      "5319927f799dd20effbfc9f8bb90ebc844b39852c433bf434ab6b36c11c36417"
    sha256 cellar: :any, el_capitan:  "61c4dd24598198386342dd9c700e218b6b83c82627efc781daa89acfaca96066"
    sha256 cellar: :any, yosemite:    "f915d916dd81ad9f767b6905e166dae07df72e70dc0c844c8011abed9f144252"
    sha256 cellar: :any, mavericks:   "b55ae55a0d684ba1e3654eee96769d206ce0c22a4ab7bad5241eb1c51bda7778"
  end

  depends_on "pkg-config" => :build
  depends_on "glib"

  def install
    ENV.append "LDFLAGS", "-liconv"
    system "./configure", "--disable-dependency-tracking",
                          "--prefix=#{prefix}"
    system "make", "install"
  end
end
