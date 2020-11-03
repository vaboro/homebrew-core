class Clinfo < Formula
  desc "Print information about OpenCL platforms and devices"
  homepage "https://github.com/Oblomov/clinfo"
  url "https://github.com/Oblomov/clinfo/archive/2.2.18.04.06.tar.gz"
  sha256 "f77021a57b3afcdebc73107e2254b95780026a9df9aa4f8db6aff11c03f0ec6c"
  license "CC0-1.0"
  head "https://github.com/Oblomov/clinfo.git"

  livecheck do
    url :homepage
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  bottle do
    cellar :any_skip_relocation
    sha256 "860a35b3f6e571b54f7d7292446b9c1365b72f9fe9cc4d402641207156a58e17" => :catalina
    sha256 "9678520a5637d07faa9cb50e9d490c5ea44da41ce332b70c0115ad6c2d2d14cc" => :mojave
    sha256 "d10832aa0b4a2f8602efca713aa85a2a78ae6df19d61d9c256c3e3cd4c37aba1" => :high_sierra
    sha256 "bc0233b23ba9f5ac6f037b206eb22ae66583853864c1334652bbc69b239307a3" => :sierra
    sha256 "1d456b254b9686f01649e08cf0c76a3b208f1873deae3d8920e22f57cc0f258a" => :el_capitan
  end

  def install
    system "make", "MANDIR=#{man}", "PREFIX=#{prefix}", "install"
  end

  test do
    assert_match /Device Type +CPU/, shell_output(bin/"clinfo")
  end
end
