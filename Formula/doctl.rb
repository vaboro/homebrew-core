class Doctl < Formula
  desc "Command-line tool for DigitalOcean"
  homepage "https://github.com/digitalocean/doctl"
<<<<<<< HEAD
<<<<<<< HEAD
<<<<<<< HEAD
  url "https://github.com/digitalocean/doctl/archive/v1.27.0.tar.gz"
  sha256 "a91e7d78da62bc965a9440cb087e5583d945ce10a3e59211992a304a16f26cad"
=======
  url "https://github.com/digitalocean/doctl/archive/v1.30.0.tar.gz"
  sha256 "a7174919e0571a590076faa494b6dd7b251f4b27450c89a4bb285a3f2db2a125"
>>>>>>> upstream/master
=======
  url "https://github.com/digitalocean/doctl/archive/v1.32.3.tar.gz"
  sha256 "e6e60c3bd6c3638a71e7be610c662344bca240194cc3de826e78a51739ca546d"
>>>>>>> upstream/master
=======
  url "https://github.com/digitalocean/doctl/archive/v1.46.0.tar.gz"
  sha256 "f283df1860afa47551da24c9c0d0ebb1ae4535c7a69e62507e4f787ff47cda60"
  license "Apache-2.0"
>>>>>>> upstream/master
  head "https://github.com/digitalocean/doctl.git"

  bottle do
    cellar :any_skip_relocation
<<<<<<< HEAD
<<<<<<< HEAD
<<<<<<< HEAD
    sha256 "dc51495bdf2fccbc3a612bb786b650cf6678ea7a2ef7238fd8a99f0e2b07a814" => :mojave
    sha256 "8f4557ba7e80e279077cde38a9d507f70a3a2713b645880f5f06aa5c0dc46c61" => :high_sierra
    sha256 "a23c2a755e42e5c155dac4e6b4844095e550a694537dd64748023eefd7b2bbcd" => :sierra
=======
    sha256 "de8b6e782729f6dacaecc97f78791278546a35657e2e9d4fce13a445c857e3c0" => :mojave
    sha256 "35c6d57eb1344f9a8caa127323844a0977d7b3de84f573017a420e79da3aaffa" => :high_sierra
    sha256 "a51f712f1778fcf7f273702556bbb7bc406494b7044048db8029f06ada14ed94" => :sierra
>>>>>>> upstream/master
=======
    sha256 "5466cd64e1e8927630df08c55385f227b823c7633e6b95ac140e746f4ada0552" => :catalina
    sha256 "81d5c7d6d1b7adf883f3e027116320a09066419a0ff768c91c68c0ee8909c314" => :mojave
    sha256 "aaf6b30417bc1a6c2351d26ab8ff603c780bfd846f648d6ac2963ef154dda3df" => :high_sierra
>>>>>>> upstream/master
=======
    sha256 "7ee6001d0ee0c2325d6047be50c8a27c347c25dffbd099c4fd00bd8462583c01" => :catalina
    sha256 "2e59a7611adcb85c8052825c8920b06d6b942e30872dd0dd2670ec99e3cdf8ad" => :mojave
    sha256 "452c701712149cba126413d035aba3fbe293c210c731c10667a7a258c22ce995" => :high_sierra
>>>>>>> upstream/master
  end

  depends_on "go" => :build

  def install
    base_flag = "-X github.com/digitalocean/doctl"
    ldflags = %W[
      #{base_flag}.Major=#{version.major}
      #{base_flag}.Minor=#{version.minor}
      #{base_flag}.Patch=#{version.patch}
      #{base_flag}.Label=release
    ].join(" ")

    system "go", "build", "-ldflags", ldflags, *std_go_args, "github.com/digitalocean/doctl/cmd/doctl"

    (bash_completion/"doctl").write `#{bin}/doctl completion bash`
    (zsh_completion/"_doctl").write `#{bin}/doctl completion zsh`
    (fish_completion/"doctl.fish").write `#{bin}/doctl completion fish`
  end

  test do
    assert_match "doctl version #{version}-release", shell_output("#{bin}/doctl version")
  end
end
