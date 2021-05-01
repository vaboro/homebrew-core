class LibpokerEval < Formula
  desc "C library to evaluate poker hands"
  homepage "https://pokersource.sourceforge.io/"
  # http://download.gna.org/pokersource/sources/poker-eval-138.0.tar.gz is offline
  url "https://deb.debian.org/debian/pool/main/p/poker-eval/poker-eval_138.0.orig.tar.gz"
  sha256 "92659e4a90f6856ebd768bad942e9894bd70122dab56f3b23dd2c4c61bdbcf68"
  license "GPL-3.0"

  bottle do
    rebuild 1
    sha256 cellar: :any, catalina:    "803f48db07d845ec9784792ed0fe5cdc86cb67e6632ed9f72dde75619481bf83"
    sha256 cellar: :any, mojave:      "313ff85dd7ec513a95ee8846c657819fdadbebccf0bdce228f180305ee56a716"
    sha256 cellar: :any, high_sierra: "415934c921d4ccced5426f9aa807b0cf11da031cb2c973e17d506a9f740ac645"
    sha256 cellar: :any, sierra:      "5216cd33d433fd9212ed14d6fffec593c7106226547c1555344604186e7aafc6"
    sha256 cellar: :any, el_capitan:  "67b105600a8e29ed2d38421bc27340ff6e9092806f6458f0ddd6a27de0bcfb9c"
    sha256 cellar: :any, yosemite:    "b15086546ac1ac0310e3113231bfcc2c9de0d23474be8a1a1b4663e6bc8f713f"
    sha256 cellar: :any, mavericks:   "9bbfb3886a4e530455dbf53581aecd0df8c86a2f80a444692441449c30f76d92"
  end

  def install
    system "./configure", "--prefix=#{prefix}",
                          "--disable-debug",
                          "--disable-dependency-tracking"
    system "make", "install"
  end
end
