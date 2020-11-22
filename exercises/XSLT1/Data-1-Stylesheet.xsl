<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl='http://www.w3.org/1999/XSL/Transform' version="1.0">

    <xsl:output method="html"/>

    <xsl:template match="/">
        <html>
            <head>
                <title><xsl:value-of select="/article/articleinfo/title"/></title>
                <xsl:apply-templates/>
            </head>
            <body>
                <xsl:apply-templates select="/article/sect1"/>
            </body>
        </html>
    </xsl:template>

    <xsl:template match="/article/articleinfo/*[position() != last()]">
        <meta>
            <xsl:attribute name="{name(.)}"><xsl:value-of select="."/></xsl:attribute>
        </meta>
    </xsl:template>

    <xsl:template match="/article/sect1">
        <section>
            <xsl:apply-templates />
        </section>
    </xsl:template>

    <xsl:template match="//sect2">
        <article>
            <xsl:value-of select="."/>
        </article>
    </xsl:template>

    <xsl:template match="//title">
        <h1><xsl:value-of select="."/></h1>
    </xsl:template>

    <xsl:template match="//para">
        <p>
            <xsl:apply-templates/>
            <xsl:value-of select="."/>
        </p>
    </xsl:template>

    <xsl:template match="//ulink | //email">
        <a>
            <xsl:attribute name="href"><xsl:value-of select="@url"/></xsl:attribute>
            <xsl:value-of select="."/>
        </a>
    </xsl:template>

    <xsl:template match="//itemizedlist">
        <ul><xsl:apply-templates select="listitem"/></ul>
    </xsl:template>

    <xsl:template match="//itemizedlist/listitem">
        <li><xsl:apply-templates/></li>
    </xsl:template>

</xsl:stylesheet>
