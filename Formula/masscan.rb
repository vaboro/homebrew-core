class Masscan < Formula
  desc "TCP port scanner, scans entire Internet in under 5 minutes"
  homepage "https://github.com/robertdavidgraham/masscan/"
  url "https://github.com/robertdavidgraham/masscan/archive/1.0.5.tar.gz"
  sha256 "a0686929888674892f464014806444d26ded56838d45035221ff88ee9f6ead73"
  license "AGPL-3.0"
  head "https://github.com/robertdavidgraham/masscan.git"

  livecheck do
    url "https://github.com/robertdavidgraham/masscan/releases/latest"
    regex(%r{href=.*?/tag/v?(\d+(?:\.\d+)+)["' >]}i)
  end

  bottle do
    sha256 cellar: :any_skip_relocation, catalina:    "480e77a29b46bf529743f0d4e21a8e69d55e41d19bbb4e3b1665d329c8b3e94f"
    sha256 cellar: :any_skip_relocation, mojave:      "6de3b12cbe718062781ee5bddad15a3f4835dafe77210f3ecba59d4e11e733e3"
    sha256 cellar: :any_skip_relocation, high_sierra: "20a6281fb4adb9aec9fd7bddf8da30bc2ae8f5bec6daa5b468444916859017fd"
    sha256 cellar: :any_skip_relocation, sierra:      "729b4ce06557da726edbf7e6e570ed1ff96ca3e0bc42d9399f9ed96aa48ef2a2"
    sha256 cellar: :any_skip_relocation, el_capitan:  "9aa4359e82e1b467f24d7e813ee8919dbc5cf32a182fd6eafcadc015bcd97955"
  end

  def install
    # Fix `dyld: lazy symbol binding failed: Symbol not found: _clock_gettime`
    # Reported 8 July 2017: https://github.com/robertdavidgraham/masscan/issues/284
    if MacOS.version == :el_capitan && MacOS::Xcode.version >= "8.0"
      inreplace "src/pixie-timer.c", "#elif defined(CLOCK_MONOTONIC)", "#elif defined(NOT_A_MACRO)"
    end

    system "make"
    bin.install "bin/masscan"
  end

  test do
    assert_match(/adapter =/, `#{bin}/masscan --echo | head -n 6 | tail -n 1`)
  end
end
