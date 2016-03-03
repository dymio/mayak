module StaticFilesHolding
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  # Module for including in ActiveRecord model with acts_as_static_files_holder
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  module Holder
    def self.included(base)
      base.has_many :static_files, as: :holder, dependent: :destroy
      base.after_create :set_static_files_holder
    end

    private

    def set_static_files_holder
      # REFACTOR use this not only for body (collection of html text fields)
      if self.body.present?
        # REFACTOR get store_dir from StaticFileUploader
        sf_ids = self.body.scan(/\/uploads\/static_file\/file\/([0-9]+)/)
                          .collect { |ida| ida[0].to_i }
        sfs = StaticFile.holderless.where id: sf_ids
        sfs.each do |sf|
          sf.holder = self
          sf.save
        end
      end
    end
  end
end

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# ActiveRecord model function for including StaticFilesHolding::Holder module
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
class << ActiveRecord::Base
  def acts_as_static_files_holder
    include StaticFilesHolding::Holder
  end
end

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# ActiveAdmin component for show static images on the show page
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
module ActiveAdmin
  module Views

    class StaticFilesPanel < Panel
      builder_method :static_files_for

      # params:
      #   holder is object of model which acts_as_static_files_holder
      def build(holder)
        super I18n.t("activerecord.models.static_file", count: 1.2), {}

        if holder.static_files.any?
          table_for holder.static_files do
            column I18n.t('activerecord.attributes.static_file.filetype'), :filetype do |sf|
              static_file_image sf, false, :thumb
            end
            column I18n.t('activerecord.attributes.static_file.url'), :url do |sf|
              [ "#{sf.file.url.split('/')[0..-2].join('/')}/",
                "<b>#{sf.file.url.split("/").last}</b>" ].join.html_safe
            end
            column I18n.t('activerecord.attributes.static_file.size'), :size
            column nil do |sf|
              link_to I18n.t('active_admin.delete'),
                      admin_static_file_path(sf, format: "json"),
                      method: :delete,
                      class: 'delete-static-file',
                      data: { confirm: I18n.t('active_admin.delete_confirmation') },
                      remote: true
            end
          end
        end
        div do
          # REFACTOR this block, maybe move to views
          semantic_form_for(StaticFile.new(holder: holder), url: admin_static_files_path) do |f|
            [ f.inputs(name: "Загрузить новый файл") do
                [
                  f.input(:holder_type, as: :hidden),
                  f.input(:holder_id, as: :hidden),
                  f.input(:file)
                ].join.html_safe
              end,
              f.actions { f.action(:submit, label: "Загрузить") }
              ].join.html_safe
          end
        end
      end

    end
  end
end
