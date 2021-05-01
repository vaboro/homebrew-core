class Hlint < Formula
  desc "Haskell source code suggestions"
  homepage "https://github.com/ndmitchell/hlint"
  url "https://hackage.haskell.org/package/hlint-3.2/hlint-3.2.tar.gz"
  sha256 "3ff4143310971e3f9d3c37c4507dd1d8cbe901f5f9aae597105b64dec0f06a3c"
  license "BSD-3-Clause"
  head "https://github.com/ndmitchell/hlint.git"

  livecheck do
    url :stable
  end

  bottle do
    sha256 cellar: :any_skip_relocation, catalina:    "ea96ebff70add4db014bd83c57f71f8f9df4ed1c437942959192b94fbdaac940"
    sha256 cellar: :any_skip_relocation, mojave:      "6b2e4de58ca753b7b91cbcbc004186de64c84be82761ffa8bc0909197449a1b1"
    sha256 cellar: :any_skip_relocation, high_sierra: "65149d639d145c02ff529cc9889c0a909f776654137ce87cd995361673fed7e5"
  end

  depends_on "cabal-install" => :build
  depends_on "ghc" => :build

  uses_from_macos "ncurses"

  def install
    system "cabal", "v2-update"
    system "cabal", "v2-install", *std_cabal_v2_args
    man1.install "data/hlint.1"
  end

  test do
    (testpath/"test.hs").write <<~EOS
      main = do putStrLn "Hello World"
    EOS
    assert_match "No hints", shell_output("#{bin}/hlint test.hs")

    (testpath/"test1.hs").write <<~EOS
      main = do foo x; return 3; bar z
    EOS
    assert_match "Redundant return", shell_output("#{bin}/hlint test1.hs", 1)
  end
end
