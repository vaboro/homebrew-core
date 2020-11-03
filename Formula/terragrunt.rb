class Terragrunt < Formula
  desc "Thin wrapper for Terraform e.g. for locking state"
  homepage "https://github.com/gruntwork-io/terragrunt"
<<<<<<< HEAD
  url "https://github.com/gruntwork-io/terragrunt.git",
<<<<<<< HEAD
<<<<<<< HEAD
<<<<<<< HEAD
    :tag      => "v0.19.19",
    :revision => "a078396d44bac85abb37819fb83687ae67ba10d7"

  bottle do
    cellar :any_skip_relocation
    sha256 "fe5445a379e6006432922e905808fa016e9433833a7c6883caf322c25d9bd823" => :mojave
    sha256 "deb31f3cbeb98d1afe5171f9f2a7ca3f1369690116d2b4598962a170b3eaae95" => :high_sierra
    sha256 "05107e0e41ab22acdbccc62c1655ab3ed56319f1578ae35b70a9128204bf09da" => :sierra
=======
    :tag      => "v0.19.23",
    :revision => "10a3eb1a1dd20427391f167b4471a31460acf393"

  bottle do
    cellar :any_skip_relocation
    sha256 "5bbec979336a0e8520f67e01be25a595d79557f095583fd59ccfa7a3557b53f7" => :mojave
    sha256 "fbefd024418ae53fb333dc9ba9d80f0a2d5b99a5b9544b28f1072bfaf69fa3a1" => :high_sierra
    sha256 "ab9c7dab716ad7cee1caf486788df4e7ddd8662dfb0cc2ebe459ddbfb6026856" => :sierra
>>>>>>> upstream/master
=======
    :tag      => "v0.19.24",
    :revision => "98b476318cef0e81c956a4fb406ae41d70e30e55"

  bottle do
    cellar :any_skip_relocation
    sha256 "e512fe3975242043c88688bf6434f250487e3b09ae029f9950adf457611ec512" => :mojave
    sha256 "30c9f70f865c06f55febc4c6d13775728779b9214918e6e65c21f58c1ff3039f" => :high_sierra
    sha256 "d66dc885cd177220458803897a69f491f02ee1ef5782769a84aa547c9e364320" => :sierra
>>>>>>> upstream/master
=======
    :tag      => "v0.19.29",
    :revision => "c5d252a82e47e5508455452ec93ac8dd516ed46d"

  bottle do
    cellar :any_skip_relocation
    sha256 "730c42bb518b0134a62e8f2c9b0906f3f68a97b4d0c5474520e265e17cb0e260" => :catalina
    sha256 "9211ce0fbec56905046f1ff748b47d556e322efc651d567f861bbde35b7d560f" => :mojave
    sha256 "26432b8a23aa65631792298f709c65cfbbcb98ea5fd48c828fcd9e141f9dcb7b" => :high_sierra
>>>>>>> upstream/master
=======
  url "https://github.com/gruntwork-io/terragrunt/archive/v0.24.4.tar.gz"
  sha256 "8241279e0301745dbb079d6e9c994b404e7c15c5a594316d94bdb5b5c2f48358"
  license "MIT"

  bottle do
    cellar :any_skip_relocation
    sha256 "d272b60ff36f7f3aebb5158046b2942760d6688eb02204b57b214d025be055ff" => :catalina
    sha256 "3d682499578b277c30a5c1b6e1e465387e57ad3f24af8ff006fca71309a5a9bd" => :mojave
    sha256 "33b9c351349db0a6f1ab105b1f7b2dda3da1677661ff1c71c7d375d7acf32c07" => :high_sierra
>>>>>>> upstream/master
  end

  depends_on "go" => :build
  depends_on "terraform"

  def install
    system "go", "build", "-ldflags", "-X main.VERSION=v#{version}", *std_go_args
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/terragrunt --version")
  end
end
