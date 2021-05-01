class Tpl < Formula
  desc "Store and retrieve binary data in C"
  homepage "https://troydhanson.github.io/tpl/"
  url "https://github.com/troydhanson/tpl/archive/v1.6.1.tar.gz"
  sha256 "0b3750bf62f56be4c42f83c89d8449b24f1c5f1605a104801d70f2f3c06fb2ff"
  license "BSD-1-Clause"
  head "https://github.com/troydhanson/tpl.git"

  bottle do
    sha256 cellar: :any, catalina:    "25b8a5fa1deda50c6dd07d69e96dd41e647b78b0f57f2696e5ddd056e509c71b"
    sha256 cellar: :any, mojave:      "668ff54097397dbf1f934f6fc380611459c1ec0c36336d1058171d4eeb349ad7"
    sha256 cellar: :any, high_sierra: "18b15a737709ac6d8ec47963fb02fba255b5e9f6c8968c126dc60bb3a0d7adee"
    sha256 cellar: :any, sierra:      "1d8a496506b276702c07d594e17b9c7be4f43c1a4651120b765b2015c18bbe54"
    sha256 cellar: :any, el_capitan:  "a887350815a2791312bdec2ecdf82795d6f54c67f9e76842236e8bb1f507108d"
    sha256 cellar: :any, yosemite:    "2587ed48c7a6ff2c309e688695c79d845b5fe2a06eae1189dc1c9de21f9bceaa"
    sha256 cellar: :any, mavericks:   "237a01785ea7f81c9977440e6d1ede64fa109a060aa855a938a6f11f6f187d4a"
  end

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "libtool" => :build

  def install
    system "autoreconf", "-fvi"
    system "./configure", "--disable-dependency-tracking",
                          "--disable-silent-rules",
                          "--prefix=#{prefix}"
    system "make", "install"
    system "make", "-C", "tests"
  end
end
