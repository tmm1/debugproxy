spec = Gem::Specification.new do |s|
  s.name = 'debugproxy'
  s.version = '0.1.0'
  s.summary = 'man-in-the-middle proxy'
  s.description = 'TCP man in the middle proxy with SSL support.'

  s.homepage = "http://github.com/tmm1/debugproxy"

  s.authors = ["Aman Gupta"]
  s.email = "aman@tmm1.net"

  s.bindir = 'bin'
  s.executables << 'debugproxy'

  s.add_dependency 'eventmachine'

  s.files = `git ls-files`.split("\n").reject{ |f| f =~ /^examples/ }
end
