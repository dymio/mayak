# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in app/assets folder are already added.
# Rails.application.config.assets.precompile += %w( search.js )
Rails.application.config.assets.precompile += %w(
    chosen.css
    chosen.jquery.js
  )

# TODO choose html redactor for admin and add assets to precompile
# redactor.css
# redactor.js
# redactor_lang_ru.js
