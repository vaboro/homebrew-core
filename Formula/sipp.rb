class Sipp < Formula
  desc "Traffic generator for the SIP protocol"
  homepage "https://sipp.sourceforge.io/"
  url "https://github.com/SIPp/sipp/releases/download/v3.6.0/sipp-3.6.0.tar.gz"
  sha256 "e47e7b11fec0769cf76b30623a66390333bdb20323c66043ca535460858fa1bb"
  license "BSD-3-Clause"

  bottle do
    sha256 cellar: :any_skip_relocation, catalina:    "6e475cbb06a46ae80606b12897928b601b8280fc16e1467c395687a2a93317b1"
    sha256 cellar: :any_skip_relocation, mojave:      "23616329b56c55eb022b055d31dadfdc79fafe5fc224cd342106a1a59afa46dd"
    sha256 cellar: :any_skip_relocation, high_sierra: "822893f07f76031fcd3c0410e2d682dc743c9ac1a9b438361dd1a6a9b6a767b8"
    sha256 cellar: :any_skip_relocation, sierra:      "79f72467ed25cb8c6db260a9fa3e8f130058424b980d9daa07f79fce77159296"
  end

  def install
    system "./configure", "--with-pcap"
    system "make", "DESTDIR=#{prefix}"
    bin.install "sipp"
  end

  test do
    assert_match "SIPp v#{version}", shell_output("#{bin}/sipp -v", 99)
  end
end
