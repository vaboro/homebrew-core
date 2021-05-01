class Bsdconv < Formula
  desc "Charset/encoding converter library"
  homepage "https://github.com/buganini/bsdconv"
  url "https://github.com/buganini/bsdconv/archive/11.5.tar.gz"
  sha256 "20137c6937a5785467296e12b18b1b9dff55f021bae3f3eb3eb4fa5826689692"
  license "BSD-2-Clause"
  head "https://github.com/buganini/bsdconv.git"

  bottle do
    sha256 catalina:    "ea7dbfdeede5b0144d00533798f4b76a4af216b12c37a5e5ecaeaac030eab507"
    sha256 mojave:      "c4133e2b55be3a74a241941b4ee3bf4a1a9cacbbe0e5a41827b1229698d79215"
    sha256 high_sierra: "ddbd2053b0cff3e0d5c635b370138d5e4de8f5353621dbcabe616f014f3362c1"
    sha256 sierra:      "9afd5dd285b98bf656bbd0e29fa3594128a312e525e079e4348b1a706e16b16a"
    sha256 el_capitan:  "565a934e96be6ef7726d1c03dbd6eec63ac5ad82678192b544cfe2bff706b1b7"
    sha256 yosemite:    "ccb11937d94df29b9434925b9416291f9d927c2e4669fb39cad96c47912662e5"
  end

  def install
    system "make", "PREFIX=#{prefix}"
    system "make", "PREFIX=#{prefix}", "install"
  end

  test do
    output = pipe_output("#{bin}/bsdconv BIG5:UTF-8", "\263\134\273\134")
    output.force_encoding("UTF-8") if output.respond_to?(:force_encoding)
    assert_equal "許蓋", output
  end
end
