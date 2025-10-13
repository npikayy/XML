import pymysql
from lxml import etree

# Kết nối database
conn = pymysql.connect(host='localhost', user='root', password='mysql', database='catalog')
cursor = conn.cursor()

# Tạo bảng
cursor.execute("CREATE TABLE IF NOT EXISTS categories (id VARCHAR(10) PRIMARY KEY, name VARCHAR(100))")
cursor.execute("""
    CREATE TABLE IF NOT EXISTS products (
        id VARCHAR(10) PRIMARY KEY, name VARCHAR(255), price DECIMAL(10,2),
        currency VARCHAR(10), stock INT, categoryRef VARCHAR(10),
        FOREIGN KEY (categoryRef) REFERENCES categories(id)
    )
""")

# Đọc XML và insert bằng XPath
tree = etree.parse('buoi6_NguyenPhucKhang/catalog.xml')

# Insert categories bằng XPath
for cat_id, cat_name in zip(
    tree.xpath('//categories/category/@id'),
    tree.xpath('//categories/category/text()')
):
    cursor.execute("INSERT IGNORE INTO categories VALUES (%s, %s)", (cat_id, cat_name))

# Insert products bằng XPath
for prod_id, category_ref, name, price, currency, stock in zip(
    tree.xpath('//products/product/@id'),
    tree.xpath('//products/product/@categoryRef'),
    tree.xpath('//products/product/name/text()'),
    tree.xpath('//products/product/price/text()'),
    tree.xpath('//products/product/price/@currency'),
    tree.xpath('//products/product/stock/text()')
):
    cursor.execute("INSERT IGNORE INTO products VALUES (%s, %s, %s, %s, %s, %s)", 
                  (prod_id, name, price, currency, stock, category_ref))

conn.commit()
print("✅ Đã insert dữ liệu từ XML vào database bằng XPath")

# Hiển thị kết quả
cursor.execute("SELECT * FROM categories")
print("\n📁 Categories:")
[print(f"  {row[0]}: {row[1]}") for row in cursor.fetchall()]

cursor.execute("SELECT * FROM products")
print("\n📦 Products:")
[print(f"  {row[0]}: {row[1]} - {row[2]}{row[3]}") for row in cursor.fetchall()]

cursor.close()
conn.close()