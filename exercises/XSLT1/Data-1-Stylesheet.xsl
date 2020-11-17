<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl='http://www.w3.org/1999/XSL/Transform' version="1.0">

<xsl:output method="html"/>

<xsl:template match="/">
    <html>
        <head>
            <title><xsl:value-of select="/article/articleinfo/title"/></title>
        </head>
        <body>
            <xsl:apply-templates/>
        </body>
    </html>
</xsl:template>

</xsl:stylesheet>
