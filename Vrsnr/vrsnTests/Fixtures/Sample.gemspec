Gem::Specification.new do |s|
    s.name        = 'Sample'
    s.version     = '0.0.0'
    s.date        = '2018-10-23'
    s.summary     = 'A sample gemspec file.'
    s.description = <<-DESC
        Description of a sample gemspec file.
    DESC
    s.files       = [
        'lib/a',
        'lib/b.rb'
    ]
    s.homepage    = 'https://github.com/my/repo'
    s.license     = 'MIT'
    s.add_runtime_dependency 'json', '~> 2.1'
end
