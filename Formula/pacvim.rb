class Pacvim < Formula
  desc "Learn vim commands via a game"
  homepage "https://github.com/jmoon018/PacVim"
  url "https://github.com/jmoon018/PacVim/archive/v1.1.1.tar.gz"
  sha256 "c869c5450fbafdfe8ba8a8a9bba3718775926f276f0552052dcfa090d21acb28"
  license "LGPL-3.0"
  head "https://github.com/jmoon018/PacVim.git"

  bottle do
    rebuild 1
    sha256 cellar: :any_skip_relocation, catalina:    "85bd0087ecc54716772881e46ce00553ee037eb2ea200d34d5db28709092369f"
    sha256 cellar: :any_skip_relocation, mojave:      "e2ecd6cc1337adb4c9e760c50a83ae04a8cb86495d3c1ea167bfa5930d7a16a0"
    sha256 cellar: :any_skip_relocation, high_sierra: "b8ef8cdba34802db97fba770e013393973e908e11486b87a4f5189f139e468dc"
  end

  uses_from_macos "ncurses"

  def install
    ENV.cxx11
    system "make", "install", "PREFIX=#{prefix}"
  end
end
