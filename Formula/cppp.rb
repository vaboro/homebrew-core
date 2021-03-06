class Cppp < Formula
  desc "Partial Preprocessor for C"
  homepage "https://www.muppetlabs.com/~breadbox/software/cppp.html"
  url "https://www.muppetlabs.com/~breadbox/pub/software/cppp-2.6.tar.gz"
  sha256 "d42cd410882c3b660c77122b232f96c209026fe0a38d819c391307761e651935"

  bottle do
    sha256 cellar: :any_skip_relocation, catalina:    "29ce2b3314eaecc5873039675e85efb132a5ebfa9aac743d1b327b60f66c1122"
    sha256 cellar: :any_skip_relocation, mojave:      "cee25209e4a2ef97d118eac091fa7d5cb6c4ba91329bd713b7ae998e92aaf3c3"
    sha256 cellar: :any_skip_relocation, high_sierra: "93bc70ed7bfe05cf901c8cb8400253c0bce2d245cbb5f47698e8c81c81ed6a85"
    sha256 cellar: :any_skip_relocation, sierra:      "af58094ee1d80d6d09163b42755d827aa5b8be15b636a6ad087b334978ad2e38"
    sha256 cellar: :any_skip_relocation, el_capitan:  "3bb773301b97402f783e506f3ccc339d7363df6e292d255d6b3209e5be8d1c1a"
    sha256 cellar: :any_skip_relocation, yosemite:    "7c18c1844a89ca3a0ee7084b06c908de2288378eaeac09c7872b0eae97129fc3"
    sha256 cellar: :any_skip_relocation, mavericks:   "2765ea90bea4f32ba431ef1f53699a61c2abaf0d3035ed32fb579d42794c9567"
  end

  def install
    system "make"
    bin.install "cppp"
  end

  test do
    (testpath/"hello.c").write <<~EOS
      /* Comments stand for code */
      #ifdef FOO
      /* FOO is defined */
      # ifdef BAR
      /* FOO & BAR are defined */
      # else
      /* BAR is not defined */
      # endif
      #else
      /* FOO is not defined */
      # ifndef BAZ
      /* FOO & BAZ are undefined */
      # endif
      #endif
    EOS
    system "#{bin}/cppp", "-DFOO", "hello.c"
  end
end
