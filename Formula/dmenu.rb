class Dmenu < Formula
  desc "Dynamic menu for X11"
  homepage "https://tools.suckless.org/dmenu/"
  url "https://dl.suckless.org/tools/dmenu-5.0.tar.gz"
  sha256 "fe18e142c4dbcf71ba5757dbbdea93b1c67d58fc206fc116664f4336deef6ed3"
  license "MIT"
  head "https://git.suckless.org/dmenu/", using: :git

  livecheck do
    url "https://dl.suckless.org/tools/"
    regex(/href=.*?dmenu[._-]v?(\d+(?:\.\d+)+)\.t/i)
  end

  bottle do
    sha256 cellar: :any_skip_relocation, catalina:    "c3c3df399b25d4f8973cb2dad21e9eee4e6c07f60fa639e0239c6e64a134c284"
    sha256 cellar: :any_skip_relocation, mojave:      "28c154b8f5c657ca864305f495d7cd43ed4d39ce3d9fe17ffc101dc808033edf"
    sha256 cellar: :any_skip_relocation, high_sierra: "ed800e10a28a770ff50b0a4462ecb18406d0dec7a4d59f42885b7f6e8ee387db"
  end

  depends_on :x11

  def install
    system "make", "PREFIX=#{prefix}", "install"
  end

  test do
    assert_match(/#{version}/, shell_output("#{bin}/dmenu -v"))
  end
end
