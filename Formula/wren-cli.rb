class WrenCli < Formula
  desc "Simple REPL and CLI tool for running Wren scripts"
  homepage "https://github.com/wren-lang/wren-cli"
  url "https://github.com/wren-lang/wren-cli/archive/0.3.0.tar.gz"
  sha256 "a498d2ccb9a723e7163b4530efbaec389cc13e6baaf935e16cbd052a739b7265"
  license "MIT"

  bottle do
    sha256 cellar: :any_skip_relocation, catalina:    "c7f9b2cc6e9913517f802d8ef0142484fd86cb2b972ceb670f1b791b65144937"
    sha256 cellar: :any_skip_relocation, mojave:      "9bf6170802498342b99b6fb167a6ff9254601e911b5c7c74605145985909e6ff"
    sha256 cellar: :any_skip_relocation, high_sierra: "074f4d9634a9e8e7fc33cd302778116121874851aa854830d41e3b73ba50500b"
  end

  def install
    system "make", "-C", "projects/make.mac"
    bin.install "bin/wren_cli"
    pkgshare.install "example"
  end

  test do
    cp pkgshare/"example/hello.wren", testpath
    assert_equal "Hello, world!\n", shell_output("#{bin}/wren_cli hello.wren")
  end
end
