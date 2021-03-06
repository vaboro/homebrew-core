class Stlviewer < Formula
  desc "View stl files"
  homepage "https://github.com/vishpat/stlviewer#readme"
  url "https://github.com/vishpat/stlviewer/archive/release-0.1.tar.gz"
  sha256 "55c1969537a7c663273d0d3ab242f0bf61b93d83a7a5ea0786436a2041ecdb8b"

  bottle do
    sha256 cellar: :any_skip_relocation, catalina:    "569d6f8f9b92abd1eb1fa15db1204b7aee1297f8e8cd078eea42da4d26a62db6"
    sha256 cellar: :any_skip_relocation, mojave:      "9179139d7ebb44d3eb664f1a58df0003722a76315dd7211345671ca21b7a59a1"
    sha256 cellar: :any_skip_relocation, high_sierra: "ce4cddb8ffed5a7154be0ce328b283805fc14a1a5769c911e1492a35c1b07a1c"
    sha256 cellar: :any_skip_relocation, sierra:      "9490714ae75aaa68e9c13f9b8d3a9cd87965d09167388d768f6299067774cc69"
    sha256 cellar: :any_skip_relocation, el_capitan:  "e2b6570f4f4fa6042528212a2c0c4798ee7375855e51eaa607e737d746aa2cd0"
    sha256 cellar: :any_skip_relocation, yosemite:    "7bf9c633d050993ecca2013098a3ea544bf25cdd5b5bfdff57607e887e58d0b6"
    sha256 cellar: :any_skip_relocation, mavericks:   "cd58c5ba32e12ebb014a809ce8bdcd4a5b85c3caaedd7063710e409a33640707"
  end

  # https://github.com/vishpat/stlviewer/issues/8
  disable! because: :no_license

  def install
    system "./compile.py"
    bin.install "stlviewer"
  end

  test do
    shell_output("#{bin}/stlviewer 2>&1", 1)
  end
end
