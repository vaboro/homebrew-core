class Rcm < Formula
  desc "RC file (dotfile) management"
  homepage "https://thoughtbot.github.io/rcm/rcm.7.html"
  url "https://thoughtbot.github.io/rcm/dist/rcm-1.3.4.tar.gz"
  sha256 "9b11ae37449cf4d234ec6d1348479bfed3253daba11f7e9e774059865b66c24a"
  license "BSD-3-Clause"

  bottle do
    cellar :any_skip_relocation
    sha256 "86ac10a7254567afb24c9816f6a80dd90a81bc8cd8619c112e59c0950929ef14" => :catalina
    sha256 "44c9524d9d5ce8ea5310fe6681b040d6c685cec693446f617686f82929d83c6b" => :mojave
    sha256 "7130060f9a26eda6a704eb06bda4c04a4cc0b0980f1c9d3fc5dce876fa5a3fdf" => :high_sierra
  end

  def install
    system "./configure", "--disable-debug",
                          "--disable-dependency-tracking",
                          "--disable-silent-rules",
                          "--prefix=#{prefix}"
    system "make", "install"
  end

  test do
    (testpath/".gitconfig").write <<~EOS
      [user]
      	name = Test User
      	email = test@test.com
    EOS
    assert_match /[Moving|Linking].../x, shell_output("#{bin}/mkrc -v ~/.gitconfig")
  end
end
