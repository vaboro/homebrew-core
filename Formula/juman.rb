class Juman < Formula
  desc "Japanese morphological analysis system"
  homepage "http://nlp.ist.i.kyoto-u.ac.jp/index.php?JUMAN"
  url "http://nlp.ist.i.kyoto-u.ac.jp/nl-resource/juman/juman-7.01.tar.bz2"
  sha256 "64bee311de19e6d9577d007bb55281e44299972637bd8a2a8bc2efbad2f917c6"

  bottle do
    sha256 catalina:    "0cb4d99f79b907922d8352e841096301a132ab0f385c75910ab53198b1f72ab7"
    sha256 mojave:      "36bae86cd2b24c5b3b4e75aed31ab0cf5da261b7a77e7ffe8a9b279ca3b801d6"
    sha256 high_sierra: "7e2b144bf77ccdb11ae0166827dd45feae62a950de00310dcb863d7f926a9510"
    sha256 sierra:      "5c1dfea7f62d1afce55c9d1ed2478f9ff3b1744285fbbf08c29eb171cc672fa7"
    sha256 el_capitan:  "6bd46cdc6ff4e159463f8d4fecda2b803c3054ec28305f3baa1ea4969c4da723"
    sha256 yosemite:    "b2ccfe90011dead77ca0789cbdcdf30aa24e2ebcd3dd19c8d01b6adacbf7c816"
    sha256 mavericks:   "f959168856e884fcdadea2d19e9ebfa3ee6cdafb6e133588fce001de677fbe2a"
  end

  def install
    system "./configure", "--disable-dependency-tracking",
                          "--prefix=#{prefix}"
    system "make"
    system "make", "install"
  end

  test do
    result = `echo \xe4\xba\xac\xe9\x83\xbd\xe5\xa4\xa7\xe5\xad\xa6 | juman | md5`.chomp
    assert_equal "a5dd58c8ffa618649c5791f67149ab56", result
  end
end
