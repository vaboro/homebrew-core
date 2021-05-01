class Findomain < Formula
  desc "Cross-platform subdomain enumerator"
  homepage "https://github.com/Edu4rdSHL/findomain"
  url "https://github.com/Edu4rdSHL/findomain/archive/2.1.4.tar.gz"
  sha256 "e669e5297c3112ec4e256bef286028220dcb9d46cd8a31e6965cbbc3d2ae3199"
  license "GPL-3.0-or-later"

  bottle do
    sha256 cellar: :any_skip_relocation, catalina:    "738cfda36178883eb8083d531385150cba5213c1831af275121d4fe7f6b3d9fb"
    sha256 cellar: :any_skip_relocation, mojave:      "0165c9c1915bc01105c4df30f8883e16ede8d48d49bc98735e85da90247864be"
    sha256 cellar: :any_skip_relocation, high_sierra: "3470286233010baffcff04f55ef25d5bc8662649a14e17832c69fc307857b84a"
  end

  depends_on "rust" => :build

  def install
    system "cargo", "install", *std_cargo_args
  end

  test do
    assert_match "Good luck Hax0r", shell_output("#{bin}/findomain -t brew.sh")
  end
end
