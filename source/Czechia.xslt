<?xml version="1.0"?>

<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:output method="html" indent="yes"/>

    <xsl:template match="/state">
        <html lang="en">
            <head>
                <title><xsl:value-of select="@name"/></title>
                <link rel="stylesheet" href="style.css"/>
            </head>
            <body>
                <nav>
                </nav>
                <div class="column_articles">
                    <div class="divider"/>
                        <section>
                            <xsl:for-each select="chapter">
                                <article class="chapter">
                                    <xsl:apply-templates select="."/>
                                </article>
                            </xsl:for-each>
                        </section>
                    <div class="divider"/>
                </div>
            </body>
        </html>
    </xsl:template>

    <xsl:template match="chapter">
        <h1><xsl:value-of select="@name"/></h1>
        <xsl:apply-templates select="section"/>
    </xsl:template>

    <xsl:template match="section">
        <article class="section">
        <h2><xsl:value-of select="@name"/></h2>
            <xsl:for-each select="*">
                <xsl:value-of select="."/>
            </xsl:for-each>
        </article>
    </xsl:template>
</xsl:stylesheet>