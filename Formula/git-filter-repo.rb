class GitFilterRepo < Formula
  include Language::Python::Shebang

  desc "Quickly rewrite git repository history"
  homepage "https://github.com/newren/git-filter-repo"
  url "https://github.com/newren/git-filter-repo/releases/download/v2.28.0/git-filter-repo-2.28.0.tar.xz"
  sha256 "fdee8d2138d31d10d821bb05e9be52dd2ecc4e7f08b5c2d1451dda1aa6814669"
  license "MIT"

  bottle :unneeded

  # ignore git dependency audit:
  #  * Don't use git as a dependency (it's always available)
  # But we require Git 2.22.0+
  # https://github.com/Homebrew/homebrew-core/pull/46550#issuecomment-563229479
  depends_on "git"
  depends_on "python@3.8"

  def install
    rewrite_shebang detected_python_shebang, "git-filter-repo"
    bin.install "git-filter-repo"
    man1.install "Documentation/man1/git-filter-repo.1"
  end

  test do
    system "#{bin}/git-filter-repo", "--version"

    system "git", "init"
    system "git", "config", "user.name", "BrewTestBot"
    system "git", "config", "user.email", "BrewTestBot@example.com"

    touch "foo"
    system "git", "add", "foo"
    system "git", "commit", "-m", "foo"
    # Use --force to accept non-fresh clone run:
    # Aborting: Refusing to overwrite repo history since this does not look like a fresh clone.
    # (expected freshly packed repo)
    system "#{bin}/git-filter-repo", "--path-rename=foo:bar", "--force"

    assert_predicate testpath/"bar", :exist?
  end
end
