class Earthly < Formula
  desc "Build automation tool for the post-container era"
  homepage "https://earthly.dev/"
  url "https://github.com/earthly/earthly/archive/v0.3.6.tar.gz"
  sha256 "ade444a236364345ddd2e0a86a6edb72fc6b9440bfa77dc340c9d35355e32f19"
  license "MPL-2.0"
  head "https://github.com/earthly/earthly.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "b955a47b38fa17490f5c8614c56faedb5e7c10194bd7c43d5a390bfe2936df5f" => :catalina
    sha256 "162bdc4555b29eff87162f351486dfc4694b287b552437e19f7632caadb79ba8" => :mojave
    sha256 "7a62ff3ac28ea63ed59b9f84947c20aa0b4b9b807b085f4877ff01726edba374" => :high_sierra
  end

  depends_on "go" => :build

  def install
    ldflags = "-X main.DefaultBuildkitdImage=earthly/buildkitd:v#{version} -X main.Version=v#{version} -X" \
              " main.GitSha=7c9dd73df3cd27e070a6d7b22910f5853c0be9dd "
    tags = "dfrunmount dfrunsecurity dfsecrets dfssh dfrunnetwork"
    system "go", "build",
        "-tags", tags,
        "-ldflags", ldflags,
        *std_go_args,
        "-o", bin/"earth",
        "./cmd/earth/main.go"
  end

  test do
    (testpath/"build.earth").write <<~EOS

      default:
      \tRUN echo Homebrew
    EOS

    output = shell_output("#{bin}/earth --buildkit-host 127.0.0.1 +default 2>&1", 1).strip
    assert_match "Error while dialing invalid address 127.0.0.1", output
  end
end
