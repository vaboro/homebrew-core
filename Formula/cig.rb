class Cig < Formula
  desc "CLI app for checking the state of your git repositories"
  homepage "https://github.com/stevenjack/cig"
  url "https://github.com/stevenjack/cig/archive/v0.1.5.tar.gz"
  sha256 "545a4a8894e73c4152e0dcf5515239709537e0192629dc56257fe7cfc995da24"
  license "MIT"
  head "https://github.com/stevenjack/cig.git"

  bottle do
    rebuild 2
    sha256 cellar: :any_skip_relocation, catalina:    "bb93970229fc7a62a6ca4b0c446ad36f135d2160aa0dce04fa5afbdc072291d3"
    sha256 cellar: :any_skip_relocation, mojave:      "6ae38e73bed4326d85c7f31498b0a5715d877c7a2e32aad9987ba7726efe240e"
    sha256 cellar: :any_skip_relocation, high_sierra: "9215f225d4b314d1047f6bb4e5c909b82b456d2005fffed8c637ca2d63641791"
    sha256 cellar: :any_skip_relocation, sierra:      "5d4eb1f34f8b185513d59dc9072f1a95555dd222f0f7a0526c89983e1643fef6"
  end

  depends_on "go" => :build
  depends_on "godep" => :build

  def install
    ENV["GOPATH"] = buildpath
    (buildpath/"src/github.com/stevenjack").mkpath
    ln_s buildpath, "src/github.com/stevenjack/cig"
    system "godep", "restore"
    system "go", "build", "-o", bin/"cig"
  end

  test do
    repo_path = "#{testpath}/test"
    system "git", "init", "--bare", repo_path
    (testpath/".cig.yaml").write <<~EOS
      test_project: #{repo_path}
    EOS
    system "#{bin}/cig", "--cp=#{testpath}"
  end
end
