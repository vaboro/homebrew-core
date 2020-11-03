class Sops < Formula
  desc "Editor of encrypted files"
  homepage "https://github.com/mozilla/sops"
  url "https://github.com/mozilla/sops/archive/v3.6.1.tar.gz"
  sha256 "bb6611eb70580ff74a258aa8b9713fdcb9a28de5a20ee716fe6b516608a60237"
  license "MPL-2.0"
  head "https://github.com/mozilla/sops.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "7b883bcead58c088e16a32310a29f4146066329f7f8b203bf69ec5f1fecec950" => :catalina
    sha256 "1c0ef6707dee2088bb816d827f6cfd2d7a26ef530b5177b3ae5652aa2a0591eb" => :mojave
    sha256 "b6e72dd038ae5c28786423aa9b5eb31c92b9533feee1b927d72cb697e3c1ddd7" => :high_sierra
  end

  depends_on "go" => :build

  def install
    system "go", "build", "-o", bin/"sops", "go.mozilla.org/sops/v3/cmd/sops"
    pkgshare.install "example.yaml"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/sops --version")

    assert_match "Recovery failed because no master key was able to decrypt the file.",
      shell_output("#{bin}/sops #{pkgshare}/example.yaml 2>&1", 128)
  end
end
