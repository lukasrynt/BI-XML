<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:template match="/xxx">
        <xsl:value-of select="normalize-space(self::*)"/>
    </xsl:template>
</xsl:stylesheet>

