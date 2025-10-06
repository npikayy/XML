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
            print(f"🔍 {description}")
            print(f"   XPath: {xpath}")
            
            # Xử lý đặc biệt cho các trường hợp trả về Element objects
            if description == "Tất cả sinh viên":
                print("   Kết quả:")
                for i, student in enumerate(result, 1):
                    id = student.find('id').text
                    name = student.find('name').text
                    date = student.find('date').text
                    print(f"     {i}. {id} - {name} - {date}")
            
            elif description == "Sinh viên đầu tiên":
                if result:
                    student = result[0]
                    id = student.find('id').text
                    name = student.find('name').text
                    date = student.find('date').text
                    print(f"   Kết quả: {id} - {name} - {date}")
                else:
                    print("   Kết quả: Không có sinh viên nào")
            
            elif description == "SV chưa đăng ký môn":
                print("   Kết quả:")
                for i, student in enumerate(result, 1):
                    id = student.find('id').text
                    name = student.find('name').text
                    print(f"     {i}. {id} - {name}")
            
            elif description == "SV họ Trần":
                print("   Kết quả:")
                for i, student in enumerate(result, 1):
                    id = student.find('id').text
                    name = student.find('name').text
                    print(f"     {i}. {id} - {name}")
            
            elif description == "Date sau name SV01":
                if result:
                    print(f"   Kết quả: {result[0].text}")
                else:
                    print("   Kết quả: Không tìm thấy")
            
            else:
                # Các trường hợp khác trả về text hoặc số
                print(f"   Kết quả: {result}")
            
            print()
        except Exception as e:
            print(f"❌ Lỗi: {e}")
            print()

# Chạy tất cả queries
run_all_xpath_queries()