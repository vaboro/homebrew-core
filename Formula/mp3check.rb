class Mp3check < Formula
  desc "Tool to check mp3 files for consistency"
  homepage "https://code.google.com/archive/p/mp3check/"
  url "https://storage.googleapis.com/google-code-archive-downloads/v2/code.google.com/mp3check/mp3check-0.8.7.tgz"
  sha256 "27d976ad8495671e9b9ce3c02e70cb834d962b6fdf1a7d437bb0e85454acdd0e"
  license "GPL-2.0"

  bottle do
    sha256 cellar: :any_skip_relocation, catalina:    "a98298c030d1ee1a28e2227ed41970fcad21d2af6486c471d045b07010ac232b"
    sha256 cellar: :any_skip_relocation, mojave:      "e19a17b2360f7a7974fe798cc68a12735155b14c68bb8c0d7a13439dd3fa5a29"
    sha256 cellar: :any_skip_relocation, high_sierra: "99c5e5b8458a0cda5f50d92d858ccbd968f059a3b639130a3378c499331e427e"
    sha256 cellar: :any_skip_relocation, sierra:      "2846b7bd6201b58c40ce9b6193a929c5404fcbe77e97854876e53bba5c9d0d82"
    sha256 cellar: :any_skip_relocation, el_capitan:  "d63ba27cfd87cf1f8b1871fe8b0531882c037f116933cbc59caf429dfeaab735"
    sha256 cellar: :any_skip_relocation, yosemite:    "5fd629e626c6227789c894f1fcf32e076118fd4fe9136e974610ef42135a4ddf"
    sha256 cellar: :any_skip_relocation, mavericks:   "ef678ca85ee3272b05e442ae13f319a1ab2868bc6ff9aa3cc84ae3bca0f98ad5"
  end

  def install
    ENV.deparallelize
    # The makefile's install target is kinda iffy, but there's
    # only one file to install so it's easier to do it ourselves
    system "make"
    bin.install "mp3check"
  end

  test do
    assert version.to_s, shell_output("#{bin}/mp3check --version")
  end
end
