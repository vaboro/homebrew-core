class OpenapiGenerator < Formula
  desc "Generate clients, server & docs from an OpenAPI spec (v2, v3)"
  homepage "https://openapi-generator.tech/"
<<<<<<< HEAD
<<<<<<< HEAD
<<<<<<< HEAD
<<<<<<< HEAD
  url "https://search.maven.org/remotecontent?filepath=org/openapitools/openapi-generator-cli/4.1.0/openapi-generator-cli-4.1.0.jar"
  sha256 "649accfdd325ef7aff03bd60cec15a39cf2b7f9f51ec1f5e4d29b930e15e715e"
=======
  url "https://search.maven.org/remotecontent?filepath=org/openapitools/openapi-generator-cli/4.1.1/openapi-generator-cli-4.1.1.jar"
  sha256 "5b35261e6144a498207fc52e6c2c9ee935a5dd513e88970154bf59180c458732"
>>>>>>> upstream/master
=======
  url "https://search.maven.org/remotecontent?filepath=org/openapitools/openapi-generator-cli/4.1.2/openapi-generator-cli-4.1.2.jar"
  sha256 "c4e3025ba2c82c24e26178ad451d0e00756ff0e151259ef3814e99feac9ec5a1"
>>>>>>> upstream/master
=======
  url "https://search.maven.org/remotecontent?filepath=org/openapitools/openapi-generator-cli/4.1.3/openapi-generator-cli-4.1.3.jar"
  sha256 "234cbbc5ec9b56e4b585199ec387b5ad3aefb3eda9424c30d35c849dd5950d2f"
>>>>>>> upstream/master
=======
  url "https://search.maven.org/remotecontent?filepath=org/openapitools/openapi-generator-cli/4.3.1/openapi-generator-cli-4.3.1.jar"
  sha256 "f438cd16bc1db28d3363e314cefb59384f252361db9cb1a04a322e7eb5b331c1"
  license "Apache-2.0"
>>>>>>> upstream/master

  head do
    url "https://github.com/OpenAPITools/openapi-generator.git"

    depends_on "maven" => :build
  end

  bottle :unneeded

  depends_on "openjdk"

  def install
    if build.head?
      system "mvn", "clean", "package", "-Dmaven.javadoc.skip=true"
      libexec.install "modules/openapi-generator-cli/target/openapi-generator-cli.jar"
    else
      libexec.install "openapi-generator-cli-#{version}.jar" => "openapi-generator-cli.jar"
    end

    (bin/"openapi-generator").write <<~EOS
      #!/bin/bash
      exec "#{Formula["openjdk"].opt_bin}/java" $JAVA_OPTS -jar "#{libexec}/openapi-generator-cli.jar" "$@"
    EOS
  end

  test do
    (testpath/"minimal.yaml").write <<~EOS
      ---
      swagger: '2.0'
      info:
        version: 0.0.0
        title: Simple API
      host: localhost
      basePath: /v2
      schemes:
        - http
      paths:
        /:
          get:
            operationId: test_operation
            responses:
              200:
                description: OK
    EOS
    system bin/"openapi-generator", "generate", "-i", "minimal.yaml", "-g", "openapi", "-o", "./"
  end
end
