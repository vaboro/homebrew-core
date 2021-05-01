class Mksh < Formula
  desc "MirBSD Korn Shell"
  homepage "https://www.mirbsd.org/mksh.htm"
  url "https://www.mirbsd.org/MirOS/dist/mir/mksh/mksh-R59b.tgz"
  mirror "https://pub.allbsd.org/MirOS/dist/mir/mksh/mksh-R59b.tgz"
  version "59b"
  sha256 "907ed1a9586e7f18bdefdd4a763aaa8397b755e15034aa54f4d753bfb272e0e6"

  livecheck do
    url "https://www.mirbsd.org/MirOS/dist/mir/mksh/"
    regex(/href=.*?mksh-R?(\d+[a-z]?)\.t/i)
  end

  bottle do
    sha256 cellar: :any_skip_relocation, catalina:    "e6b59cb6a1bb326e97bbbad191d735e85e39f899726a68225c01e137ea88066f"
    sha256 cellar: :any_skip_relocation, mojave:      "1360021d58dfbb2b4baedc74ad72890ee1aa4178865c4aa61e6142da58ba8c06"
    sha256 cellar: :any_skip_relocation, high_sierra: "249f6b7a2ea7d278fd5b21ec947d9f88eeb8d803f28c286e140aa293beaf301d"
  end

  def install
    system "sh", "./Build.sh", "-r"
    bin.install "mksh"
    man1.install "mksh.1"
  end

  test do
    assert_equal "honk",
      shell_output("#{bin}/mksh -c 'echo honk'").chomp
  end
end
