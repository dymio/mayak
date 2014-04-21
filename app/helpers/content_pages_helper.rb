module ContentPagesHelper

  # Get collections of pages with tree ordering with parent names
  #   except_homepage - boolean value for exclude homepage from collection
  #   except_page - ContentPage thats we need to exclude from collection
  #   except_with_children - true if need exclude all of childs of except_page
  def content_pages_tree_ordered_collection(except_homepage = false,
                              except_page = nil,
                              except_with_children = false)
    collect_tree_up_from ContentPage.order(:id),
                         [],
                         except_homepage,
                         except_page,
                         except_with_children
  end

  private

  # collecting ancestry tree, starting from parents from already done array
  # 'foliage' with all tree elements
  def collect_tree_up_from (foliage,
                            parents,
                            except_homepage,
                            except_page,
                            except_with_children)
    ancestry_string = parents.collect {|x| x.id.to_s }.join("/")
    name_prefix = parents.collect {|x| x.title }.join(" / ")
    name_prefix += " / " if name_prefix.present?

    our_mans_indexes = []
    foliage.each_index do |indx|
      if foliage[indx].ancestry.to_s == ancestry_string
        our_mans_indexes << indx
      end
    end

    leaves = []

    our_mans_indexes.reverse!
    our_mans_indexes.each do |indx|
      leaves << foliage.delete_at(indx)
    end

    leaves.sort! {|a,b| (a.prior == b.prior) ? a.id <=> b.id : a.prior <=> b.prior }
    result = []

    leaves.each do |leaf|
      do_writing = true
      if (except_page && leaf == except_page) || (except_homepage && leaf.home?)
        do_writing = false
      end
      result << [ name_prefix + leaf.title, leaf.id ] if do_writing
      unless do_writing == false && except_with_children
        result += collect_tree_up_from foliage,
                                     (parents + [ leaf ]),
                                     except_homepage,
                                     except_page,
                                     except_with_children
      end
    end

    result
  end

end