class GitImerge < Formula
  desc "Incremental merge for git"
  homepage "https://github.com/mhagger/git-imerge"
  url "https://github.com/mhagger/git-imerge/archive/v1.1.0.tar.gz"
  sha256 "62692f43591cc7d861689c60b68c55d7b10c7a201c1026096a7efc771df2ca28"
  license "GPL-2.0"
  head "https://github.com/mhagger/git-imerge.git"

  bottle do
    sha256 cellar: :any_skip_relocation, catalina:    "18c1258aaf3bf4614044a508f4e9189ea2a4c751bafb3885f36147662010a435"
    sha256 cellar: :any_skip_relocation, mojave:      "5abf5b539420bb46a8ab7b10e43126b3719e2ebc6e0a37fc18434027ed816995"
    sha256 cellar: :any_skip_relocation, high_sierra: "76aee24eeb5e7615e4cfbd7aaf3aacac8d8729dfcee79d8542a84cbd9b663459"
    sha256 cellar: :any_skip_relocation, sierra:      "76aee24eeb5e7615e4cfbd7aaf3aacac8d8729dfcee79d8542a84cbd9b663459"
    sha256 cellar: :any_skip_relocation, el_capitan:  "76aee24eeb5e7615e4cfbd7aaf3aacac8d8729dfcee79d8542a84cbd9b663459"
  end

  def install
    bin.mkpath
    # Work around Makefile insisting to write to $(DESTDIR)/etc/bash_completion.d
    system "make", "install", "DESTDIR=#{prefix}", "PREFIX="
  end

  test do
    system bin/"git-imerge", "-h"
  end
end
