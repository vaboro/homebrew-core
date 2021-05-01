class Convmv < Formula
  desc "Filename encoding conversion tool"
  homepage "https://www.j3e.de/linux/convmv/"
  url "https://www.j3e.de/linux/convmv/convmv-2.05.tar.gz"
  sha256 "53b6ac8ae4f9beaee5bc5628f6a5382bfd14f42a5bed3d881b829d7b52d81ca6"

  livecheck do
    url :homepage
    regex(/href=.*?convmv[._-]v?(\d+(?:\.\d+)+)\.t/i)
  end

  bottle do
    sha256 cellar: :any_skip_relocation, catalina:    "203e34d5e76b55fabbf8548b93f749cd044ad843ca9062a916026e548332f7b0"
    sha256 cellar: :any_skip_relocation, mojave:      "8e5a0c8207cb0c57f1640c5a8c9a4a05cd9c8ffc68d922774cae4bfa56b691e6"
    sha256 cellar: :any_skip_relocation, high_sierra: "856021a73afb22052e496ced9eb1a7386d810a6d75903aac99feb98298801ea8"
    sha256 cellar: :any_skip_relocation, sierra:      "cc6cf7ff9cfd8909a76e29dd6ddbdddc9ad95638e154b72a36fe6c255e3a367d"
    sha256 cellar: :any_skip_relocation, el_capitan:  "43278a7c7ef7720e20fed3179ff8519230678d3fd4e98f4b0e8e796b5fdb40ac"
  end

  def install
    system "make", "install", "PREFIX=#{prefix}"
  end

  test do
    system "#{bin}/convmv", "--list"
  end
end
