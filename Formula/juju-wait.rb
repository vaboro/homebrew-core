class JujuWait < Formula
  include Language::Python::Virtualenv

  desc "Juju plugin for waiting for deployments to settle"
  homepage "https://launchpad.net/juju-wait"
  url "https://files.pythonhosted.org/packages/38/3a/f78817ea1f36b53864cec95f4ede230ac611812c76532d882ef493cf6ad2/juju-wait-2.8.3.tar.gz"
  sha256 "4a9fc3aaee9ae99f508d39b6ce5bba53eff8b409ed222f8920e02d0e80e94dc8"
  license "GPL-3.0-only"

  livecheck do
    url :stable
  end

  bottle do
    cellar :any
    sha256 "63d455969326b24e9016938041b17d8bf92aea6b1c100e1f8962580e3b82e1fe" => :catalina
    sha256 "f4a9b3fedc8177c234a239b3584985e64f472b5a1e4801454e4ee68351975205" => :mojave
    sha256 "67a6293bdc2f335eb5312338e06c879822f73516084a92cb4169b78176f168bf" => :high_sierra
  end

  depends_on "juju"
  depends_on "libyaml"
  depends_on "python@3.8"

  resource "PyYAML" do
    url "https://files.pythonhosted.org/packages/64/c2/b80047c7ac2478f9501676c988a5411ed5572f35d1beff9cae07d321512c/PyYAML-5.3.1.tar.gz"
    sha256 "b8eac752c5e14d3eca0e6dd9199cd627518cb5ec06add0de9d32baeee6fe645d"
  end

  def install
    virtualenv_install_with_resources
  end

  test do
    # Note: Testing this plugin requires a Juju environment that's in the
    # process of deploying big software. This plugin relies on those application
    # statuses to determine if an environment is completely deployed or not.
    system "#{bin}/juju-wait", "--version"
  end
end
