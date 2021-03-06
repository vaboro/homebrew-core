class Dnstop < Formula
  desc "Console tool to analyze DNS traffic"
  homepage "http://dns.measurement-factory.com/tools/dnstop/index.html"
  url "http://dns.measurement-factory.com/tools/dnstop/src/dnstop-20140915.tar.gz"
  sha256 "b4b03d02005b16e98d923fa79957ea947e3aa6638bb267403102d12290d0c57a"
  license "BSD-3-Clause"

  bottle do
    rebuild 1
    sha256 cellar: :any_skip_relocation, catalina:    "61522feaa64c92d28044e88366555a6f816366671728d71e286960b83a176417"
    sha256 cellar: :any_skip_relocation, mojave:      "fc741283d3b21ab68de0972c733b38ac01c363a0588254c41ad19f5591f32bda"
    sha256 cellar: :any_skip_relocation, high_sierra: "4d6b9a2f15e3165ccf63b67752cd4f0d21b128f64b5f22beb2c2b0657e082709"
    sha256 cellar: :any_skip_relocation, sierra:      "dc995c2857fdd5093ae753844ce5c45ed00bae59184528a184e0313b25882802"
    sha256 cellar: :any_skip_relocation, el_capitan:  "1d5b1ad056475ce9a27f40b48cbbf58421e4eb66fd134ac318413de2d025db66"
    sha256 cellar: :any_skip_relocation, yosemite:    "aa3b72d1432e7c13b9b7e0722cde3f7fafef17aff557489662029698929638dc"
    sha256 cellar: :any_skip_relocation, mavericks:   "4a57a6144a94b3eb2cce64ec7f8f97447eafd1c0be2c5789593920d045e9a189"
  end

  def install
    system "./configure", "--prefix=#{prefix}"
    system "make"
    bin.install "dnstop"
    man8.install "dnstop.8"
  end

  test do
    system "#{bin}/dnstop", "-v"
  end
end
