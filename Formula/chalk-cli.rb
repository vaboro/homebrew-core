require "language/node"

class ChalkCli < Formula
  desc "Terminal string styling done right"
  homepage "https://github.com/chalk/chalk-cli"
  url "https://registry.npmjs.org/chalk-cli/-/chalk-cli-4.1.0.tgz"
  sha256 "000d9fa6969d5da248fc3b415c48e76a999e2f3e04594f14c335baab058c7a7c"
  license "MIT"

  livecheck do
    url :stable
  end

  bottle do
    sha256 cellar: :any_skip_relocation, catalina:    "3761c3a51544b65bfc8868207049ef0af1bf6d4c80f8fec674884c52f783007e"
    sha256 cellar: :any_skip_relocation, mojave:      "f3ddf504d4a6d55285398c1fda8c5b9b7d8ff0c7e7594afcd0288fa8adf3ab81"
    sha256 cellar: :any_skip_relocation, high_sierra: "a0966f5c0489b4edd61e8f733bd1571de8c80deec7c715cca6084f3fc72d2abf"
  end

  depends_on "node"

  def install
    system "npm", "install", *Language::Node.std_npm_install_args(libexec)
    bin.install_symlink Dir["#{libexec}/bin/*"]
  end

  test do
    assert_match "hello, world!", pipe_output("#{bin}/chalk bold cyan", "hello, world!")
  end
end
