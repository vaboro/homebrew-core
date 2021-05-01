class Aalib < Formula
  desc "Portable ASCII art graphics library"
  homepage "https://aa-project.sourceforge.io/aalib/"
  url "https://downloads.sourceforge.net/project/aa-project/aa-lib/1.4rc5/aalib-1.4rc5.tar.gz"
  sha256 "fbddda9230cf6ee2a4f5706b4b11e2190ae45f5eda1f0409dc4f99b35e0a70ee"
  license "GPL-2.0-or-later"
  revision 1

  # The latest version in the formula is a release candidate, so we have to
  # allow matching of unstable versions.
  livecheck do
    url :stable
    regex(%r{url=.*?/aalib[._-]v?(\d+(?:\.\d+)+.*?)\.t}i)
  end

  bottle do
    sha256 cellar: :any_skip_relocation, catalina:    "306da4a8cb39ef81eed8b81a7d1c1c7bd47405d8270d036dde9c07c630fa4ea3"
    sha256 cellar: :any_skip_relocation, mojave:      "a19ebbf86362d9a90900dd0b4013ebed778cd8681c0b3ed122c8bbaa04b11cbe"
    sha256 cellar: :any_skip_relocation, high_sierra: "b2c5467ff9182645676381967b8dc89878f88900b19bed34ef432fd3257aa2a0"
    sha256 cellar: :any_skip_relocation, sierra:      "2c2d05720ca991422e4c27e3f770c29024c5197871cba67404f4e72a3cfaf002"
    sha256 cellar: :any_skip_relocation, el_capitan:  "9b3f19e5da28fb682aeb1fe40f1747d1b532490dd50262978aaefcb7afbc8804"
    sha256 cellar: :any_skip_relocation, yosemite:    "9e08dd4e3545b05353f3158e4e756c20a301bef295b72183e1fd5fb1d6d8e897"
  end

  # Fix malloc/stdlib issue on macOS
  # Fix underquoted definition of AM_PATH_AALIB in aalib.m4
  patch do
    url "https://raw.githubusercontent.com/Homebrew/formula-patches/6e23dfb/aalib/1.4rc5.patch"
    sha256 "54aeff2adaea53902afc2660afb9534675b3ea522c767cbc24a5281080457b2c"
  end

  def install
    ENV.ncurses_define
    system "./configure", "--disable-debug",
                          "--disable-dependency-tracking",
                          "--prefix=#{prefix}",
                          "--mandir=#{man}",
                          "--infodir=#{info}",
                          "--enable-shared=yes",
                          "--enable-static=yes",
                          "--without-x"
    system "make", "install"
  end

  test do
    system "script", "-q", "/dev/null", bin/"aainfo"
  end
end
