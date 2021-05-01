class Jshon < Formula
  desc "Parse, read, and create JSON from the shell"
  homepage "http://kmkeen.com/jshon/"
  url "https://github.com/keenerd/jshon/archive/20131105.tar.gz"
  sha256 "28420f6f02c6b762732898692cc0b0795cfe1a59fbfb24e67b80f332cf6d4fa2"
  license "MIT"

  bottle do
    sha256 cellar: :any, catalina:    "ec755371878b6471b6d5fb0dac981f7969dad3a42b9aa2e9be60f7a303b3fffe"
    sha256 cellar: :any, mojave:      "5aa1d640857651175a6fe692f31c0a28b58c7d5b02aac1dc6945c2fce7b76a81"
    sha256 cellar: :any, high_sierra: "c32084666ea13118a66803175575de9b74ca5a04d5a32bdd91883007ef6822b8"
    sha256 cellar: :any, sierra:      "3215b76a79af85c6ae21b7de4e2eff0eb83098c0c5e1ae5b8c870d912498ed13"
    sha256 cellar: :any, el_capitan:  "bab45017500667c7f8cf3b73c513f043cd04da04610cb2dc8a117ad5c9a5b99a"
    sha256 cellar: :any, yosemite:    "a97e9310af44fae5cdd60a0bcbae2bc0190c4d773d6290db3b5e970cd9999395"
  end

  depends_on "jansson"

  def install
    system "make"
    bin.install "jshon"
    man1.install "jshon.1"
  end

  test do
    (testpath/"test.json").write <<~EOS
      {"a":1,"b":2}
    EOS

    assert_equal "2", pipe_output("#{bin}/jshon -l < test.json").strip
  end
end
