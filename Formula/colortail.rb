class Colortail < Formula
  desc "Like tail(1), but with various colors for specified output"
  homepage "https://github.com/joakim666/colortail"
  url "https://github.com/joakim666/colortail.git",
    revision: "f44fce0dbfd6bd38cba03400db26a99b489505b5"
  version "0.3.4"
  license "GPL-2.0"

  bottle do
    sha256 cellar: :any_skip_relocation, catalina:    "76e327c10e6614aed10396f4da1008eda7d0574c77b009e6c4cc109829033bb1"
    sha256 cellar: :any_skip_relocation, mojave:      "f68bafd58bcff89453bf8f81331eb968c5bde460821a885523863ec4ee9482fb"
    sha256 cellar: :any_skip_relocation, high_sierra: "a7974ddb2f0bd3a7946bb5d06fe637f94c7a8776f9cd811bf8fbd530caa92816"
    sha256 cellar: :any_skip_relocation, sierra:      "44e09610d285f503fbae67f930ae7bea894c737d1e2c9c634332188340a70e3e"
    sha256 cellar: :any_skip_relocation, el_capitan:  "e0c8c9af739ce911c0d09eaee26b615444c17f48de27c680cbaf27739e45d8f5"
    sha256 cellar: :any_skip_relocation, yosemite:    "1be1c0067a5621f5edcabf64ec06a775d334924e4ea01bccd1c42830f6c9d0c6"
    sha256 cellar: :any_skip_relocation, mavericks:   "8570fbda1625d70eac83d0e53a1d32d0cd7b32f9fb0b8dea38d32a3228dc6688"
  end

  depends_on "autoconf" => :build
  depends_on "automake" => :build

  # Upstream PR to fix the build on ML
  patch do
    url "https://github.com/joakim666/colortail/commit/36dd0437bb364fd1493934bdb618cc102a29d0a5.diff?full_index=1"
    sha256 "87e4a6b24f447312cc3ea3d8b65af54a37d0723e682dfb70b9a0c4b21e0e102c"
  end

  def install
    system "./autogen.sh", "--disable-dependency-tracking",
                           "--prefix=#{prefix}"
    system "make", "install"
  end

  test do
    (testpath/"test.txt").write "Hello\nWorld!\n"
    assert_match(/World!/, shell_output("#{bin}/colortail -n 1 test.txt"))
  end
end
