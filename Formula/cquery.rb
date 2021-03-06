class Cquery < Formula
  desc "C/C++ language server"
  homepage "https://github.com/cquery-project/cquery"
  # pull from git tag to get submodules
  url "https://github.com/cquery-project/cquery.git",
      tag:      "v20180718",
      revision: "b523aa928acf8ffb3de6b22c79db7366a9672489"
  license "MIT"
  head "https://github.com/cquery-project/cquery.git"

  bottle do
    sha256 catalina:    "8d2680e2397cbaa0a6c6cb2ffa00da5a10d3c2b89f5faeaa493c066417199e87"
    sha256 mojave:      "e35aabf6a4b2b0ac21c59b6e6121aa3bc8cc623ca7fe1bd763dd6430d3339eae"
    sha256 high_sierra: "ee46fd2b279edc3b52df5ca9b84bdce404bb888f8a7d31e092b3fda33285a02b"
    sha256 sierra:      "ac3ad5aada30ca31d70f36e6e3ba76d96aa0e235ccdd62259a086578fe182b44"
  end

  depends_on "cmake" => :build
  depends_on "llvm"

  # error: 'shared_timed_mutex' is unavailable: introduced in macOS 10.12
  depends_on macos: :sierra

  def install
    system "cmake", ".", "-DSYSTEM_CLANG=ON", *std_cmake_args
    system "make", "install"
  end

  test do
    system bin/"cquery", "--test-unit"
  end
end
