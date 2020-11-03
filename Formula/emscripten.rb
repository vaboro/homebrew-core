require "language/node"

class Emscripten < Formula
  desc "LLVM bytecode to JavaScript compiler"
  homepage "https://emscripten.org/"
  # Emscripten is available under 2 licenses, the MIT license and the
  # University of Illinois/NCSA Open Source License.
  license "MIT"

  stable do
<<<<<<< HEAD
<<<<<<< HEAD
<<<<<<< HEAD
<<<<<<< HEAD
    url "https://github.com/emscripten-core/emscripten/archive/1.38.41.tar.gz"
    sha256 "9e87e82799b7a26146333764c986b54274a2b75984bbb7112d9a08f0a1836a63"
=======
    url "https://github.com/emscripten-core/emscripten/archive/1.38.42.tar.gz"
    sha256 "a7547d6f36dc25f4bf431ad4d112a5604cc03e71ed05547acdf910c3cfcd8a8c"
>>>>>>> upstream/master
=======
    url "https://github.com/emscripten-core/emscripten/archive/1.38.43.tar.gz"
    sha256 "9f558fde1e8b06b36b562280d20ae135659493e54bc4f63ee75db0be6b715c43"
>>>>>>> upstream/master
=======
    url "https://github.com/emscripten-core/emscripten/archive/1.38.44.tar.gz"
    sha256 "e6bf63595ca28beb4c0385062cd686f1b442d7faa8b3c717fb4cb872478b4660"
>>>>>>> upstream/master
=======
    url "https://github.com/emscripten-core/emscripten/archive/1.40.1.tar.gz"
    sha256 "e15ad7ffa1cce35c25cac7c797d6daa0c5868905eaaf5ed1431a8228b8803dfc"
>>>>>>> upstream/master

    resource "fastcomp" do
      url "https://github.com/emscripten-core/emscripten-fastcomp/archive/1.40.1.tar.gz"
      sha256 "c34868ab566e9f073df319d9872608cef47ed1ea74852acacb12a22fd7c99a4c"
    end

    resource "fastcomp-clang" do
      url "https://github.com/emscripten-core/emscripten-fastcomp-clang/archive/1.40.1.tar.gz"
      sha256 "9ce4612df39684348d78acb711ec10bee98ad4ac136fb0dcb70d4c884b8bb6b3"
    end
  end

  livecheck do
    url :head
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  bottle do
    cellar :any
<<<<<<< HEAD
<<<<<<< HEAD
<<<<<<< HEAD
<<<<<<< HEAD
    sha256 "ee09e4fe76e73f15173595b699e47ad84f0bf64ec0e2e9828df530a3e120bf14" => :mojave
    sha256 "9a9a67b78002a571d37599ac549b6077624fce822389ead382c56398dd18eeed" => :high_sierra
    sha256 "65190c6fbab46020a8a73ed718815ef8647c0165a1158395a664075f29c1c152" => :sierra
=======
    sha256 "5656868253b6e951d14f867e4774dac829c3f77b0084dfc2da0fb8d1db55d633" => :mojave
    sha256 "28a7604f4172a745abcd45d74381be426daad67be58d8dea95105aeaf5206d82" => :high_sierra
    sha256 "e10fb143ed1d67ec0e6297d9df4afdfc4204bcf1a323429026e2b04235dd954c" => :sierra
>>>>>>> upstream/master
=======
    sha256 "5e505328f809b05324f19aaf431e2d4dcc7ba5e0117e533ec541824433e75c18" => :mojave
    sha256 "a0ace11df2d442d629cc9f06d9f97dc93b7f20e444351b632075acfdfab52e79" => :high_sierra
    sha256 "03dda9034b5a51462e3b46833666f2fc82e9811055fa4fde8f690134312aa508" => :sierra
