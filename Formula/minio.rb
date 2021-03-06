class Minio < Formula
  desc "High Performance, Kubernetes Native Object Storage"
  homepage "https://min.io"
  url "https://github.com/minio/minio.git",
<<<<<<< HEAD
<<<<<<< HEAD
<<<<<<< HEAD
      :tag      => "RELEASE.2019-08-07T01-59-21Z",
      :revision => "930943f058f01f37cfbc2265d5f80ea7026ec55d"
  version "20190807015921"

  bottle do
    cellar :any_skip_relocation
    sha256 "78d447010bc2a90c9449ae8dff314fc62d31d10e3175e6e9dc086fc598d14749" => :mojave
    sha256 "c5943139f722c1d8f5a6a1747cb74707e962d2f03b0893875c1646e259902537" => :high_sierra
    sha256 "9458a6de00ffc1332c743a60c056589c3cd97a46f9aa342a86671e1e5f3083e0" => :sierra
=======
      :tag      => "RELEASE.2019-08-29T00-25-01Z",
      :revision => "eb18c82976251d9a0c0730df27e10204c89beae2"
  version "20190829002501"

  bottle do
    cellar :any_skip_relocation
    sha256 "fff2da8cec5959ecd7c3a5e3c8b796f1c60539f7ad0ac0dd87b7e631fa9ca604" => :mojave
    sha256 "4087e5bd650645204c8f303f2e5845079436ad2f4fe2eff135198c144f21c9cb" => :high_sierra
    sha256 "18ca5c1f8c4705ab82c3c57f08ebf1aa17b6c5eea7b8cf91acae7e611221b3b6" => :sierra
>>>>>>> upstream/master
=======
      :tag      => "RELEASE.2019-10-02T21-19-38Z",
      :revision => "90bfa6260a8ac83199d522ed4c8fe1097dbd5153"
  version "20191002211938"

  bottle do
    cellar :any_skip_relocation
    sha256 "a3c06aa40a0338f8313294e99738201a7eb3ba35ea0c7e256a7fff5a62802a9e" => :catalina
    sha256 "5ac5fff839ad066e7957f519b4a016f288cb382dc9890a24d58aabf428c0cf78" => :mojave
    sha256 "3a2b1d0f5aa0e937bdf025d3941366acf0182ba14b3f18a438061478bdd1e0b3" => :high_sierra
>>>>>>> upstream/master
=======
      tag:      "RELEASE.2020-09-08T23-05-18Z",
      revision: "0987069e373f6ae4f7391c3d2a00f76e416f2000"
  version "20200908230518"
  license "Apache-2.0"
  head "https://github.com/minio/minio.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "1f3af5d2256645b9b9111c6fa3be79e73b38b87d6c67bd9905eda2d1e2ab2b0a" => :catalina
    sha256 "b5f088476c2820dfbc87464b479a6120a3b5dcfae53ae44d2a469b1f1587ebbc" => :mojave
    sha256 "17bacabe2a633de1fabb61f6cb723a991627b3117ee9abae1723e10df80ad000" => :high_sierra
>>>>>>> upstream/master
  end

  depends_on "go" => :build

  def install
    if build.head?
      system "go", "build", *std_go_args
    else
      release = `git tag --points-at HEAD`.chomp
      version = release.gsub(/RELEASE\./, "").chomp.gsub(/T(\d+)-(\d+)-(\d+)Z/, 'T\1:\2:\3Z')
      commit = `git rev-parse HEAD`.chomp
      proj = "github.com/minio/minio"

      system "go", "build", *std_go_args, "-ldflags", <<~EOS
        -X #{proj}/cmd.Version=#{version}
        -X #{proj}/cmd.ReleaseTag=#{release}
        -X #{proj}/cmd.CommitID=#{commit}
      EOS
    end
  end

  def post_install
    (var/"minio").mkpath
    (etc/"minio").mkpath
  end

  plist_options manual: "minio server"

  def plist
    <<~EOS
      <?xml version="1.0" encoding="UTF-8"?>
      <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
      <plist version="1.0">
        <dict>
          <key>KeepAlive</key>
          <true/>
          <key>Label</key>
          <string>#{plist_name}</string>
          <key>ProgramArguments</key>
          <array>
            <string>#{opt_bin}/minio</string>
            <string>server</string>
            <string>--config-dir=#{etc}/minio</string>
            <string>--address=:9000</string>
            <string>#{var}/minio</string>
          </array>
          <key>RunAtLoad</key>
          <true/>
          <key>KeepAlive</key>
          <true/>
          <key>WorkingDirectory</key>
          <string>#{HOMEBREW_PREFIX}</string>
          <key>StandardErrorPath</key>
          <string>#{var}/log/minio.log</string>
          <key>StandardOutPath</key>
          <string>#{var}/log/minio.log</string>
          <key>RunAtLoad</key>
          <true/>
        </dict>
      </plist>
    EOS
  end

  test do
    assert_match "minio server - start object storage server",
      shell_output("#{bin}/minio server --help 2>&1")

    assert_match "minio gateway - start object storage gateway",
      shell_output("#{bin}/minio gateway 2>&1")
    assert_match "ERROR Unable to validate credentials",
      shell_output("#{bin}/minio gateway s3 2>&1", 1)
  end
end
