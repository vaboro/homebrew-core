class Etl < Formula
  desc "Extensible Template Library"
  homepage "https://synfig.org"
  url "https://downloads.sourceforge.net/project/synfig/releases/1.2.2/source/ETL-1.2.2.tar.gz"
  sha256 "0dc19c5a6c9e964054ca3af6dacd6ab0c198d78071cfab2aebac178afe454d8b"
  license "GPL-3.0"

  livecheck do
    url :stable
    regex(%r{url=.*?/releases/.+?/ETL[._-]v?(\d+(?:\.\d+)+)\.t}i)
  end

  bottle do
    sha256 cellar: :any_skip_relocation, catalina:    "1ff4de15ba9b82ef2afe44be648f1c42031d7bc4e9e1538e3e1951cfa353ecaa"
    sha256 cellar: :any_skip_relocation, mojave:      "b775dfeb3634c3b4ff3828239250394328b5c971e472cb775a0590d94bcdc6f8"
    sha256 cellar: :any_skip_relocation, high_sierra: "b775dfeb3634c3b4ff3828239250394328b5c971e472cb775a0590d94bcdc6f8"
    sha256 cellar: :any_skip_relocation, sierra:      "507d4f4b35d0e075869446600e36e0f9f382014e99bf16a07d77f2c256cbc594"
  end

  def install
    system "./configure", "--disable-debug",
                          "--disable-dependency-tracking",
                          "--prefix=#{prefix}"
    system "make", "install"
  end

  test do
    (testpath/"test.cpp").write <<~EOS
      #include <ETL/misc>
      int main(int argc, char *argv[])
      {
        int rv = etl::ceil_to_int(5.5);
        return 6 - rv;
      }
    EOS
    flags = %W[
      -I#{include}
      -lpthread
    ]
    system ENV.cxx, "test.cpp", "-o", "test", *flags
    system "./test"
  end
end
