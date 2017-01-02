require 'nokogiri'
require 'open-uri'
require_relative '../spotira_utils.rb'

module SpotiraFetchers

  def self.fetch_soundsofatiredcity
    result = ResultList.new
    (1..3).each do |page|
      url = "http://soundsofatiredcity.com/best-of-2016-part-#{ page }"
      doc = Nokogiri::HTML(open(url))
      doc.css('.post_content h1 span').each do |link|
        artist, album = link.text.split(': ')
        artist = artist.split('.')[1]
        if artist && album
          artist = artist.strip
          album = album.gsub(/(?<=\[)[^\]]+?(?=\])/, "").gsub("[]","")
          album = album.strip
          puts "#{artist} - #{album}"
        end
      end
    end

    SpotiraUtils.fetch(result, 'soundsofatiredcity')
  end

end
