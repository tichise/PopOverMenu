Pod::Spec.new do |s|
  s.name = 'PopOverMenu'
  s.version = '1.1'
  s.license = 'MIT'
  s.summary = 'PopOverMenu is a PopOver style menu.'
  s.homepage = 'https://github.com/tichise/PopOverMenu'
  s.social_media_url = 'http://twitter.com/tichise'
  s.author = "Takuya Ichise"
  s.source = { :git => 'https://github.com/tichise/PopOverMenu.git', :tag => s.version }

  s.ios.deployment_target = '9.0'

  s.source_files = 'Sources/*.swift'
  s.requires_arc = true
  
  s.resource_bundles = {
    'Storyboards' => [
        'Storyboards/*.storyboard'
    ]
  }
end