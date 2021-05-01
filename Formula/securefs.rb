class Securefs < Formula
  desc "Filesystem with transparent authenticated encryption"
  homepage "https://github.com/netheril96/securefs"
  url "https://github.com/netheril96/securefs.git",
    tag:      "0.11.1",
    revision: "dfeebf8406871d020848edde668234715356158c"
  license "MIT"
  head "https://github.com/netheril96/securefs.git"

  bottle do
    sha256 cellar: :any, catalina:    "8a8c7dd74f9b3082b2b128cc058714a27206d910273e4148959a25b7d30c51b5"
    sha256 cellar: :any, mojave:      "9bee23af87518f68df56b862ad0ef88f842ebe65f8feff02e90bf5ab8e91522e"
    sha256 cellar: :any, high_sierra: "632496d8e9ed9fe91d18e9a2c9fef49c920dc091e10108246f8ab2056f75ea38"
  end

  depends_on "cmake" => :build
  depends_on :osxfuse

  def install
    system "cmake", ".", *std_cmake_args
    system "make", "install"
  end

  test do
    system "#{bin}/securefs", "version" # The sandbox prevents a more thorough test
  end
end
