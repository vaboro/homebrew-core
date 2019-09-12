class Emscripten < Formula
  desc "LLVM bytecode to JavaScript compiler"
  homepage "https://kripken.github.io/emscripten-site/"

  stable do
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

    resource "fastcomp" do
      url "https://github.com/emscripten-core/emscripten-fastcomp/archive/1.38.44.tar.gz"
      sha256 "d066f36d1083e5d62e2a9fb24e162e506a6b359fc101c43aec22ba8b1a836a01"
    end

    resource "fastcomp-clang" do
      url "https://github.com/emscripten-core/emscripten-fastcomp-clang/archive/1.38.44.tar.gz"
      sha256 "13aca52d91aba756f8e0610e4a4ebd8147369f4708c7542efdf8a4f96e52f2a1"
    end
  end

  bottle do
    cellar :any
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
  end

  head do
    url "https://github.com/emscripten-core/emscripten.git", :branch => "incoming"

    resource "fastcomp" do
      url "https://github.com/emscripten-core/emscripten-fastcomp.git", :branch => "incoming"
    end

    resource "fastcomp-clang" do
      url "https://github.com/emscripten-core/emscripten-fastcomp-clang.git", :branch => "incoming"
    end
  end

  depends_on "cmake" => :build
  depends_on "node"
  depends_on "python"
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

    %w[em++ em-config emar emcc emcmake emconfigure emlink.py emmake
       emranlib emrun emscons].each do |emscript|
      bin.install_symlink libexec/emscript
    end
  end

  def caveats; <<~EOS
    Manually set LLVM_ROOT to
      #{opt_libexec}/llvm/bin
    and comment out BINARYEN_ROOT
    in ~/.emscripten after running `emcc` for the first time.
  EOS
  end

  test do
    system bin/"emcc"
    assert_predicate testpath/".emscripten", :exist?, "Failed to create sample config"
  end
end
