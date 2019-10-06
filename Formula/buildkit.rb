class Buildkit < Formula
  desc "Сoncurrent, cache-efficient, and Dockerfile-agnostic builder toolkit"
  homepage "https://github.com/moby/buildkit"
  url "https://github.com/moby/buildkit/archive/v0.6.2.tar.gz"
  sha256 "1eaf2c85c20d8da283e48548954484883354df66c6a4c2dc87bba7514a7ba99e"

  bottle do
    cellar :any_skip_relocation
    sha256 "2919c138a4e31b0559dbbe6e8726a97b2b85e8c4385372eb037a7261b0330c5d" => :catalina
    sha256 "8b2ab85aad03d95ab7b3ed555ff7b7aa0622ccec01ddfc4b0040b3b3eabc3f4f" => :mojave
    sha256 "0b46243086892d27bc10c58eb8d3a193e614f38da65b58b25b2038382135d2db" => :high_sierra
  end

  depends_on "go" => :build

  def install
    ENV["GOPATH"] = buildpath
    doc.install %w[README.md] + Dir["docs/*.md"]

    (buildpath/"src/github.com/moby/buildkit/").install Dir["*"]

    ldflags = ["-X github.com/moby/buildkit/version.Version=#{version}",
               "-X github.com/moby/buildkit/version.Package=github.com/moby/buildkit"]
    system "go", "build", "-o", bin/"buildctl", "-ldflags", ldflags.join(" "), "github.com/moby/buildkit/cmd/buildctl"
  end

  test do
    shell_output("#{bin}/buildctl --addr unix://dev/null --timeout 0 du 2>&1", 1)
  end
end
