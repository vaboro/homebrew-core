class Gitslave < Formula
  desc "Create group of related repos with one as superproject"
  homepage "https://gitslave.sourceforge.io"
  url "https://downloads.sourceforge.net/project/gitslave/gitslave-2.0.2.tar.gz"
  sha256 "8aa3dcb1b50418cc9cee9bee86bb4b279c1c5a34b7adc846697205057d4826f0"

  livecheck do
    url :stable
  end

  bottle do
    sha256 cellar: :any_skip_relocation, catalina:    "dd32d79091815434db1c465b3f7caa6c6c346449558d82023a6d88ff92c6ba6b"
    sha256 cellar: :any_skip_relocation, mojave:      "0a6c3ead2d8834fb3e728c06bb72d1102ff516cfafd8283e96b03c5a13a44b89"
    sha256 cellar: :any_skip_relocation, high_sierra: "53cbfbd7d9f86fa6ee98b46356d76db4c952adbf9e3cf913f0a3136da56bcb69"
    sha256 cellar: :any_skip_relocation, sierra:      "3ccd021a4393d137eed5c0dfdfe94b325b6142258a7090ad04f9166039efa52d"
    sha256 cellar: :any_skip_relocation, el_capitan:  "e556bf6f7ddfa3e9f6a9b726d80a35404270c96e36ada122fd16d8946394aaa6"
    sha256 cellar: :any_skip_relocation, yosemite:    "395794a75f26acdf034f4ab1541cd9af327d13309517e2553bbcb1fdb4bb0f85"
    sha256 cellar: :any_skip_relocation, mavericks:   "f960d16d68868685850464321b5e4f82be4b85b1e3baa9392f185773818e596f"
  end

  def install
    system "make", "install", "prefix=#{prefix}"
  end

  test do
    output = shell_output("#{bin}/gits --version")
    assert_match "gits version #{version}", output
  end
end
