Gem::Specification.new do |spec|

  spec.name        = 'lit-cli'
  spec.version     = '0.3.0'
  spec.date        = '2021-02-06'
  spec.authors     = ["Maedi Prichard"]
  spec.email       = 'maediprichard@gmail.com'
  spec.summary     = "Shine a light on terminal commands. 🔥"
  spec.description = "Console logs that are only visible after prefixing commands with 'lit'."
  spec.homepage    = 'https://reflekt.dev/lit'
  spec.license     = 'MPL-2.0'

  spec.files = [
    "lib/config.rb",
    "lib/lit_cli.rb",
  ]
  spec.require_paths = ["lib"]

  spec.add_dependency "pastel"

  spec.executables << 'lit'

end
