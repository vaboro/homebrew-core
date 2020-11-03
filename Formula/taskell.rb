class Taskell < Formula
  desc "Command-line Kanban board/task manager with support for Trello"
  homepage "https://taskell.app"
<<<<<<< HEAD
<<<<<<< HEAD
  url "https://github.com/smallhadroncollider/taskell/archive/1.5.1.tar.gz"
  sha256 "24f0cafa515a0551e03b1596ef65d93c82e743ec8a690b91b482691f14f6b4c4"

  bottle do
    cellar :any_skip_relocation
    sha256 "fa9e5e45f4a80ab1b9c1ac8b483a9416aa295da5c20e127a99e2245dd37cd7dc" => :mojave
    sha256 "c259424717e16109518f3a1a13695892b1f221fba2dbd9985a0d96ce26eb2184" => :high_sierra
    sha256 "4128b2dba1114854573304a44312297ad5efbf4603ff531c9489c29582650772" => :sierra
=======
  url "https://github.com/smallhadroncollider/taskell/archive/1.6.1.tar.gz"
  sha256 "66f4b80c5f5a79f7f796bac7f24834879f30492dcf420041ea4f005bedf656d3"

  bottle do
    cellar :any_skip_relocation
    sha256 "baa3bdfa34942bc24d117265911acf485b2653d30419fd7b92e86eecf72e5d3d" => :mojave
    sha256 "5cefc442114d0e3f7bd06eb84285c6f61c5c6730b346eb80c02d72d21e552e5a" => :high_sierra
    sha256 "94210ead7c255058a381a46fee0bd06166737173e208b0ced933849950d4589e" => :sierra
>>>>>>> upstream/master
=======
  url "https://github.com/smallhadroncollider/taskell/archive/1.10.1.tar.gz"
  sha256 "5056fad8983253a8c67d28f525b2cdf1dc7a182e0e1885a6f060189832aaae54"
  license "BSD-3-Clause"

  bottle do
    cellar :any_skip_relocation
    sha256 "d224f2ea895ced6b1a8cc761e3d3c79478a9e210df68f3cbcdb65debacd8a246" => :catalina
    sha256 "6733a5756ba481343d132064e22a6a6447eef1e374ad4a9d4915d8951fe5ccb0" => :mojave
    sha256 "d7fbd709e7713e2f08a1d75a64c2527dfa87f8d935a872054119bedc4338d652" => :high_sierra
>>>>>>> upstream/master
  end

  depends_on "cabal-install" => :build
  depends_on "ghc@8.8" => :build
  depends_on "hpack" => :build

  uses_from_macos "ncurses"
  uses_from_macos "zlib"

  def install
    system "hpack"
    system "cabal", "v2-update"
    system "cabal", "v2-install", *std_cabal_v2_args
  end

  test do
    (testpath/"test.md").write <<~EOS
      ## To Do

      - A thing
      - Another thing
    EOS

    expected = <<~EOS
      test.md
      Lists: 1
      Tasks: 2
    EOS

    assert_match expected, shell_output("#{bin}/taskell -i test.md")
  end
end
