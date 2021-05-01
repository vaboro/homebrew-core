class Metashell < Formula
  desc "Metaprogramming shell for C++ templates"
  homepage "http://metashell.org"
  url "https://github.com/metashell/metashell/archive/v4.0.0.tar.gz"
  sha256 "02a88204fe36428cc6c74453059e8c399759d4306e8156d0920aefa4c07efc64"
  license "GPL-3.0"

  bottle do
    sha256 cellar: :any_skip_relocation, catalina:    "792f1b46b5f17933b21ec7adb62cf0b6add03ef94e8a73e5e691e12e9aa85049"
    sha256 cellar: :any_skip_relocation, mojave:      "4629398ca4b1bf5cf7779b8d5c9e6f066ea5e96f66063c265f0b13e106a0cba0"
    sha256 cellar: :any_skip_relocation, high_sierra: "05387acf4adf651aaa011d02f5a08ddf49725a550440cc7eb496c1112166852b"
    sha256 cellar: :any_skip_relocation, sierra:      "14fc35b7b932170333d8260b8bda881844ffc68870aeb1a120ebd74072ef900c"
    sha256 cellar: :any_skip_relocation, el_capitan:  "209c4c475fa58cb42a2e98bd34c11a983463465ce4ee5470474177d6740fb2e5"
  end

  depends_on "cmake" => :build

  def install
    ENV.cxx11

    # Build internal Clang
    mkdir "3rd/templight/build" do
      system "cmake", "../llvm", "-DLLVM_ENABLE_TERMINFO=OFF", *std_cmake_args
      system "make", "templight"
    end

    mkdir "build" do
      system "cmake", "..", *std_cmake_args
      system "make", "install"
    end
  end

  test do
    (testpath/"test.hpp").write <<~EOS
      template <class T> struct add_const { using type = const T; };
      add_const<int>::type
    EOS
    output = shell_output("cat #{testpath}/test.hpp | #{bin}/metashell -H")
    assert_match "const int", output
  end
end
