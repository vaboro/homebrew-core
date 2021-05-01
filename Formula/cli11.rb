class Cli11 < Formula
  desc "Simple and intuitive command-line parser for C++11"
  homepage "https://cliutils.github.io/CLI11/book/"
  url "https://github.com/CLIUtils/CLI11/archive/v1.9.1.tar.gz"
  sha256 "c780cf8cf3ba5ec2648a7eeb20a47e274493258f38a9b417628e0576f473a50b"
  license "BSD-3-Clause"
  head "https://github.com/CLIUtils/CLI11.git"

  bottle do
    sha256 cellar: :any_skip_relocation, catalina:    "bd03843ddff7cee05b6734cca05ecf1452d5c67c1df67c88f0415aee4b0dc270"
    sha256 cellar: :any_skip_relocation, mojave:      "9960ada2b8c3f40fb2993c12a7b0a14cebecac6157844252ad5cdea8b7e6c59b"
    sha256 cellar: :any_skip_relocation, high_sierra: "76c6f767bbcbcf11a05f9579447d94d2d86c0c9dbb2502f63dd05b4b54102fac"
  end

  depends_on "cmake" => :build

  def install
    system "cmake", ".", "-DCLI11_BUILD_DOCS=OFF", "-DCLI11_BUILD_TESTS=OFF", *std_cmake_args
    system "make", "install"
  end

  test do
    (testpath/"test.cpp").write <<~EOS
      #include "CLI/App.hpp"
      #include "CLI/Formatter.hpp"
      #include "CLI/Config.hpp"

      int main(int argc, char** argv) {
          CLI::App app{"App description"};

          std::string filename = "default";
          app.add_option("-r,--result", filename, "A test string");

          CLI11_PARSE(app, argc, argv);
          std::cout << filename << std::endl;
          return 0;
      }
    EOS
    system ENV.cxx, "-std=c++11", "test.cpp", "-o", "test", "-I#{include}"
    assert_equal "foo\n", shell_output("./test -r foo")
  end
end
