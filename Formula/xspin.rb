class Xspin < Formula
  desc "Software verification tool (developed at Bell Labs)"
  homepage "https://spinroot.com/spin/Src/index.html"
  url "https://spinroot.com/spin/Src/xspin525.tcl"
  version "5.2.5"
  sha256 "e23d8d562e39db6fe73570e52ee895cd806d15c3e52e638299cbc1eb61289eb6"

  bottle do
    sha256 cellar: :any_skip_relocation, catalina:    "2128720e4a7cda7778a5f6e0f16ecadb1b37eb125d37db2958ba1c84d97c379c"
    sha256 cellar: :any_skip_relocation, mojave:      "e268eebef598b8df39bcd1bb2daaf5ea7b13975532f4dcba6426659fecf47482"
    sha256 cellar: :any_skip_relocation, high_sierra: "f35ea74745fac858274f01c76d879c3713a9ca35e8282ced5c080276f2934580"
    sha256 cellar: :any_skip_relocation, sierra:      "493d8bfac9052ece7d96eaed9b70792d7fe41b7566de2a523dd86664e3a3debb"
    sha256 cellar: :any_skip_relocation, el_capitan:  "896d3acc7e60648410ff86b1f8e744059bb71015900360fc18b3a75537e2c13e"
    sha256 cellar: :any_skip_relocation, yosemite:    "2ff10f844a1c09cc99bf8e630bde4e191a450697ab6ea286c85bfb66670db405"
    sha256 cellar: :any_skip_relocation, mavericks:   "a1b19b1227fc19b6ea00cfea5a49955a82d180521e8df29d68842b465e5b4b89"
  end

  depends_on "spin"

  patch :DATA

  def install
    inreplace "xspin525.tcl", "CELLAR", prefix
    bin.install "xspin525.tcl" => "xspin"
  end
end

# manual patching is required by the spin install process
__END__
diff --git a/xspin525.tcl b/xspin525.tcl
old mode 100644
new mode 100755
index 73fc6bf..444b0ad
--- a/xspin525.tcl
+++ b/xspin525.tcl
@@ -1,8 +1,9 @@
-#!/bin/sh
+#!/usr/bin/wish -f
 # the next line restarts using wish \
-exec wish c:/cygwin/bin/xspin -- $*
+exec wish CELLAR/bin/xspin -- $*
+
+ cd	;# enable to cd to home directory by default
 
-# cd	;# enable to cd to home directory by default
 
 # on PCs:
 # adjust the first argument to wish above with the name and
