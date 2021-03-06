class ColorCode < Formula
  desc "Free advanced MasterMind clone"
  homepage "http://colorcode.laebisch.com/"
  url "http://colorcode.laebisch.com/download/ColorCode-0.8.5.tar.gz"
  sha256 "7c128db12af6ab11439eb710091b4a448100553a4d11d3a7c8dafdfbc57c1a85"
  revision 1

  bottle do
    sha256 cellar: :any, catalina:    "3e03afccc282a21468f748cefdbdbf3d577dc6f84e2ef40f9b00379e48e18dd3"
    sha256 cellar: :any, mojave:      "5f2a2c56ba83fb2bddac500099a41121e89e1a029393b62e45c65e894ebd4863"
    sha256 cellar: :any, high_sierra: "d184a0b2db2fb9bff024968e3b13c53339599c9a51510c9e1e76ddc073b64834"
    sha256 cellar: :any, sierra:      "761681dc9bcdb911c692d954ffde633471db71ea30ad9babad16237b734e7005"
    sha256 cellar: :any, el_capitan:  "1f8e9c02a931f025d172594e30ae20dbd745c6acc5e91f4d8c54b2fa426cff1c"
    sha256 cellar: :any, yosemite:    "559f6c6ac094ff6d6e5f7157c3042ae819cd4a4233292c36dca21db85b152b90"
  end

  depends_on "qt"

  def install
    system "qmake"
    system "make"
    prefix.install "ColorCode.app"
    bin.write_exec_script "#{prefix}/ColorCode.app/Contents/MacOS/colorcode"
  end

  test do
    system "#{bin}/colorcode", "-h"
  end
end
