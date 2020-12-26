<?xml version="1.0"?>

<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:my="cz/cvut/fit/ryntluka/my">
    <xsl:import href="countries.xslt"/>
    <xsl:output method="html" indent="yes"/>

    <xsl:template match="/">
        <html lang="en">
            <head>
                <title>Index</title>
                <link rel="stylesheet" href="../stylesheets/index.css"/>
            </head>
            <body>
                <xsl:attribute name="class" select="my:country_short(@name)"/>
                <div class="column_articles">
                    <div class="divider">
                        <nav>
                            <xsl:apply-templates mode="nav" select="//country"/>
                        </nav>
                    </div>
                    <section>
                        <header>
                            <h1><xsl:value-of select="@name"/></h1>
                            <xsl:apply-templates select="intro"/>
                        </header>
                        <xsl:apply-templates select="chapter"/>
                    </section>
                    <div class="divider"/>
                </div>
            </body>
        </html>
    </xsl:template>

</xsl:stylesheet>