class Rc < Formula
  desc "Implementation of the AT&T Plan 9 shell"
  homepage "http://doc.cat-v.org/plan_9/4th_edition/papers/rc"
  url "http://static.tobold.org/rc/rc-1.7.4.tar.gz"
  mirror "https://src.fedoraproject.org/repo/extras/rc/rc-1.7.4.tar.gz/f99732d7a8be3f15f81e99c3af46dc95/rc-1.7.4.tar.gz"
  sha256 "5ed26334dd0c1a616248b15ad7c90ca678ae3066fa02c5ddd0e6936f9af9bfd8"

  bottle do
    sha256 cellar: :any_skip_relocation, catalina:    "ab871610d857058773a87f70ad995a5e02fdeb1e6fe3d699e2051892ce60af84"
    sha256 cellar: :any_skip_relocation, mojave:      "f14ceeb0e4315379e2052e39a24fafb529f841428b1a64e3009cfd62769b9e4a"
    sha256 cellar: :any_skip_relocation, high_sierra: "c2ee55c504be78889adc7d0cba962528f995bf222dc77ce5a6b930210851294e"
    sha256 cellar: :any_skip_relocation, sierra:      "627e45477eabd5854e3c5f39af5290befd43d03b385d1b20f0ce4b49636fd2d9"
  end

  def install
    system "./configure", "--prefix=#{prefix}",
                          "--mandir=#{man}",
                          "--with-edit=edit"
    system "make"
    system "make", "install"
  end

  test do
    system "#{bin}/rc", "-c", "echo Hello!"
  end
end
