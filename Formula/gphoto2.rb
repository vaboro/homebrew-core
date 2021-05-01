class Gphoto2 < Formula
  desc "Command-line interface to libgphoto2"
  homepage "http://www.gphoto.org/"
  url "https://downloads.sourceforge.net/project/gphoto/gphoto/2.5.23/gphoto2-2.5.23.tar.bz2"
  sha256 "df87092100e7766c9d0a4323217c91908a9c891c0d3670ebf40b76903be458d1"
  license "GPL-2.0"

  livecheck do
    url :stable
    regex(%r{url=.*?/gphoto2[._-]v?(\d+(?:\.\d+)+)\.t}i)
  end

  bottle do
    sha256 cellar: :any, catalina:    "41373d501ce514558ba5ef0ba1511a4e1b340157eb900adc50c27c3712f479e5"
    sha256 cellar: :any, mojave:      "da5cc508f296a7830b969ac4689ed9decb2242f1f2ce847bbffa76bc4ee535db"
    sha256 cellar: :any, high_sierra: "5d8185b94ff870dbea0947367b66b839a48523be64eef5b351e67d94fb3d3587"
    sha256 cellar: :any, sierra:      "058a04c33c80cfaad20f5bf35f1afee9624c390cf163e96df60f6c9c0c06f7e3"
  end

  depends_on "pkg-config" => :build
  depends_on "jpeg"
  depends_on "libgphoto2"
  depends_on "popt"
  depends_on "readline"

  def install
    system "./configure", "--disable-dependency-tracking",
                          "--prefix=#{prefix}"
    system "make", "install"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/gphoto2 -v")
  end
end
