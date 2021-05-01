require "language/node"

class Coffeescript < Formula
  desc "Unfancy JavaScript"
  homepage "https://coffeescript.org/"
  url "https://registry.npmjs.org/coffeescript/-/coffeescript-2.5.1.tgz"
  sha256 "0ab43e873a859d323f2f5a0069a8bef3acfa72b09769be3350c9d43c5bb489a0"
  license "MIT"
  head "https://github.com/jashkenas/coffeescript.git"

  livecheck do
    url :stable
  end

  bottle do
    sha256 cellar: :any_skip_relocation, catalina:    "090fe2a4161fbcf4e7615cded97c8e9736f7939c1a70a863f37d83141f5cb118"
    sha256 cellar: :any_skip_relocation, mojave:      "acd2a08cb5db976c36508582ac5ff82476ad9dc037ab065353d071cf46c211f5"
    sha256 cellar: :any_skip_relocation, high_sierra: "4ee049a8e7bb8a0c67452cb0b912ef5fd4e402c4948cf1b4cb8a5022640df19e"
  end

  depends_on "node"

  conflicts_with "cake", because: "both install `cake` binaries"

  def install
    system "npm", "install", *Language::Node.std_npm_install_args(libexec)
    bin.install_symlink Dir["#{libexec}/bin/*"]
  end

  test do
    (testpath/"test.coffee").write <<~EOS
      square = (x) -> x * x
      list = [1, 2, 3, 4, 5]

      math =
        root:   Math.sqrt
        square: square
        cube:   (x) -> x * square x

      cubes = (math.cube num for num in list)
    EOS

    system bin/"coffee", "--compile", "test.coffee"
    assert_predicate testpath/"test.js", :exist?, "test.js was not generated"
  end
end
