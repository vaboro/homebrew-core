class Libuvc < Formula
  desc "Cross-platform library for USB video devices"
  homepage "https://github.com/ktossell/libuvc"
  url "https://github.com/ktossell/libuvc/archive/v0.0.6.tar.gz"
  sha256 "42175a53c1c704365fdc782b44233925e40c9344fbb7f942181c1090f06e2873"
  license "BSD-3-Clause"
  head "https://github.com/ktossell/libuvc.git"

  bottle do
    rebuild 1
    sha256 cellar: :any, catalina:    "4051cd7aa8dbf7a5e940a85f8c38900829e66cabfb00be22a592dd3a421e3cca"
    sha256 cellar: :any, mojave:      "1ff736e2499c4da037ff74ea31ebe2be23defd7e316ad974ff57cd9a712c7445"
    sha256 cellar: :any, high_sierra: "c0ec2076095af1c5154bc43d18a5869b5678f026f1b3c76964f136e4ada07717"
    sha256 cellar: :any, sierra:      "1888941024fe1b8ca44f15b98e51390872286c0145806fbd0a61999bab225905"
    sha256 cellar: :any, el_capitan:  "4defbab7e171c20da065eb5e4f2b11b5b27165efbd850e742674be281f3a0fcd"
  end

  depends_on "cmake" => :build
  depends_on "pkg-config" => :build
  depends_on "libusb"

  def install
    system "cmake", ".", *std_cmake_args
    system "make"
    system "make", "install"
  end
end
