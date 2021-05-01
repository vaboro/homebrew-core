class SsllabsScan < Formula
  desc "This tool is a command-line client for the SSL Labs APIs"
  homepage "https://github.com/ssllabs/ssllabs-scan/"
  url "https://github.com/ssllabs/ssllabs-scan/archive/v1.5.0.tar.gz"
  sha256 "51c52e958d5da739910e9271a3abf4902892b91acb840ea74f5c052a71e3a008"
  license "Apache-2.0"

  bottle do
    sha256 cellar: :any_skip_relocation, catalina:    "6e5035b4bf3b2535da7964ea92672059f254df09f1dcaac94fa51e70a084861c"
    sha256 cellar: :any_skip_relocation, mojave:      "eab95a02c320153e8bcc68bcbc960665fd7b755d9a339d4bdd6618d5d33714e6"
    sha256 cellar: :any_skip_relocation, high_sierra: "91041d74d4bd340c53f15bab9c43fb6d7757601e0da00d810cdc2733a6e6c9a5"
    sha256 cellar: :any_skip_relocation, sierra:      "a2e66ec0c5e565428d2cc33906d8eecf38697e503cedb95f4817c8f186537f73"
  end

  depends_on "go" => :build

  def install
    ENV["GOPATH"] = buildpath
    system "go", "build", "-o", bin/"ssllabs-scan", "ssllabs-scan-v3.go"
  end

  def caveats
    <<~EOS
      By installing this package you agree to the Terms and Conditions defined by Qualys.
      You can find the terms and conditions at this link:
         https://www.ssllabs.com/about/terms.html

      If you do not agree with those you should uninstall the formula.
    EOS
  end

  test do
    system "#{bin}/ssllabs-scan", "-grade", "-quiet", "-usecache", "ssllabs.com"
  end
end
