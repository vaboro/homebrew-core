class Convox < Formula
  desc "Command-line interface for the Rack PaaS on AWS"
  homepage "https://convox.com/"
<<<<<<< HEAD
<<<<<<< HEAD
  url "https://github.com/convox/rack/archive/20190808190811.tar.gz"
  sha256 "f2c6f4dadea44dd79714e4e8d34993a7010607c4cd3284f5ae23d10014ffaead"

  bottle do
    cellar :any_skip_relocation
    sha256 "e6f8e907a3bf74d07a1cc5c0763a7d91e8c1db8e75ca0b5fb963b1c1eb9a5ca9" => :mojave
    sha256 "3198731aba7624070995b9992e7518f5ea995461c285302fde87d8d609a4a4b1" => :high_sierra
    sha256 "7c0b74a22dc21ee190a0e321a2f30b9bb2da97042852ea8ddb4c8eb2ab3566ce" => :sierra
=======
  url "https://github.com/convox/rack/archive/20190822194002.tar.gz"
  sha256 "83c95dab0727442ea19b6fc728308dd277cd0959cea0a73a676feebec3872827"

  bottle do
    cellar :any_skip_relocation
    sha256 "e31a089d3f3bedc0e29f390f951f691058857c2258840d76cb1a1b25e59c62f0" => :mojave
    sha256 "57c39d488c2835599c39f93e4b45c83147031ba47370db22ee3172eeace060d2" => :high_sierra
    sha256 "b5ee911a364ff3bc2068bb14ae901dd7f44c8cc85b4933f130ced74f7611b998" => :sierra
>>>>>>> upstream/master
=======
  url "https://github.com/convox/rack/archive/20190905141723.tar.gz"
  sha256 "2a308b69fcd2e0a7daf35b99b838b987432f73de63be2d5d5cb40bd1e4c5e87e"

  bottle do
    cellar :any_skip_relocation
    sha256 "e9b0d97a54e2d619a879426cdb4811ecd14da62608765edec9468d3cbcb3068e" => :mojave
    sha256 "4dfacf3fc7ba14bb7d196f0422acb723b6b0f441240a376c7fc8456ed7415b00" => :high_sierra
    sha256 "e9fecd043541f924bb4ef659b447af1799e157447cabbc0c27c4f155a9bcdb8b" => :sierra
>>>>>>> upstream/master
  end

  depends_on "go" => :build

  resource "packr" do
    url "https://github.com/gobuffalo/packr/archive/v2.0.1.tar.gz"
    sha256 "cc0488e99faeda4cf56631666175335e1cce021746972ce84b8a3083aa88622f"
  end

  def install
    ENV["GOPATH"] = buildpath

    (buildpath/"src/github.com/convox/rack").install Dir["*"]

    resource("packr").stage { system "go", "install", "./packr" }
    cd buildpath/"src/github.com/convox/rack" do
      system buildpath/"bin/packr"
    end

    system "go", "build", "-ldflags=-X main.version=#{version}",
           "-o", bin/"convox", "-v", "github.com/convox/rack/cmd/convox"
    prefix.install_metafiles
  end

  test do
    system bin/"convox"
  end
end
