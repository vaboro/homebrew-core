class Okteto < Formula
  desc "Build better apps by developing and testing code directly in Kubernetes"
  homepage "https://okteto.com"
  url "https://github.com/okteto/okteto/archive/1.8.22.tar.gz"
  sha256 "e74b989eafd0b8c8cc6f11d30b6bc2424e5fef4137806765d8a6c8e301bba188"
  license "Apache-2.0"

  bottle do
    cellar :any_skip_relocation
    sha256 "505c1a79da06eb50f76cd67ee58721ca095f0418008bdc910b809ca7edca981a" => :catalina
    sha256 "7bf004a9622ec82e7d073fddea7b2fb661c4bf35935f52f6d047c5ee06e20e25" => :mojave
    sha256 "810219a2736be9d0b090d917c8d255b44dfcf6042d71fa97acf740282fd3962d" => :high_sierra
  end

  depends_on "go" => :build

  def install
    ldflags = "-s -w -X github.com/okteto/okteto/pkg/config.VersionString=#{version}"
    tags = "osusergo netgo static_build"
    system "go", "build", "-o", "#{bin}/#{name}", "-trimpath", "-ldflags", ldflags, "-tags", tags
  end

  test do
    touch "test.rb"
    system "echo | okteto init --overwrite --file test.yml"
    expected = <<~EOS
      name: #{Pathname.getwd.basename}
      image: okteto/ruby:2
      command:
      - bash
      workdir: /okteto
      sync:
      - .:/okteto
      forward:
      - 1234:1234
      - 8080:8080
      persistentVolume: {}
    EOS
    got = File.read("test.yml")
    assert_equal expected, got
  end
end
