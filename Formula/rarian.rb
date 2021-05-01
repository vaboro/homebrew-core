class Rarian < Formula
  desc "Documentation metadata library"
  homepage "https://rarian.freedesktop.org/"
  url "https://rarian.freedesktop.org/Releases/rarian-0.8.1.tar.bz2"
  sha256 "aafe886d46e467eb3414e91fa9e42955bd4b618c3e19c42c773026b205a84577"

  livecheck do
    url "https://rarian.freedesktop.org/Releases/"
    regex(/href=.*?rarian[._-]v?(\d+(?:\.\d+)+)\.t/i)
  end

  bottle do
    sha256 catalina:    "6cd01a0bbc9d5168548c6735ddf1057ae3ef403d3868be499ff1ce3ba1cd6ab8"
    sha256 mojave:      "e727630f28efcdcb1a577f67525992f00a00c25ee1582277e1e91e2fa060187d"
    sha256 high_sierra: "815aafc0d05198cd4e3880715a6ad5de21b3bf47ccf25ef4b91aa918848a67ee"
    sha256 sierra:      "9266addbd38ed67b7394d05702d2be69d44ccafeb8132ef75470a816614a9f8e"
    sha256 el_capitan:  "7784dc13b95c0c2f5818bc3657da52f0365bbe9c6ddf8871d81b8638cb89390c"
    sha256 yosemite:    "069ff9e17c252271d058e72f38eedb2e1196cee49598e1537c64bd45b7f356e6"
    sha256 mavericks:   "1a81d2fe1bb961b9b479da410046f24fa65df8db7cac5ee0853cc09f380f6bc4"
  end

  conflicts_with "scrollkeeper",
    because: "rarian and scrollkeeper install the same binaries"

  def install
    system "./configure", "--disable-dependency-tracking",
                          "--prefix=#{prefix}"
    system "make", "install"
  end
end
