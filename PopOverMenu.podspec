Pod::Spec.new do |s|
  s.name = 'PopOverMenu'
  s.version = '2.7.0'
  s.license = 'MIT'
  s.swift_versions = '5.0'
  s.summary = 'PopOverMenu is a PopOver style menu.'
  s.homepage = 'https://github.com/tichise/PopOverMenu'
  s.social_media_url = 'http://twitter.com/tichise'
  s.author = "Takuya Ichise"
  s.source = { :git => 'https://github.com/tichise/PopOverMenu.git', :tag => s.version }

  s.ios.deployment_target = '14.0'

  s.source_files = 'Sources/*.swift'
  s.requires_arc = true

  s.resource_bundles = {
    'PopOverMenuStoryboards' => [
        'Sources/Storyboards/*.storyboard'
    ]
  }
end
