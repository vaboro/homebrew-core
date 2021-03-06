class Phpstan < Formula
  desc "PHP Static Analysis Tool"
  homepage "https://github.com/phpstan/phpstan"
<<<<<<< HEAD
<<<<<<< HEAD
<<<<<<< HEAD
  url "https://github.com/phpstan/phpstan/releases/download/0.11.12/phpstan.phar"
  sha256 "2bb113875df5379b000e33f0aa703938f7bb8b308c58a4eb99431d874020678a"
=======
  url "https://github.com/phpstan/phpstan/releases/download/0.11.15/phpstan.phar"
  sha256 "691093135f5856a42f935c9552832bded395957db36701afbf1291320b5e43b9"
>>>>>>> upstream/master
=======
  url "https://github.com/phpstan/phpstan/releases/download/0.11.16/phpstan.phar"
  sha256 "fa7b4db67d132c023e1f5ac22320e40dfc1adee1d405e57f7076c8c9e7094430"
>>>>>>> upstream/master
=======
  url "https://github.com/phpstan/phpstan/releases/download/0.12.42/phpstan.phar"
  sha256 "9ba7c68409ed718f852492c4cc394faa938a11147d8ae8e470ff81e252815158"
  license "MIT"
>>>>>>> upstream/master

  bottle :unneeded

  depends_on "php" => :test

  def install
    bin.install "phpstan.phar" => "phpstan"
  end

  test do
    (testpath/"src/autoload.php").write <<~EOS
      <?php
      spl_autoload_register(
          function($class) {
              static $classes = null;
              if ($classes === null) {
                  $classes = array(
                      'email' => '/Email.php'
                  );
              }
              $cn = strtolower($class);
              if (isset($classes[$cn])) {
                  require __DIR__ . $classes[$cn];
              }
          },
          true,
          false
      );
    EOS

    (testpath/"src/Email.php").write <<~EOS
      <?php
        declare(strict_types=1);

        final class Email
        {
            private string $email;

            private function __construct(string $email)
            {
                $this->ensureIsValidEmail($email);

                $this->email = $email;
            }

            public static function fromString(string $email): self
            {
                return new self($email);
            }

            public function __toString(): string
            {
                return $this->email;
            }

            private function ensureIsValidEmail(string $email): void
            {
                if (!filter_var($email, FILTER_VALIDATE_EMAIL)) {
                    throw new InvalidArgumentException(
                        sprintf(
                            '"%s" is not a valid email address',
                            $email
                        )
                    );
                }
            }
        }
    EOS
    assert_match /^\n \[OK\] No errors/,
      shell_output("#{bin}/phpstan analyse --level max --autoload-file src/autoload.php src/Email.php")
  end
end
