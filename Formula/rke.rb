class Rke < Formula
  desc "Rancher Kubernetes Engine, a Kubernetes installer that works everywhere"
  homepage "https://rancher.com/docs/rke/latest/en/"
  url "https://github.com/rancher/rke/archive/v1.1.7.tar.gz"
  sha256 "f50c3f4464b8f20feed476abe7673becc9f7f233b950418ffd04728c9acc28a6"
  license "Apache-2.0"

  bottle do
    cellar :any_skip_relocation
    sha256 "ed2861b932970dd5fdedae695208f82ff22c8a5069d33badb8f8e0c6a0042fc2" => :catalina
    sha256 "8d5de39b4d8477ffdde29e56bfd894fe24545eaf0684290e53f8dc579c425aa6" => :mojave
    sha256 "d49c1a3f544d638b6291975a16f0ed0416b11f3ebad7bb524dd7fbab1ddb5a1e" => :high_sierra
  end

  depends_on "go" => :build

  def install
    system "go", "build", "-ldflags",
            "-w -X main.VERSION=v#{version}",
            "-o", bin/"rke"
  end

  test do
    system bin/"rke", "config", "-e"
    assert_predicate testpath/"cluster.yml", :exist?
  end
end
