class Tasksh < Formula
  desc "Shell wrapper for Taskwarrior commands"
  homepage "https://tasktools.org/projects/tasksh.html"
  url "https://taskwarrior.org/download/tasksh-1.2.0.tar.gz"
  sha256 "6e42f949bfd7fbdde4870af0e7b923114cc96c4344f82d9d924e984629e21ffd"
  license "MIT"
  head "https://github.com/GothenburgBitFactory/taskshell.git", branch: "1.3.0"

  bottle do
    sha256 cellar: :any_skip_relocation, catalina:    "db065e61ef2e605a1987012eaf4c0f10b648a98da3d143b9a02e1c22d51216f7"
    sha256 cellar: :any_skip_relocation, mojave:      "c766ebd317962a04a3d78a4fbcc202085a27e0d15f63debf095f84a9a97d6306"
    sha256 cellar: :any_skip_relocation, high_sierra: "17f99be8d0aea4c43877fbfb121b7989047f04650ccffa85e948859e8ee51e0b"
    sha256 cellar: :any_skip_relocation, sierra:      "fd1b333c777401c53d5ddc8aaf52150a2a15fea4230a91d457d9d99ce2819ee7"
    sha256 cellar: :any_skip_relocation, el_capitan:  "d695adcf10582123053612d98ed4bf988b22c50919598bf167bc2e62db142352"
  end

  depends_on "cmake" => :build
  depends_on "task"

  on_linux do
    depends_on "readline"
  end

  def install
    system "cmake", ".", *std_cmake_args
    system "make", "install"
  end

  test do
    system "#{bin}/tasksh", "--version"
    (testpath/".taskrc").write "data.location=#{testpath}/.task\n"
    assert_match "Created task 1.", pipe_output("#{bin}/tasksh", "add Test Task", 0)
  end
end
