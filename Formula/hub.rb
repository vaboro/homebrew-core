class Hub < Formula
  desc "Add GitHub support to git on the command-line"
  homepage "https://hub.github.com/"
  url "https://github.com/github/hub/archive/v2.14.2.tar.gz"
  sha256 "e19e0fdfd1c69c401e1c24dd2d4ecf3fd9044aa4bd3f8d6fd942ed1b2b2ad21a"
  license "MIT"
  head "https://github.com/github/hub.git"

  bottle do
    sha256 cellar: :any_skip_relocation, catalina:    "fdf05855839a9d7ec6e7bee6796e3cb5fc473500cffc002366cf98c09a805b69"
    sha256 cellar: :any_skip_relocation, mojave:      "bcbae9c683d76f3395665467ba0f0c00c60c12c84022f72faba4b8981724b563"
    sha256 cellar: :any_skip_relocation, high_sierra: "8800cda4532784bf764ea6116a06c81d8d90bb3d36d8ecf295e64f9dd647c4ad"
  end

  depends_on "go" => :build

  uses_from_macos "groff" => :build
  uses_from_macos "ruby" => :build

  on_linux do
    depends_on "util-linux"
  end

  def install
    system "make", "install", "prefix=#{prefix}"

    prefix.install_metafiles

    bash_completion.install "etc/hub.bash_completion.sh"
    zsh_completion.install "etc/hub.zsh_completion" => "_hub"
    fish_completion.install "etc/hub.fish_completion" => "hub.fish"
  end

  test do
    system "git", "init"
    %w[haunted house].each { |f| touch testpath/f }
    system "git", "add", "haunted", "house"
    system "git", "commit", "-a", "-m", "Initial Commit"
    assert_equal "haunted\nhouse", shell_output("#{bin}/hub ls-files").strip
  end
end
