class Osm < Formula
  desc "Open Service Mesh (OSM)"
  homepage "https://openservicemesh.io/"
  url "https://github.com/openservicemesh/osm/archive/v0.3.0.tar.gz"
  sha256 "d4b9fa2789fd8dfadae9df5a8a80d3e6db24cca7629a52b0d61608761ae70d73"
  license "MIT"

  bottle do
    sha256 cellar: :any_skip_relocation, catalina:    "1d919080c06f48497aa61afa3218a14e16deb130de69237b55e9d55c18bd9cd5"
    sha256 cellar: :any_skip_relocation, mojave:      "6d61028e903da81e664ee9994c3948353303d52212f1c1e894af0baa15b259ca"
    sha256 cellar: :any_skip_relocation, high_sierra: "08c329ad3fa81cd0da5e94015d462c35cb7764f7a1e490bdac51e8d3021ebbb3"
  end

  depends_on "go" => :build

  def install
    system "make", "build-osm"
    bin.install "bin/osm"
  end

  test do
    assert_match "Error: Error fetching kubeconfig", shell_output("#{bin}/osm namespace list 2>&1", 1)
  end
end
