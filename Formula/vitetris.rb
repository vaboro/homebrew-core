class Vitetris < Formula
  desc "Terminal-based Tetris clone"
  homepage "https://www.victornils.net/tetris/"
  url "https://github.com/vicgeralds/vitetris/archive/v0.58.0.tar.gz"
  sha256 "e7e7cb74bb814b9fec80fe4ede3c3f04134d8217d630e092a097238248d604f9"
  license "BSD-2-Clause"

  bottle do
    sha256 cellar: :any_skip_relocation, catalina:    "17c380c39ba763e9559876cef2a6c5189947994aef7c0e6f3613e383f8f9e646"
    sha256 cellar: :any_skip_relocation, mojave:      "5cfebdcea81b5e7720d1941f3973b0b47c1fd510234b09f81e9098c1132c0b92"
    sha256 cellar: :any_skip_relocation, high_sierra: "175da9ed672d62d7c5409d94f299a67ab8499020283a4ea1ca21f6efc6470809"
    sha256 cellar: :any_skip_relocation, sierra:      "6cb9f1f8d9492c7a652d32115ae488dd19282aa94261957115b50e97c74f06f4"
  end

  # remove a 'strip' option not supported on OS X and root options for
  # 'install'
  patch :DATA

  def install
    system "./configure", "--prefix=#{prefix}", "--without-xlib"
    system "make", "install"
  end

  test do
    system "#{bin}/tetris", "-hiscore"
  end
end
__END__
--- a/Makefile  2013-10-07 11:57:18.000000000 +0200
+++ b/Makefile  2013-10-07 11:57:29.000000000 +0200
@@ -5,7 +5,7 @@
 # Uncomment to change the default.  (Only used in Unix-like systems.)
 #HISCORE_FILENAME = /var/games/vitetris-hiscores

-INSTALL = install -oroot -groot
+INSTALL = install

 default: build
	@echo Done.
@@ -18,7 +18,7 @@
  cd src; $(MAKE) tetris
	mv -f src/tetris$(EXE) $(PROGNAME)
	@echo stripping symbols to reduce program size:
-	-strip --strip-all $(PROGNAME)
+	-strip $(PROGNAME)

 gameserver: src/netw/gameserver.c
	cd src/netw; $(MAKE) gameserver
