class Dhcping < Formula
  desc "Perform a dhcp-request to check whether a dhcp-server is running"
  homepage "https://www.mavetju.org/unix/general.php"
  url "https://www.mavetju.org/download/dhcping-1.2.tar.gz"
  mirror "https://deb.debian.org/debian/pool/main/d/dhcping/dhcping_1.2.orig.tar.gz"
  sha256 "32ef86959b0bdce4b33d4b2b216eee7148f7de7037ced81b2116210bc7d3646a"

  bottle do
    sha256 cellar: :any_skip_relocation, catalina:    "6c8a4c00ebe101f4ad040238d79137025331d8af78327b77ef72d83da985402e"
    sha256 cellar: :any_skip_relocation, mojave:      "94dba411868455abd17d818d1009e71bae362cea093ec01437b19fbbb33a0cc2"
    sha256 cellar: :any_skip_relocation, high_sierra: "e30ef14d867a06bcc9bcde18965fa00366780c3323841ca0fb25f864077044d6"
    sha256 cellar: :any_skip_relocation, sierra:      "5c41d596cb2a9835fc5f170ccd602294c98f163ba3f2a8d5c83bae252189817e"
    sha256 cellar: :any_skip_relocation, el_capitan:  "d3b03b1004d3a2d97b80fbbe9714bd29d006d9099a8f6baec343feb2833f3996"
    sha256 cellar: :any_skip_relocation, yosemite:    "7741adb9bc166ee2450e521f7468e2b023632e737eb4da065848c5e87b6bd35a"
    sha256 cellar: :any_skip_relocation, mavericks:   "49206410d2fc5259798c2a76ee871df08c54772d1501d7ce1d29be652d600905"
  end

  def install
    system "./configure", "--prefix=#{prefix}", "--mandir=#{man}"
    system "make", "install"
  end
end
