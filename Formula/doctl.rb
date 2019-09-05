class Doctl < Formula
  desc "Command-line tool for DigitalOcean"
  homepage "https://github.com/digitalocean/doctl"
<<<<<<< HEAD
  url "https://github.com/digitalocean/doctl/archive/v1.27.0.tar.gz"
  sha256 "a91e7d78da62bc965a9440cb087e5583d945ce10a3e59211992a304a16f26cad"
=======
  url "https://github.com/digitalocean/doctl/archive/v1.30.0.tar.gz"
  sha256 "a7174919e0571a590076faa494b6dd7b251f4b27450c89a4bb285a3f2db2a125"
>>>>>>> upstream/master
  head "https://github.com/digitalocean/doctl.git"

  bottle do
    cellar :any_skip_relocation
<<<<<<< HEAD
    sha256 "dc51495bdf2fccbc3a612bb786b650cf6678ea7a2ef7238fd8a99f0e2b07a814" => :mojave
    sha256 "8f4557ba7e80e279077cde38a9d507f70a3a2713b645880f5f06aa5c0dc46c61" => :high_sierra
    sha256 "a23c2a755e42e5c155dac4e6b4844095e550a694537dd64748023eefd7b2bbcd" => :sierra
=======
    sha256 "de8b6e782729f6dacaecc97f78791278546a35657e2e9d4fce13a445c857e3c0" => :mojave
    sha256 "35c6d57eb1344f9a8caa127323844a0977d7b3de84f573017a420e79da3aaffa" => :high_sierra
    sha256 "a51f712f1778fcf7f273702556bbb7bc406494b7044048db8029f06ada14ed94" => :sierra
>>>>>>> upstream/master
  end

  depends_on "go" => :build

  def install
    ENV["GO111MODULE"] = "on"
    ENV["GOPATH"] = buildpath

    doctl_version = version.to_s.split(/\./)

    src = buildpath/"src/github.com/digitalocean/doctl"
    src.install buildpath.children
    src.cd do
      base_flag = "-X github.com/digitalocean/doctl"
      ldflags = %W[
        #{base_flag}.Major=#{doctl_version[0]}
        #{base_flag}.Minor=#{doctl_version[1]}
        #{base_flag}.Patch=#{doctl_version[2]}
        #{base_flag}.Label=release
      ].join(" ")
      system "go", "build", "-ldflags", ldflags, "-o", bin/"doctl", "github.com/digitalocean/doctl/cmd/doctl"
    end

    (bash_completion/"doctl").write `#{bin}/doctl completion bash`
    (zsh_completion/"doctl").write `#{bin}/doctl completion zsh`
  end

  test do
    assert_match "doctl version #{version}-release", shell_output("#{bin}/doctl version")
  end
end
