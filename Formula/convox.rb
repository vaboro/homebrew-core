class Convox < Formula
  desc "Command-line interface for the Convox PaaS"
  homepage "https://convox.com/"
<<<<<<< HEAD
<<<<<<< HEAD
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
=======
  url "https://github.com/convox/rack/archive/20191001204055.tar.gz"
  sha256 "05d33857621a209aed742d625789ca42f6a4b3e9508c6c0186bd6f3f07486288"

  bottle do
    cellar :any_skip_relocation
    sha256 "a1a1c50b2b290b3ada7871ab8b18af2f02f55b5f169cdb7c07efcb1e068a5696" => :catalina
    sha256 "215d38747544079f064c4d32757dc2e1248f580680811c67d58682d958822ffe" => :mojave
    sha256 "087470ac0f18cb77a538ddb313fa96ce96b4d0b00be2d193244d42d988c83e18" => :high_sierra
>>>>>>> upstream/master
=======
  url "https://github.com/convox/convox/archive/3.0.39.tar.gz"
  sha256 "d0463a18136a444b205637a2e469fd8c7ad651e11d2f3a17f3002616e960f52a"
  license "Apache-2.0"
  version_scheme 1

  bottle do
    cellar :any_skip_relocation
    sha256 "b62171ef51c1017aa870388dc232f43b6f9f84657e83d8128710f470ffbc6a73" => :catalina
    sha256 "c31194017443911acb240f42dc823f1cf0c79d856fb4499d475cd7f65a27e63b" => :mojave
    sha256 "f3d44595da202f318d089724cf8f187425cf2439055478b30c5aec2ea5f5b10c" => :high_sierra
>>>>>>> upstream/master
  end

  depends_on "go" => :build

  def install
    ldflags = %W[
      -X main.version=#{version}
    ].join(" ")

    system "go", "build", *std_go_args, "-mod=vendor", "-ldflags", ldflags, "./cmd/convox"
  end

  test do
    assert_equal "Authenticating with localhost... ERROR: invalid login\n",
      shell_output("#{bin}/convox login -t invalid localhost 2>&1", 1)
  end
end
