class Dmagnetic < Formula
  desc "Magnetic Scrolls Interpreter"
  homepage "https://www.dettus.net/dMagnetic/"
  url "https://www.dettus.net/dMagnetic/dMagnetic_0.25.tar.bz2"
  sha256 "5cbe2aee7e8870628eaeaf2fe3fc550f31736fe617897648a77283be6a381e6d"
  license "BSD-2-Clause"

  bottle do
    sha256 cellar: :any_skip_relocation, catalina:    "e4731f50eb5fb519c288b177211866aa5c9564c3128ccfd90cace9f17349f6ef"
    sha256 cellar: :any_skip_relocation, mojave:      "e3fb3df08f05eaef9fcfd093300312997523292bae8c9497e008b3404d122faf"
    sha256 cellar: :any_skip_relocation, high_sierra: "c3d655f6787a40b59db97b491c3e057da87044f3a382debd00ec0bf61e528890"
  end

  def install
    system "make", "PREFIX=#{prefix}", "install"
    (share/"games/dMagnetic").install "testcode/minitest.mag", "testcode/minitest.gfx"
  end

  test do
    assert_match "ab9ec7787593e310ac4d8187db3f6cee", \
      shell_output("echo Hello | #{bin}/dMagnetic "\
        "-vmode none -vcols 300 -vrows 300 -vecho -sres 1024x768 "\
        "-mag #{share}/games/dMagnetic/minitest.mag "\
        "-gfx #{share}/games/dMagnetic/minitest.gfx "\
        "| md5").strip
  end
end
