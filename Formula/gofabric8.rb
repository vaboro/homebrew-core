class Gofabric8 < Formula
  desc "CLI for fabric8 running on Kubernetes or OpenShift"
  homepage "https://github.com/fabric8io/gofabric8/"
  url "https://github.com/fabric8io/gofabric8/archive/v0.4.176.tar.gz"
  sha256 "78e44fdfd69605f50ab1f5539f2d282ce786b28b88c49d0f9671936c9e37355a"
  license "Apache-2.0"

  bottle do
    sha256 cellar: :any_skip_relocation, catalina:    "d77a93b69fcd7ce3924da680758be10df17d36de20bacc45163af46e7a590613"
    sha256 cellar: :any_skip_relocation, mojave:      "f3e6eb21a7d5e2e83ae1d463fa36a5501d8bc1f72d98d105e700a446003ee336"
    sha256 cellar: :any_skip_relocation, high_sierra: "5835f2a6b6dd8e030b75bd7b8d5b28852011c23fb41864d54cb5af8b1a9af8d7"
    sha256 cellar: :any_skip_relocation, sierra:      "4e5c9251203ad5c0d80959d881551231159ba4782346c5619fa6a521d3dc86c2"
    sha256 cellar: :any_skip_relocation, el_capitan:  "b727813219f939d47303e0ed627d778747ba890456d7f571675e6caf79b92ea1"
  end

  depends_on "go" => :build

  def install
    ENV["GOPATH"] = buildpath
    dir = buildpath/"src/github.com/fabric8io/gofabric8"
    dir.install buildpath.children

    cd dir do
      system "make", "install", "REV=homebrew"
      prefix.install_metafiles
    end

    bin.install "bin/gofabric8"
  end

  test do
    Open3.popen3("#{bin}/gofabric8", "version") do |stdin, stdout, _|
      stdin.puts "N" # Reject any auto-update prompts
      stdin.close
      assert_match "gofabric8, version #{version} (branch: 'unknown', revision: 'homebrew')", stdout.read
    end
  end
end
