class Glooctl < Formula
  desc "Envoy-Powered API Gateway"
  homepage "https://gloo.solo.io"
  url "https://github.com/solo-io/gloo.git",
<<<<<<< HEAD
      :tag      => "v0.18.15",
      :revision => "523d8c54473de48660619863523976d344aef06e"
=======
      :tag      => "v0.18.31",
      :revision => "b27018fdbadf7526ebe7190cf692e66235e3e922"
>>>>>>> upstream/master
  head "https://github.com/solo-io/gloo.git"

  bottle do
    cellar :any_skip_relocation
<<<<<<< HEAD
    sha256 "16f3a3c0806b61aa398afc71473f7ad528813c5accc0ddff19f004de3f81fc4b" => :mojave
    sha256 "e0b9ab5fe62fba765943dfbc7e06080c166c80bb956d663feb7531df46b3a86a" => :high_sierra
    sha256 "9e678de4c47f5f57a06a31bb6b6ba23a9259072bcbddabc6c6b789a94d1a0954" => :sierra
=======
    sha256 "705795dde16511a4a40093bc12b00807963fd35f19d6309c5080c61d59d68af7" => :mojave
    sha256 "896e927c8d32372793045c665cd2a3056480916b94bd6e38f8ec88490f700781" => :high_sierra
    sha256 "d2cdabb69a181870863969de0f71535dbb7a164a06ea81f68e9dec2190c8adf3" => :sierra
>>>>>>> upstream/master
  end

  depends_on "dep" => :build
  depends_on "go" => :build

  def install
    ENV["GOPATH"] = buildpath
    dir = buildpath/"src/github.com/solo-io/gloo"
    dir.install buildpath.children - [buildpath/".brew_home"]

    cd dir do
      system "dep", "ensure", "-vendor-only"
      system "make", "glooctl", "TAGGED_VERSION=v#{version}"
      bin.install "_output/glooctl"
    end
  end

  test do
    run_output = shell_output("#{bin}/glooctl 2>&1")
    assert_match "glooctl is the unified CLI for Gloo.", run_output

    version_output = shell_output("#{bin}/glooctl --version 2>&1")
    assert_match "glooctl community edition version #{version}", version_output

    # Should error out as it needs access to a Kubernetes cluster to operate correctly
    status_output = shell_output("#{bin}/glooctl get proxy 2>&1", 1)
    assert_match "failed to create proxy client", status_output
  end
end
