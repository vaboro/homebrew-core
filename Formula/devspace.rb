class Devspace < Formula
  desc "CLI helps develop/deploy/debug apps with Docker and k8s"
  homepage "https://devspace.cloud/docs"
  url "https://github.com/devspace-cloud/devspace.git",
<<<<<<< HEAD
    :tag      => "v3.5.15",
    :revision => "c8d66b7d7b2284b26c90b2c3411fe364faa61b05"

  bottle do
    cellar :any_skip_relocation
    sha256 "7545e1b89eecb77fe947eac3f3d1dad3726f79110d5fe911ca6cdf09b3296838" => :mojave
    sha256 "c09d3a425d8ff80f4976a4182c6e8047de6939300dca40a17a1fa03ed460a818" => :high_sierra
    sha256 "50cd2a4bfb17dc98492123c2928be97a9551716f9b7a40bab338c08603c7d87d" => :sierra
=======
    :tag      => "v3.5.18",
    :revision => "06a0eab8c1ef6a14d1d4287b491ce4815a15f7bb"

  bottle do
    cellar :any_skip_relocation
    sha256 "b020230a8307110c1f6506cce8a6c28285a012c5f232594b22e7c6219bdbec72" => :mojave
    sha256 "9f9a1382ad606c760a53326537bf35e132e00deeb2260cfe354d1724758eb44e" => :high_sierra
    sha256 "96d46840e94b1a40888f3c57833233892c57015909ad7ce97c9aaf39d393cbbf" => :sierra
>>>>>>> upstream/master
  end

  depends_on "go" => :build
  depends_on "kubernetes-cli"

  def install
    ENV["GOPATH"] = buildpath
    ENV["GO111MODULE"] = "on"

    dir = buildpath/"src/github.com/devspace-cloud/devspace"
    dir.install buildpath.children

    cd dir do
      system "go", "build", "-o", bin/"devspace"
      prefix.install_metafiles
    end
  end

  test do
    help_output = "DevSpace accelerates developing, deploying and debugging applications with Docker and Kubernetes."
    assert_match help_output, shell_output("#{bin}/devspace help")

    init_help_output = "Initializes a new devspace project"
    assert_match init_help_output, shell_output("#{bin}/devspace init --help")
  end
end
