class Libbluray < Formula
  desc "Blu-Ray disc playback library for media players like VLC"
  homepage "https://www.videolan.org/developers/libbluray.html"
  url "https://download.videolan.org/videolan/libbluray/1.2.0/libbluray-1.2.0.tar.bz2"
  sha256 "cd41ea06fd2512a77ebf63872873641908ef81ce2fe4e4c842f6035a47696c11"
  license "LGPL-2.1-or-later"

  livecheck do
    url "https://download.videolan.org/pub/videolan/libbluray/"
    regex(%r{>([\d.]+)/<}i)
  end

  bottle do
    cellar :any
    rebuild 1
    sha256 "9c6ef542e0a86886c669d99765c9a4f649e62a6e48ebd5a2dd961255e8657426" => :catalina
    sha256 "49791738b4090ceba841a1a867c6c9724257f631e054ec716e67924b838a0059" => :mojave
    sha256 "dbba386dc3a04515924b9423c37f293a57cceee8295e15994b3afe856a5e291a" => :high_sierra
  end

  head do
    url "https://code.videolan.org/videolan/libbluray.git"

    depends_on "autoconf" => :build
    depends_on "automake" => :build
    depends_on "libtool" => :build
  end

  depends_on "ant" => :build
  depends_on java: ["1.8", :build]
  depends_on "pkg-config" => :build
  depends_on "fontconfig"
  depends_on "freetype"

  uses_from_macos "libxml2"

  def install
    # Need to set JAVA_HOME manually since ant overrides 1.8 with 1.8+
    ENV["JAVA_HOME"] = Language::Java.java_home("1.8")

    # https://mailman.videolan.org/pipermail/libbluray-devel/2014-April/001401.html
    ENV.append_to_cflags "-D_DARWIN_C_SOURCE"

    # Work around Xcode 11 clang bug
    # https://code.videolan.org/videolan/libbluray/issues/20
    ENV.append_to_cflags "-fno-stack-check" if DevelopmentTools.clang_build_version >= 1010

    args = %W[--prefix=#{prefix} --disable-dependency-tracking]

    system "./bootstrap" if build.head?
    system "./configure", *args
    system "make"
    system "make", "install"
  end

  test do
    (testpath/"test.c").write <<~EOS
      #include <libbluray/bluray.h>
      int main(void) {
        BLURAY *bluray = bd_init();
      }
    EOS

    system ENV.cc, "test.c", "-I#{include}", "-L#{lib}", "-lbluray", "-o", "test"
    system "./test"
  end
end
