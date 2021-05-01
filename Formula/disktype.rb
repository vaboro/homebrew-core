class Disktype < Formula
  desc "Detect content format of a disk or disk image"
  homepage "https://disktype.sourceforge.io/"
  url "https://downloads.sourceforge.net/project/disktype/disktype/9/disktype-9.tar.gz"
  sha256 "b6701254d88412bc5d2db869037745f65f94b900b59184157d072f35832c1111"
  license "MIT"
  head "https://git.code.sf.net/p/disktype/disktype.git"

  livecheck do
    url :stable
    regex(%r{url=.*?/disktype[._-]v?(\d+(?:\.\d+)*)\.t}i)
  end

  bottle do
    sha256 cellar: :any_skip_relocation, catalina:    "6821d802c4418c949b8e3394893f03cf6152020881096b304ab0c87313fff2e3"
    sha256 cellar: :any_skip_relocation, mojave:      "7b401cb017bbe0f119b590839941ca7a8d77136483f651504382ed595f4280ec"
    sha256 cellar: :any_skip_relocation, high_sierra: "b6212feab524e86a8fc1f3c366092af206dee279900ea2753d331b295dd22c14"
    sha256 cellar: :any_skip_relocation, sierra:      "18ed63d389b55d3dabb84e355323f303013acd46a1905c194b470cc74fc95e4f"
    sha256 cellar: :any_skip_relocation, el_capitan:  "c1f45dc2bdcec2e3b56741bf03d673f3a99534f851d1c77de59d6832d0f75236"
    sha256 cellar: :any_skip_relocation, yosemite:    "cc767e7be270b683021ecb2ef3dd16c77b05e9cdf34ed524c942a89514284f57"
    sha256 cellar: :any_skip_relocation, mavericks:   "36d5db65030be2813c20d3d9df48ae5f2114ea1a3b4f5fb2db324169a52c3c87"
  end

  def install
    system "make"
    bin.install "disktype"
    man1.install "disktype.1"
  end

  test do
    path = testpath/"foo"
    path.write "1234"

    output = shell_output("#{bin}/disktype #{path}")
    assert_match "Regular file, size 4 bytes", output
  end
end
