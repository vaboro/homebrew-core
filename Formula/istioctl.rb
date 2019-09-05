class Istioctl < Formula
  desc "Istio configuration command-line utility"
  homepage "https://github.com/istio/istio"
  url "https://github.com/istio/istio.git",
<<<<<<< HEAD
      :tag      => "1.2.4",
      :revision => "c562694ea6e554c2b60d12c9876d2641cfdd917d"

  bottle do
    cellar :any_skip_relocation
    sha256 "82fb877fda80c90d3dee76cc77a597b74c5f2376cab5789d73d37709acebacd0" => :mojave
    sha256 "5c19aef1c2561ed75835ae9d6c6346590678035f657c57ae13d954d931b898be" => :high_sierra
    sha256 "59293cc59c1ae3bc5d043b77a52fff7e87756b9c421b37bacfffd9b9f31201f3" => :sierra
=======
      :tag      => "1.2.5",
      :revision => "d9e231eda0e163d0f3df0103546c7a06b72cc48d"

  bottle do
    cellar :any_skip_relocation
    sha256 "a52ce214a65325356946c7d27b89f3e730a40ce2969807a613a776e748774c9d" => :mojave
    sha256 "2a4e330945618ac2fb2009a2e6f282d2ed5023627471cd6a6a03798596696a27" => :high_sierra
    sha256 "48144f9cd3eff46fad23a5bc84d2e7975774f66f0ceabb24934ef7696779997f" => :sierra
>>>>>>> upstream/master
  end

  depends_on "go" => :build

  def install
    ENV["GOPATH"] = buildpath
    ENV["TAG"] = version.to_s
    ENV["ISTIO_VERSION"] = version.to_s

    srcpath = buildpath/"src/istio.io/istio"
    outpath = buildpath/"out/darwin_amd64/release"
    srcpath.install buildpath.children

    cd srcpath do
      system "make", "istioctl"
      prefix.install_metafiles
      bin.install outpath/"istioctl"
    end
  end

  test do
    assert_match "Retrieve policies and rules", shell_output("#{bin}/istioctl get -h")
  end
end
