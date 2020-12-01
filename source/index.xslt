<?xml version="1.0"?>

<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:output method="html" indent="yes"/>

    <xsl:template match="country">
        <p><xsl:value-of select="@name"/></p>
    </xsl:template>

</xsl:stylesheet>