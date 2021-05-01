class Hostess < Formula
  desc "Idempotent command-line utility for managing your /etc/hosts file"
  homepage "https://github.com/cbednarski/hostess"
  url "https://github.com/cbednarski/hostess/archive/v0.5.2.tar.gz"
  sha256 "ece52d72e9e886e5cc877379b94c7d8fe6ba5e22ab823ef41b66015e5326da87"
  license "MIT"
  head "https://github.com/cbednarski/hostess.git"

  bottle do
    sha256 cellar: :any_skip_relocation, catalina:    "80480773a167fdcad3fadb3feeb298b51aeb89aec5863204f512f941af7271da"
    sha256 cellar: :any_skip_relocation, mojave:      "f3f06881067507c0d115209d515e6ebbe4090d7aa8fcff7bc685027c49ea6479"
    sha256 cellar: :any_skip_relocation, high_sierra: "15050f5b2f5936fe74e47937323c8a872ec12b75ed639b3df2c6eac11cf7da6f"
  end

  depends_on "go" => :build

  def install
    ENV["GOOS"] = "darwin"
    ENV["GOARCH"] = "amd64"

    system "go", "build", "-ldflags", "-s -w -X main.version=#{version}", "-o", bin/"hostess"
  end

  test do
    assert_match "localhost", shell_output("#{bin}/hostess ls 2>&1")
  end
end
