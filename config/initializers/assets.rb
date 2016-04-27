# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'

### fonts ###
Rails.application.config.assets.paths << Rails.root.join('vendor', 'assets', 'fonts')

### CSS ###
Rails.application.config.assets.precompile += %w(
  admin.sass
  admin/metisMenu.css )

### JS ###
Rails.application.config.assets.precompile += %w(
  admin.js
  admin/metisMenu.js )