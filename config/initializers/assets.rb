# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'

### fonts ###
Rails.application.config.assets.paths << Rails.root.join('vendor', 'assets', 'fonts')
Rails.application.config.assets.precompile += %w(
  glyphicons-halflings-regular.ttf
  glyphicons-halflings-regular.woff )

### CSS ###
Rails.application.config.assets.precompile += %w(
  admin.sass )

### JS ###
Rails.application.config.assets.precompile += %w(
  admin.js )
