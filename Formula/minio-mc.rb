class MinioMc < Formula
  desc "Replacement for ls, cp and other commands for object storage"
  homepage "https://github.com/minio/mc"
  url "https://github.com/minio/mc.git",
<<<<<<< HEAD
<<<<<<< HEAD
<<<<<<< HEAD
<<<<<<< HEAD
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
=======
      :tag      => "RELEASE.2019-09-05T23-43-50Z",
      :revision => "22ab93da0f995172520c8ddf182bff3d10ca5b66"
  version "20190905234350"

  bottle do
    cellar :any_skip_relocation
    sha256 "916382ab97bf764da38634354e1f9ab99b29556502c0241e347497052d0c6761" => :mojave
    sha256 "ca8ae7c4979cc4be2e6b8cf145669d3221d5c9b1b449ca64dba514eb4a917942" => :high_sierra
    sha256 "e799d58ba08a41be206b832ae2f4a67519cd4f8f21c21af5c93e0804fc56335f" => :sierra
>>>>>>> upstream/master
=======
      :tag      => "RELEASE.2019-09-11T20-17-47Z",
      :revision => "54ee3a280031adabc49a8309b74e5786cf266706"
  version "20190911201747"

  bottle do
    cellar :any_skip_relocation
    sha256 "1aaabc9d35b614a4b4b6118347092dfd190dfbea91c26865241a8aa4be010ed7" => :mojave
    sha256 "7a8d082fa5024d44f37fc5c4af532ff8488b9d9358ea512f7fd859024ef602d1" => :high_sierra
    sha256 "daae2008ce5947b834ad499e91ae18f570539dba4737cf79567f3e8f77962b34" => :sierra
>>>>>>> upstream/master
=======
      :tag      => "RELEASE.2019-10-02T19-41-02Z",
      :revision => "26b9044a8676a8c5ff79a6054343e5be74c35135"
  version "20191002194102"

  bottle do
    cellar :any_skip_relocation
    sha256 "0b81d4b1f5f97dce43fb77117a98ac7f10adc82146ed1b29dc657770366ab21d" => :catalina
    sha256 "3a85394b3ca31a22fc3a897ff376d8a88fcfffaf0be8b2af66f1bc68914a9cd9" => :mojave
    sha256 "f52d51b974009d99558a49490b0de689abd137eea2aa816bc4f285b4806a4640" => :high_sierra
>>>>>>> upstream/master
=======
      tag:      "RELEASE.2020-09-03T00-08-28Z",
      revision: "f99232260606ae4a6ef16613838d202765efa18c"
  version "20200903000828"
  license "Apache-2.0"

  bottle do
    cellar :any_skip_relocation
    sha256 "9750629887fa58c2781b5d196e1b4698cd14732939be39129b76bd46838841a4" => :catalina
    sha256 "ef16e1f657e99451344fe207c322cd30f767de1403652dc2d32aea8637c44f1d" => :mojave
    sha256 "bd54790c65a26c3fd798a8574cf29ecd60305183b31b52a7cc4b8624489054c0" => :high_sierra
>>>>>>> upstream/master
  end

  depends_on "go" => :build

  conflicts_with "midnight-commander", because: "both install an `mc` binary"

  def install
    if build.head?
      system "go", "build", "-trimpath", "-o", bin/"mc"
    else
      minio_release = `git tag --points-at HEAD`.chomp
      minio_version = minio_release.gsub(/RELEASE\./, "").chomp.gsub(/T(\d+)-(\d+)-(\d+)Z/, 'T\1:\2:\3Z')
      minio_commit = `git rev-parse HEAD`.chomp
      proj = "github.com/minio/mc"

      system "go", "build", "-trimpath", "-o", bin/"mc", "-ldflags", <<~EOS
        -X #{proj}/cmd.Version=#{minio_version}
        -X #{proj}/cmd.ReleaseTag=#{minio_release}
        -X #{proj}/cmd.CommitID=#{minio_commit}
      EOS
    end
  end

  test do
    system bin/"mc", "mb", testpath/"test"
    assert_predicate testpath/"test", :exist?
  end
end
