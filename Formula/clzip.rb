class Clzip < Formula
  desc "C language version of lzip"
  homepage "https://www.nongnu.org/lzip/clzip.html"
  url "https://download.savannah.gnu.org/releases/lzip/clzip/clzip-1.11.tar.gz"
  sha256 "d9d51212afa80371dc2546d278ef8ebbb3cd57c06fdd761b7b204497586d24c0"
  license "GPL-2.0"

  livecheck do
    url "https://download.savannah.gnu.org/releases/lzip/clzip/"
    regex(/href=.*?clzip[._-]v?(\d+(?:\.\d+)+)\.t/i)
  end

  bottle do
    sha256 cellar: :any_skip_relocation, catalina:    "ae164ce5fd5a020988dc4e177a25cf19f924b282e561cdabf57577c88940ac2b"
    sha256 cellar: :any_skip_relocation, mojave:      "654a41ff519d4109d38f17c3fb321f130e60c9d72d137674f2dde9ef5cf129be"
    sha256 cellar: :any_skip_relocation, high_sierra: "2a3bf6819a2fdbef49fa7bf1e1cea7ef6c6d090bf8fa787fe7b2a582b2631045"
    sha256 cellar: :any_skip_relocation, sierra:      "26dbdb3a397aa3f62acc15bbbf599a32e5b832564ea6ddc6e15327baac90b5ba"
  end

  def install
    system "./configure", "--disable-debug",
                          "--disable-dependency-tracking",
                          "--prefix=#{prefix}"
    system "make", "install"
    pkgshare.install "testsuite"
  end

  test do
    cp_r pkgshare/"testsuite", testpath
    cd "testsuite" do
      ln_s bin/"clzip", "clzip"
      system "./check.sh"
    end
  end
end
