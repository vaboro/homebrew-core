class Fades < Formula
  desc "Automatically handle virtualenvs for python scripts"
  homepage "https://fades.readthedocs.io/"
  url "https://files.pythonhosted.org/packages/cd/b0/381b14139b36dcbd317349ce7c2bd2e2a66bfc772d13e568d71f3d98d977/fades-9.0.tar.gz"
  sha256 "77192b76efbd08dfabce65fe6012805a2383ec1b893c12091efe35fbfd9677f6"
  license "GPL-3.0"
  head "https://github.com/PyAr/fades.git"

  livecheck do
    url :stable
  end

  bottle do
    cellar :any_skip_relocation
    sha256 "89d1989f379c15d5ad71b60fdb11422da663f371e6353028ec36df258d2aca72" => :catalina
    sha256 "89d1989f379c15d5ad71b60fdb11422da663f371e6353028ec36df258d2aca72" => :mojave
    sha256 "89d1989f379c15d5ad71b60fdb11422da663f371e6353028ec36df258d2aca72" => :high_sierra
  end

  depends_on "python@3.8"

  def install
    pyver = Language::Python.major_minor_version "python3"
    ENV.prepend_create_path "PYTHONPATH", libexec/"lib/python#{pyver}/site-packages"
    system "python3", *Language::Python.setup_install_args(libexec)

    bin.install Dir[libexec/"bin/*"]
    bin.env_script_all_files(libexec/"bin", PYTHONPATH: ENV["PYTHONPATH"])
  end

  test do
    (testpath/"test.py").write("print('it works')")
    system "#{bin}/fades", testpath/"test.py"
  end
end
