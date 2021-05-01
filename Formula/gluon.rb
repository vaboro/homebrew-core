class Gluon < Formula
  desc "Static, type inferred and embeddable language written in Rust"
  homepage "https://gluon-lang.org"
  url "https://github.com/gluon-lang/gluon/archive/v0.17.1.tar.gz"
  sha256 "7d81ded58d062098f2dc44f3c86076b37fa5fca0c1a4d349922d13b447fdcdf0"
  license "MIT"
  head "https://github.com/gluon-lang/gluon.git"

  livecheck do
    url "https://github.com/gluon-lang/gluon/releases/latest"
    regex(%r{href=.*?/tag/v?(\d+(?:\.\d+)+)["' >]}i)
  end

  bottle do
    sha256 cellar: :any_skip_relocation, catalina:    "a33dc9492de59e81d955a15cc08683642a2b9212f634ac34b05dc655a3b78b0b"
    sha256 cellar: :any_skip_relocation, mojave:      "8afb0cf0ee97de2828321adb5998543c6b2fc1a923da02974ddf6a789bbf3d1b"
    sha256 cellar: :any_skip_relocation, high_sierra: "aa7eb03685fd24f3b5a2f1f71268279cff482cbcda5c998a1850c209bd22ea47"
  end

  depends_on "rust" => :build

  def install
    cd "repl" do
      system "cargo", "install", *std_cargo_args
    end
  end

  test do
    (testpath/"test.glu").write <<~EOS
      let io = import! std.io
      io.print "Hello world!\\n"
    EOS
    assert_equal "Hello world!\n", shell_output("#{bin}/gluon test.glu")
  end
end
