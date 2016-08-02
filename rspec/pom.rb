project 'demo-app', 'http://maven.apache.org' do
  model_version '4.0.0'
  id 'org.jruby.demo:demo-app:1.0-SNAPSHOT'
  packaging 'jar'
  repository url: 'https://otto.takari.io/content/repositories/rubygems/maven/releases', id: 'rubygems-releases'
  
  properties 'polyglot.dump.pom' => 'pom.xml'
  
  gem 'rubygems:rspec:3.3.0', scope: 'test'
  
  plugin 'de.saumya.mojo:rspec-maven-plugin:1.1.2', extensions: true
end
