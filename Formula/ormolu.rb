class Ormolu < Formula
  desc "Formatter for Haskell source code"
  homepage "https://github.com/tweag/ormolu"
  url "https://github.com/tweag/ormolu/archive/0.1.2.0.tar.gz"
  sha256 "ef7164d1d32f59e2a3317d82978fb7b66b496dd2c9ed618d224dc9b6ec15123c"
  license "BSD-3-Clause"
  head "https://github.com/tweag/ormolu.git"

  bottle do
    sha256 cellar: :any_skip_relocation, catalina:    "14ca12579e0137130bdb48ee2eaaf1610f526bb0e0cd30c1444c1ccbef86a6a2"
    sha256 cellar: :any_skip_relocation, mojave:      "393da89deaa62a76fe3d0453736f0f94ba8d5ba4ea69b47ea453bcb2351e1f71"
    sha256 cellar: :any_skip_relocation, high_sierra: "09803d60ccbd9bb84b5dd99b8f387c2d4553ffd38aa02545596bc19b38ea4b67"
  end

  depends_on "cabal-install" => :build
  depends_on "ghc" => :build

  def install
    system "cabal", "v2-update"
    system "cabal", "v2-install", *std_cabal_v2_args
  end

  test do
    (testpath/"test.hs").write <<~EOS
      foo =
        f1
        p1
        p2 p3

      foo' =
        f2 p1
        p2
        p3

      foo'' =
        f3 p1 p2
        p3
    EOS
    expected = <<~EOS
      foo =
        f1
          p1
          p2
          p3

      foo' =
        f2
          p1
          p2
          p3

      foo'' =
        f3
          p1
          p2
          p3
    EOS
    assert_equal expected, shell_output("#{bin}/ormolu test.hs")
  end
end
