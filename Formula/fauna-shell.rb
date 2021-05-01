require "language/node"

class FaunaShell < Formula
  desc "Interactive shell for FaunaDB"
  homepage "https://fauna.com/"
  url "https://registry.npmjs.org/fauna-shell/-/fauna-shell-0.11.5.tgz"
  sha256 "6f13bf92cb812b9bb02ce2e6e617c21a05e2f06ce721a0eb4a1a045d48d7cdff"
  license "MPL-2.0"

  livecheck do
    url :stable
  end

  bottle do
    sha256 cellar: :any_skip_relocation, catalina:    "daf47c5c95fdd585174b163460de46222f00b5b33f4d2c40841bd776c3eaf320"
    sha256 cellar: :any_skip_relocation, mojave:      "87851f867bc3abac318d5daefa3ca5a47418bef8fbfec7d3c36c1ea7ce1f852d"
    sha256 cellar: :any_skip_relocation, high_sierra: "c286772fc79797ad48cea7b0691d15daa2b487892734391fb5a0c7ed0ad40a5e"
  end

  depends_on "node"

  def install
    system "npm", "install", *Language::Node.std_npm_install_args(libexec)
    bin.install_symlink Dir["#{libexec}/bin/*"]
  end

  test do
    output = shell_output("#{bin}/fauna list-endpoints 2>&1", 1)
    assert_match "No endpoints defined", output

    pipe_output("#{bin}/fauna add-endpoint https://db.fauna.com:443", "your_fauna_secret\nfauna_endpoint\n")

    output = shell_output("#{bin}/fauna list-endpoints")
    assert_equal "fauna_endpoint *\n", output
  end
end
