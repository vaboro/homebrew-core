class Mp3cat < Formula
  desc "Reads and writes mp3 files"
  homepage "https://tomclegg.ca/mp3cat"
  url "https://github.com/tomclegg/mp3cat/archive/0.5.tar.gz"
  sha256 "b1ec915c09c7e1c0ff48f54844db273505bc0157163bed7b2940792dca8ff951"
  license "GPL-2.0-or-later"

  bottle do
    sha256 cellar: :any_skip_relocation, catalina:    "07766f0495aa6c8566d8594a64f5004d1ad56f7e522f90cc1dcaf58001e7d2ab"
    sha256 cellar: :any_skip_relocation, mojave:      "e075f29990e6b5222d3e82ed27de698bed42257097e9bd59f0d60f64ea7ae46b"
    sha256 cellar: :any_skip_relocation, high_sierra: "91152cced755097c42117c72e71f3db9023716e2e9befd1e8a6630fd225e3cea"
    sha256 cellar: :any_skip_relocation, sierra:      "3954ad75806e1948a4e69efb74fb2e86a4920c7e6b61537ca48f696289ca998a"
  end

  def install
    system "make"
    bin.install %w[mp3cat mp3log mp3log-conf mp3dirclean mp3http mp3stream-conf]
  end

  test do
    pipe_output("#{bin}/mp3cat -v --noclean - -", test_fixtures("test.mp3"))
  end
end
