class Bzip2 < Formula
  desc "Freely available high-quality data compressor"
  homepage "https://sourceware.org/bzip2/"
  url "https://sourceware.org/pub/bzip2/bzip2-1.0.8.tar.gz"
  sha256 "ab5a03176ee106d3f0fa90e381da478ddae405918153cca248e682cd0c4a2269"
  license "bzip2-1.0.6"

  livecheck do
    url "https://sourceware.org/pub/bzip2/"
    regex(/href=.*?bzip2[._-]v?(\d+(?:\.\d+)+)\.t/i)
  end

  bottle do
    sha256 cellar: :any_skip_relocation, catalina:    "b4fd6d4e72285e422d385623273ccd7967f4a3f475335cd49aa61e22c3e7d3d6"
    sha256 cellar: :any_skip_relocation, mojave:      "b8683b824f4cc702d06031c3762ba079e8bc1ea27413f6d08f10e93c539d89fd"
    sha256 cellar: :any_skip_relocation, high_sierra: "c7f2266c2d354c706de5163c23bb7b7204f1f15a85027ea486877a0c5d253336"
    sha256 cellar: :any_skip_relocation, sierra:      "1f11350ccb9a3bd1dd250b5e440d68a5ea65408d4b91f9eae2aa7628e899b7c5"
  end

  keg_only :provided_by_macos

  def install
    inreplace "Makefile", "$(PREFIX)/man", "$(PREFIX)/share/man"

    system "make", "install", "PREFIX=#{prefix}"
  end

  test do
    testfilepath = testpath + "sample_in.txt"
    zipfilepath = testpath + "sample_in.txt.bz2"

    testfilepath.write "TEST CONTENT"

    system "#{bin}/bzip2", testfilepath
    system "#{bin}/bunzip2", zipfilepath

    assert_equal "TEST CONTENT", testfilepath.read
  end
end
