class Xsv < Formula
  desc "Fast CSV toolkit written in Rust"
  homepage "https://github.com/BurntSushi/xsv"
  url "https://github.com/BurntSushi/xsv/archive/0.13.0.tar.gz"
  sha256 "2b75309b764c9f2f3fdc1dd31eeea5a74498f7da21ae757b3ffd6fd537ec5345"
  head "https://github.com/BurntSushi/xsv.git"

  bottle do
    rebuild 2
    sha256 cellar: :any_skip_relocation, catalina:    "b077e2fd6f968d6a3fa5c22a145e134bcead5cbe50ff20c78495937cbee7ea1d"
    sha256 cellar: :any_skip_relocation, mojave:      "ade2c436c1acf011ef7807b01a2783f6c31c0cacf066e51db904adefd99d4a14"
    sha256 cellar: :any_skip_relocation, high_sierra: "557ef267b773911347df0d1960040f2d28e20c3680637b8af5bd89edc77bcce2"
  end

  depends_on "rust" => :build

  def install
    system "cargo", "install", *std_cargo_args
  end

  test do
    (testpath/"test.csv").write("first header,second header")
    system "#{bin}/xsv", "stats", "test.csv"
  end
end
