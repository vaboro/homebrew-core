class Html2text < Formula
  desc "Advanced HTML-to-text converter"
  homepage "http://www.mbayer.de/html2text/"
  url "https://github.com/grobian/html2text/archive/v2.0.0.tar.gz"
  sha256 "061125bfac658c6d89fa55e9519d90c5eeb3ba97b2105748ee62f3a3fa2449de"
  license "GPL-2.0"
  head "https://github.com/grobian/html2text.git"

  bottle do
    sha256 cellar: :any_skip_relocation, catalina:    "567d2c7e25a24c445ad54074e9ff3ee6edfce3fe7fe960966dcd49a488b2affb"
    sha256 cellar: :any_skip_relocation, mojave:      "55a8fe864bc8e05e7e2fa0085e22adb251fdeeee3fd463e326224a3dff78c773"
    sha256 cellar: :any_skip_relocation, high_sierra: "b0c913f98f9169669395d57c28c45d7d6c1dc68c13fdb82ba52a04fefdb00bc5"
  end

  def install
    ENV.cxx11

    system "./configure", "--disable-dependency-tracking",
                          "--disable-debug",
                          "--prefix=#{prefix}"
    system "make", "all"

    bin.install "html2text"
    man1.install "html2text.1"
    man5.install "html2textrc.5"
  end

  test do
    path = testpath/"index.html"
    path.write <<~EOS
      <!DOCTYPE html>
      <html>
        <head><title>Home</title></head>
        <body><p>Hello World</p></body>
      </html>
    EOS

    output = `#{bin}/html2text #{path}`.strip
    assert_equal "Hello World", output
    assert_equal 0, $CHILD_STATUS.exitstatus
  end
end