>>>>>>> upstream/master
=======
    sha256 "4f8be86a67d0f1fc87c01c92dd0fe8112f1cd6c5b1ae210ac0528ce02ad36b8a" => :mojave
    sha256 "3abedeaff354db116142227d55d93232210b073549ab26c33b7f8c97fe8e897b" => :high_sierra
    sha256 "36d6ea5dd8eaff5b9f8adf9388bfc9bcab2d22b8b738a164378601e174cc9bca" => :sierra
>>>>>>> upstream/master
=======
    rebuild 1
    sha256 "8b21f38d1065a89301c3cce79c0bce448089d536280ae6d1cbe97ee3a98b183d" => :catalina
    sha256 "476a8b8a00f535d160cbb8a08f82c5256d46a434703ecd86d2ed10ec5cea36fe" => :mojave
    sha256 "09ad53bb82328357f106bbb01b06caa9a02c3daedc9d3ea4f7419badbaa66e17" => :high_sierra
>>>>>>> upstream/master
  end

  head do
    url "https://github.com/emscripten-core/emscripten.git"

    resource "fastcomp" do
      url "https://github.com/emscripten-core/emscripten-fastcomp.git"
    end

    resource "fastcomp-clang" do
      url "https://github.com/emscripten-core/emscripten-fastcomp-clang.git"
    end
  end

  depends_on "cmake" => :build
  depends_on "binaryen"
  depends_on "node"
  depends_on "python@3.8"
  depends_on "yuicompressor"

  def install
    ENV.cxx11

    # All files from the repository are required as emscripten is a collection
    # of scripts which need to be installed in the same layout as in the Git
    # repository.
    libexec.install Dir["*"]

    (buildpath/"fastcomp").install resource("fastcomp")
    (buildpath/"fastcomp/tools/clang").install resource("fastcomp-clang")

    cmake_args = std_cmake_args.reject { |s| s["CMAKE_INSTALL_PREFIX"] }
    cmake_args = [
      "-DCMAKE_BUILD_TYPE=Release",
      "-DCMAKE_INSTALL_PREFIX=#{libexec}/llvm",
      "-DLLVM_TARGETS_TO_BUILD='X86;JSBackend'",
      "-DLLVM_INCLUDE_EXAMPLES=OFF",
      "-DLLVM_INCLUDE_TESTS=OFF",
      "-DCLANG_INCLUDE_TESTS=OFF",
      "-DOCAMLFIND=/usr/bin/false",
      "-DGO_EXECUTABLE=/usr/bin/false",
    ]

    mkdir "fastcomp/build" do
      system "cmake", "..", *cmake_args
      system "make"
      system "make", "install"
    end

    cd libexec do
      system "npm", "install", *Language::Node.local_npm_install_args
      rm_f "node_modules/ws/builderror.log" # Avoid references to Homebrew shims
    end

    %w[em++ em-config emar emcc emcmake emconfigure emlink.py emmake
       emranlib emrun emscons].each do |emscript|
      (bin/emscript).write_env_script libexec/emscript, PYTHON: Formula["python@3.8"].opt_bin/"python3"
    end
  end

  def post_install
    system bin/"emcc"
    inreplace "#{libexec}/.emscripten" do |s|
      s.gsub! /^(LLVM_ROOT.*)/, "#\\1\nLLVM_ROOT = \"#{opt_libexec}/llvm/bin\"\\2"
      s.gsub! /^(BINARYEN_ROOT.*)/, "#\\1\nBINARYEN_ROOT = \"#{Formula["binaryen"].opt_prefix}\"\\2"
    end
  end

  test do
    # Fixes "Unsupported architecture" Xcode prepocessor error
    ENV.delete "CPATH"

    (testpath/"test.c").write <<~EOS
      #include <stdio.h>
      int main()
      {
        printf("Hello World!");
        return 0;
      }
    EOS

    system bin/"emcc", "test.c", "-o", "test.js", "-s", "NO_EXIT_RUNTIME=0"
    assert_equal "Hello World!", shell_output("node test.js").chomp
  end
end
