require 'writeexcel'

class GenerateExcel
  def initialize
    @workbook = WriteExcel.new('politician_list.xls')
    @worksheet = @workbook.add_add_worksheet

  end

  private

  attr_reader :workbook, :worksheet

  def init_columns
    #총 7개의 column이 필요함
    #name, 출석 횟수, 출석률, 정당, 지역구, 홈페이지, 총 본회의 횟수
    worksheet.write('A1', 'name_kr')
    worksheet.write('B1', 'attendance_count')
    worksheet.write('C1', 'attendance_percentage')
    worksheet.write('D1', 'party')
    worksheet.write('E1', 'district')
    worksheet.write('F1', 'homepage')
    worksheet.write('G1', 'full_session_count')
  end
end
