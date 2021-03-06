class Dynamips < Formula
  desc "Cisco 7200/3600/3725/3745/2600/1700 Router Emulator"
  homepage "https://github.com/GNS3/dynamips"
  url "https://github.com/GNS3/dynamips/archive/v0.2.21.tar.gz"
  sha256 "08587589db2c3fc637e6345aebf4f9706825c12f45d9e2cf40d4189c604656d2"
  license "GPL-2.0"

  livecheck do
    url "https://github.com/GNS3/dynamips/releases/latest"
    regex(%r{href=.*?/tag/v?(\d+(?:\.\d+)+)["' >]}i)
  end

  bottle do
    sha256 cellar: :any_skip_relocation, catalina:    "ecf536589504e42389e91865495faa4eb30ba20adad56bc865c0481e80abefe4"
    sha256 cellar: :any_skip_relocation, mojave:      "db5398464afdb11af6f26cd4780f6e688bed0f35c9fea8f8308f11991987a037"
    sha256 cellar: :any_skip_relocation, high_sierra: "cb9bf6eebd6a7987976e0e2543a807e1b0f16698a1c71eb64e7da56f320fd425"
    sha256 cellar: :any_skip_relocation, sierra:      "08b44502cd3b052592f11f5b75453fabd51fdcfe1a311405c4b7329a701dc424"
  end

  depends_on "cmake" => :build
  depends_on "libelf"

  def install
    ENV.append "CFLAGS", "-I#{Formula["libelf"].include}/libelf"

    ENV.deparallelize
    system "cmake", ".", "-DANY_COMPILER=1", *std_cmake_args
    system "make", "DYNAMIPS_CODE=stable",
                   "DYNAMIPS_ARCH=amd64",
                   "install"
  end

  test do
    system "#{bin}/dynamips", "-e"
  end
end
