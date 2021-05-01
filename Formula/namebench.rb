class Namebench < Formula
  desc "DNS benchmark utility"
  homepage "https://code.google.com/archive/p/namebench/"
  url "https://storage.googleapis.com/google-code-archive-downloads/v2/code.google.com/namebench/namebench-1.3.1-source.tgz"
  sha256 "30ccf9e870c1174c6bf02fca488f62bba280203a0b1e8e4d26f3756e1a5b9425"
  license "Apache-2.0"

  bottle do
    sha256 cellar: :any_skip_relocation, catalina:    "c958cb3841f9462efd7e2199cad803262dcb3b0b6ab766af53681910090e95e2"
    sha256 cellar: :any_skip_relocation, mojave:      "35225323dc77dc1954cd19b1aa0476e4ebab47e91dbabbfc7e169b5b500b0eba"
    sha256 cellar: :any_skip_relocation, high_sierra: "4c2312daef0aae052b7e65bdb4b20cdcf1bfa601e5f8a484a7f846be1096bcb1"
    sha256 cellar: :any_skip_relocation, sierra:      "ae766151284842185ceecf1622a82cf55c949994729536015a42eea38f62309c"
    sha256 cellar: :any_skip_relocation, el_capitan:  "3333ef2615f6fbf294cede389d8545487474779a52c18108feb83a4697530cdc"
    sha256 cellar: :any_skip_relocation, yosemite:    "8d400aed171038f248e9d91718fb42625fc1f278df538b34259f26918b245f66"
    sha256 cellar: :any_skip_relocation, mavericks:   "ac3d993b71305c18b47fa671ecb4c5875b80fd7ea87a6fff0f123c3c2cfdcb43"
  end

  def install
    ENV.prepend_create_path "PYTHONPATH", libexec/"lib/python2.7/site-packages"

    system "python", "setup.py", "install", "--prefix=#{libexec}",
                     "--install-data=#{libexec}/lib/python2.7/site-packages"

    bin.install "namebench.py" => "namebench"
    bin.env_script_all_files(libexec/"bin", PYTHONPATH: ENV["PYTHONPATH"])
  end

  test do
    system bin/"namebench", "--query_count", "1", "--only", "8.8.8.8"
  end
end
