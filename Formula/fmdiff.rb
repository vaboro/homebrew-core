class Fmdiff < Formula
  desc "Use FileMerge as a diff command for Subversion and Mercurial"
  homepage "https://github.com/brunodefraine/fmscripts"
  url "https://github.com/brunodefraine/fmscripts/archive/20150915.tar.gz"
  sha256 "45ead0c972aa8ff5b3f9cf1bcefbc069931fd8218b2e28ff76958437a3fabf96"
  license :public_domain
  head "https://github.com/brunodefraine/fmscripts.git"

  bottle do
    rebuild 2
    sha256 cellar: :any_skip_relocation, catalina:    "4dc5d4eed6916cab57ab1350c7623014c1f2136b69dcb5593c9e344b86328f6c"
    sha256 cellar: :any_skip_relocation, mojave:      "4c5fb2bb25510c7269a40ef77d55a3d7e52377db2a012d60c3003a9512616314"
    sha256 cellar: :any_skip_relocation, high_sierra: "03bf7b7acda053f3b96de99591fb97cef678297941eab37f52802a3c2734afdd"
    sha256 cellar: :any_skip_relocation, sierra:      "59d9c9d8a8759531a2f715619cfb2bce404fc7378235cf416ea5a426eb8d967f"
    sha256 cellar: :any_skip_relocation, el_capitan:  "59d9c9d8a8759531a2f715619cfb2bce404fc7378235cf416ea5a426eb8d967f"
    sha256 cellar: :any_skip_relocation, yosemite:    "59d9c9d8a8759531a2f715619cfb2bce404fc7378235cf416ea5a426eb8d967f"
  end

  # Needs FileMerge.app, which is part of Xcode.
  depends_on :xcode

  def install
    system "make"
    system "make", "DESTDIR=#{bin}", "install"
  end

  test do
    ENV.prepend_path "PATH", testpath

    # dummy filemerge script
    (testpath/"filemerge").write <<~EOS
      #!/bin/sh
      echo "it works"
    EOS

    chmod 0744, testpath/"filemerge"
    touch "test"

    assert_match(/it works/, shell_output("#{bin}/fmdiff test test"))
  end
end
