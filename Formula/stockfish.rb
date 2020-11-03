class Stockfish < Formula
  desc "Strong open-source chess engine"
  homepage "https://stockfishchess.org/"
  url "https://github.com/official-stockfish/Stockfish/archive/sf_12.tar.gz"
  sha256 "d1ec11d1cb8dfc5b33bcd6ec89ed0bafb3951cc1690851448a2696caa2022899"
  license "GPL-3.0-only"
  head "https://github.com/official-stockfish/Stockfish.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "04832aaf954ad2c9f50909fc8d03958e445a9e784d4c43b04d5cdcbd8232b4dd" => :catalina
    sha256 "a2fd4c1073710d99d49a34e4a77399915e13829dab269774beb71f48e087461f" => :mojave
    sha256 "9c65cfd27113438abd3823e5172b58816b9081f8b41123e32da8c72d590121e2" => :high_sierra
  end

  def install
    arch = if MacOS.version.requires_popcnt?
      "x86-64-modern"
    else
      "x86-64"
    end

    system "make", "-C", "src", "build", "ARCH=#{arch}"
    bin.install "src/stockfish"
  end

  test do
    system "#{bin}/stockfish", "go", "depth", "20"
  end
end
