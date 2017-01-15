require '../jobs/enum/url_enum'
require 'nokogiri'
require 'open-uri'
require 'set'

class CrawlerJob
  include UrlEnum

  def self.parse_document(page_num)
    document = rake(page_num)
    first_table = document.xpath('//table[@class="table table-striped"]')[0]

    table_rows = first_table.xpath('./tr')


    attend = get_list(table_rows[0])
    leave = get_list(table_rows[1])
    absent = get_list(table_rows[2])

    all_politician = attend + leave + absent
    info = {all: all_politician, attend: attend, leave: leave, absent: absent}
    return info
  end

  private

  def except_dup_politician(list)
    list = list.uniq
    except_people = ["최경환", "김성태"]
    except_people.each do |person|
      if(list.include? person)
        list -= [person]
      end
    end
    return list
  end

  def get_list(table_rows)
    cell = table_rows.xpath('./td')[1]
    name_cell = cell.xpath('./span[@class="session_attend_name"]/a/text()')
    list = []
    if name_cell.empty?
      return list
    else
      list = convert_to_text_from_node(name_cell)
      return except_dup_politician(list)
    end
  end

  def convert_to_text_from_node(name_cell)
    name_cell.map(&:text)
  end

  def rake(page_num)
    base = BASE
    target_url = base + page_num
    document = Nokogiri::HTML(open(target_url, 'Accept-Encoding' => ''))
    return document
  end
end



 # CrawlerJob.new().parse_document "829"





