class Goad < Formula
  desc "AWS Lambda powered, highly distributed, load testing tool built in Go"
  homepage "https://goad.io/"
  url "https://github.com/goadapp/goad.git",
      tag:      "2.0.4",
      revision: "e015a55faa940cde2bc7b38af65709d52235eaca"
  license "MIT"

  bottle do
    rebuild 1
    sha256 cellar: :any_skip_relocation, catalina:    "57345918587236f5235fcacc3d6d7f64272a5c1def4e64632fee13b960c027b5"
    sha256 cellar: :any_skip_relocation, mojave:      "366aad32eaa55e8561244bc31dc7650d829dd1f588801ad5d986a22cbfc80418"
    sha256 cellar: :any_skip_relocation, high_sierra: "3a87755d9b4b48b07a7fecd9be72df574d5866fe39d4dc0c60d6a88da40c5081"
    sha256 cellar: :any_skip_relocation, sierra:      "b10fb1177f1f3548b2a497cb56ce9f10620a06175adec6a1d452b0e136981d1e"
    sha256 cellar: :any_skip_relocation, el_capitan:  "f0c6400909fbe194400717025ad64cba2ccd63b1db9cba5ec7a9195274614b41"
  end

  depends_on "go" => :build
  depends_on "go-bindata" => :build

  uses_from_macos "zip" => :build

  def install
    ENV["GOPATH"] = buildpath
    dir = buildpath/"src/github.com/goadapp/goad"
    dir.install buildpath.children

    cd dir do
      system "make", "build"
      bin.install "build/goad"
      prefix.install_metafiles
    end
  end

  test do
    system "#{bin}/goad", "--version"
  end
end
