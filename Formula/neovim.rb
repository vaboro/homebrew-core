class Neovim < Formula
  desc "Ambitious Vim-fork focused on extensibility and agility"
  homepage "https://neovim.io/"
  revision 2

  stable do
    url "https://github.com/neovim/neovim/archive/v0.3.7.tar.gz"
    sha256 "4c0f1b839ef2c8cfee63eb2a072324accf4f0c0badd2fbd087d3e7a12d538bca"

    depends_on "jemalloc"
  end

  bottle do
    sha256 "7955703de89c1ea63cb5185b3bb6a61426d9add22321cd27882265179ede2207" => :mojave
    sha256 "e6a01b6a91406aa0284dae08446ed6b845a465b14f90efef6c9ee7db5bd54268" => :high_sierra
    sha256 "0874c9a239cc6d8964e44dcba2eac512bb7932b680eaf9a74e4370f8581f0083" => :sierra
  end

  head do
    url "https://github.com/neovim/neovim.git"

    resource "lua-compat-5.3" do
      url "https://github.com/keplerproject/lua-compat-5.3/archive/v0.7.tar.gz"
      sha256 "bec3a23114a3d9b3218038309657f0f506ad10dfbc03bb54e91da7e5ffdba0a2"
    end

    resource "luv" do
      url "https://github.com/luvit/luv/releases/download/1.29.1-2/luv-1.29.1-2.tar.gz"
      sha256 "866e6c82f3eb4ae73222b835c7621d1b8f6b4271b5cee8dd00729338cfef9d47"
    end
  end

  depends_on "cmake" => :build
  depends_on "luarocks" => :build
  depends_on "pkg-config" => :build
  depends_on "gettext"
  depends_on "libtermkey"
  depends_on "libuv"
  depends_on "libvterm"
  depends_on "luajit"
  depends_on "msgpack"
  depends_on "unibilium"

  resource "mpack" do
    url "https://github.com/libmpack/libmpack-lua/releases/download/1.0.7/libmpack-lua-1.0.7.tar.gz"
    sha256 "68565484a3441d316bd51bed1cacd542b7f84b1ecfd37a8bd18dd0f1a20887e8"
  end

  resource "lpeg" do
    url "https://luarocks.org/manifests/gvvaughan/lpeg-1.0.2-1.src.rock"
    sha256 "e0d0d687897f06588558168eeb1902ac41a11edd1b58f1aa61b99d0ea0abbfbc"
  end

  resource "inspect" do
    url "https://luarocks.org/manifests/kikito/inspect-3.1.1-0.src.rock"
    sha256 "ea1f347663cebb523e88622b1d6fe38126c79436da4dbf442674208aa14a8f4c"
  end

  def install
    resources.each do |r|
      r.stage(buildpath/"deps-build/build/src/#{r.name}")
    end

    ENV.prepend_path "LUA_PATH", "#{buildpath}/deps-build/share/lua/5.1/?.lua"
    ENV.prepend_path "LUA_CPATH", "#{buildpath}/deps-build/lib/lua/5.1/?.so"
    lua_path = "--lua-dir=#{Formula["luajit"].opt_prefix}"

    cd "deps-build" do
      %w[
        mpack/mpack-1.0.7-0.rockspec
        lpeg/lpeg-1.0.2-1.src.rock
        inspect/inspect-3.1.1-0.src.rock
      ].each do |rock|
        dir, rock = rock.split("/")
        cd "build/src/#{dir}" do
          output = Utils.popen_read("luarocks", "unpack", lua_path, rock, "--tree=#{buildpath}/deps-build")
          unpack_dir = output.split("\n")[-2]
          cd unpack_dir do
            system "luarocks", "make", lua_path, "--tree=#{buildpath}/deps-build"
          end
        end
      end

      if build.head?
        cd "build/src/luv" do
          cmake_args = std_cmake_args.reject { |s| s["CMAKE_INSTALL_PREFIX"] }
          cmake_args += %W[
            -DCMAKE_INSTALL_PREFIX=#{buildpath}/deps-build
            -DLUA_BUILD_TYPE=System
            -DWITH_SHARED_LIBUV=ON
            -DBUILD_SHARED_LIBS=OFF
            -DBUILD_MODULE=OFF
            -DLUA_COMPAT53_DIR=#{buildpath}/deps-build/build/src/lua-compat-5.3
          ]
          system "cmake", ".", *cmake_args
          system "make", "install"
        end
      end
    end

    mkdir "build" do
      cmake_args = std_cmake_args
      if build.head?
        cmake_args += %W[
          -DLIBLUV_INCLUDE_DIR=#{buildpath}/deps-build/include
          -DLIBLUV_LIBRARY=#{buildpath}/deps-build/lib/libluv.a
        ]
      end
      system "cmake", "..", *cmake_args
      system "make", "install"
    end
  end

  test do
    (testpath/"test.txt").write("Hello World from Vim!!")
    system bin/"nvim", "--headless", "-i", "NONE", "-u", "NONE",
                       "+s/Vim/Neovim/g", "+wq", "test.txt"
    assert_equal "Hello World from Neovim!!", (testpath/"test.txt").read.chomp
  end
end
