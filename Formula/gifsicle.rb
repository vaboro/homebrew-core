class Gifsicle < Formula
  desc "GIF image/animation creator/editor"
  homepage "https://www.lcdf.org/gifsicle/"
  url "https://www.lcdf.org/gifsicle/gifsicle-1.92.tar.gz"
  sha256 "5ab556c01d65fddf980749e3ccf50b7fd40de738b6df679999294cc5fabfce65"
  license "GPL-2.0"

  bottle do
    sha256 cellar: :any_skip_relocation, catalina:    "5c39ab6736846e30082db190167bc498e78d03e523f642057eadc29f854c71b1"
    sha256 cellar: :any_skip_relocation, mojave:      "52be1cd49246909777199147dcbbeb6f490580558615138ae063b6149cfbe53c"
    sha256 cellar: :any_skip_relocation, high_sierra: "a7cfb607906023c5bdb56a49f8a75ce0b3e2c76a971266bb530d04ed29be74f9"
    sha256 cellar: :any_skip_relocation, sierra:      "746d071f268950c6af18704590b981f5f965d35e2adf6c202aa3df0f13e943e9"
  end

  head do
    url "https://github.com/kohler/gifsicle.git"

    depends_on "autoconf" => :build
    depends_on "automake" => :build
  end

  conflicts_with "giflossy",
    because: "both install an `gifsicle` binary"

  def install
    args = %W[
      --disable-dependency-tracking
      --prefix=#{prefix}
      --disable-gifview
    ]

    system "./bootstrap.sh" if build.head?
    system "./configure", *args
    system "make", "install"
  end

  test do
    system "#{bin}/gifsicle", "--info", test_fixtures("test.gif")
  end
end
