class Tivodecode < Formula
  desc "Convert .tivo to .mpeg"
  homepage "https://tivodecode.sourceforge.io/"
  url "https://downloads.sourceforge.net/project/tivodecode/tivodecode/0.2pre4/tivodecode-0.2pre4.tar.gz"
  sha256 "788839cc4ad66f5b20792e166514411705e8564f9f050584c54c3f1f452e9cdf"

  livecheck do
    url :stable
    regex(%r{url=.*?/tivodecode[._-]v?(\d+(?:\.\d+)+(?:pre\d+)?)\.t}i)
  end

  bottle do
    sha256 cellar: :any_skip_relocation, catalina:    "153d8b8e152ccf3c87041ff40739a80952da5ad06c572d7febb9b222b16069e1"
    sha256 cellar: :any_skip_relocation, mojave:      "efa83924ac8d8e07e539c6d9b3aa5d5d7440fd34bccc1da793ead1224eabdbbf"
    sha256 cellar: :any_skip_relocation, high_sierra: "0016f711d79454b154708804c574633c48e472b9a81c257730e5cf4aa00dd220"
    sha256 cellar: :any_skip_relocation, sierra:      "5682668b2e721933054656cebc49ccb46c382428b77409d94251c6f1dfd3092d"
    sha256 cellar: :any_skip_relocation, el_capitan:  "d50450e62c6fcf71643ceaf5f33dcf4e904e389c89597ccbe148de3053839ccd"
    sha256 cellar: :any_skip_relocation, yosemite:    "cb74afdc87eca67025849836bee29e04f6c8e7755753a9daa52c84cfc9201cd8"
    sha256 cellar: :any_skip_relocation, mavericks:   "7622e7c60ecd22127b454e303d7c15b14c6cc79bcddf00c0de0de58e9350b5bd"
  end

  def install
    system "./configure", "--disable-debug", "--disable-dependency-tracking",
                          "--prefix=#{prefix}"
    system "make", "install"
  end
end
