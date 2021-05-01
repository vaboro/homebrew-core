class Cifer < Formula
  desc "Work on automating classical cipher cracking in C"
  homepage "https://code.google.com/p/cifer/"
  url "https://storage.googleapis.com/google-code-archive-downloads/v2/code.google.com/cifer/cifer-1.2.0.tar.gz"
  sha256 "436816c1f9112b8b80cf974596095648d60ffd47eca8eb91fdeb19d3538ea793"
  license "GPL-3.0"

  bottle do
    sha256 cellar: :any_skip_relocation, catalina:    "ce4a7d9b846388eae2309dbd0a1f0493b533cbefef85ae50ff97648b6a46600c"
    sha256 cellar: :any_skip_relocation, mojave:      "ed647fac83a0f0605c4fbf0492be1568199a60473e20ac455feb4ff1abea1946"
    sha256 cellar: :any_skip_relocation, high_sierra: "04d95a6448d38450079196139c6e6d5b5811265444c9abf8fe93b7424181a222"
    sha256 cellar: :any_skip_relocation, sierra:      "875e676d7866fd3ba2c8b70806838068775ffbc1102c56ca52d041155b2ade43"
    sha256 cellar: :any_skip_relocation, el_capitan:  "86cbc00f11a5818f48ee67bdc0fa5f2692cc7f37ae6c2c5eb237338c7dc6919b"
    sha256 cellar: :any_skip_relocation, yosemite:    "bde7d97d9ef2a07c481ff8c5ec717fb2ec455fdef864db2a1a7b3056aa1934d2"
    sha256 cellar: :any_skip_relocation, mavericks:   "f4e2f4024a8daf1e2a1fc071113947561c803503fa242b7df7970e8979cf10be"
  end

  def install
    system "make", "prefix=#{prefix}",
                   "CC=#{ENV.cc}",
                   "CFLAGS=#{ENV.cflags}",
                   "LDFLAGS=#{ENV.ldflags}",
                   "install"
  end

  test do
    assert_match version.to_s, pipe_output("#{bin}/cifer")
  end
end
