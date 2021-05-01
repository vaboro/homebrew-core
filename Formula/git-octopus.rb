class GitOctopus < Formula
  desc "Continuous merge workflow"
  homepage "https://github.com/lesfurets/git-octopus"
  url "https://github.com/lesfurets/git-octopus/archive/v1.4.tar.gz"
  sha256 "e2800eea829c6fc74da0d3f3fcb3f7d328d1ac8fbb7b2eca8c651c0c903a50c3"
  license "LGPL-3.0"

  bottle do
    sha256 cellar: :any_skip_relocation, catalina:    "175dcb36b4098a7c406d15a84cd2cfa856d6df0cfd0cdb3d2a08ff4101dc5249"
    sha256 cellar: :any_skip_relocation, mojave:      "4288690717a7c78406fde14701b2d8c3f7d1d24b27257ceedd02dda4ed81765e"
    sha256 cellar: :any_skip_relocation, high_sierra: "67b8b9950133c0ca6f8a0be544bf192136ebad791eea0070becf47ab99eec270"
    sha256 cellar: :any_skip_relocation, sierra:      "8d5bd1ae923518cd155c1e1ddf1a31b93d75af241e325087853657adc39eca85"
    sha256 cellar: :any_skip_relocation, el_capitan:  "8d5bd1ae923518cd155c1e1ddf1a31b93d75af241e325087853657adc39eca85"
    sha256 cellar: :any_skip_relocation, yosemite:    "8d5bd1ae923518cd155c1e1ddf1a31b93d75af241e325087853657adc39eca85"
  end

  def install
    system "make", "build"
    bin.install "bin/git-octopus", "bin/git-conflict", "bin/git-apply-conflict-resolution"
    man1.install "doc/git-octopus.1", "doc/git-conflict.1"
  end

  test do
    (testpath/".gitconfig").write <<~EOS
      [user]
        name = Real Person
        email = notacat@hotmail.cat
    EOS
    system "git", "init"
    touch "homebrew"
    system "git", "add", "."
    system "git", "commit", "--message", "brewing"

    assert_equal "", shell_output("#{bin}/git-octopus 2>&1").strip
  end
end
