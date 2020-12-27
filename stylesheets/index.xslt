<?xml version="1.0"?>

<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:my="cz/cvut/fit/ryntluka/my">
    <xsl:import href="countries.xslt"/>
    <xsl:output method="html" indent="yes"/>

    <xsl:template match="/countries">
        <html lang="en">
            <head>
                <title>Index</title>
                <link rel="stylesheet" href="../design/main.css"/>
                <link rel="stylesheet" href="../design/index.css"/>
            </head>
            <body class="index">
                <div class="column_articles">
                    <div class="divider"/>
                    <section>
                        <h1>Countries - semestral work for BI-XML</h1>
                        <xsl:apply-templates mode="nav" select="//country"/>
                        <xsl:apply-templates select="author"/>
                    </section>
                    <div class="divider"/>
                </div>
            </body>
        </html>
    </xsl:template>

</xsl:stylesheet>