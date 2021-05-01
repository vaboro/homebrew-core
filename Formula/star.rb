class Star < Formula
  desc "Standard tap archiver"
  homepage "https://cdrtools.sourceforge.io/private/star.html"
  url "https://downloads.sourceforge.net/project/s-tar/star-1.5.3.tar.bz2"
  sha256 "070342833ea83104169bf956aa880bcd088e7af7f5b1f8e3d29853b49b1a4f5b"

  livecheck do
    url :stable
  end

  bottle do
    sha256 cellar: :any_skip_relocation, catalina:    "d97f6a6df5eaf3360e7b4c17a475e5417ce268815c01dfcbc94709377a47f6eb"
    sha256 cellar: :any_skip_relocation, mojave:      "8d1e4d304f4ac9c281f3b445f31a1268271eebba6a58f098b4f9339be51218b9"
    sha256 cellar: :any_skip_relocation, high_sierra: "9f4a24f592647071a2ead26c2dba4d86cb664f71cdf4d280037a94748c92ec0c"
    sha256 cellar: :any_skip_relocation, sierra:      "ec7a276b68c0dc946d3320e3cd9cf923d0affdbfa72587ecccb2efa3dc7276cc"
    sha256 cellar: :any_skip_relocation, el_capitan:  "64288e33524b1d1afcc5ae7e6ff5dc1488f1793eba9452e54279054d55e93db3"
    sha256 cellar: :any_skip_relocation, yosemite:    "e3b77b33bc2c8ec917ddf41a29d937de1492253c7d039f5747e44e2361cfadd4"
    sha256 cellar: :any_skip_relocation, mavericks:   "410f5637ccdf115373b5a08c5037cdb8c66cb113719ead191070d087eae43285"
  end

  depends_on "smake" => :build

  def install
    ENV.deparallelize # smake does not like -j

    system "smake", "GMAKE_NOWARN=true", "INS_BASE=#{prefix}", "INS_RBASE=#{prefix}", "install"

    # Remove symlinks that override built-in utilities
    (bin+"gnutar").unlink
    (bin+"tar").unlink
    (man1+"gnutar.1").unlink

    # Remove useless files
    lib.rmtree
    include.rmtree

    # Remove conflicting files
    %w[makefiles makerules].each { |f| (man5/"#{f}.5").unlink }
  end

  test do
    system "#{bin}/star", "--version"
  end
end
