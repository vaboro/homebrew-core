class PassGitHelper < Formula
  include Language::Python::Virtualenv

  desc "Git credential helper interfacing with pass"
  homepage "https://github.com/languitar/pass-git-helper"
  url "https://github.com/languitar/pass-git-helper/archive/v1.1.0.tar.gz"
  sha256 "85c9e2f1f544227da9129503d91ce5d502be127c83ad24cbc6dc8ba3ab746b8e"
  license "LGPL-3.0"

  bottle do
    cellar :any_skip_relocation
    sha256 "1f3954dd243690c880e3feb3a919e6c2778646ec90e56f0b1e285837c8441c20" => :catalina
    sha256 "e08a67118a8d49dc0d3088dfd239b7f8869eebd1fcfd833aaa26bf799eb12fde" => :mojave
    sha256 "1e05bbb2761624c80e9eb1c952f70a97ae6d214bc2e9cee9c17949e3eb099933" => :high_sierra
  end

  depends_on "gnupg" => :test
  depends_on "pass"
  depends_on "python@3.8"

  resource "pyxdg" do
    url "https://files.pythonhosted.org/packages/47/6e/311d5f22e2b76381719b5d0c6e9dc39cd33999adae67db71d7279a6d70f4/pyxdg-0.26.tar.gz"
    sha256 "fe2928d3f532ed32b39c32a482b54136fe766d19936afc96c8f00645f9da1a06"
  end

  def install
    virtualenv_install_with_resources
  end

  test do
    # Generate temporary GPG key for use with pass
    pipe_output("#{Formula["gnupg"].opt_bin}/gpg --generate-key --batch", <<~EOS, 0)
      %no-protection
      %transient-key
      Key-Type: RSA
      Name-Real: Homebrew Test
    EOS

    system "pass", "init", "Homebrew Test"

    pipe_output("pass insert -m -f homebrew/pass-git-helper-test", <<~EOS, 0)
      test_password
      test_username
    EOS

    (testpath/"config.ini").write <<~EOS
      [github.com*]
      target=homebrew/pass-git-helper-test
    EOS

    result = pipe_output("#{bin}/pass-git-helper -m #{testpath}/config.ini get", <<~EOS, 0)
      protocol=https
      host=github.com
      path=homebrew/homebrew-core
    EOS

    assert_match "password=test_password\nusername=test_username", result
  end
end
