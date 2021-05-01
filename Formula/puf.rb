class Puf < Formula
  desc "Parallel URL fetcher"
  homepage "https://puf.sourceforge.io/"
  url "https://downloads.sourceforge.net/project/puf/puf/1.0.0/puf-1.0.0.tar.gz"
  sha256 "3f1602057dc47debeb54effc2db9eadcffae266834389bdbf5ab14fc611eeaf0"
  license "GPL-2.0"

  livecheck do
    url :stable
  end

  bottle do
    sha256 cellar: :any_skip_relocation, catalina:    "cad4c55abee941651ac9e1f203041240aae43b990f3e9efdce7cd9e0342b727c"
    sha256 cellar: :any_skip_relocation, mojave:      "0135ce2eda650af382ccefebc51bce5b83b356234ad02177a311309a1799af79"
    sha256 cellar: :any_skip_relocation, high_sierra: "e9f5c12dedbca6d80be8321abdea89162af0097d68401b77aadf93605877a967"
    sha256 cellar: :any_skip_relocation, sierra:      "3153e22f42620f0ceb69f11080e6ba113765d7847cbbb2672f30a7a6766db972"
    sha256 cellar: :any_skip_relocation, el_capitan:  "24952b79335eb08d7a8880a16714e6afe3b73a65f5f26c59b106020198c1b3f3"
    sha256 cellar: :any_skip_relocation, yosemite:    "d96385896fd7831b71af3b05d55f3c5cd2c3a9565f9083c2efe96309989dcf15"
    sha256 cellar: :any_skip_relocation, mavericks:   "7b76565452fb4f2b03a8b01d6e7495634965ba0bad74906cb907c0642805e5e5"
  end

  def install
    system "./configure", "--disable-debug", "--disable-dependency-tracking",
                          "--prefix=#{prefix}",
                          "--mandir=#{man}"
    system "make", "install"
  end
end
