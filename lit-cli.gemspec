Gem::Specification.new do |spec|

  spec.name        = 'lit-cli'
  spec.version     = '0.0.3'
  spec.date        = '2021-02-01'
  spec.authors     = ["Maedi Prichard"]
  spec.email       = 'maediprichard@gmail.com'

  spec.summary     = "Shine a light on terminal commands. 🔥"
  spec.description = "Show more detailed logs by starting commands with 'lit'."
  spec.homepage    = 'https://reflekt.dev/lit'
  spec.license     = 'MPL-2.0'

  spec.files = [
    "lib/api.rb",
  ]
  spec.require_paths = ["lib"]

  spec.add_dependency "pastel"

  spec.executables << 'lit'

end
