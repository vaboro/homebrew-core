class Ploticus < Formula
  desc "Scriptable plotting and graphing utility"
  homepage "https://ploticus.sourceforge.io/"
  url "https://downloads.sourceforge.net/project/ploticus/ploticus/2.42/ploticus242_src.tar.gz"
  sha256 "3f29e4b9f405203a93efec900e5816d9e1b4381821881e241c08cab7dd66e0b0"
  revision 1

  livecheck do
    url :stable
  end

  bottle do
    sha256 catalina:    "5b23a77e8f83f384d8b3da9af8d1bd89832099a5dec99f1711a72f50a4d682fe"
    sha256 mojave:      "b9ba4732a13508d6aba81b81c31a71ca65543fbcda431d57263f28255072087f"
    sha256 high_sierra: "bfdaab8cdaf7c0c97e02caea8fa79e76e7ac85704d21591ced4a59914b4c5c26"
    sha256 sierra:      "06456d2606a86782cd75ee63f67e738e7ce33271902d3f4e7807d2061c0a5f4a"
    sha256 el_capitan:  "088f4ba0eea75ed4b401f94331b70dd64e23f02fa0d95731fbaccf6904c8cea5"
    sha256 yosemite:    "b15be72d80abf16b348c625945de811bf1fb411b1cb329adc701bc04cfb41dd8"
    sha256 mavericks:   "c2b4982907f4a9de66973cf55729fed03f17c42704593d6dbcce955ce53cd9bb"
  end

  depends_on "libpng"

  def install
    # Use alternate name because "pl" conflicts with macOS "pl" utility
    args=["INSTALLBIN=#{bin}",
          "EXE=ploticus"]
    inreplace "src/pl.h", /#define\s+PREFABS_DIR\s+""/, "#define PREFABS_DIR \"#{pkgshare}\""
    system "make", "-C", "src", *args
    # Required because the Makefile assumes INSTALLBIN dir exists
    bin.mkdir
    system "make", "-C", "src", "install", *args
    pkgshare.install Dir["prefabs/*"]
  end

  def caveats
    <<~EOS
      Ploticus prefabs have been installed to #{opt_pkgshare}
    EOS
  end

  test do
    assert_match "ploticus 2.", shell_output("#{bin}/ploticus -version 2>&1", 1)

    (testpath/"test.in").write <<~EOS
      #proc areadef
        rectangle: 1 1 4 2
        xrange: 0 5
        yrange: 0 100

      #proc xaxis:
        stubs: text
        Africa
        Americas
        Asia
        Europe,\\nAustralia,\\n\& Pacific
    EOS
    system "#{bin}/ploticus", "-f", "test.in", "-png", "-o", "test.png"
    assert_match "PNG image data", shell_output("file test.png")
  end
end
