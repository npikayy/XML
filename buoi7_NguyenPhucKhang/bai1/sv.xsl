<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:output method="html" encoding="UTF-8" indent="yes"/>
    
    <xsl:template match="/">
        <html>
            <head>
                <title>Student Lists</title>
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
                <!-- ●	Liệt kê thông tin của tất cả sinh viên gồm mã và họ tên -->
                <h2>Danh sách sinh viên</h2>
                <table>
                    <tr>
                        <th>Mã SV</th>
                        <th>Họ và Tên</th>
                    </tr>
                    <xsl:apply-templates select="/school/student" mode="basic"/>
                </table>
                
                <!-- ●	Liệt kê danh sách sinh viên gồm mã, tên, điểm. Sắp xếp danh sách theo điểm từ cao đến thấp -->
                <h2>Danh sách sinh viên theo điểm</h2>
                <table>
                    <tr>
                        <th>Mã SV</th>
                        <th>Họ và Tên</th>
                        <th>Điểm</th>
                    </tr>
                    <xsl:apply-templates select="/school/student" mode="grade">
                        <xsl:sort select="grade" data-type="number" order="descending"/>
                    </xsl:apply-templates>
                </table>

                <!-- ●	Hiển thị danh sách sinh viên sinh tháng gần nhau, danh sách gồm: Số thứ tự, Họ tên, ngày sinh. -->
                 <h2>Danh sách sinh viên theo tháng sinh</h2>
                <xsl:for-each select="/school/student">
                    <xsl:sort select="substring(date, 6, 2)" data-type="number"/>
                    <xsl:variable name="currentMonth" select="substring(date, 6, 2)"/>
                    
                    <xsl:if test="not(preceding-sibling::student[substring(date, 6, 2) = $currentMonth])">
                        <table border="1">
                            <tr>
                                <th>STT</th>
                                <th>Họ tên</th>
                                <th>Ngày sinh</th>
                            </tr>
                            <xsl:apply-templates select="/school/student[substring(date, 6, 2) = $currentMonth]" mode="month"/>
                        </table>
                    </xsl:if>
                </xsl:for-each>
                <!-- ●	Hiển thị danh sách các khóa học có sinh viên học. Sắp xếp theo khóa học -->
                <h2>Danh sách các khóa học có sinh viên học</h2>
                <table>
                    <tr>
                        <th>Mã Khóa Học</th>
                        <th>Tên Khóa Học</th>
                    </tr>
                    <xsl:for-each select="/school/course">
                        <xsl:sort select="name"/>
                        <xsl:if test="id = /school/enrollment/courseRef">
                            <tr>
                                <td><xsl:value-of select="id"/></td>
                                <td><xsl:value-of select="name"/></td>
                            </tr>
                        </xsl:if>
                    </xsl:for-each>
                </table>
                <!-- ●	Lấy danh sách sinh viên đăng ký khóa học "Hóa học 201" -->
                <h2>Danh sách sinh viên đăng ký khóa học "Hóa học 201"</h2>
                <table>
                    <tr>
                        <th>Mã SV</th>
                        <th>Họ và Tên</th>
                    </tr>
                    <xsl:for-each select="/school/enrollment[courseRef='c3']">
                        <xsl:variable name="studentId" select="studentRef"/>
                        <xsl:for-each select="/school/student[id=$studentId]">
                            <tr>
                                <td><xsl:value-of select="id"/></td>
                                <td><xsl:value-of select="name"/></td>
                            </tr>
                        </xsl:for-each>
                    </xsl:for-each>
                </table>
                <!-- ●	Lấy danh sách của sinh viên sinh năm 1997 -->
                <h2>Danh sách sinh viên sinh năm 1997</h2>
                <table>
                    <tr>
                        <th>Mã SV</th>
                        <th>Họ và Tên</th>
                        <th>Ngày sinh</th>
                    </tr>
                    <xsl:apply-templates select="/school/student[substring(date, 1, 4)='1997']" mode="year1997"/>
                </table>
                <!-- ●	Thống kê danh sách sinh viên họ “Trần” -->
                <h2>Danh sách sinh viên họ "Trần"</h2>
                <table>
                    <tr>
                        <th>Mã SV</th>
                        <th>Họ và Tên</th>
                    </tr>
                    <xsl:for-each select="/school/student[starts-with(name, 'Trần')]">
                        <tr>
                            <td><xsl:value-of select="id"/></td>
                            <td><xsl:value-of select="name"/></td>
                        </tr>
                    </xsl:for-each>
                </table>
            </body>
        </html>
    </xsl:template>
    <!-- Template cho bài 1: Chỉ mã và tên -->
    <xsl:template match="student" mode="basic">
        <tr>
            <td><xsl:value-of select="id"/></td>
            <td><xsl:value-of select="name"/></td>
        </tr>
    </xsl:template>
    
    <!-- Template cho bài 2: Có điểm và sắp xếp -->
    <xsl:template match="student" mode="grade">
        <tr>
            <td><xsl:value-of select="id"/></td>
            <td><xsl:value-of select="name"/></td>
            <td><xsl:value-of select="grade"/></td>
        </tr>
    </xsl:template>

    <!-- Template cho mỗi sinh viên -->
    <xsl:template match="student" mode="month">
        <tr>
            <td><xsl:value-of select="position()"/></td>
            <td><xsl:value-of select="name"/></td>
            <td><xsl:value-of select="date"/></td>
        </tr>
    </xsl:template>
    <xsl:template match="student" mode="year1997">
        <tr>
            <td><xsl:value-of select="id"/></td>
            <td><xsl:value-of select="name"/></td>
            <td><xsl:value-of select="date"/></td>
        </tr>
    </xsl:template>
</xsl:stylesheet>