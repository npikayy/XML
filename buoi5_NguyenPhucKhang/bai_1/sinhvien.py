from lxml import etree

def run_all_xpath_queries():
    tree = etree.parse('buoi5_NguyenPhucKhang/bai_1/sv.xml')
    root = tree.getroot()
    
    queries = [
        ('//student', 'Tất cả sinh viên'),
        ('//student/name/text()', 'Tên tất cả sinh viên'),
        ('//student/id/text()', 'Tất cả id của sinh viên'),
        ('//student[id="SV01"]/date/text()', 'Ngày sinh SV01'),
        ('//enrollment/course/text()', 'Các khóa học'),
        ('//student[1]', 'Sinh viên đầu tiên'),
        ('//enrollment[course="Vatly203"]/studentRef/text()', 'SV đăng ký Vatly203'),
        ('//enrollment[course="Toan101"]/studentRef/text()', 'SV đăng ký Toan101'),
        ('count(//student)', 'Tổng số sinh viên'),
        ('//student[not(id = //enrollment/studentRef)]', 'SV chưa đăng ký môn'),
        ('//student[id="SV01"]/name/following-sibling::date', 'Date sau name SV01'),
        ('//student[starts-with(name, "Trần")]', 'SV họ Trần'),
        ('substring(//student[id="SV01"]/date, 1, 4)', 'Năm sinh SV01')
    ]
    
    for xpath, description in queries:
        try:
            result = root.xpath(xpath)
            print(f"{description}")
            print(f"   XPath: {xpath}")
            print(f"   Kết quả: {result}")
            print()
        except Exception as e:
            print(f"❌ Lỗi: {e}")

# Chạy tất cả queries
run_all_xpath_queries()