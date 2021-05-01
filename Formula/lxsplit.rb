class Lxsplit < Formula
  desc "Tool for splitting or joining files"
  homepage "https://lxsplit.sourceforge.io/"
  url "https://downloads.sourceforge.net/project/lxsplit/lxsplit/0.2.4/lxsplit-0.2.4.tar.gz"
  sha256 "858fa939803b2eba97ccc5ec57011c4f4b613ff299abbdc51e2f921016845056"
  license "GPL-2.0"

  livecheck do
    url :stable
  end

  bottle do
    sha256 cellar: :any_skip_relocation, catalina:    "8f2c02d85a1aec1e2ec692564896c668cb6d7c4cd28b0d3b1f08da1be7070b07"
    sha256 cellar: :any_skip_relocation, mojave:      "ffc9b9b7e9669e1cff8a46b3930d052ffa149179897134439b1228d8ee178777"
    sha256 cellar: :any_skip_relocation, high_sierra: "da1b73f5843b77ce947ce546fb77a47f2c1b989efbf70fdd61b9d05f81a386b5"
    sha256 cellar: :any_skip_relocation, sierra:      "f4d271c94546ca73b9e5262ff53bf7b51dcde2a83998d5a2e4b663109f2f69d8"
    sha256 cellar: :any_skip_relocation, el_capitan:  "25699d54183a01f446015fb02521a50b3967ef2d250e56bb1fe3fd0a5aaec2e1"
    sha256 cellar: :any_skip_relocation, yosemite:    "d7d8d9eb204599056a4e109c63114c90e3be797d2be700e114cc3675d8eba0bb"
    sha256 cellar: :any_skip_relocation, mavericks:   "da0ee88012d21dc120c7247fd856305fe14a213e38babcd39ab652af06483b7e"
  end

  def install
    bin.mkpath
    inreplace "Makefile", "/usr/local/bin", bin
    system "make"
    system "make", "install"
  end
end
