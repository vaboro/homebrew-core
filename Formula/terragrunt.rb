class Terragrunt < Formula
  desc "Thin wrapper for Terraform e.g. for locking state"
  homepage "https://github.com/gruntwork-io/terragrunt"
  url "https://github.com/gruntwork-io/terragrunt.git",
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
  end

  depends_on "dep" => :build
  depends_on "go" => :build
  depends_on "terraform"

  def install
    ENV["GOPATH"] = buildpath
    (buildpath/"src/github.com/gruntwork-io/terragrunt").install buildpath.children
    cd "src/github.com/gruntwork-io/terragrunt" do
      system "dep", "ensure", "-vendor-only"
      system "go", "build", "-o", bin/"terragrunt", "-ldflags", "-X main.VERSION=v#{version}"
    end
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/terragrunt --version")
  end
end
