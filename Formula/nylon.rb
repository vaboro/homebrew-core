class Nylon < Formula
  desc "Proxy server"
  homepage "https://github.com/smeinecke/nylon"
  url "https://monkey.org/~marius/nylon/nylon-1.21.tar.gz"
  sha256 "34c132b005c025c1a5079aae9210855c80f50dc51dde719298e1113ad73408a4"
  license "BSD-3-Clause"
  revision 2

  bottle do
    sha256 cellar: :any, catalina:    "6138b062f2a435928485795e2b3bdef81983a87137d4bf73029838f19c1210f5"
    sha256 cellar: :any, mojave:      "cb2cbfbd8df94b8581a116807075daf9fadbe9b9c5cfa537ea30dfa76537dd5c"
    sha256 cellar: :any, high_sierra: "3df9b3197c8dc9a227221027047c8de77ddb6ad9ce2edd14544c2d6e4923b660"
    sha256 cellar: :any, sierra:      "b7eeab5896aaaca9c73166e519d092a71f15a36e800a28742729f8cbc270e6d8"
  end

  depends_on "libevent"

  def install
    system "./configure", "--disable-debug",
                          "--disable-dependency-tracking",
                          "--prefix=#{prefix}",
                          "--mandir=#{man}",
                          "--with-libevent=#{HOMEBREW_PREFIX}"
    system "make", "install"
  end

  test do
    assert_equal "nylon: nylon version #{version}",
      shell_output("#{bin}/nylon -V 2>&1").chomp
  end
end
