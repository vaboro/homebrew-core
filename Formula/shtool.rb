class Shtool < Formula
  desc "GNU's portable shell tool"
  homepage "https://www.gnu.org/software/shtool/"
  url "https://ftp.gnu.org/gnu/shtool/shtool-2.0.8.tar.gz"
  mirror "https://ftpmirror.gnu.org/shtool/shtool-2.0.8.tar.gz"
  sha256 "1298a549416d12af239e9f4e787e6e6509210afb49d5cf28eb6ec4015046ae19"
  license "GPL-2.0"

  livecheck do
    url :stable
  end

  bottle do
    sha256 cellar: :any_skip_relocation, catalina:    "e2f7c7a3b0b39b0b9d161e503310b09443cc8e4dc5283dce371afa0b4d87094a"
    sha256 cellar: :any_skip_relocation, mojave:      "7d9087a21cd6724aa82694ceca768d3044d5ab854c5ba95ae04146b3b83c2bf5"
    sha256 cellar: :any_skip_relocation, high_sierra: "fc22505f6424dece01dcdee55907eebcb490a299763f2f217511fa14c5927711"
    sha256 cellar: :any_skip_relocation, sierra:      "172a4e2c133efcc6235aa3901bbc89ea11c48cfa70833fe67801240236d1757d"
    sha256 cellar: :any_skip_relocation, el_capitan:  "17dcf1289dd178b75b670d8061d54e4b2004feeb7de0d9e1ea43ffb46220e4fd"
    sha256 cellar: :any_skip_relocation, yosemite:    "de69e23a1e88799c78891298045bd8f79ef67ee48b7609fa065c7acdc1ddbde4"
    sha256 cellar: :any_skip_relocation, mavericks:   "14b7ea00fce6bf6df8e684f1f4db589ad4f6bc7051a4a29f34d51fb6d287d0a9"
  end

  def install
    system "./configure", "--prefix=#{prefix}"
    system "make", "install"
  end

  test do
    assert_equal "Hello World!", pipe_output("#{bin}/shtool echo 'Hello World!'").chomp
  end
end
