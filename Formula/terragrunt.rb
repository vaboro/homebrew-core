class Terragrunt < Formula
  desc "Thin wrapper for Terraform e.g. for locking state"
  homepage "https://github.com/gruntwork-io/terragrunt"
  url "https://github.com/gruntwork-io/terragrunt/archive/v0.19.9.tar.gz"
  sha256 "6e3526c050b4904c3eb32bd8f49630569050cae946b2cbee4b24fb36a7223b79"
  head "https://github.com/gruntwork-io/terragrunt.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "f72ab6319d3456fba966cf1e921c79bd3de6765dfa6a58bdb9b3a7b3b0642086" => :mojave
    sha256 "7eb162f5820f7941efa06c21c1ca84b6526b541ff48d6d9d9a8117539803b4be" => :high_sierra
    sha256 "16123a29e6ea40e08fee855a2d505dfdd3039e7e482ba61aecfa32f1f0b93297" => :sierra
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
