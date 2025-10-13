<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:output method="html" encoding="UTF-8" indent="no"/>
    <xsl:template match="/">
        <html>
            <head>
                <title>Quản lý bàn ăn</title>
                <style>
                    body {
                        font-family: Arial, sans-serif;
                        margin: 20px;
                    }
                    h2 {
                        text-align: center;
                        margin-bottom: 20px;
                    }
                    table {
                        border-collapse: collapse;
                        width: 80%;
                        margin: 20px auto;
                        border: 2px solid black;
                    }
                    th {
                        background-color: black;
                        color: white;
                        padding: 10px;
                        text-align: left;
                        border: 1px solid black;
                    }
                    td {
                        padding: 10px;
                        border: 1px solid black;
                    }
                    tr:nth-child(even) {
                        background-color: white;
                    }
                    tr:nth-child(odd) {
                        background-color: #f0f0f0;
                    }
                </style>
            </head>
            <body>
                <!-- ●	Hiển thị danh sách tất cả các bàn -->
                <h2>Danh sách bàn ăn</h2>
                <table>
                    <tr>
                        <th>STT</th>
                        <th>Số bàn</th>
                        <th>Tên bàn</th>
                    </tr>
                    <xsl:for-each select="QUANLY/BANS/BAN">
                        <tr>
                            <td>
                                <xsl:value-of select="position()"/>
                            </td>
                            <td>
                                <xsl:value-of select="SOBAN"/>
                            </td>
                            <td>
                                <xsl:value-of select="TENBAN"/>
                            </td>
                        </tr>
                    </xsl:for-each>
                </table>
                <!-- ●	Hiển thị danh sách các nhân viên -->
                <h2>Danh sách nhân viên</h2>
                <table>
                    <tr>
                        <th>STT</th>
                        <th>Mã NV</th>
                        <th>Tên NV</th>
                        <th>Số điện thoại</th>
                        <th>Giới tính</th>
                    </tr>
                    <xsl:apply-templates select="QUANLY/NHANVIENS/NHANVIEN"/>
                </table>
                <!-- ●	Hiển thị danh sách các món ăn -->
                <h2>Danh sách món ăn</h2>
                <table>
                    <tr>
                        <th>STT</th>
                        <th>Mã món</th>
                        <th>Tên món</th>
                        <th>Giá</th>
                        <th>Hình ảnh</th>
                    </tr>
                    <xsl:apply-templates select="QUANLY/MONS/MON"/>
                    </table>
                    <!-- ●	Hiển thị thông tin của nhân viên NV02 -->
                    <h2>Thông tin nhân viên NV02</h2>
                    <table>
                        <tr>
                            <th>Mã NV</th>
                            <th>Tên NV</th>
                            <th>Số điện thoại</th>
                            <th>Giới tính</th>
                        </tr>
                        <xsl:apply-templates select="QUANLY/NHANVIENS/NHANVIEN[MANV='NV02']"/>
                    </table>
                    <!-- ●	Hiển thị danh sách các món ăn có giá > 50,000 -->
                    <h2>Danh sách món ăn có giá lớn hơn 50,000</h2>
                    <table>
                        <tr>
                            <th>STT</th>
                            <th>Mã món</th>
                            <th>Tên món</th>
                            <th>Giá</th>
                            <th>Hình ảnh</th>
                        </tr>
                        <xsl:apply-templates select="QUANLY/MONS/MON[GIA &gt; 50000]"/>
                    </table>
                    <!-- ●	Hiển thị các thông tin liên quan đến hóa đơn HD03 gồm: tên nhân viên phục vụ, số bàn, ngày lập, tổng tiền -->
                    <h2>Thông tin hóa đơn HD03</h2>
                    <table>
                        <tr>
                            <th>STT</th>
                            <th>Tên nhân viên phục vụ</th>
                            <th>Số bàn</th>
                            <th>Ngày lập</th>
                            <th>Tổng tiền</th>
                        </tr>
                        <xsl:apply-templates select="QUANLY/HOADONS/HOADON[SOHD='HD03']"/>
                    </table>
                    <!-- ●	Hiển thị tên các món ăn trong trong hóa đơn HD02 -->
                    <h2>Tên các món ăn trong hóa đơn HD02</h2>
                    <table>
                        <tr>
                            <th>Tên món ăn</th>
                            <th>Số lượng</th>
                        </tr>
                        <xsl:for-each select="QUANLY/HOADONS/HOADON[SOHD='HD02']/CTHDS/CTHD">
                            <tr>
                                <xsl:variable name="mamondachon" select="MAMON"/>
                                <xsl:for-each select="/QUANLY/MONS/MON[MAMON=$mamondachon]">

                                    <td>
                                        <xsl:value-of select="TENMON"/>
                                    </td>

                                </xsl:for-each>
                                <td>
                                    <xsl:value-of select="SOLUONG"/>
                                </td>
                            </tr>
                        </xsl:for-each>
                    </table>
                    <!-- ●	Lấy tên nhân viên lập hóa đơn HD02 -->
                    <h2>Tên nhân viên lập hóa đơn HD02</h2>
                    <table>
                        <tr>
                            <th>Tên nhân viên</th>
                        </tr>
                        <xsl:for-each select="QUANLY/HOADONS/HOADON[SOHD='HD02']">
                            <xsl:variable name="manvlaphoadon" select="MANV"/>
                            <xsl:for-each select="/QUANLY/NHANVIENS/NHANVIEN[MANV=$manvlaphoadon]">
                                <tr>
                                    <td>
                                        <xsl:value-of select="TENV"/>
                                    </td>
                                </tr>
                            </xsl:for-each>
                        </xsl:for-each>
                    </table>
                    <!-- ●	Đếm số bàn  -->
                    <h2>Tổng số bàn ăn</h2>
                    <table>
                        <tr>
                            <th>Số bàn</th>
                        </tr>
                        <tr>
                            <td>
                                <xsl:value-of select="count(QUANLY/BANS/BAN)"/>
                            </td>
                        </tr>
                    </table>
                    <!-- ●	Đếm số hóa đơn lập bởi NV01 -->
                    <h2>Tổng số hóa đơn lập bởi NV01</h2>
                    <table>
                        <tr>
                            <th>Số hóa đơn</th>
                        </tr>
                        <tr>
                            <td>
                                <xsl:value-of select="count(QUANLY/HOADONS/HOADON[MANV='NV01'])"/>
                            </td>
                        </tr>
                    </table>
                    <!-- ●	Hiển thị danh sách các món từng bán cho bàn số 2 -->
                    <h2>Danh sách món ăn từng bán cho bàn số 2</h2>
                    <table>
                        <tr>
                            <th>Tên món ăn</th>
                            <th>Số lượng</th>
                        </tr>
                        <xsl:for-each select="QUANLY/HOADONS/HOADON[SOBAN='2']/CTHDS/CTHD">
                            <tr>
                                <xsl:variable name="mamondachon" select="MAMON"/>
                                <xsl:for-each select="/QUANLY/MONS/MON[MAMON=$mamondachon]">

                                    <td>
                                        <xsl:value-of select="TENMON"/>
                                    </td>

                                </xsl:for-each>
                                <td>
                                    <xsl:value-of select="SOLUONG"/>
                                </td>
                            </tr>
                        </xsl:for-each>
                    </table>
                    <!-- ●	Hiển thị danh sách nhân viên từng lập hóa đơn cho bàn số 3 -->
                    <h2>Danh sách nhân viên từng lập hóa đơn cho bàn số 3</h2>
                    <table>
                        <tr>
                            <th>Tên nhân viên</th>
                        </tr>
                        <xsl:for-each select="QUANLY/HOADONS/HOADON[SOBAN='3']">
                            <xsl:variable name="manvlaphoadon" select="MANV"/>
                            <xsl:for-each select="/QUANLY/NHANVIENS/NHANVIEN[MANV=$manvlaphoadon]">
                                <tr>
                                    <td>
                                        <xsl:value-of select="TENV"/>
                                    </td>
                                </tr>
                            </xsl:for-each>
                        </xsl:for-each>
                    </table>
                    <!-- ●	Hiển thị các món ăn được gọi nhiều hơn 1 lần trong các hóa đơn -->
                    <h2>Các món ăn được gọi nhiều hơn 1 lần trong các hóa đơn</h2>
                    <table>
                        <tr>
                            <th>Tên món ăn</th>
                            <th>Số lần gọi</th>
                        </tr>
                        <xsl:for-each select="QUANLY/MONS/MON">
                            <xsl:variable name="mamondachon" select="MAMON"/>
                            <xsl:variable name="solanngoi" select="count(/QUANLY/HOADONS/HOADON/CTHDS/CTHD[MAMON=$mamondachon])"/>
                            <xsl:if test="$solanngoi &gt; 1">
                                <tr>
                                    <td>
                                        <xsl:value-of select="TENMON"/>
                                    </td>
                                    <td>
                                        <xsl:value-of select="$solanngoi"/>
                                    </td>
                                </tr>
                            </xsl:if>
                        </xsl:for-each>
                    </table>
            </body>
        </html>
    </xsl:template>

    <xsl:template match="MON">
        <tr>
            <td>
                <xsl:value-of select="position()"/>
            </td>
            <td>
                <xsl:value-of select="MAMON"/>
            </td>
            <td>
                <xsl:value-of select="TENMON"/>
            </td>
            <td>
                <xsl:value-of select="GIA"/>
            </td>
            <td>
                <xsl:value-of select="HINHANH"/>
            </td>
        </tr>
    </xsl:template>

    <xsl:template match="NHANVIEN">
        <tr>
            <td>
                <xsl:value-of select="MANV"/>
            </td>
            <td>
                <xsl:value-of select="TENV"/>
            </td>
            <td>
                <xsl:value-of select="SDT"/>
            </td>
            <td>
                <xsl:value-of select="GIOITINH"/>
            </td>
        </tr>
    </xsl:template>
    <xsl:template match="HOADON">
        <tr>
            <td>
                <xsl:value-of select="position()"/>
            </td>
            <td>
                <xsl:value-of select="MANV"/>
            </td>
            <td>
                <xsl:value-of select="SOBAN"/>
            </td>
            <td>
                <xsl:value-of select="NGAYLAP"/>
            </td>
            <td>
                <xsl:value-of select="TONGTIEN"/>
            </td>
        </tr>
    </xsl:template>
</xsl:stylesheet>