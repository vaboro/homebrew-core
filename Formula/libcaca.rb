class Libcaca < Formula
  desc "Convert pixel information into colored ASCII art"
  homepage "http://caca.zoy.org/wiki/libcaca"
  url "http://caca.zoy.org/files/libcaca/libcaca-0.99.beta19.tar.gz"
  mirror "https://www.mirrorservice.org/sites/distfiles.macports.org/libcaca/libcaca-0.99.beta19.tar.gz"
  mirror "https://fossies.org/linux/privat/libcaca-0.99.beta19.tar.gz"
  version "0.99b19"
  sha256 "128b467c4ed03264c187405172a4e83049342cc8cc2f655f53a2d0ee9d3772f4"
  license "WTFPL"
  revision 1

  # The regex here matches unstable releases and is loose about it (`.*`), as
  # there are currently only beta releases and we don't know if there will be
  # releases candidates, etc. before there's a stable release. Hopefully we can
  # restrict this to stable releases in the future but it has to be loose for
  # the moment.
  livecheck do
    url :head
    regex(/^v?(\d+(?:\.\d+)+.*)/i)
  end

  bottle do
    sha256 cellar: :any, catalina:    "bd3e0ddf184652575170248e9a3b1b4a8c03ac21913cfcac8016baa9d39386fa"
    sha256 cellar: :any, mojave:      "5da241ff15fcb9b6ad7625b223cbda3b4e4aa5e449677f44c2512cec892485cd"
    sha256 cellar: :any, high_sierra: "804a53d45e6db70f211f7b0eebcd9a84d61784a891268889d55b81135e9621a5"
  end

  head do
    url "https://github.com/cacalabs/libcaca.git"

    depends_on "autoconf" => :build
    depends_on "automake" => :build
    depends_on "libtool" => :build
  end

  depends_on "pkg-config" => :build
  depends_on "imlib2"

  def install
    system "./bootstrap" if build.head?

    # Fix --destdir issue.
    #   ../.auto/py-compile: Missing argument to --destdir.
    inreplace "python/Makefile.in",
              '$(am__py_compile) --destdir "$(DESTDIR)"',
              "$(am__py_compile) --destdir \"$(cacadir)\""

    args = %W[
      --disable-dependency-tracking
      --prefix=#{prefix}
      --disable-doc
      --disable-slang
      --disable-java
      --disable-csharp
      --disable-ruby
      --disable-x11
    ]

    system "./configure", *args
    system "make"
    ENV.deparallelize # Or install can fail making the same folder at the same time
    system "make", "install"
  end

  test do
    system "#{bin}/img2txt", "--version"
  end
end
