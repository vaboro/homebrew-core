class Deno < Formula
  desc "Command-line JavaScript / TypeScript engine"
  homepage "https://deno.land/"
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
  end

  depends_on "llvm" => :build if DevelopmentTools.clang_build_version < 1100
  depends_on "ninja" => :build
  depends_on "rust" => :build

  depends_on :xcode => ["10.0", :build] # required by v8 7.9+

  resource "gn" do
    url "https://gn.googlesource.com/gn.git",
      :revision => "972ed755f8e6d31cae9ba15fcd08136ae1a7886f"
  end

  def install
    # Build gn from source (used as a build tool here)
    (buildpath/"gn").install resource("gn")
    cd "gn" do
      system "python", "build/gen.py"
      system "ninja", "-C", "out/", "gn"
    end

    # workaround for xcode-select --print-path pointing to CLT
    inreplace "core/libdeno/build/config/mac/mac_sdk.gni",
              "\"--print_bin_path\",",
              "\"--print_bin_path\", \"--developer_dir\", \"#{MacOS::Xcode.bundle_path}\""

    # env args for building a release build with our clang, ninja and gn
    ENV["DENO_NO_BINARY_DOWNLOAD"] = "1"
    ENV["DENO_GN_PATH"] = buildpath/"gn/out/gn"
    args = %W[
      clang_use_chrome_plugins=false
      mac_deployment_target="#{MacOS.version}"
      treat_warnings_as_errors=false
    ]
    if DevelopmentTools.clang_build_version < 1100
      # build with llvm and link against system libc++ (no runtime dep)
      args << "clang_base_path=\"#{Formula["llvm"].prefix}\""
      ENV.remove "HOMEBREW_LIBRARY_PATHS", Formula["llvm"].opt_lib
    else # build with system clang
      args << "clang_base_path=\"/usr/\""
    end
    ENV["DENO_BUILD_ARGS"] = args.join(" ")

    cd "cli" do
      system "cargo", "install", "-vv", "--root", prefix, "--path", "."
    end

    # Install bash and zsh completion
    output = Utils.popen_read("#{bin}/deno completions bash")
    (bash_completion/"deno").write output
    output = Utils.popen_read("#{bin}/deno completions zsh")
    (zsh_completion/"_deno").write output
  end

  test do
    (testpath/"hello.ts").write <<~EOS
      console.log("hello", "deno");
    EOS
    hello = shell_output("#{bin}/deno run hello.ts")
    assert_includes hello, "hello deno"
  end
end
