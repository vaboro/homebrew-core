class Pcrexx < Formula
  desc "C++ wrapper for the Perl Compatible Regular Expressions"
  homepage "https://www.daemon.de/PCRE"
  url "https://www.daemon.de/idisk/Apps/pcre++/pcre++-0.9.5.tar.gz"
  sha256 "77ee9fc1afe142e4ba2726416239ced66c3add4295ab1e5ed37ca8a9e7bb638a"
  license "LGPL-2.1"

  bottle do
    sha256 cellar: :any, catalina:    "61b2942fa6a519289532736eaaa9754f8d0020ffca215eb8ba18324ed1682ab0"
    sha256 cellar: :any, mojave:      "74eb2f78269663a150978c7a221af9bb453c459f14838cbe551f9b25cba222ce"
    sha256 cellar: :any, high_sierra: "65018b1dd42de0fc89e533f5343754cf8b07e0b989d0fc1820483fd76a36caab"
    sha256 cellar: :any, sierra:      "04da88d9c66600d7f636106f00b496e90fbd213431b7c4a2c20cc43f7e206a21"
    sha256 cellar: :any, el_capitan:  "5c30b4cbf987ad3b9a05521f83c672419b636277714838b6f7dee5a656c9868b"
    sha256 cellar: :any, yosemite:    "c883ed380b38f020e7383643fedf80f4bad9ed1205592fe8127423e340c02c05"
    sha256 cellar: :any, mavericks:   "fd7050ff36dbb4c5605a4f0a9bb5d5de3ea01e6b959dd2026297a9ae35b99f51"
  end

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "libtool" => :build
  depends_on "pcre"

  # Fix building with libc++. Patch sent to maintainer.
  patch :DATA

  def install
    pcre = Formula["pcre"]
    system "autoreconf", "-fvi"
    system "./configure", "--disable-debug",
                          "--disable-dependency-tracking",
                          "--disable-silent-rules",
                          "--prefix=#{prefix}",
                          "--with-pcre-lib=#{pcre.opt_lib}",
                          "--with-pcre-include=#{pcre.opt_include}"
    system "make", "install"

    # Pcre++ ships Pcre.3, which causes a conflict with pcre.3 from pcre
    # in case-insensitive file system. Rename it to pcre++.3 to avoid
    # this problem.
    mv man3/"Pcre.3", man3/"pcre++.3"
  end

  def caveats
    <<~EOS
      The man page has been renamed to pcre++.3 to avoid conflicts with
      pcre in case-insensitive file system.  Please use "man pcre++"
      instead.
    EOS
  end
end

__END__
diff --git a/libpcre++/pcre++.h b/libpcre++/pcre++.h
index d80b387..21869fc 100644
--- a/libpcre++/pcre++.h
+++ b/libpcre++/pcre++.h
@@ -47,11 +47,11 @@
 #include <map>
 #include <stdexcept>
 #include <iostream>
+#include <clocale>
 
 
 extern "C" {
   #include <pcre.h>
-  #include <locale.h>
 }
 
 namespace pcrepp {
