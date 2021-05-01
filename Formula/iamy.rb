class Iamy < Formula
  desc "AWS IAM import and export tool"
  homepage "https://github.com/99designs/iamy"
  url "https://github.com/99designs/iamy/archive/v2.3.2.tar.gz"
  sha256 "66d44dd6af485b2b003b0aa1c8dcd799f7bae934f1ce1efb7e5d5f6cfe7f8bf2"
  license "MIT"
  head "https://github.com/99designs/iamy.git"

  bottle do
    sha256 cellar: :any_skip_relocation, catalina:    "a74e94857f4b788918ac74f9ef20c3c6c19a0e1164522a4591165b0d070795a4"
    sha256 cellar: :any_skip_relocation, mojave:      "d24e802f1fc572c7d49620531e57a5e143956b2ce1e1d05b2320167b09fbf875"
    sha256 cellar: :any_skip_relocation, high_sierra: "aac8b68119dad48d8aca16a2355cc5c8605e8b1fe44b18e5eb8326216873d657"
    sha256 cellar: :any_skip_relocation, sierra:      "1d22caa158fea3cb67ca07ef5f0785dc9f8568470d0323a5958229ed1f650f6c"
  end

  depends_on "go" => :build
  depends_on "awscli"

  def install
    ENV["GOPATH"] = buildpath
    src = buildpath/"src/github.com/99designs/iamy"
    src.install buildpath.children
    src.cd do
      system "go", "build", "-o", bin/"iamy", "-ldflags",
             "-X main.Version=v#{version}"
      prefix.install_metafiles
    end
  end

  test do
    ENV.delete "AWS_ACCESS_KEY"
    ENV.delete "AWS_SECRET_KEY"
    output = shell_output("#{bin}/iamy pull 2>&1", 1)
    assert_match "Can't determine the AWS account", output
  end
end
