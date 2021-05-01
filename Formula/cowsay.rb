class Cowsay < Formula
  desc "Configurable talking characters in ASCII art"
  # Historical homepage: https://web.archive.org/web/20120225123719/www.nog.net/~tony/warez/cowsay.shtml
  homepage "https://github.com/tnalpgge/rank-amateur-cowsay"
  url "https://github.com/tnalpgge/rank-amateur-cowsay/archive/cowsay-3.04.tar.gz"
  sha256 "d8b871332cfc1f0b6c16832ecca413ca0ac14d58626491a6733829e3d655878b"
  license "GPL-3.0"

  bottle do
    sha256 cellar: :any_skip_relocation, catalina:    "f6cb1c4d1b6f9d8eff3630420c8e51cb51029d00261fa30513f915ff231f5e2d"
    sha256 cellar: :any_skip_relocation, mojave:      "bff466bf07d7aba50b954b4b37b15eb338da542244450843ed6f1fd8223a5eab"
    sha256 cellar: :any_skip_relocation, high_sierra: "9dd1c2263533507d55a6cfc8747ad6a68c0c042c7631512f0611001831dd441c"
    sha256 cellar: :any_skip_relocation, sierra:      "17a1a4620885c9a4b7104b43072ed32348b37f6bb43a1120fe23a46d893e87ea"
    sha256 cellar: :any_skip_relocation, el_capitan:  "360390af15a3c4793e07eda95f55f4a5466ffafc766cb6b62f9790146080a62a"
    sha256 cellar: :any_skip_relocation, yosemite:    "a622af361a6139bc930b371fbde7cfc54bbe8bebfbbe0782e59248fadb10b95f"
    sha256 cellar: :any_skip_relocation, mavericks:   "185bfafd379cd6f6d6202fdae0750fdd2998cc94f33ea349bd4872a0274cb1dc"
  end

  def install
    system "/bin/sh", "install.sh", prefix
    mv prefix/"man", share
  end

  test do
    output = shell_output("#{bin}/cowsay moo")
    assert_match "moo", output  # bubble
    assert_match "^__^", output # cow
  end
end
