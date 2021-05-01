class IosClassGuard < Formula
  desc "Objective-C obfuscator for Mach-O executables"
  homepage "https://github.com/Polidea/ios-class-guard/"
  url "https://github.com/Polidea/ios-class-guard/archive/0.8.tar.gz"
  sha256 "4446993378f1e84ce1d1b3cbace0375661e3fe2fa1a63b9bf2c5e9370a6058ff"
  license "GPL-2.0"
  head "https://github.com/Polidea/ios-class-guard.git"

  bottle do
    sha256 cellar: :any_skip_relocation, catalina:    "807b425c949e9a25331abd13967721d6f58d3a1674fcc8175744e713e81ee5d3"
    sha256 cellar: :any_skip_relocation, mojave:      "480f0437e5217cb8a47fcc0e9ffb6ffc62e4f81a79d5df9529320edeed479217"
    sha256 cellar: :any_skip_relocation, high_sierra: "1962e7dde167e41141680b1347318396c0878fb8eeae55ec9f09460fcee33142"
    sha256 cellar: :any_skip_relocation, sierra:      "a7843a0767e916aa6be1509a984eb698bb54d125d06ad762fd25f4a3d6a55db1"
    sha256 cellar: :any_skip_relocation, el_capitan:  "0bb9abaac82cbc4e66a12493548659197559a01a779db6ceda4cf6c4439ea0bb"
    sha256 cellar: :any_skip_relocation, yosemite:    "4cada6d32bb82fbd8ad2afa58b7041bd5da12dc5d9fceab6277eec97459a2d33"
    sha256 cellar: :any_skip_relocation, mavericks:   "4eddde784c843628cb8bcb8c971142683c5a17373058f5bda62356b432dec00a"
  end

  depends_on xcode: :build

  def install
    xcodebuild "-workspace", "ios-class-guard.xcworkspace",
               "-scheme", "ios-class-guard",
               "-configuration", "Release",
               "SYMROOT=build", "PREFIX=#{prefix}", "ONLY_ACTIVE_ARCH=YES"
    bin.install "build/Release/ios-class-guard"
  end

  test do
    (testpath/"crashdump").write <<~EOS
      1   MYAPP                           0x0006573a -[C03B setR02:] + 42
    EOS
    (testpath/"symbols.json").write <<~EOS
      {
        "C03B" : "MyViewController",
        "setR02" : "setRightButtons"
      }
    EOS
    system "#{bin}/ios-class-guard", "-c", "crashdump", "-m", "symbols.json"
  end
end
