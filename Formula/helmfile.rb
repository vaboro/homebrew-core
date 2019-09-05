class Helmfile < Formula
  desc "Deploy Kubernetes Helm Charts"
  homepage "https://github.com/roboll/helmfile"
  url "https://github.com/roboll/helmfile/archive/v0.82.0.tar.gz"
  sha256 "68a69b7a3ed999c2699d672fb0a152f18703298a5edc982d338590c140c2d64a"

  bottle do
    cellar :any_skip_relocation
    sha256 "fe205fc05566e17c9ccdb85d96810b84d7ac98a9abfef74cc8bbe889295d9038" => :mojave
    sha256 "30c4f0a85ea6548c00db30237baf1e6668d1a0a76412e0d4f97e4b70b651e7e8" => :high_sierra
    sha256 "0544a40faaa1ed5724168c2ee9ca46164c700ca6dd8cf31b07ed56b748591411" => :sierra
  end

  depends_on "go" => :build
  depends_on "kubernetes-helm"

  # See https://github.com/roboll/helmfile/issues/834
  # Remove this patch in the next version.
  patch do
    url "https://github.com/roboll/helmfile/commit/1823bb1e5b159dfd8198704722d63ec6db40b4ee.patch?full_index=1"
    sha256 "4d37b12b9565d45c2c885277b54cf8c799263dbbd8d2d165f13da095dc38dfe6"
  end

  def install
    ENV["GOPATH"] = buildpath
    ENV["GO111MODULE"] = "on"

    (buildpath/"src/github.com/roboll/helmfile").install buildpath.children
    cd "src/github.com/roboll/helmfile" do
      system "go", "build", "-ldflags", "-X main.Version=v#{version}",
             "-o", bin/"helmfile", "-v", "github.com/roboll/helmfile"
      prefix.install_metafiles
    end
  end

  test do
    (testpath/"helmfile.yaml").write <<-EOS
    repositories:
    - name: stable
      url: https://kubernetes-charts.storage.googleapis.com/

    releases:
    - name: test
    EOS
    system Formula["kubernetes-helm"].opt_bin/"helm", "init", "--client-only"
    output = "Adding repo stable https://kubernetes-charts.storage.googleapis.com"
    assert_match output, shell_output("#{bin}/helmfile -f helmfile.yaml repos 2>&1")
    assert_match version.to_s, shell_output("#{bin}/helmfile -v")
  end
end
