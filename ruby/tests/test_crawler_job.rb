require 'rspec/core'

describe 'CrawlerJob' do
  it '' do
    job = new CrawlerJob()
    html_obj = job.rake("829")
    html_obj.class.must_equal Nokogiri::HTML::Document
  end
end
