class Globe < Formula
  desc "Prints ASCII graphic of currently-lit side of the Earth"
  homepage "https://www.acme.com/software/globe/"
  url "https://www.acme.com/software/globe/globe_14Aug2014.tar.gz"
  version "0.0.20140814"
  sha256 "5507a4caaf3e3318fd895ab1f8edfa5887c9f64547cad70cff3249350caa6c86"

  bottle do
    sha256 cellar: :any_skip_relocation, catalina:    "813ec2be614ca68c63af2b1830b6aa5129c5b65ce3c0d3aa6fa6d8f826f674e5"
    sha256 cellar: :any_skip_relocation, mojave:      "a5a07b3dfade00debcfe123b8ce103ec33649c9152f89676fce5b70c0f0fec8a"
    sha256 cellar: :any_skip_relocation, high_sierra: "f61e4026debce10b4611ce963f5387721296b9bd84120eecfcff275facf76f32"
    sha256 cellar: :any_skip_relocation, sierra:      "20488fcd0137e0d2a05ea3bfa91adc2f45460f05bb01f26e41005ccafc3e8c54"
    sha256 cellar: :any_skip_relocation, el_capitan:  "11acded7be5d1ba22260d039e3daf4fdc4cac49ebcd234c879da655a1532c22f"
    sha256 cellar: :any_skip_relocation, yosemite:    "a3ccdf74813e704ab1c8d50bb32f3f9b3f62110c8a6a143e3df85eb6ab7ecd7d"
    sha256 cellar: :any_skip_relocation, mavericks:   "8ff4dd96c5ab3c846ac61ff66c866e3d4969560611405db6e20436ff75494715"
  end

  def install
    bin.mkpath
    man1.mkpath

    system "make", "all", "install", "BINDIR=#{bin}", "MANDIR=#{man1}"
  end

  test do
    system "#{bin}/globe"
  end
end
