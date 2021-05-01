class Cabocha < Formula
  desc "Yet Another Japanese Dependency Structure Analyzer"
  homepage "https://taku910.github.io/cabocha/"
  # Files are listed in https://drive.google.com/drive/folders/0B4y35FiV1wh7cGRCUUJHVTNJRnM
  url "https://dl.bintray.com/homebrew/mirror/cabocha-0.69.tar.bz2"
  mirror "https://mirrorservice.org/sites/ftp.netbsd.org/pub/pkgsrc/distfiles/cabocha-20160909/cabocha-0.69.tar.bz2"
  sha256 "9db896d7f9d83fc3ae34908b788ae514ae19531eb89052e25f061232f6165992"

  bottle do
    sha256 catalina:    "70e045edcdf30456dfcf96777f0f8fa68807d638ec90995b076c4ce47730e5ff"
    sha256 mojave:      "7142730e5fa6dd1203d6f34168f85d7704050cf620891a9d0db4f9eefc49370a"
    sha256 high_sierra: "beafa5ccf84633bed67d405f22ac8e570d2dc2fe0e10fccf8c11076639c672ae"
    sha256 sierra:      "27bd41bab80ab64fb32e5bc8b568864b874f0dec16817d38c37abd3c7582c694"
    sha256 el_capitan:  "bf3ed6bc9333b43919264913c40a86997a7601a83abf6dcfa1dfe14745b3fc7c"
    sha256 yosemite:    "fe97decdca655899faffd6356bb8ddbb52d4949222690835374c3aeb9a65cdb2"
    sha256 mavericks:   "794df46e362f3146b2bab17ba132978609954b0ba0a51ffa4d6d4e8845548764"
  end

  depends_on "crf++"
  depends_on "mecab"
  depends_on "mecab-ipadic"

  def install
    ENV["LIBS"] = "-liconv"

    inreplace "Makefile.in" do |s|
      s.change_make_var! "CFLAGS", ENV.cflags
      s.change_make_var! "CXXFLAGS", ENV.cflags
    end

    args = %W[
      --disable-dependency-tracking
      --prefix=#{prefix}
      --with-charset=UTF8
      --with-posset=IPA
    ]

    system "./configure", *args
    system "make", "install"
  end

  test do
    result = `echo "CaboCha はフリーソフトウェアです。" | cabocha | md5`.chomp
    assert_equal "a5b8293e6ebcb3246c54ecd66d6e18ee", result
  end
end
