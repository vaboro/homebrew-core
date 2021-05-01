class Daemonize < Formula
  desc "Run a command as a UNIX daemon"
  homepage "https://software.clapper.org/daemonize/"
  url "https://github.com/bmc/daemonize/archive/release-1.7.8.tar.gz"
  sha256 "20c4fc9925371d1ddf1b57947f8fb93e2036eb9ccc3b43a1e3678ea8471c4c60"
  license "BSD-3-Clause"

  bottle do
    sha256 cellar: :any_skip_relocation, catalina:    "a5c898ee425aecfb5c3d41e75da436ebbd44ad2fa343fa85b60573bd4fd8c7a7"
    sha256 cellar: :any_skip_relocation, mojave:      "45a895642c3be14e888b66607c2a4567408657111686437a431a730358b2feea"
    sha256 cellar: :any_skip_relocation, high_sierra: "bc501e9e4ba9fd11390fa9749a7b9a38a70353edaf75499bd969c45921d06bfe"
    sha256 cellar: :any_skip_relocation, sierra:      "d4d5109292158ef32eb73a37b9b6a037dcae620e234be945410ea927322bb998"
    sha256 cellar: :any_skip_relocation, el_capitan:  "5e05991cf0462e4fe32dd70354d2520a378831d2b1c0fc2cf0b4fbca8dc85489"
  end

  def install
    system "./configure", "--disable-debug", "--disable-dependency-tracking",
                          "--prefix=#{prefix}"
    system "make"
    system "make", "install"
  end

  test do
    dummy_script_file = testpath/"script.sh"
    output_file = testpath/"outputfile.txt"
    pid_file = testpath/"pidfile.txt"
    dummy_script_file.write <<~EOS
      #!/bin/sh
      echo "#{version}" >> "#{output_file}"
    EOS
    chmod 0700, dummy_script_file
    system "#{sbin}/daemonize", "-p", pid_file, dummy_script_file
    assert_predicate pid_file, :exist?,
      "The file containing the PID of the child process was not created."
    sleep(4) # sleep while waiting for the dummy script to finish
    assert_predicate output_file, :exist?,
      "The file which should have been created by the child process doesn't exist."
    assert_match version.to_s, output_file.read
  end
end
