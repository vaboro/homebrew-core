require "language/node"

class AngularCli < Formula
  desc "CLI tool for Angular"
  homepage "https://cli.angular.io/"
<<<<<<< HEAD
  url "https://registry.npmjs.org/@angular/cli/-/cli-8.2.1.tgz"
  sha256 "15a0b18dfa45c39ed8ff29a33927a44eaeb21c1e9b4e647cb1f7229c2d3ad856"

  bottle do
    cellar :any_skip_relocation
    sha256 "00a8ed0603600400ab4994dafdd8b39ad47ae8a7a8cdfab4ee61be2d2d3d1ddf" => :mojave
    sha256 "21552fa7382d61fbc9a362e2a6bfdfd7e9b5c7607cb80c5db0ee0a14e73c5efa" => :high_sierra
    sha256 "43da5d2eb22fb10b725aa861ae416697d44c78740dab0c489df5f5e758ea2879" => :sierra
=======
  url "https://registry.npmjs.org/@angular/cli/-/cli-8.3.3.tgz"
  sha256 "02d589a62632797c2309ca4788b0bed7fade526e897ca692e3cf9aef7d9e9ff7"

  bottle do
    cellar :any_skip_relocation
    sha256 "47a73457a1a7406aeb6b799940c0d781e83c137ea7e1e1d484f14912a9d42593" => :mojave
    sha256 "48f1f66cd56a0e3f4dd7dfb655cb34dfa6cf198331852abd074548cc5f8dafe1" => :high_sierra
    sha256 "a8dc879f09669b9b0420d684fdec6365aba2b5fd759096154baaad67a02f24e1" => :sierra
>>>>>>> upstream/master
  end

  depends_on "node"

  def install
    system "npm", "install", *Language::Node.std_npm_install_args(libexec)
    bin.install_symlink Dir["#{libexec}/bin/*"]
  end

  test do
    system bin/"ng", "new", "angular-homebrew-test", "--skip-install"
    assert_predicate testpath/"angular-homebrew-test/package.json", :exist?, "Project was not created"
  end
end
