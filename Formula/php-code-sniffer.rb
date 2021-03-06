class PhpCodeSniffer < Formula
  desc "Check coding standards in PHP, JavaScript and CSS"
  homepage "https://github.com/squizlabs/PHP_CodeSniffer/"
  url "https://github.com/squizlabs/PHP_CodeSniffer/releases/download/3.5.6/phpcs.phar"
  sha256 "60493158a3484e2192c85bc7303eca4eaf8a71b4c1a68408df218b33991b3d94"
  license "BSD-3-Clause"

  bottle :unneeded

  resource "phpcbf.phar" do
    url "https://github.com/squizlabs/PHP_CodeSniffer/releases/download/3.5.5/phpcbf.phar"
    sha256 "6f64fe00dee53fa7b256f63656dc0154f5964666fc7e535fac86d0078e7dea41"
  end

  def install
    bin.install "phpcs.phar" => "phpcs"
    resource("phpcbf.phar").stage { bin.install "phpcbf.phar" => "phpcbf" }
  end

  test do
    (testpath/"test.php").write <<~EOS
      <?php
      /**
      * PHP version 5
      *
      * @category  Homebrew
      * @package   Homebrew_Test
      * @author    Homebrew <do.not@email.me>
      * @license   BSD Licence
      * @link      https://brew.sh/
      */
    EOS

    assert_match(/FOUND 13 ERRORS/, shell_output("#{bin}/phpcs --runtime-set ignore_errors_on_exit true test.php"))
    assert_match(/13 ERRORS WERE FIXED/, shell_output("#{bin}/phpcbf test.php", 1))
    system "#{bin}/phpcs", "test.php"
  end
end
