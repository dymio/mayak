require 'rails_helper'

RSpec.describe News, type: :model do

  it 'should have published_at after initialize' do
    one_news = News.new
    expect(one_news.published_at).not_to be_nil
  end

end
