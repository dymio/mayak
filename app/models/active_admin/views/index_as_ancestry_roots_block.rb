module ActiveAdmin
  module Views
    class IndexAsAncestryRootsBlock < ActiveAdmin::Component

      def build(page_presenter, collection)
        add_class "index"
        resource_selection_toggle_panel if active_admin_config.batch_actions.any?
        collection.select {|ao| ao.root? }.each do |obj|
          instance_exec(obj, &page_presenter.block)
        end
      end

      def self.index_name
        "roots_block"
      end

    end
  end
end