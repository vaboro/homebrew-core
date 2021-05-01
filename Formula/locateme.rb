class Locateme < Formula
  desc "Find your location using Apple's geolocation services"
  homepage "https://iharder.sourceforge.io/current/macosx/locateme"
  url "https://downloads.sourceforge.net/project/iharder/locateme/LocateMe-v0.2.1.zip"
  sha256 "137016e6c1a847bbe756d8ed294b40f1d26c1cb08869940e30282e933e5aeecd"

  livecheck do
    url :stable
    regex(%r{url=.*?/LocateMe[._-]v?(\d+(?:\.\d+)+)\.(?:t|zip)}i)
  end

  bottle do
    sha256 cellar: :any_skip_relocation, catalina:    "20c927c90ce8813ed161667367c75f8235705fe9fe4c8e5cc6e0b0505b19c978"
    sha256 cellar: :any_skip_relocation, mojave:      "3ece081d7d799312e2f1afb6cdc210a5915a89e30143412fa30f2d1953701ede"
    sha256 cellar: :any_skip_relocation, high_sierra: "e5be4f7b94d001483320c2445739e26deb3007f8fb54185eac4c1cdf941114a3"
    sha256 cellar: :any_skip_relocation, sierra:      "cb5fe0b740f04c036726e546481f0eed603873ce57b063e0621ae8f73f66645d"
    sha256 cellar: :any_skip_relocation, el_capitan:  "5f8e1febc1886565bfa9691cb3ffc0486999f8b682a52276c1d9ea6e0f1f4470"
    sha256 cellar: :any_skip_relocation, yosemite:    "a7876905a4c06452431e506523c5fdf142e2de364427600122fbb9b4928bc6d1"
  end

  def install
    system ENV.cc, "-framework", "Foundation", "-framework", "CoreLocation", "LocateMe.m", "-o", "LocateMe"
    bin.install "LocateMe"
    man1.install "LocateMe.1"
  end

  test do
    system "#{bin}/LocateMe", "-h"
  end
end
