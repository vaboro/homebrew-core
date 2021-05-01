class Kytea < Formula
  desc "Toolkit for analyzing text, especially Japanese and Chinese"
  homepage "http://www.phontron.com/kytea/"
  url "http://www.phontron.com/kytea/download/kytea-0.4.7.tar.gz"
  sha256 "534a33d40c4dc5421f053c71a75695c377df737169f965573175df5d2cff9f46"
  license "Apache-2.0"

  bottle do
    sha256 catalina:    "927aac3d562cc2977f84670c850ab262a05a010bfe7e7f16aa0eb7d9532eae7b"
    sha256 mojave:      "57c8c3acf60417d44d7df27445d667dd03095f1afdad70aeb63cf68e0cbc64c0"
    sha256 high_sierra: "bcdb450698d5065cf82b7726d6dc21381632c41352237dc547c05cc62e4b7e59"
    sha256 sierra:      "d29c61f74da5f4d88f09d8b540943599ce8b6e5062af88b7d5725ea84fb4c603"
    sha256 el_capitan:  "3e0c66a7efb34ddb8e4f80d9b95562779e224271b8d63d38f9bc8176103427e2"
    sha256 yosemite:    "2f2dda314728cd74750db339ebc2d166b8b611ad54668cc3e7b6225d39aec3f5"
    sha256 mavericks:   "045d0c9ad0cf35e003b8839cb0213e3f49d9107dfbc955e449b36fd4b6596640"
  end

  head do
    url "https://github.com/neubig/kytea.git"
    depends_on "autoconf" => :build
    depends_on "automake" => :build
    depends_on "libtool" => :build
  end

  def install
    system "autoreconf", "-i" if build.head?
    system "./configure", "--disable-dependency-tracking",
                          "--prefix=#{prefix}"
    system "make", "install"
  end

  test do
    system "#{bin}/kytea", "--version"
  end
end
