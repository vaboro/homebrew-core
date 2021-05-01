class Openmsx < Formula
  desc "MSX emulator"
  homepage "https://openmsx.org/"
  url "https://github.com/openMSX/openMSX/releases/download/RELEASE_0_15_0/openmsx-0.15.0.tar.gz"
  sha256 "93f209d8fed2e04e62526469bb6bb431b82ea4d07ecdc45dab2b8cc4ca21d62a"
  license "GPL-2.0"
  head "https://github.com/openMSX/openMSX.git"

  bottle do
    sha256 cellar: :any, catalina:    "d747a6fb6c9f9a489468f55765dbe8ef19664c1feb7346a42ed3f093cc61499a"
    sha256 cellar: :any, mojave:      "64145c0b205a9eeb64e12f06b63440ee7c8bbba0153a0e248a1e37486815fb21"
    sha256 cellar: :any, high_sierra: "eb64da0eff2b09fb3046903b020becc06aa8683ad398e9cea08708567fbcf194"
    sha256 cellar: :any, sierra:      "a2396de7cce4f6a317d6f8f3e38e32afb304580f08ccc798c36b0c5a933fcf8f"
  end

  depends_on "freetype"
  depends_on "glew"
  depends_on "libpng"
  depends_on "sdl"
  depends_on "sdl_ttf"

  def install
    # Fixes a clang crash; this is an LLVM/Apple bug, not an openmsx bug
    # https://github.com/Homebrew/homebrew-core/pull/9753
    # Filed with Apple: rdar://30475877
    ENV.O0

    # Hardcode prefix
    inreplace "build/custom.mk", "/opt/openMSX", prefix

    # Help finding Tcl (https://github.com/openMSX/openMSX/issues/1082)
    inreplace "build/libraries.py" do |s|
      s.gsub!(/\((distroRoot), \)/, "(\\1, '/usr', '#{MacOS.sdk_path}/System/Library/Frameworks/Tcl.framework')")
      s.gsub! "lib/tcl", "."
    end

    system "./configure"
    system "make"
    prefix.install Dir["derived/**/openMSX.app"]
    bin.write_exec_script "#{prefix}/openMSX.app/Contents/MacOS/openmsx"
  end

  test do
    system "#{bin}/openmsx", "-testconfig"
  end
end
