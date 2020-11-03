class Minizinc < Formula
  desc "Medium-level constraint modeling language"
  homepage "https://www.minizinc.org/"
  url "https://github.com/MiniZinc/libminizinc/archive/2.4.3.tar.gz"
  sha256 "c5c379b0275cc6c0fefd4568e621a43b6f1f0b4af793fea5995be7c6cf73cc07"
  license "MPL-2.0"
  head "https://github.com/MiniZinc/libminizinc.git", branch: "develop"

  bottle do
    cellar :any_skip_relocation
    rebuild 1
    sha256 "de77b7f987cc6bded664d6467dead64f56706c41ae76610fcf4929d12a30d90e" => :catalina
    sha256 "6e007ff9719ca90fb5840d363e96237718fbcc225f1616adf516fc85a8d43031" => :mojave
    sha256 "f4ca6c6e0495880b7990a438f7c06a6bf9d91bab85d6f1497944ae7370a4e911" => :high_sierra
  end

  depends_on "cmake" => :build
  depends_on arch: :x86_64

  def install
    mkdir "build" do
      system "cmake", "..", *std_cmake_args
      system "cmake", "--build", ".", "--target", "install"
    end
  end

  test do
    system bin/"mzn2doc", pkgshare/"std/all_different.mzn"
  end
end
