class Convertlit < Formula
  desc "Convert Microsoft Reader format eBooks into open format"
  homepage "http://www.convertlit.com/"
  url "http://www.convertlit.com/clit18src.zip"
  version "1.8"
  sha256 "d70a85f5b945104340d56f48ec17bcf544e3bb3c35b1b3d58d230be699e557ba"

  bottle do
    sha256 cellar: :any_skip_relocation, mojave:      "7d06d34736082be89b9e6c0db2fa42c4d2b4fb15469bef2922003d3d299680c8"
    sha256 cellar: :any_skip_relocation, high_sierra: "f41e31b1f6f53d1441bf670e75e0315f6a0f0e938de75e9973678ed565b6b4b8"
    sha256 cellar: :any_skip_relocation, sierra:      "43e28e7711f27843223b29d351ba0ce03a4deee76bbc99c4bdac50969b8eaeb7"
    sha256 cellar: :any_skip_relocation, el_capitan:  "66b05c2c6371f16620c82b31b507413556b511b859644322c65f4ceea4a83a64"
    sha256 cellar: :any_skip_relocation, yosemite:    "024a9fdb4b58a3e04c12ec300facbac636b3510f8726726c4be93c60cf272ab1"
    sha256 cellar: :any_skip_relocation, mavericks:   "366ce6afb71223d3f14939c5d4d382a90cf56df7920cb41dca0eeae72e809702"
  end

  depends_on "libtommath"

  def install
    inreplace "clit18/Makefile" do |s|
      s.gsub! "-I ../libtommath-0.30", "#{HOMEBREW_PREFIX}/include"
      s.gsub! "../libtommath-0.30/libtommath.a", "#{HOMEBREW_PREFIX}/lib/libtommath.a"
    end

    system "make", "-C", "lib"
    system "make", "-C", "clit18"
    bin.install "clit18/clit"
  end
end
