class Stdman < Formula
  desc "Formatted C++11/14/17 stdlib man pages from cppreference.com"
  homepage "https://github.com/jeaye/stdman"
  url "https://github.com/jeaye/stdman/archive/2018.03.11.tar.gz"
  sha256 "d29e6b34cb5ba9905360cee6adcdf8c49e7f11272521bf2e10b42917486840e8"
  license "MIT"
  version_scheme 1
  head "https://github.com/jeaye/stdman.git"

  bottle do
    sha256 cellar: :any_skip_relocation, catalina:    "e6de42bfa765085aca6f89020a7c61142f37d87f84d3290d8d427416ec7ba83f"
    sha256 cellar: :any_skip_relocation, mojave:      "538451fbb366f727f89919bc2056b4b4bde46351d07509559c1793d5816c9099"
    sha256 cellar: :any_skip_relocation, high_sierra: "0f795424e68e066cc1f6c567a5513001481cd610cded75dfab77aa8db42cf9ed"
    sha256 cellar: :any_skip_relocation, sierra:      "d3e640c191d2cf471b37b2121d20ebab97ff353f2d69616cfa7f7227db069beb"
    sha256 cellar: :any_skip_relocation, el_capitan:  "d4b15103ae4011c1f2c9a4e3dcb0b205bfa45595d7ad25d6cb87ec1dc4f395ab"
  end

  on_linux do
    depends_on "man-db" => :test
  end

  def install
    system "./configure", "--prefix=#{prefix}"
    system "make", "install"
  end

  test do
    system "man", "-w", "std::string"
  end
end
