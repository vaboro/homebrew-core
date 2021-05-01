class Glide < Formula
  desc "Simplified Go project management, dependency management, and vendoring"
  homepage "https://github.com/Masterminds/glide"
  url "https://github.com/Masterminds/glide/archive/v0.13.3.tar.gz"
  sha256 "817dad2f25303d835789c889bf2fac5e141ad2442b9f75da7b164650f0de3fee"
  license "MIT"
  head "https://github.com/Masterminds/glide.git"

  bottle do
    sha256 cellar: :any_skip_relocation, catalina:    "6950b3ca86a9c460e3937ca5b931836586310203726ca37bd434b822b4f0f8c1"
    sha256 cellar: :any_skip_relocation, mojave:      "795f7f533f050b5356846b3ed2a9db88a51ef74b929e28ea0473c83f630b03c3"
    sha256 cellar: :any_skip_relocation, high_sierra: "45c35a6adf13bc732a827669e4ffb19dcfa710180c2b2930435d4217802313d6"
    sha256 cellar: :any_skip_relocation, sierra:      "d665d8221c75985ffde8357c5ebfd53c2cb3398ac699a1afc1ebf8000e5206cc"
  end

  depends_on "go"

  def install
    ENV["GOPATH"] = buildpath
    glidepath = buildpath/"src/github.com/Masterminds/glide"
    glidepath.install buildpath.children

    cd glidepath do
      system "go", "build", "-o", "glide", "-ldflags", "-X main.version=#{version}"
      bin.install "glide"
      prefix.install_metafiles
    end
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/glide --version")
    system bin/"glide", "create", "--non-interactive", "--skip-import"
    assert_predicate testpath/"glide.yaml", :exist?
  end
end
