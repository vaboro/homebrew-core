class Rebar < Formula
  desc "Erlang build tool"
  homepage "https://github.com/rebar/rebar"
  url "https://github.com/rebar/rebar/archive/2.6.4.tar.gz"
  sha256 "577246bafa2eb2b2c3f1d0c157408650446884555bf87901508ce71d5cc0bd07"
  license "Apache-2.0"
  head "https://github.com/rebar/rebar.git"

  bottle do
    rebuild 1
    sha256 cellar: :any_skip_relocation, catalina:    "9cf28b95d6114a6eb76e9378f117745bad0c4e304feebae67fb545a6166410b8"
    sha256 cellar: :any_skip_relocation, mojave:      "6c6b5ff9c5b90070a6dcd9bc8d6a6b96807ed74eee4229389f30e3716b347bb8"
    sha256 cellar: :any_skip_relocation, high_sierra: "d5a5ed085e413f898c5a2f36f0696343b08e592d901bcb01ddc9c41098a8aadf"
    sha256 cellar: :any_skip_relocation, sierra:      "9deae896b5a7656fdbbbcdb134f17f776b9ba3b320a007a9ea84c97f1242ea76"
    sha256 cellar: :any_skip_relocation, el_capitan:  "dc9934c431b8435022a1b47400d04357ef1da4bc579e523c14d9e6ddf9d44715"
    sha256 cellar: :any_skip_relocation, yosemite:    "30b03e9b4d9405d3131cbc4d4303797496d264fafed8f708a7a862e73e2e99ea"
  end

  depends_on "erlang"

  def install
    system "./bootstrap"
    bin.install "rebar"

    bash_completion.install "priv/shell-completion/bash/rebar"
    zsh_completion.install "priv/shell-completion/zsh/_rebar" => "_rebar"
    fish_completion.install "priv/shell-completion/fish/rebar.fish"
  end

  test do
    system bin/"rebar", "--version"
  end
end
