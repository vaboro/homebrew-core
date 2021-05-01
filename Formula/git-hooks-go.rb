class GitHooksGo < Formula
  desc "Git hooks manager"
  homepage "https://git-hooks.github.io/git-hooks"
  url "https://github.com/git-hooks/git-hooks/archive/v1.3.0.tar.gz"
  sha256 "518eadf3229d9db16d603290634af8ae66461ec021edf646e8bca49deee81850"
  license "MIT"
  head "https://github.com/git-hooks/git-hooks.git"

  bottle do
    sha256 cellar: :any_skip_relocation, catalina:    "367a0e8d166a30749447132c88d5bf1c43fc8ab7c4316c91a990c13d4e887c32"
    sha256 cellar: :any_skip_relocation, mojave:      "b61330cf67d4b8a572bb2f7a22434a00bb74d85bb93254ff6a60e8d3c8f12877"
    sha256 cellar: :any_skip_relocation, high_sierra: "95786772c28deeaaa6c979f93174e1f49bd6dd8370e8927861f6b950dd5b3910"
  end

  depends_on "go" => :build

  conflicts_with "git-hooks", because: "both install `git-hooks` binaries"

  def install
    system "go", "build", *std_go_args, "-o", "#{bin}/git-hooks"
  end

  test do
    system "git", "init"
    system "git", "hooks", "install"
    assert_match "Git hooks ARE installed in this repository.", shell_output("git hooks")
  end
end
