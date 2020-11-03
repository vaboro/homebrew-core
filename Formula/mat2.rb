class Mat2 < Formula
  desc "Metadata anonymization toolkit"
  homepage "https://0xacab.org/jvoisin/mat2"
  url "https://0xacab.org/jvoisin/mat2/-/archive/0.11.0/mat2-0.11.0.tar.gz"
  sha256 "c37be119f4bc6226257cd72048bba4eaf3bb24a62fd38c2a34d9b937e6bd36b7"
  license "LGPL-3.0"

  bottle do
    cellar :any_skip_relocation
    sha256 "34a6c1014ecd99466de27658a669939047ab794d2d6272b483066a52988fb911" => :catalina
    sha256 "34a6c1014ecd99466de27658a669939047ab794d2d6272b483066a52988fb911" => :mojave
    sha256 "34a6c1014ecd99466de27658a669939047ab794d2d6272b483066a52988fb911" => :high_sierra
  end

  depends_on "exiftool"
  depends_on "ffmpeg"
  depends_on "gdk-pixbuf"
  depends_on "librsvg"
  depends_on "poppler"
  depends_on "py3cairo"
  depends_on "pygobject3"
  depends_on "python@3.8"

  resource "mutagen" do
    url "https://files.pythonhosted.org/packages/96/9f/280220926cabbf4822f80e094a5190fb3df245209648e169c8bcf708697b/mutagen-1.44.0.tar.gz"
    sha256 "56065d8a9ca0bc64610a4d0f37e2bd4453381dde3226b8835ee656faa3287be4"
  end

  def install
    version = Language::Python.major_minor_version Formula["python@3.8"].bin/"python3"
    pygobject3 = Formula["pygobject3"]
    ENV["PYTHONPATH"] = lib/"python#{version}/site-packages"
    ENV.append_path "PYTHONPATH", pygobject3.opt_lib+"python#{version}/site-packages"
    ENV.prepend_create_path "PYTHONPATH", libexec/"vendor/lib/python#{version}/site-packages"

    resources.each do |r|
      r.stage do
        system Formula["python@3.8"].bin/"python3", *Language::Python.setup_install_args(libexec/"vendor")
      end
    end

    system Formula["python@3.8"].bin/"python3", *Language::Python.setup_install_args(prefix)

    bin.env_script_all_files(libexec/"bin", PYTHONPATH: ENV["PYTHONPATH"])
  end

  test do
    system "#{bin}/mat2", "-l"
  end
end
