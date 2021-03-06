class F3 < Formula
  desc "Test various flash cards"
  homepage "https://web.archive.org/web/20200110163924/oss.digirati.com.br/f3/"
  url "https://github.com/AltraMayor/f3/archive/v7.2.tar.gz"
  sha256 "ba9210a0fc3a42c2595fe19bf13b8114bb089c4f274b4813c8f525a695467f64"
  license "GPL-3.0"
  head "https://github.com/AltraMayor/f3.git"

  bottle do
    sha256 cellar: :any_skip_relocation, catalina:    "470b2c09c266e1d53efbb7784bb697a22ee3ba6a24a0c3abdae1445692e41ef9"
    sha256 cellar: :any_skip_relocation, mojave:      "5830e81dc3a83ed4ad4b2955d1775e63367d68a815299f99b7556cfe4aca38f7"
    sha256 cellar: :any_skip_relocation, high_sierra: "725c7f88756ea641e75796949e5c59fa7040a97b5ae6f8fd1e580a77a50cd0b6"
    sha256 cellar: :any_skip_relocation, sierra:      "04f2d3dee579c8740b23f48f7df4160f2e680d92afb4f887bba65f87b804ed93"
  end

  depends_on "argp-standalone"

  def install
    system "make", "all", "ARGP=#{Formula["argp-standalone"].opt_prefix}"
    bin.install %w[f3read f3write]
    man1.install "f3read.1"
    man1.install_symlink "f3read.1" => "f3write.1"
  end

  test do
    system "#{bin}/f3read", testpath
  end
end
