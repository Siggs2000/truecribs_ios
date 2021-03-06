# -*- coding: utf-8 -*-
$:.unshift('/Library/RubyMotion/lib')
require 'motion/project/template/ios'

require 'bundler'
Bundler.require

# require 'bubble-wrap'

Motion::Project::App.setup do |app|
  # Use `rake config' to see complete project settings

  app.name = 'TrueCribs'
  app.identifier = 'com.truecribs'
  app.seed_id    = "QKKZN47C74"
    app.short_version = '0.1.0'
    # Get version from git
    #app.version = (`git rev-list HEAD --count`.strip.to_i).to_s
    app.version = app.short_version
    app.info_plist['CFBundleVersion'] = app.version
    app.info_plist['CFBundleShortVersionString'] = app.version

  # RubyMotion by default selects the latest SDK you have installed,
  # if you would like to specify the SDK to assure consistency across multiple machines,
  # you can do so like the following examples
  # app.sdk_version = '8.3'
  # app.sdk_version = '7.1'

  # Target OS
  app.deployment_target = '8.0'
  # app.deployment_target = '8.0'
  app.sdk_version = '9.1'

  app.icons = Dir.glob("resources/icon*.png").map{|icon| icon.split("/").last}

  app.device_family = [:iphone, :ipad]
  app.interface_orientations = [:landscape_left, :landscape_right]

  app.files += Dir.glob(File.join(app.project_dir, 'lib/**/*.rb'))

  # app.fonts = ['Oswald-Regular.ttf', 'FontAwesome.otf'] # These go in /resources
  # Or use all *.ttf fonts in the /resources/fonts directory:
  # app.fonts = Dir.glob("resources/fonts/*.ttf").map{|font| "fonts/#{font.split('/').last}"}
  # app.frameworks += %w(QuartzCore CoreGraphics MediaPlayer MessageUI CoreData)

  # app.vendor_project('vendor/Flurry', :static)
  # app.vendor_project('vendor/DSLCalendarView', :static, :cflags => '-fobjc-arc') # Using arc
  app.info_plist['NSAppTransportSecurity'] = { 'NSAllowsArbitraryLoads' => true }

  app.pods do
    pod 'SDWebImage'
  #   pod 'JGProgressHUD'
    pod 'SVProgressHUD'
  #   pod "FontasticIcons"
  end

  app.development do
    app.codesign_certificate = "iPhone Developer: Seth Siegler (ZTGHVU7A3C)"
    app.provisioning_profile = "./environment/truecribs_dev.mobileprovision"
    app.entitlements['aps-environment'] = 'development'
    app.entitlements['get-task-allow'] = true

    app.entitlements['application-identifier'] = app.seed_id + '.' + app.identifier
    app.entitlements['keychain-access-groups'] = [
    app.seed_id + '.' + app.identifier
  ]
  end

  app.release do
    app.entitlements['get-task-allow'] = false
    app.codesign_certificate = 'iPhone Distribution: YOURNAME'
    app.provisioning_profile = "signing/truecribs_ios.mobileprovision"
    app.entitlements['beta-reports-active'] = true # For TestFlight

    app.seed_id = "YOUR_SEED_ID"
    app.entitlements['application-identifier'] = app.seed_id + '.' + app.identifier
    app.entitlements['keychain-access-groups'] = [ app.seed_id + '.' + app.identifier ]
  end

  puts "Name: #{app.name}"
  puts "Using profile: #{app.provisioning_profile}"
  puts "Using certificate: #{app.codesign_certificate}"
end

# Remove this if you aren't using CDQ
task :"build:simulator" => :"schema:build"
