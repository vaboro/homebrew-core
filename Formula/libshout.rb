class Libshout < Formula
  desc "Data and connectivity library for the icecast server"
  homepage "https://icecast.org/"
  url "https://downloads.xiph.org/releases/libshout/libshout-2.4.3.tar.gz"
  sha256 "0d8af55d1141bf90710bcd41a768c9cc5adb251502a0af1dd22c8da215d40dfe"

  livecheck do
    url "https://ftp.osuosl.org/pub/xiph/releases/libshout/"
    regex(/href=.*?libshout[._-]v?(\d+(?:\.\d+)+)\.t/i)
  end

  bottle do
    sha256 cellar: :any, catalina:    "c0a0c87887e331d2f4b174d956e974bae44d427f282024f6a7b36910da7dbe05"
    sha256 cellar: :any, mojave:      "14144ef978dbceb4b858ebeb667be83721ba4b3742fd0e0743ab76a9b2f99095"
    sha256 cellar: :any, high_sierra: "f9fef02da35d628c601f24726fa2d748f350692d4bf4c196d28bd08b0f4786eb"
    sha256 cellar: :any, sierra:      "1d246580781a0bf5240363da62a476499a16948935f1b0693d05660ccd5aa9de"
  end

  depends_on "pkg-config" => :build
  depends_on "libogg"
  depends_on "libvorbis"
  depends_on "speex"
  depends_on "theora"

  def install
    system "./configure", "--disable-dependency-tracking", "--prefix=#{prefix}"
    system "make", "install"
  end
end
