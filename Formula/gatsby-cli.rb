require "language/node"

class GatsbyCli < Formula
  desc "Gatsby command-line interface"
  homepage "https://www.gatsbyjs.org/docs/gatsby-cli/"
<<<<<<< HEAD
<<<<<<< HEAD
  url "https://registry.npmjs.org/gatsby-cli/-/gatsby-cli-2.7.29.tgz"
  sha256 "d13c33580f8acad2622387aa5a6b22ec825dab30b215c8eb8bc8f7b15894a3cf"

  bottle do
    cellar :any_skip_relocation
    sha256 "f9b689c5f2d432e8116274592aed70f46a984fb0a4c4df360f5eeda4ae9541dd" => :mojave
    sha256 "b28662b2463ffd2388b72ef9dcef714ff89a48c8a9b5b755dc4828dc8d497477" => :high_sierra
    sha256 "1cf06602e5f03d1ba97f5a08ff75f21189e71a1c94ed2add8280971c5343a556" => :sierra
=======
  url "https://registry.npmjs.org/gatsby-cli/-/gatsby-cli-2.7.33.tgz"
  sha256 "a6ae227ec6b015e0d4d0b3c6ed466964e12d991b3d6622ee7a1775b30bc3957b"

  bottle do
    cellar :any_skip_relocation
    sha256 "6b7ea744bfd61c416582e4dc92f3943c0bb8e35ca8995fa3f0b89d67f8d5e9e2" => :mojave
    sha256 "119a8cf11c74dd0f0fb77e61923a4942cc05db22fdb18af6576e984000efeb7d" => :high_sierra
    sha256 "a5b10e591502765911891092169e7128d8635034f8f774dd92d90d4bcdae79e4" => :sierra
>>>>>>> upstream/master
=======
  # gatsby-cli should only be updated every 10 releases on multiples of 10
  url "https://registry.npmjs.org/gatsby-cli/-/gatsby-cli-2.12.90.tgz"
  sha256 "37572b832940c61b58a288c816e41aefefb6356a4ac4a7b567a6216e67a3954c"
  license "MIT"

  livecheck do
    url :stable
  end

  bottle do
    cellar :any_skip_relocation
    sha256 "8c40749f4e362ad58e1312428882f13e1cedc3cf612ca02d82fd9efff7d898c0" => :catalina
    sha256 "dedfd0cdfeaf1238995b448e68d847c52d4a8c942fe5eb2eb30acc84930f9540" => :mojave
    sha256 "731794bbd7da8e7e18d38e0f41e7950ccaa33cdb11069f6de020d1a011aad2c5" => :high_sierra
>>>>>>> upstream/master
  end

  depends_on "node"

  def install
    system "npm", "install", *Language::Node.std_npm_install_args(libexec)
    bin.install_symlink Dir["#{libexec}/bin/*"]

    # Avoid references to Homebrew shims
    rm_f "#{libexec}/lib/node_modules/gatsby-cli/node_modules/websocket/builderror.log"
  end

  test do
    system bin/"gatsby", "new", "hello-world", "https://github.com/gatsbyjs/gatsby-starter-hello-world"
    assert_predicate testpath/"hello-world/package.json", :exist?, "package.json was not cloned"
  end
end
