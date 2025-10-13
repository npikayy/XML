<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:output method="text" encoding="UTF-8" indent="no"/>
    
    <xsl:template match="/">
        <xsl:text>{
  "students": [</xsl:text>
        
        <xsl:for-each select="/school/student">
            <xsl:text>
    {
      "id": "</xsl:text><xsl:value-of select="id"/><xsl:text>",
      "name": "</xsl:text><xsl:value-of select="name"/><xsl:text>",
      "birthDate": "</xsl:text><xsl:value-of select="date"/><xsl:text>"
    }</xsl:text>
            <xsl:if test="position() != last()">
                <xsl:text>,</xsl:text>
            </xsl:if>
        </xsl:for-each>
        
        <xsl:text>
  ]
}</xsl:text>
    </xsl:template>
</xsl:stylesheet>