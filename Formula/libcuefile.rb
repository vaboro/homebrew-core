class Libcuefile < Formula
  desc "Library to work with CUE files"
  homepage "https://www.musepack.net/"
  url "https://files.musepack.net/source/libcuefile_r475.tar.gz"
  version "r475"
  sha256 "b681ca6772b3f64010d24de57361faecf426ee6182f5969fcf29b3f649133fe7"
  license "GPL-2.0"

  livecheck do
    url "https://www.musepack.net/index.php?pg=src"
    regex(/href=.*?libcuefile[._-](r\d+)\.t/i)
  end

  bottle do
    rebuild 1
    sha256 cellar: :any, catalina:    "3069cf9b0261d8cedee8979348227f5c77a5c6dcb8942f9fbea20b3e3f190374"
    sha256 cellar: :any, mojave:      "1e64fe68ce178b904ac44a7a2c017a030c6f0ff87fb18b7c943c8c766f23d186"
    sha256 cellar: :any, high_sierra: "a0b9b31c26ac9dc2704e71834259c0f9d0a12dce4ad4bbcdaae64fea5004ceae"
    sha256 cellar: :any, sierra:      "66ec2d9281a5459326a1b2d220b9f68fa241a6b9f8370324377af6751d60b7fd"
    sha256 cellar: :any, el_capitan:  "fc48e0953e3df489f37ee30214bd50b07020955b02f957a90c699474f09ef974"
    sha256 cellar: :any, yosemite:    "427a043ee4dc777743c80a836c5fa69c4de91ea2510f740db099224f95ed38b4"
    sha256 cellar: :any, mavericks:   "b3336424f211dfdd684537b4674afbe32e86179d9cf36dd3c07c3cb0e624cbb8"
  end

  depends_on "cmake" => :build

  def install
    system "cmake", ".", *std_cmake_args
    system "make", "install"
    include.install "include/cuetools/"
  end
end
