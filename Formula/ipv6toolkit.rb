class Ipv6toolkit < Formula
  desc "Security assessment and troubleshooting tool for IPv6"
  homepage "https://www.si6networks.com/tools/ipv6toolkit/"
  url "https://www.si6networks.com/tools/ipv6toolkit/ipv6toolkit-v2.0.tar.gz"
  sha256 "16f13d3e7d17940ff53f028ef0090e4aa3a193a224c97728b07ea6e26a19e987"
  license "GPL-3.0"

  bottle do
    rebuild 1
    sha256 cellar: :any_skip_relocation, catalina:    "cf001c12f138a06ba8e4a68935ef1f2e9da358cc2af2326d4faa6ff8a156f1be"
    sha256 cellar: :any_skip_relocation, mojave:      "c46d5e8c7752380d8416e916a6b71c2630ed2a150fb3ecddea24bf559587aa04"
    sha256 cellar: :any_skip_relocation, high_sierra: "1d1069f07134e882a0d670210ea607f209007f89325e0d414a45c4423c7eaebf"
    sha256 cellar: :any_skip_relocation, sierra:      "347e2904a6adc26c82a9a123636234cbc95694f4d94b948b922e137073c7081d"
    sha256 cellar: :any_skip_relocation, el_capitan:  "1d7d0b6b4d248ccff98362f4d7707821ae2109591717d56d3b49f0c1d6b83b16"
    sha256 cellar: :any_skip_relocation, yosemite:    "d337148bcff3080cd4e94fee0adb1b5226421020bcc6296f97bcf1986dcbea6a"
    sha256 cellar: :any_skip_relocation, mavericks:   "cd4b85ebae536aea022ab34174c36d360b2db31a9f5c11ad58ae6aa4644ff2b0"
  end

  def install
    system "make"
    system "make", "install", "DESTDIR=#{prefix}", "PREFIX=", "MANPREFIX=/share"
  end

  test do
    system "#{bin}/addr6", "-a", "fc00::1"
  end
end
