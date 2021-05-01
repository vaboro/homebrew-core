class DockerMachineParallels < Formula
  desc "Parallels Driver for Docker Machine"
  homepage "https://github.com/Parallels/docker-machine-parallels"
  url "https://github.com/Parallels/docker-machine-parallels/archive/v1.4.0.tar.gz"
  sha256 "2c0615f015c7d686050625f1f68c5f62b10e0f924f6126c4d31a56c17be2ef47"
  license "MIT"
  head "https://github.com/Parallels/docker-machine-parallels.git"

  bottle do
    sha256 cellar: :any_skip_relocation, catalina:    "6a72d65d67b02ad07e0be3f5fea043bcb406860d58ba4131fdc66ec77b9c212a"
    sha256 cellar: :any_skip_relocation, mojave:      "56183f07f2f09eaae958ba5029bfd366a53a42acc40dda6685923fbd524d3dfc"
    sha256 cellar: :any_skip_relocation, high_sierra: "c7c2c22c321fb09e28ad35576479ea27cf37aaa9a84f63983b771774aaa7dbc4"
    sha256 cellar: :any_skip_relocation, sierra:      "626f025bef7c15943215ca899dae86bd4e07926826a9eba9b7b43798a16c82ce"
  end

  depends_on "go" => :build
  depends_on "docker-machine"

  def install
    ENV["GOPATH"] = buildpath

    path = buildpath/"src/github.com/Parallels/docker-machine-parallels"
    path.install Dir["*"]

    cd path do
      system "make", "build"
      bin.install "bin/docker-machine-driver-parallels"
    end

    prefix.install_metafiles path
  end

  test do
    assert_match "parallels-memory", shell_output("docker-machine create -d parallels -h")
  end
end
