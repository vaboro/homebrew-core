class Composer < Formula
  desc "Dependency Manager for PHP"
  homepage "https://getcomposer.org/"
  url "https://getcomposer.org/download/1.10.13/composer.phar"
  sha256 "5ca7445cfd48dd27c5a84aa005a47b4d9fd91132313830609875df3a6973708f"
  license "MIT"

  livecheck do
    url "https://github.com/composer/composer.git"
    regex(/^[\d.]+$/i)
  end

  bottle :unneeded

  def install
    bin.install "composer.phar" => "composer"
  end

  test do
    (testpath/"composer.json").write <<~EOS
      {
        "name": "homebrew/test",
        "authors": [
          {
            "name": "Homebrew"
          }
        ],
        "require": {
          "php": ">=5.3.4"
          },
        "autoload": {
          "psr-0": {
            "HelloWorld": "src/"
          }
        }
      }
    EOS

    (testpath/"src/HelloWorld/greetings.php").write <<~EOS
      <?php

      namespace HelloWorld;

      class Greetings {
        public static function sayHelloWorld() {
          return 'HelloHomebrew';
        }
      }
    EOS

    (testpath/"tests/test.php").write <<~EOS
      <?php

      // Autoload files using the Composer autoloader.
      require_once __DIR__ . '/../vendor/autoload.php';

      use HelloWorld\\Greetings;

      echo Greetings::sayHelloWorld();
    EOS

    system "#{bin}/composer", "install"
    assert_match /^HelloHomebrew$/, shell_output("php tests/test.php")
  end
end
