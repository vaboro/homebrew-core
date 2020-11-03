class Deno < Formula
  desc "Secure runtime for JavaScript and TypeScript"
  homepage "https://deno.land/"
<<<<<<< HEAD
  url "https://github.com/denoland/deno.git",
<<<<<<< HEAD
<<<<<<< HEAD
    :tag      => "v0.14.0",
    :revision => "83d5362f1d7d8589b862de57912135067a8278c7"

  bottle do
    cellar :any_skip_relocation
    sha256 "8e2e967422d2c8b24ac4d4d4742d80e99355cd019954b57d3ff3f5fffa085765" => :mojave
    sha256 "ffb56f0d5b484fe0efdb2d837e18adfd12d38f23c35322c3ab0dac2c2b7fa7f9" => :high_sierra
    sha256 "dc19254bace232ee1d6986d9f8c052f90849d146cdcc704b8562670357566dcf" => :sierra
=======
    :tag      => "v0.17.0",
    :revision => "82588ec09c199683cff88097e1b90649497239c7"

  bottle do
    cellar :any_skip_relocation
    sha256 "40cf36716f92b92f76266e848ea0eab0cc2eb650f4d3c5b9ee6f67d534f7397b" => :mojave
    sha256 "96e525af076b48951a045969c0a010edc59d9a07914b5bd6167cafabc0265d1c" => :high_sierra
    sha256 "53c554f9e6296ead230ad0277634f036a6bfea70071c98478f8d254332fb3a22" => :sierra
>>>>>>> upstream/master
=======
    :tag      => "v0.19.0",
    :revision => "3892cf59018acd71dd4bc1099d747bd683cd4118"

  bottle do
    cellar :any_skip_relocation
    sha256 "1c083c25b408820e9487f87d97a228ee285c891e9169bddcb4e6e40fe66854a7" => :catalina
    sha256 "91292b33e48cc6f9450db8957b77ae4829751bad09fe0da675ccaef90a1c7bde" => :mojave
    sha256 "88e034a6a92a220a044a52d96119a38bb7903fce908577d1d1b9be2ed95a1c22" => :high_sierra
>>>>>>> upstream/master
=======
  url "https://github.com/denoland/deno/releases/download/v1.3.3/deno_src.tar.gz"
  sha256 "f378d81b193db153dba3f8ee142ca5407a3cf444a08cebff67773a336efc8b84"
  license "MIT"

  bottle do
    cellar :any_skip_relocation
    sha256 "528e3075635976785eb449baf85364b0498fd412670997456c155d971b63f9c6" => :catalina
    sha256 "bae7502363e89dafd0fdefa4de800093a597236b39ea01caf97a4dfb9ec79b97" => :mojave
    sha256 "78555b4595c443327ab3a2c0f75106e622839b10a73716409623b3c5c9aaccac" => :high_sierra
>>>>>>> upstream/master
  end

  depends_on "llvm" => :build
  depends_on "ninja" => :build
  depends_on "rust" => :build
  depends_on xcode: ["10.0", :build] # required by v8 7.9+
  depends_on :macos # Due to Python 2 (see https://github.com/denoland/deno/issues/2893)

  uses_from_macos "xz"

  resource "gn" do
    url "https://gn.googlesource.com/gn.git",
      revision: "5ed3c9cc67b090d5e311e4bd2aba072173e82db9"
  end

  def install
    # Build gn from source (used as a build tool here)
    (buildpath/"gn").install resource("gn")
    cd "gn" do
      system "python", "build/gen.py"
      system "ninja", "-C", "out/", "gn"
    end

    # env args for building a release build with our clang, ninja and gn
    ENV["GN"] = buildpath/"gn/out/gn"
    # build rusty_v8 from source
    ENV["V8_FROM_SOURCE"] = "1"
    # overwrite Chromium minimum sdk version of 10.15
    ENV["FORCE_MAC_SDK_MIN"] = "10.13"
    # build with llvm and link against system libc++ (no runtime dep)
    ENV["CLANG_BASE_PATH"] = Formula["llvm"].prefix
    ENV.remove "HOMEBREW_LIBRARY_PATHS", Formula["llvm"].opt_lib

    cd "cli" do
      system "cargo", "install", "-vv", *std_cargo_args
    end

    # Install bash and zsh completion
    output = Utils.safe_popen_read("#{bin}/deno", "completions", "bash")
    (bash_completion/"deno").write output
    output = Utils.safe_popen_read("#{bin}/deno", "completions", "zsh")
    (zsh_completion/"_deno").write output
  end

  test do
    (testpath/"hello.ts").write <<~EOS
      console.log("hello", "deno");
    EOS
    assert_match "hello deno", shell_output("#{bin}/deno run hello.ts")
    assert_match "console.log",
      shell_output("#{bin}/deno run --allow-read=#{testpath} https://deno.land/std@0.50.0/examples/cat.ts " \
                   "#{testpath}/hello.ts")
  end
end
