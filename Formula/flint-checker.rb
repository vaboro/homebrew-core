class FlintChecker < Formula
  desc "Check your project for common sources of contributor friction"
  homepage "https://github.com/pengwynn/flint"
  url "https://github.com/pengwynn/flint/archive/v0.1.0.tar.gz"
  sha256 "ec865ec5cad191c7fc9c7c6d5007754372696a708825627383913367f3ef8b7f"
  license "MIT"

  bottle do
    sha256 cellar: :any_skip_relocation, catalina:    "48211955f96e66b5254338d9f6ba56e6e35f6680fb0379190f5b4a3d8f6fe6f4"
    sha256 cellar: :any_skip_relocation, mojave:      "8cd18ca30e932554d379b710cd9d1adc9b14c073d2c7bf7f993c4e98c2349947"
    sha256 cellar: :any_skip_relocation, high_sierra: "b1d4e65bc48b267d9d05b31ad5321d534717a5b0122d80a8bf5d483bd4c00662"
    sha256 cellar: :any_skip_relocation, sierra:      "0d246b741b5a09fcb7aa0641ba2322e55db92eb98b755f6528171e0ce82c782e"
    sha256 cellar: :any_skip_relocation, el_capitan:  "be77f701f14ecabf655ddbf92eb132aa0cca9413196343783032a665ce2b33c0"
    sha256 cellar: :any_skip_relocation, yosemite:    "5dcce77a6426af8579cd283a120f6bb3b8cce384f6d4934c995dc7b23779bc51"
  end

  depends_on "go" => :build

  def install
    ENV["GOPATH"] = buildpath
    (buildpath/"src/github.com/pengwynn").mkpath
    ln_sf buildpath, buildpath/"src/github.com/pengwynn/flint"
    system "go", "build", "-o", bin/"flint"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/flint --version")

    shell_output("#{bin}/flint", 2)
    (testpath/"README.md").write("# Readme")
    (testpath/"CONTRIBUTING.md").write("# Contributing Guidelines")
    (testpath/"LICENSE").write("License")
    (testpath/"CHANGELOG").write("changelog")
    (testpath/"CODE_OF_CONDUCT").write("code of conduct")
    (testpath/"script").mkpath
    (testpath/"script/bootstrap").write("Bootstrap Script")
    (testpath/"script/test").write("Test Script")
    shell_output("#{bin}/flint")
  end
end
