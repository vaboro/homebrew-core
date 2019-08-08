class Rpm2cpio < Formula
  desc "Tool to convert RPM package to CPIO archive"
  homepage "https://svnweb.freebsd.org/ports/head/archivers/rpm2cpio/"
  url "https://svnweb.freebsd.org/ports/head/archivers/rpm2cpio/files/rpm2cpio?revision=408590&view=co"
  version "1.4"
  sha256 "2841bacdadde2a9225ca387c52259d6007762815468f621253ebb537d6636a00"

  bottle do
    cellar :any_skip_relocation
    sha256 "ab485e451668ede8eea2b1a9f8ac1781aae218399604d72e28587ece7674f0b0" => :mojave
    sha256 "82c3021a2e882829d635ff45fc9780e72d0199777aa5dbbeb6f07b1a17944369" => :high_sierra
    sha256 "864c4e9533aaf62e67a119006017df772a961bb0c407a0184fb0c9d8e1202509" => :sierra
    sha256 "d26a07db8b6c1293171dc4937d81b2dc9936da0d52718d5f94ddd83524d5974e" => :el_capitan
    sha256 "623651ab4e150e1f05ba3a42aa6a18a1e7cb2c023cc3327cd3388f178e65d80a" => :yosemite
    sha256 "fcb6787ea96ae09d99bb6a7e28f653966277543b7a832661bb6da1a2903567cf" => :mavericks
  end

  depends_on "xz"

  def install
    bin.install "rpm2cpio?revision=408590&view=co" => "rpm2cpio"
  end
end
