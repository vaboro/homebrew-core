class WoboqCodebrowser < Formula
  desc "Generate HTML from C++ Code"
  homepage "https://code.woboq.org/"
  url "https://github.com/woboq/woboq_codebrowser/archive/2.1.tar.gz"
  sha256 "f7c803260a9a79405c4c2c561443c49702811f38dcf1081238ef024a6654caa0"
  revision 3

  bottle do
    sha256 cellar: :any, catalina:    "1785b502be3a5893629c65428066323ecec0d513917e7ce3f4c4e6245aa75340"
    sha256 cellar: :any, mojave:      "f8aa32aaefa2b3ed4c1d6867d0b4b1945429a09043c5a6649801a3cf62d99a10"
    sha256 cellar: :any, high_sierra: "6aca9d134daeb173b56d1d3b0122c21b461c119add8feca1c52bef0ad91c267d"
    sha256 cellar: :any, sierra:      "6dccc1dbb8c14362b3df29dc93bdfa010ad5de7e734d99a34918f28dc9f8035c"
  end

  depends_on "cmake" => :build
  depends_on "llvm@6"

  def install
    args = std_cmake_args + %W[
      -DLLVM_CONFIG_EXECUTABLE=#{Formula["llvm@6"].opt_bin}/llvm-config
      -DCMAKE_EXPORT_COMPILE_COMMANDS=ON
    ]
    system "cmake", ".", *args
    system "make"
    bin.install "indexgenerator/codebrowser_indexgenerator",
                "generator/codebrowser_generator"
    prefix.install "data"
  end

  test do
    (testpath/"test.c").write <<~EOS
      #include <stdio.h>
      int main() {
      printf(\"hi!\");
      }
    EOS
    system "#{bin}/codebrowser_generator", "-o=#{testpath}", "-p",
                                           "test:#{testpath}",
                                           "#{testpath}/test.c",
                                           "--", "clang", "#{testpath}/test.c"

    assert_predicate testpath/"test/test.c.html", :exist?
    assert_predicate testpath/"refs/printf", :exist?
    assert_predicate testpath/"fnSearch", :exist?
    assert_predicate testpath/"fileIndex", :exist?
  end
end
