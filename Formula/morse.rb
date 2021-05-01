class Morse < Formula
  desc "QSO generator and morse code trainer"
  homepage "http://www.catb.org/~esr/morse/"
  url "http://www.catb.org/~esr/morse/morse-2.5.tar.gz"
  sha256 "476d1e8e95bb173b1aadc755db18f7e7a73eda35426944e1abd57c20307d4987"

  bottle do
    sha256 cellar: :any_skip_relocation, catalina:    "b97853e5c7a071e81c9fc7845f9467ebe00fab07fd0c738532230d3463d1826b"
    sha256 cellar: :any_skip_relocation, mojave:      "5fe911c0c4d71783759f9d8c4e6269c873a830d0511e0813edf7ec86f3c7f62f"
    sha256 cellar: :any_skip_relocation, high_sierra: "fb58a8af73002f98fe7ff1274c1712eb4bf0cab8b08640d2836fc6951c5cb2e9"
    sha256 cellar: :any_skip_relocation, sierra:      "d779902b961e9ebbfa41b0906d8d41357232fd4da83a393e112cde87f5bcdcaa"
    sha256 cellar: :any_skip_relocation, el_capitan:  "491a1ea5455d058af9adb607e0e49d95b94e52f0068cd5fb197c1ea71666b524"
    sha256 cellar: :any_skip_relocation, yosemite:    "c89c45cdc2ff59d6ac327188c484659c769fe94a07e5e1f38f4d568f0b1a943d"
  end

  depends_on :x11

  def install
    system "make", "all", "DEVICE=X11"
    bin.install "morse"
    man1.install "morse.1"
  end
end
