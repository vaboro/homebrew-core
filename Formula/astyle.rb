class Astyle < Formula
  desc "Source code beautifier for C, C++, C#, and Java"
  homepage "https://astyle.sourceforge.io/"
  url "https://downloads.sourceforge.net/project/astyle/astyle/astyle%203.1/astyle_3.1_macos.tar.gz"
  sha256 "c4eebbe082eb2cb98f90aafcce3da2daeb774dd092e4cf8b728102fded8d1dcf"
  license "MIT"
  head "https://svn.code.sf.net/p/astyle/code/trunk/AStyle"

  livecheck do
    url :stable
    regex(%r{url=.*?/astyle[._-]v?(\d+(?:\.\d+)+)_}i)
  end

  bottle do
    sha256 cellar: :any_skip_relocation, catalina:    "8bffda383a58eb65c458e00a9cc7dcb3b852a1b5e89a830df7e6eeb594a92f3c"
    sha256 cellar: :any_skip_relocation, mojave:      "65a2f71d86cbc112f12729a0845f47f718cb2751e2e1ccdd78c6c4fc4ad6e817"
    sha256 cellar: :any_skip_relocation, high_sierra: "a58fdf5320a691b37337973e0ca43d2e69f42adbc96d6ab160066c3574373047"
    sha256 cellar: :any_skip_relocation, sierra:      "7a3ff647da72399ee8aa05f1c55806b3bc273409e4a7b2ab0f68930227a47b5f"
    sha256 cellar: :any_skip_relocation, el_capitan:  "e6eb9d95f56fa99005173fcd1c147f9335f55c9ccf52067f57da36e95f7f4c7e"
  end

  def install
    cd "src" do
      system "make", "CXX=#{ENV.cxx}", "-f", "../build/mac/Makefile"
      bin.install "bin/astyle"
    end
  end

  test do
    (testpath/"test.c").write("int main(){return 0;}\n")
    system "#{bin}/astyle", "--style=gnu", "--indent=spaces=4",
           "--lineend=linux", "#{testpath}/test.c"
    assert_equal File.read("test.c"), <<~EOS
      int main()
      {
          return 0;
      }
    EOS
  end
end
