from lxml import etree

def main():
    # Đọc file XML
    tree = etree.parse('buoi5_NguyenPhucKhang/bai_2/quanlybanan.xml')
    root = tree.getroot()
    
    print("=== KẾT QUẢ TRUY VẤN QUẢN LÝ BÀN ĂN ===\n")
    
    # 1. Lấy tất cả bàn
    bans = root.xpath('//BAN')
    print(f"1. Tất cả bàn: {len(bans)} bàn")
    for ban in bans:
        soban = ban.find('SOBAN').text
        tenban = ban.find('TENBAN').text
        print(f"   - {soban}: {tenban}")
    
    # 2. Lấy tất cả nhân viên
    nhanviens = root.xpath('//NHANVIEN')
    print(f"\n2. Tất cả nhân viên: {len(nhanviens)} nhân viên")
    for nv in nhanviens:
        manv = nv.find('MANV').text
        tennv = nv.find('TENV').text
        print(f"   - {manv}: {tennv}")
    
    # 3. Lấy tất cả tên món
    tenmons = root.xpath('//MON/TENMON/text()')
    print(f"\n3. Tất cả tên món: {tenmons}")
    
    # 4. Lấy tên nhân viên có mã NV02
    tennv02 = root.xpath('//NHANVIEN[MANV="NV02"]/TENV/text()')
    print(f"\n4. Tên nhân viên NV02: {tennv02[0] if tennv02 else 'Không tìm thấy'}")
    
    # 5. Lấy tên và số điện thoại của nhân viên NV03
    nv03_info = root.xpath('//NHANVIEN[MANV="NV03"]')
    if nv03_info:
        nv03 = nv03_info[0]
        ten = nv03.find('TENV').text
        sdt = nv03.find('SDT').text
        print(f"\n5. Thông tin NV03: {ten} - {sdt}")
    
    # 6. Lấy tên món có giá > 50,000
    mon_dattien = root.xpath('//MON[GIA > 50000]/TENMON/text()')
    print(f"\n6. Món có giá > 50,000: {mon_dattien}")
    
    # 7. Lấy số bàn của hóa đơn HD03
    soban_hd03 = root.xpath('//HOADON[SOHD="HD03"]/SOBAN/text()')
    print(f"\n7. Số bàn của HD03: {soban_hd03[0] if soban_hd03 else 'Không tìm thấy'}")
    
    # 8. Lấy tên món có mã M02
    tenmon_m02 = root.xpath('//MON[MAMON="M02"]/TENMON/text()')
    print(f"\n8. Tên món M02: {tenmon_m02[0] if tenmon_m02 else 'Không tìm thấy'}")
    
    # 9. Lấy ngày lập của hóa đơn HD03
    ngaylap_hd03 = root.xpath('//HOADON[SOHD="HD03"]/NGAYLAP/text()')
    print(f"\n9. Ngày lập HD03: {ngaylap_hd03[0] if ngaylap_hd03 else 'Không tìm thấy'}")
    
    # 10. Lấy tất cả mã món trong hóa đơn HD01
    mamon_hd01 = root.xpath('//HOADON[SOHD="HD01"]//CTHD/MAMON/text()')
    print(f"\n10. Mã món trong HD01: {mamon_hd01}")
    
    # 11. Lấy tên món trong hóa đơn HD01
    tenmon_hd01 = root.xpath('//MON[MAMON=//HOADON[SOHD="HD01"]//CTHD/MAMON]/TENMON/text()')
    print(f"\n11. Tên món trong HD01: {tenmon_hd01}")
    
    # 12. Lấy tên nhân viên lập hóa đơn HD02
    manv_hd02 = root.xpath('//HOADON[SOHD="HD02"]/MANV/text()')
    if manv_hd02:
        tennv_hd02 = root.xpath(f'//NHANVIEN[MANV="{manv_hd02[0]}"]/TENV/text()')
        print(f"\n12. Nhân viên lập HD02: {tennv_hd02[0] if tennv_hd02 else 'Không tìm thấy'}")
    
    # 13. Đếm số bàn
    count_ban = root.xpath('count(//BAN)')
    print(f"\n13. Tổng số bàn: {int(count_ban)}")
    
    # 14. Đếm số hóa đơn lập bởi NV01
    count_hd_nv01 = root.xpath('count(//HOADON[MANV="NV01"])')
    print(f"\n14. Số hóa đơn lập bởi NV01: {int(count_hd_nv01)}")
    
    # 15. Lấy tên tất cả món có trong hóa đơn của bàn số 2
    tenmon_ban2 = root.xpath('//MON[MAMON=//HOADON[SOBAN="2"]//CTHD/MAMON]/TENMON/text()')
    print(f"\n15. Món trong hóa đơn bàn 2: {tenmon_ban2}")
    
    # 16. Lấy tất cả nhân viên từng lập hóa đơn cho bàn số 3
    nv_ban3 = root.xpath('//NHANVIEN[MANV=//HOADON[SOBAN="3"]/MANV]')
    print(f"\n16. Nhân viên lập HD cho bàn 3: {len(nv_ban3)} người")
    for nv in nv_ban3:
        print(f"   - {nv.find('MANV').text}: {nv.find('TENV').text}")
    
    # 17. Lấy tất cả hóa đơn mà nhân viên nữ lập
    hd_nu = root.xpath('//HOADON[MANV=//NHANVIEN[GIOITINH="Nữ"]/MANV]')
    print(f"\n17. Hóa đơn nhân viên nữ lập: {len(hd_nu)} hóa đơn")
    for hd in hd_nu:
        print(f"   - {hd.find('SOHD').text}: {hd.find('NGAYLAP').text}")
    
    # 18. Lấy tất cả nhân viên từng phục vụ bàn số 1
    nv_ban1 = root.xpath('//NHANVIEN[MANV=//HOADON[SOBAN="1"]/MANV]')
    print(f"\n18. Nhân viên phục vụ bàn 1: {len(nv_ban1)} người")
    for nv in nv_ban1:
        print(f"   - {nv.find('MANV').text}: {nv.find('TENV').text}")
    
    # 19. Lấy tất cả món được gọi nhiều hơn 1 lần trong các hóa đơn
    mon_nhieu = root.xpath('//MON[MAMON=//CTHD[SOLUONG > 1]/MAMON]/TENMON/text()')
    print(f"\n19. Món được gọi > 1 lần: {mon_nhieu}")
    
    # 20. Lấy tên bàn + ngày lập hóa đơn tương ứng SOHD='HD02'
    soban_hd02 = root.xpath('//HOADON[SOHD="HD02"]/SOBAN/text()')
    if soban_hd02:
        tenban_hd02 = root.xpath(f'//BAN[SOBAN="{soban_hd02[0]}"]/TENBAN/text()')
        ngaylap_hd02 = root.xpath('//HOADON[SOHD="HD02"]/NGAYLAP/text()')
        print(f"\n20. Thông tin HD02:")
        print(f"   - Tên bàn: {tenban_hd02[0] if tenban_hd02 else 'Không tìm thấy'}")
        print(f"   - Ngày lập: {ngaylap_hd02[0] if ngaylap_hd02 else 'Không tìm thấy'}")

if __name__ == "__main__":
    main()