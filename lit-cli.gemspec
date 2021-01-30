Gem::Specification.new do |spec|

  spec.name        = 'lit-cli'
  spec.version     = '0.0.1'
  spec.date        = '2021-01-30'
  spec.authors     = ["Maedi Prichard"]
  spec.email       = 'maediprichard@gmail.com'

  spec.summary     = "Shine a light on terminal commands. 🔥"
  spec.description = "Show log messages in the terminal by starting commands with 'lit'."
  spec.homepage    = 'https://reflekt.dev/lit'
  spec.license     = 'MPL-2.0'

  spec.files = [
    "lib/cli.rb",
  ]
  spec.require_paths = ["lib"]

  spec.executables << 'lit-cli'

end
