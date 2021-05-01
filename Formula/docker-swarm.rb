class DockerSwarm < Formula
  desc "Turn a pool of Docker hosts into a single, virtual host"
  homepage "https://github.com/docker/classicswarm"
  url "https://github.com/docker/classicswarm/archive/v1.2.9.tar.gz"
  sha256 "13d0d39dbd2bccb32016e6aa782da67b6207f203e253e06b0f6eb4f25da85474"
  license "Apache-2.0"
  head "https://github.com/docker/classicswarm.git"

  livecheck do
    url :head
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  bottle do
    rebuild 1
    sha256 cellar: :any_skip_relocation, catalina:    "e2d8d18ea613fd94a32e0918f29238836b89dd32464e8f6e1145e744348ab0cd"
    sha256 cellar: :any_skip_relocation, mojave:      "d3cc672187adb5d73dfb2b6a90326de6ad228ccf48141ef3242447ca0416aee3"
    sha256 cellar: :any_skip_relocation, high_sierra: "29e47d799c8e2d2977dd58444095a51c9ac7f261f56eeb5d5b6f71ed299e7533"
  end

  depends_on "go" => :build

  def install
    ENV["GOPATH"] = buildpath
    (buildpath/"src/github.com/docker/swarm").install buildpath.children
    cd "src/github.com/docker/swarm" do
      system "go", "build", "-o", bin/"docker-swarm"
      prefix.install_metafiles
    end
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/docker-swarm --version")
  end
end
