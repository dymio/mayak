# Set the host name for URL creation
SitemapGenerator::Sitemap.default_host = "http://example.com"

SitemapGenerator::Sitemap.create do
  # Put links creation logic here.
  #
  # The root path '/' and sitemap index file are added automatically for you.
  # Links are added to the Sitemap in the order they are specified.
  #
  # Usage: add(path, options={})
  #        (default options are used if you don't specify)
  #
  # Defaults: :priority => 0.5, :changefreq => 'weekly',
  #           :lastmod => Time.now, :host => default_host
  #
  # Examples:
  #
  # Add '/articles'
  #
  #   add articles_path, :priority => 0.7, :changefreq => 'daily'
  #
  # Add all articles:
  #
  #   Article.find_each do |article|
  #     add article_path(article), :lastmod => article.updated_at
  #   end

  exclude_from_pages = ["/"]

  exclude_from_pages << feedback_path # because crawlers don't need this page

  add news_index_path
  exclude_from_pages << news_index_path

  News.visibles.ordered.each do |news|
    add news_path(news.slug), changefreq: 'yearly', lastmod: news.updated_at
  end

  Page.visibles.ordered.each do |page|
    next if page.home?
    unless exclude_from_pages.include? page_path(page.path)
      add page_path(page.path), lastmod: page.updated_at, changefreq: 'monthly'
    end
  end
end
