class Xrick < Formula
  desc "Clone of Rick Dangerous"
  homepage "https://www.bigorno.net/xrick/"
  url "https://www.bigorno.net/xrick/xrick-021212.tgz"
  sha256 "aa8542120bec97a730258027a294bd16196eb8b3d66134483d085f698588fc2b"

  bottle do
    sha256 catalina:    "8b155ebc162ed2990de96f1842fb3b880b4ae84fc187664d13696a3c7d1edfe8"
    sha256 mojave:      "632c310d5834fd968c2d908e3721ff62b3a7c01ee97e4b1587b0dad33067674c"
    sha256 high_sierra: "a45d9b27ee02a21aa81ecc8b7eaf2718521388972559003c46fc428d15584f15"
    sha256 sierra:      "03e69c34042ffa8849aaa653f06ae889a6d404797a42c6549ce7de8d3de72dce"
    sha256 el_capitan:  "772f6718786e66657b0647dc7233b3680903a2e16d06fa59a9f804dd33d5096a"
    sha256 yosemite:    "2d4e9e140f15692acd4d0e9f4a9da08d1a3e6f3d3fdbc8d4d799e6d2bde91e8f"
  end

  depends_on "sdl"

  def install
    inreplace "src/xrick.c", "data.zip", "#{pkgshare}/data.zip"
    system "make"
    bin.install "xrick"
    man6.install "xrick.6.gz"
    pkgshare.install "data.zip"
  end

  test do
    assert_match "xrick [version ##{version}]", shell_output("#{bin}/xrick --help", 1)
  end
end
