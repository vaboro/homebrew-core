class PinentryMac < Formula
  desc "Pinentry for GPG on Mac"
  homepage "https://github.com/GPGTools/pinentry-mac"
  url "https://github.com/GPGTools/pinentry-mac/archive/v0.9.4.tar.gz"
  sha256 "037ebb010377d3a3879ae2a832cefc4513f5c397d7d887d7b86b4e5d9a628271"
  license "GPL-2.0"
  head "https://github.com/GPGTools/pinentry-mac.git"

  bottle do
    sha256 cellar: :any_skip_relocation, catalina:    "936dba5c3bdd8279e5380012645a349a6ef8c69d1cc9066f28f9c6fa6642fd64"
    sha256 cellar: :any_skip_relocation, mojave:      "6b2e8f260b2c9d2d7cd3f39516d7794656492cf7726a92a847aa86ba02d83179"
    sha256 cellar: :any_skip_relocation, high_sierra: "aa7a00ec594541e43a74cf7ae16cb05317d5b73c7b6b6647ca349584280eaad7"
    sha256 cellar: :any_skip_relocation, sierra:      "3da6a88abbd4bb04eb2455d8e6998f4fc4db77c3f765d52b7eadf364e82aeaa7"
    sha256 cellar: :any_skip_relocation, el_capitan:  "c3d508c96256c50b6a62f9e64fc4cb28810a910927c21f7defbe8af11a3c5961"
    sha256 cellar: :any_skip_relocation, yosemite:    "b96a51a263a9447101d4bb8dc4247f324531bd4fd96218f6e170edfc983a87f7"
    sha256 cellar: :any_skip_relocation, mavericks:   "c2538b57edce2eb7ccc10a32e16ccfbbbe8e61c384c4db8d5a62b04d3815c0ed"
  end

  depends_on xcode: :build

  patch do
    # patch header locations for macOS 10.14
    # https://github.com/GPGTools/pinentry-mac/pull/7
    url "https://github.com/GPGTools/pinentry-mac/commit/62fe9f9a3d21891e87883af2e0e3815155926b20.patch?full_index=1"
    sha256 "d4bcf2003fa1345ecb1809461140179a3737e8e03eb49d623435beb3c2f09b64"
  end

  def install
    system "make"
    prefix.install "build/Release/pinentry-mac.app"
    bin.write_exec_script "#{prefix}/pinentry-mac.app/Contents/MacOS/pinentry-mac"
  end

  def caveats
    <<~EOS
      You can now set this as your pinentry program like

      ~/.gnupg/gpg-agent.conf
          pinentry-program #{HOMEBREW_PREFIX}/bin/pinentry-mac
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/pinentry-mac --version")
  end
end
