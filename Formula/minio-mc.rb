class MinioMc < Formula
  desc "Replacement for ls, cp and other commands for object storage"
  homepage "https://github.com/minio/mc"
  url "https://github.com/minio/mc.git",
<<<<<<< HEAD
      :tag      => "RELEASE.2019-08-07T23-14-43Z",
      :revision => "fef437bdd6bdd65dbc51e3d069c2e7d0413bc143"
  version "20190807231443"

  bottle do
    cellar :any_skip_relocation
    sha256 "f622613623a76c7842c8207cce1fb1d171e16cbfa4576b88bd6ac266520bd344" => :mojave
    sha256 "9df5964acc88d7898897312bdeea08d804e7cd4926ccdeb1a605756257c49189" => :high_sierra
    sha256 "75be01c21c8230f6bce104456ce1b044a789c1c3a35362a8c7bae378754a6dc2" => :sierra
=======
      :tag      => "RELEASE.2019-08-29T00-40-57Z",
      :revision => "bd7564a2d4524335a594f0f4e10b06c033eb299c"
  version "20190829004057"

  bottle do
    cellar :any_skip_relocation
    sha256 "57ac5a062e01a021e9d00898acdece98ae44dfc62740b1e29afda77aa16f3283" => :mojave
    sha256 "ec768c4079bc505adfe5acab72d3b5b24a7395bf8a5610286fbbe1952117de2d" => :high_sierra
    sha256 "9a101b02fd37e960e805ca86cc49b95a25c366dc992276c057c198efaa67bb36" => :sierra
>>>>>>> upstream/master
  end

  depends_on "go" => :build

  conflicts_with "midnight-commander", :because => "Both install a `mc` binary"

  def install
    ENV["GOPATH"] = buildpath
    ENV["GO111MODULE"] = "on"
    src = buildpath/"src/github.com/minio/mc"
    src.install buildpath.children
    src.cd do
      if build.head?
        system "go", "build", "-o", buildpath/"mc"
      else
        minio_release = `git tag --points-at HEAD`.chomp
        minio_version = minio_release.gsub(/RELEASE\./, "").chomp.gsub(/T(\d+)\-(\d+)\-(\d+)Z/, 'T\1:\2:\3Z')
        minio_commit = `git rev-parse HEAD`.chomp
        proj = "github.com/minio/mc"

        system "go", "build", "-o", buildpath/"mc", "-ldflags", <<~EOS
          -X #{proj}/cmd.Version=#{minio_version}
          -X #{proj}/cmd.ReleaseTag=#{minio_release}
          -X #{proj}/cmd.CommitID=#{minio_commit}
        EOS
      end
    end

    bin.install buildpath/"mc"
    prefix.install_metafiles
  end

  test do
    system bin/"mc", "mb", testpath/"test"
    assert_predicate testpath/"test", :exist?
  end
end
