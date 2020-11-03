class Goreleaser < Formula
  desc "Deliver Go binaries as fast and easily as possible"
  homepage "https://goreleaser.com/"
  url "https://github.com/goreleaser/goreleaser.git",
<<<<<<< HEAD
<<<<<<< HEAD
<<<<<<< HEAD
<<<<<<< HEAD
      :tag      => "v0.114.1",
      :revision => "36b190490f7b1716c9edb9ce96f243397b97abf3"

  bottle do
    cellar :any_skip_relocation
    sha256 "65552f0e69391e74a594c3991d7e9e0de1ef2d16a097a232d2bc298c789ea696" => :mojave
    sha256 "d395c23e294f1db26bb848ee56bfe953b3d05936fc0ea97b835456dc99c33cae" => :high_sierra
    sha256 "a1aa330e997689be34c7c25544276f00d20bc7df0c5acd821d358bc00776309e" => :sierra
=======
      :tag      => "v0.117.1",
      :revision => "ebe510a894357f7e5d8895a934d5db5dd3c7ecb4"

  bottle do
    cellar :any_skip_relocation
    sha256 "277eec4f91d832f7866e4f4301f3415213e23db3a7e0099e99f3984e947d6107" => :mojave
    sha256 "d9c87ed8a8e70af624181baf2a10555c32eab1500542ca38f0ce656a5ea41582" => :high_sierra
    sha256 "fd81544342d78c0f6033dd02b166ac66facece3bb6a99ee684fd3d0dbdaff78a" => :sierra
>>>>>>> upstream/master
=======
      :tag      => "v0.117.2",
      :revision => "2c08ab87a13ce4a70cf89a691fbbc46c7da6c2e6"

  bottle do
    cellar :any_skip_relocation
    sha256 "e10336aea2dddb3ee0fc4b602cac2b08aeed29015a28b94f381b22017cc66bf1" => :mojave
    sha256 "51acd8378f68914c2cf92f2e8db7e4357024b69f4ad1efec5edfe367bdc9cfe1" => :high_sierra
    sha256 "188cf53e7074a0efaf73c88b0af27e966cd44ff459fab3a2da27cdfe3e8054b9" => :sierra
>>>>>>> upstream/master
=======
      :tag      => "v0.118.2",
      :revision => "d1e97a3fd8bc8e0680329a5f45172c9788b6f057"

  bottle do
    cellar :any_skip_relocation
    sha256 "839280137bcdcc14f29c892c01e7c465ccc36fe62b905e435bab008942260210" => :catalina
    sha256 "8ef334862e473c30a273acc7eb552ec438bdfa126156032bbe85ac93b4c3ce8c" => :mojave
    sha256 "28177e58ab866d7440b6c65b67485f6c1a21f9bf75cbf66e83476daf7f207e85" => :high_sierra
>>>>>>> upstream/master
=======
      tag:      "v0.143.0",
      revision: "28230b67f8f25ed8493e85f3d06fb4dec5618f44"
  license "MIT"

  bottle do
    cellar :any_skip_relocation
    sha256 "7ef7ca6765c61694e6d63c5e95929d2234480c7d75807ce68a73234b2cbc239d" => :catalina
    sha256 "d64c123992116544febbe08e0a88476b7b9e9ac320efad00d9760ad34c71e44e" => :mojave
    sha256 "fa1e0110c826109db418814d9c34827e41a7d1125a9cea5c28c0cebe427d68dd" => :high_sierra
>>>>>>> upstream/master
  end

  depends_on "go" => :build

  def install
    system "go", "build", "-ldflags",
             "-s -w -X main.version=#{version} -X main.commit=#{stable.specs[:revision]} -X main.builtBy=homebrew",
             *std_go_args
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/goreleaser -v 2>&1")
    assert_match "config created", shell_output("#{bin}/goreleaser init --config=.goreleaser.yml 2>&1")
    assert_predicate testpath/".goreleaser.yml", :exist?
  end
end
