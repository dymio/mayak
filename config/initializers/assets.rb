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

# TODO check this assets includion needness aaa!
# active_admin.css
# active_admin/print.css
# active_admin.js
# redactor.css
#
# redactor.js
# redactor_lang_ru.js