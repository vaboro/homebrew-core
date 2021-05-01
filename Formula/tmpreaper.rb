class Tmpreaper < Formula
  desc "Clean up files in directories based on their age"
  homepage "https://packages.debian.org/sid/tmpreaper"
  url "https://deb.debian.org/debian/pool/main/t/tmpreaper/tmpreaper_1.6.14.tar.gz"
  sha256 "4acb93745ceb8b8c5941313bbba78ceb2af0c3914f1afea0e0ae1f7950d6bdae"
  license "GPL-2.0"

  bottle do
    sha256 cellar: :any_skip_relocation, catalina:    "ff2c0c053d3e9ac8c9d46750bfc6ba417b8ab2bbd9d10def4463ab4a14724b4c"
    sha256 cellar: :any_skip_relocation, mojave:      "023f17c260582b8cfd5c1cfc7ad647c290e210cf63c393dfffe7413509ff39ff"
    sha256 cellar: :any_skip_relocation, high_sierra: "0c65319f2d3cf6a71e13a18fddfc1112f343db3877ad8f3d760bf1731a49cc50"
    sha256 cellar: :any_skip_relocation, sierra:      "c91992d1bd2100c8519f08f169096b71547b41d476f229a76b6d002c9d9d046a"
  end

  def install
    system "./configure", "--prefix=#{prefix}", "--sysconfdir=#{etc}"
    system "make", "install"
  end

  test do
    touch "removed"
    sleep 3
    touch "not-removed"
    system "#{sbin}/tmpreaper", "2s", "."
    refute_predicate testpath/"removed", :exist?
    assert_predicate testpath/"not-removed", :exist?
  end
end
