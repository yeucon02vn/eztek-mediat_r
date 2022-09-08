require_relative "lib/ez/mediat_r/version"

lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |spec|
  spec.name       = "eztek-mediat_r"
  spec.version    = EZ::MediatR::VERSION
  spec.authors    = ["yeucon02vn"]
  spec.email      = ["phiphuqn1@gmail.com"]

  spec.summary    = "This is an async implementation of Mediator pattern with pipline behaviors.
  It is a port of Mediatr from .Net C#"
  spec.homepage   = "https://github.com/yeucon02vn/eztek-mediat_r"
  spec.license    = "MIT"

  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject do |f|
      (f == __FILE__) || f.match(%r{\A(?:(?:bin|test|spec|features)/|\.(?:git|travis|circleci)|appveyor)})
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "concurrent-ruby"

  spec.add_development_dependency "bundler"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.4.0"
end
