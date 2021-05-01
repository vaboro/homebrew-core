class HaskellStack < Formula
  desc "Haskell Tool Stack"
  homepage "https://haskellstack.org/"
  url "https://github.com/commercialhaskell/stack/archive/v2.3.3.tar.gz"
  sha256 "57042c0c7b53a6f8dba7f31679e9049c28351a86b8bc2786f7e37eda4733634e"
  license "BSD-3-Clause"
  head "https://github.com/commercialhaskell/stack.git"

  livecheck do
    url "https://github.com/commercialhaskell/stack/releases/latest"
    regex(%r{href=.*?/tag/v?(\d+(?:\.\d+)+)["' >]}i)
  end

  bottle do
    sha256 cellar: :any_skip_relocation, catalina:    "0e72e5dcc47ad2a71d842bde6aa742a0ae87d68d5fc22c948db6585d2be400da"
    sha256 cellar: :any_skip_relocation, mojave:      "4407ef8eb595ebd28d5d2a1256c0356466cd4239a2b95e99ffd02b0b306a7ffb"
    sha256 cellar: :any_skip_relocation, high_sierra: "4f3617f2778d5f30f46c8a6c20ccbe7ea4488332734b9b8ca399e476b6dfd03f"
  end

  depends_on "cabal-install" => :build
  depends_on "ghc" => :build

  uses_from_macos "zlib"

  on_linux do
    depends_on "gmp"
  end

  def install
    system "cabal", "v2-update"
    system "cabal", "v2-install", *std_cabal_v2_args
  end

  test do
    system bin/"stack", "new", "test"
    assert_predicate testpath/"test", :exist?
    assert_match "# test", File.read(testpath/"test/README.md")
  end
end
