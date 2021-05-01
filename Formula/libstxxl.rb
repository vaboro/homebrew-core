class Libstxxl < Formula
  desc "C++ implementation of STL for extra large data sets"
  homepage "https://stxxl.sourceforge.io/"
  url "https://downloads.sourceforge.net/project/stxxl/stxxl/1.4.1/stxxl-1.4.1.tar.gz"
  sha256 "92789d60cd6eca5c37536235eefae06ad3714781ab5e7eec7794b1c10ace67ac"

  livecheck do
    url :stable
  end

  bottle do
    sha256 cellar: :any_skip_relocation, catalina:    "d8789eb30edee21c2800e2f93f70a2187a9a62ec193ec4d63ed5788cffdd9c0d"
    sha256 cellar: :any_skip_relocation, mojave:      "be650cf787270080a323cbebf05109bcc72d94ea508b0e7c265c6592b871065a"
    sha256 cellar: :any_skip_relocation, high_sierra: "a8b116ba332c5d32055f754db6fb491e3c3fd87b4b4a317213a2e0963d34ddeb"
    sha256 cellar: :any_skip_relocation, sierra:      "0f9cb534bcdc8d344dd5da5b8381cca527e515d1a3df2bf5b3785783f7f482d7"
    sha256 cellar: :any_skip_relocation, el_capitan:  "8753b0c9ec11f1f6195fa52c346b4d6015652931908156dcdb4468cc94103d1c"
    sha256 cellar: :any_skip_relocation, yosemite:    "fbefd1ceb6f328ef77b9a005f5bc3c93fe23fa68d60b4a5e126a68a6a9d8e17d"
    sha256 cellar: :any_skip_relocation, mavericks:   "5a64626281265368e41f51089271c031ae8782651d65fe012f8a86949e37573b"
  end

  depends_on "cmake" => :build

  def install
    args = std_cmake_args - %w[-DCMAKE_BUILD_TYPE=None]
    args << "-DCMAKE_BUILD_TYPE=Release"
    mkdir "build" do
      system "cmake", "..", *args
      system "make", "install"
    end
  end
end
