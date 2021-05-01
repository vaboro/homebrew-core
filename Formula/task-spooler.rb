class TaskSpooler < Formula
  desc "Batch system to run tasks one after another"
  homepage "https://vicerveza.homeunix.net/~viric/soft/ts/"
  url "https://vicerveza.homeunix.net/~viric/soft/ts/ts-1.0.tar.gz"
  sha256 "4f53e34fff0bb24caaa44cdf7598fd02f3e5fa7cacaea43fa0d081d03ffbb395"
  license "GPL-2.0"

  bottle do
    sha256 cellar: :any_skip_relocation, catalina:    "2a31687b430989e2a004ef2a3c69e20648707f6d60907031dcebd43b51924a38"
    sha256 cellar: :any_skip_relocation, mojave:      "319c29e750b0ba183b14accb571c4d210723458d5fcd72302b5ec866e5a76ad4"
    sha256 cellar: :any_skip_relocation, high_sierra: "8045397e275ade52621a1ab3a21e3eddf277fafd1beea60db2d10bc15d11b8f2"
    sha256 cellar: :any_skip_relocation, sierra:      "e0f7e33946d3f8c93782692b3bab5833cb2e882f1fb47a4473b69e39ce3e7378"
    sha256 cellar: :any_skip_relocation, el_capitan:  "9403d0c240bad09d576288d6b5ed94057dad03ceb30a4893a935c13f9e58af7f"
  end

  conflicts_with "moreutils", because: "both install a `ts` executable"

  def install
    system "make", "install", "PREFIX=#{prefix}"
  end

  test do
    system "#{bin}/ts", "-l"
  end
end
