class SdlMixer < Formula
  desc "Sample multi-channel audio mixer library"
  homepage "https://www.libsdl.org/projects/SDL_mixer/"
  url "https://www.libsdl.org/projects/SDL_mixer/release/SDL_mixer-1.2.12.tar.gz"
  sha256 "1644308279a975799049e4826af2cfc787cad2abb11aa14562e402521f86992a"
  revision 3

  livecheck do
    url "https://www.libsdl.org/projects/SDL_mixer/release/"
    regex(/href=.*?SDL_mixer[._-]v?(\d+(?:\.\d+)+)\.t/i)
  end

  bottle do
    sha256 cellar: :any, catalina:    "a2555ba3d81dd01637f6407db77cd7cc5ed363fd887627d786d3475e79e960a0"
    sha256 cellar: :any, mojave:      "c957ec0e2f17c89e78b2b6aff735ec7abe19bd0e10a0e2aaad227746c26dd910"
    sha256 cellar: :any, high_sierra: "e08902563c6265ac480323c9f22a26ee0e51f42fb1c36efb9b66b1f6b34a032d"
    sha256 cellar: :any, sierra:      "69e8726e5b9bb858e069d244844411fc43930d3a7d0b78c6177bf36c76bb04c2"
    sha256 cellar: :any, el_capitan:  "9c9a55fe416bc37a14e9a58439093b85274bf12c2bab24660a3f7c4b0fff70c3"
  end

  depends_on "pkg-config" => :build
  depends_on "libmikmod"
  depends_on "libogg"
  depends_on "libvorbis"
  depends_on "sdl"

  # Source file for sdl_mixer example
  resource "playwave" do
    url "https://hg.libsdl.org/SDL_mixer/raw-file/a4e9c53d9c30/playwave.c"
    sha256 "92f686d313f603f3b58431ec1a3a6bf29a36e5f792fb78417ac3d5d5a72b76c9"
  end

  def install
    inreplace "SDL_mixer.pc.in", "@prefix@", HOMEBREW_PREFIX

    args = %W[
      --prefix=#{prefix}
      --disable-dependency-tracking
      --enable-music-ogg
      --disable-music-ogg-shared
      --disable-music-mod-shared
    ]

    system "./configure", *args
    system "make", "install"
  end

  test do
    testpath.install resource("playwave")
    system ENV.cc, "-o", "playwave", "playwave.c", "-I#{include}/SDL",
                   "-I#{Formula["sdl"].opt_include}/SDL",
                   "-L#{lib}", "-lSDL_mixer",
                   "-L#{Formula["sdl"].lib}", "-lSDLmain", "-lSDL",
                   "-Wl,-framework,Cocoa"
    Utils.safe_popen_read({ "SDL_VIDEODRIVER" => "dummy", "SDL_AUDIODRIVER" => "disk" },
                          "./playwave", test_fixtures("test.wav"))
    assert_predicate testpath/"sdlaudio.raw", :exist?
  end
end
