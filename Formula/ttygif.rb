class Ttygif < Formula
  desc "Converts a ttyrec file into gif files"
  homepage "https://github.com/icholy/ttygif"
  url "https://github.com/icholy/ttygif/archive/1.5.0.tar.gz"
  sha256 "b5cc9108b1add88c6175e3e001ad4615a628f93f2fffcb7da9e85a9ec7f23ef6"
  license "MIT"

  bottle do
    sha256 cellar: :any_skip_relocation, catalina:    "61f7135b9f03465ac86f26e7b7cad7ca09ec35495841ee868b76f001faefd040"
    sha256 cellar: :any_skip_relocation, mojave:      "34060f2f53d6388461ca29a81938490bb1768aa9f44303c7cce717c2f8ad6246"
    sha256 cellar: :any_skip_relocation, high_sierra: "ab8ee96836d9a9663e94f9dc9e2337a2968a8fe4523f8da166b4e865a1e81ada"
  end

  depends_on "imagemagick"
  depends_on "ttyrec"

  def install
    system "make", "install", "PREFIX=#{prefix}"
  end

  test do
    ENV["TERM_PROGRAM"] = "Something"
    system "#{bin}/ttygif", "--version"
  end
end
