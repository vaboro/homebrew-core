class Libdshconfig < Formula
  desc "Distributed shell library"
  homepage "https://www.netfort.gr.jp/~dancer/software/dsh.html.en"
  url "https://www.netfort.gr.jp/~dancer/software/downloads/libdshconfig-0.20.13.tar.gz"
  sha256 "6f372686c5d8d721820995d2b60d2fda33fdb17cdddee9fce34795e7e98c5384"
  license "GPL-2.0"

  bottle do
    rebuild 1
    sha256 cellar: :any, catalina:    "eb5fb662035498062529345467af13234be5d022ccec9d2b3e2ad3437ff96e04"
    sha256 cellar: :any, mojave:      "7e2632a44dad0f9eedc38577c8dcb8c11856e036f05ba444a814f8bd93dd47ea"
    sha256 cellar: :any, high_sierra: "2000ae2106bb3b10a77b91b75a40dbb6ec60a8aad8de220aa2af69e1a41b905f"
    sha256 cellar: :any, sierra:      "82fc9db7c3ad20bdcd5681be1075ae4853b6f19caeb41624dac33d53470b2523"
    sha256 cellar: :any, el_capitan:  "a26ea1d1cefed24fd890bbc65f9a11d171cdbcb1c00936562255e2adfe29205f"
    sha256 cellar: :any, yosemite:    "7f4e5e77fc14d6920bd212e9c812c7dad51ad1dbe1542f1c0e4999928db9ad3f"
    sha256 cellar: :any, mavericks:   "c1c35337d7b2bebb59d07a8f792493f1da89f2701eae58d382bb24edfd2c73d3"
  end

  def install
    system "./configure", "--disable-debug", "--disable-dependency-tracking",
                          "--prefix=#{prefix}"
    system "make", "install"
  end
end
