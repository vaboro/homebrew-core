class TtySolitaire < Formula
  desc "Ncurses-based klondike solitaire game"
  homepage "https://github.com/mpereira/tty-solitaire"
  url "https://github.com/mpereira/tty-solitaire/archive/v1.3.0.tar.gz"
  sha256 "a270ee639e911a89add6a3c765b0548c9d762e0388c323807708d2509cfa64a0"
  license "MIT"

  bottle do
    sha256 cellar: :any_skip_relocation, catalina:    "8a9b3d7d5b62d5a82b3e37920d76bdd02902c4705d81d2b158b8eb605232b91f"
    sha256 cellar: :any_skip_relocation, mojave:      "ad68372ed5eb8f98d1175fd9b014fb0881a6615fe05e21811ed4327ded9aa066"
    sha256 cellar: :any_skip_relocation, high_sierra: "d35722d89335ba81284acdde82cdb5f370860441950f3acd7290a8e821382147"
  end

  def install
    system "make"
    system "make", "install", "PREFIX=#{prefix}"
  end

  test do
    system "#{bin}/ttysolitaire", "-h"
  end
end
