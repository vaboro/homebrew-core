class Stone < Formula
  desc "TCP/IP packet repeater in the application layer"
  homepage "https://www.gcd.org/sengoku/stone/"
  url "https://www.gcd.org/sengoku/stone/stone-2.3e.tar.gz"
  sha256 "b2b664ee6771847672e078e7870e56b886be70d9ff3d7b20d0b3d26ee950c670"

  bottle do
    sha256 cellar: :any_skip_relocation, catalina:    "8b37777addb031114cadd5d09ca216ffaff9df2316073077c79c072d9debc761"
    sha256 cellar: :any_skip_relocation, mojave:      "0d2db17e57c53f2be5b1b8feea072923bddd3c86efe37c9a8db6296087ee5687"
    sha256 cellar: :any_skip_relocation, high_sierra: "579a9dee4b6fb57f0f1313a656250b00a428bdff7c2401431bb96d0ef0496c25"
    sha256 cellar: :any_skip_relocation, sierra:      "540bd64b2264bfe03d88ad620a7138a1d96742d6810eec301fd7e5ea63970ee9"
    sha256 cellar: :any_skip_relocation, el_capitan:  "9d4038c7882d2fe256d77340b5e0ec52a551697b9869fb61f3a22b0be917e92b"
    sha256 cellar: :any_skip_relocation, yosemite:    "e01e391d43da23b477186a54f96b0d20bb67c24e1503e20408dc12d025f04def"
    sha256 cellar: :any_skip_relocation, mavericks:   "ab43aca5038bdf014c1a5aaadb9e526626c9c4369dcaeac045b9dce6514b30bc"
  end

  def install
    system "make", "macosx"
    bin.install "stone"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/stone -h 2>&1", 1)
  end
end
