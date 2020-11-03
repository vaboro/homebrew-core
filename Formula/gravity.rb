class Gravity < Formula
  desc "The Gravity Programming Language"
  homepage "https://marcobambini.github.io/gravity/"
  url "https://github.com/marcobambini/gravity/archive/0.7.9.tar.gz"
  sha256 "6fb79176b991420fed4d19dc6e831d4cd8b0b5a591257a32b1eb64fe03530dfa"
  license "MIT"

  bottle do
    cellar :any_skip_relocation
    sha256 "543401f3a030a381022baf39aa857ab38d22be167347b5939b90d70df96f23d9" => :catalina
    sha256 "e56e2dbf6d0eb7d2be1b159caa2ae9073b7417904b91bfc1152d9dceb8c7683c" => :mojave
    sha256 "d34c1ba9ec0b997826e15114bfebed1aa22c425a39187bc5e8d9591d8a1fcc57" => :high_sierra
  end

  def install
    system "make"
    bin.install "gravity"
    doc.install Dir["docs/*"]
  end

  test do
    (testpath/"hello.gravity").write <<~EOS
      func main() {
          System.print("Hello World!")
      }
    EOS
    system bin/"gravity", "-c", "hello.gravity", "-o", "out.json"
    assert_equal "Hello World!\n", shell_output("#{bin}/gravity -q -x out.json")
    assert_equal "Hello World!\n", shell_output("#{bin}/gravity -q hello.gravity")
  end
end
