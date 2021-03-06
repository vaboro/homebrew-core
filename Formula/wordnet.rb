class Wordnet < Formula
  desc "Lexical database for the English language"
  homepage "https://wordnet.princeton.edu/"
  url "https://wordnetcode.princeton.edu/3.0/WordNet-3.0.tar.bz2"
  # Version 3.1 is version 3.0 with the 3.1 dictionary.
  version "3.1"
  sha256 "6c492d0c7b4a40e7674d088191d3aa11f373bb1da60762e098b8ee2dda96ef22"

  bottle do
    sha256 catalina:    "a815dc11f451a82c84ed37266010f81bc4f5993467c1e6063edb3fc3f0fd95c5"
    sha256 mojave:      "142195600ccc68f0140352b71e9976e61758b9212d84c69dedd759cdd7a450ac"
    sha256 high_sierra: "307362dabf35eb3deb0c75154245df65a166655973a822d901a20fcad3a01f5a"
    sha256 sierra:      "873bcb33510b3211fc34bb986f9527ab554f01177fb765c7db48509291a6f7cb"
    sha256 el_capitan:  "412b4cc4b65d5083176aa69647ab5a15b96b63b758fa8900c80b402c5a9d2cb6"
    sha256 yosemite:    "876de343c8e2d508af818a7aacdcc8015f7e662edf8f08e068ca7800f48d50d4"
    sha256 mavericks:   "786bc9b811d958b71888cc87e0ef75a6cd66ebc05202278b7827f847f6b4dfe5"
  end

  depends_on :x11

  resource "dict" do
    url "https://wordnetcode.princeton.edu/wn3.1.dict.tar.gz"
    sha256 "3f7d8be8ef6ecc7167d39b10d66954ec734280b5bdcd57f7d9eafe429d11c22a"
  end

  def install
    (prefix/"dict").install resource("dict")

    # Disable calling deprecated fields within the Tcl_Interp during compilation.
    # https://bugzilla.redhat.com/show_bug.cgi?id=902561
    ENV.append_to_cflags "-DUSE_INTERP_RESULT"
    system "./configure", "--disable-debug", "--disable-dependency-tracking",
                          "--prefix=#{prefix}",
                          "--mandir=#{man}",
                          "--with-tcl=#{MacOS.sdk_path}/System/Library/Frameworks/Tcl.framework",
                          "--with-tk=#{MacOS.sdk_path}/System/Library/Frameworks/Tk.framework"
    ENV.deparallelize
    system "make", "install"
  end

  test do
    output = pipe_output("#{bin}/wn homebrew -synsn")
    assert_match(/alcoholic beverage/, output)
  end
end
