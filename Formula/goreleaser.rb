class Goreleaser < Formula
  desc "Deliver Go binaries as fast and easily as possible"
  homepage "https://goreleaser.com/"
  url "https://github.com/goreleaser/goreleaser.git",
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
  end

  depends_on "go" => :build

  def install
    ENV["GOPATH"] = buildpath
    ENV["GO111MODULE"] = "on"

    dir = buildpath/"src/github.com/goreleaser/goreleaser"
    dir.install buildpath.children

    cd dir do
      system "go", "mod", "vendor"
      system "go", "build", "-ldflags",
                   "-s -w -X main.version=#{version} -X main.commit=#{stable.specs[:revision]} -X main.builtBy=homebrew",
                   "-o", bin/"goreleaser"
      prefix.install_metafiles
    end
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/goreleaser -v 2>&1")
    assert_match "config created", shell_output("#{bin}/goreleaser init --config=.goreleaser.yml 2>&1")
    assert_predicate testpath/".goreleaser.yml", :exist?
  end
end
