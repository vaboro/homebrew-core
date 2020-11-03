class Stow < Formula
  desc "Organize software neatly under a single directory tree (e.g. /usr/local)"
  homepage "https://www.gnu.org/software/stow/"
  url "https://ftp.gnu.org/gnu/stow/stow-2.3.1.tar.gz"
  mirror "https://ftpmirror.gnu.org/stow/stow-2.3.1.tar.gz"
  sha256 "09d5d99671b78537fd9b2c0b39a5e9761a7a0e979f6fdb7eabfa58ee45f03d4b"
  license "GPL-3.0"

  livecheck do
    url :stable
  end

  bottle do
    cellar :any_skip_relocation
    sha256 "c99a90dc5e3db8ebcb017df044723fb4e6cce7fb94aa24cf46c8d2c0665bf9a0" => :catalina
    sha256 "409987564f7779d6a1db75f64e54c4713ecd9b9e006abac931f8e8d645bdac92" => :mojave
    sha256 "409987564f7779d6a1db75f64e54c4713ecd9b9e006abac931f8e8d645bdac92" => :high_sierra
    sha256 "cbc7a61940a343aff46fdb6190dc26a359d26c9c468c05b1dbde2484a066ceb6" => :sierra
  end

  def install
    system "./configure", "--prefix=#{prefix}"
    system "make", "install"
  end

  test do
    (testpath/"test").mkpath
    system "#{bin}/stow", "-nvS", "test"
  end
end
