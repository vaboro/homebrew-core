class Paket < Formula
  desc "Dependency manager for .NET with support for NuGet and Git repositories"
  homepage "https://fsprojects.github.io/Paket/"
<<<<<<< HEAD
<<<<<<< HEAD
  url "https://github.com/fsprojects/Paket/releases/download/5.216.0/paket.exe"
  sha256 "8afa98f4765ab97592027851df18073bbf0e74e0acd67412fce3d956473241f0"
=======
  url "https://github.com/fsprojects/Paket/releases/download/5.217.1/paket.exe"
  sha256 "4902751e83d79e93aea1f422de2879cb2496e13202102de76c2faf704a68ee50"
>>>>>>> upstream/master
=======
  url "https://github.com/fsprojects/Paket/releases/download/5.219.0/paket.exe"
  sha256 "63cee3934cf4fa8607d0a5b1d20253de56cb2088d2377b4abc7cbfa1e43cd621"
>>>>>>> upstream/master

  bottle :unneeded

  depends_on "mono"

  def install
    libexec.install "paket.exe"
    (bin/"paket").write <<~EOS
      #!/bin/bash
      mono #{libexec}/paket.exe "$@"
    EOS
  end

  test do
    test_package_id = "Paket.Test"
    test_package_version = "1.2.3"

    touch testpath/"paket.dependencies"
    touch testpath/"testfile.txt"

    system bin/"paket", "install"
    assert_predicate testpath/"paket.lock", :exist?

    (testpath/"paket.template").write <<~EOS
      type file

      id #{test_package_id}
      version #{test_package_version}
      authors Test package author

      description
          Description of this test package

      files
          testfile.txt ==> lib
    EOS

    system bin/"paket", "pack", "output", testpath
    assert_predicate testpath/"#{test_package_id}.#{test_package_version}.nupkg", :exist?
  end
end
