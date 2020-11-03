class Trimage < Formula
  desc "Cross-platform tool for optimizing PNG and JPG files"
  homepage "https://trimage.org"
  url "https://github.com/Kilian/Trimage/archive/1.0.6.tar.gz"
  sha256 "60448b5a827691087a1bd016a68f84d8c457fc29179271f310fe5f9fa21415cf"
  license "MIT"

  bottle do
    cellar :any_skip_relocation
    sha256 "34db72d3e2bbec742fd9d8286919e6dfda53ad2d552c80c1285240b9338ff384" => :catalina
    sha256 "34db72d3e2bbec742fd9d8286919e6dfda53ad2d552c80c1285240b9338ff384" => :mojave
    sha256 "34db72d3e2bbec742fd9d8286919e6dfda53ad2d552c80c1285240b9338ff384" => :high_sierra
  end

  depends_on "advancecomp"
  depends_on "jpegoptim"
  depends_on "optipng"
  depends_on "pngcrush"
  depends_on "pyqt"
  depends_on "python@3.8"

  def install
    system "#{Formula["python@3.8"].opt_bin}/python3", "setup.py", "build"
    system "#{Formula["python@3.8"].opt_bin}/python3", "setup.py", "install", "--prefix=#{prefix}"
  end

  test do
    cp test_fixtures("test.png"), testpath
    cp test_fixtures("test.jpg"), testpath
    assert_match "New Size", shell_output("#{bin}/trimage -f #{testpath}/test.png 2>1")
    assert_match "New Size", shell_output("#{bin}/trimage -f #{testpath}/test.jpg 2>1")
  end
end
