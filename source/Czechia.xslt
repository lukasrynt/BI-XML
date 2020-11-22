<?xml version="1.0"?>

<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:my="cz/cvut/fit/ryntluka/my">
    <xsl:output method="html" indent="yes"/>

    <xsl:variable name='newline'>
        <xsl:text>&#xa;</xsl:text>
    </xsl:variable>


    <xsl:template match="/state">
        <html lang="en">
            <head>
                <title><xsl:value-of select="@name"/></title>
                <link rel="stylesheet" href="../stylesheets/style.css"/>
                <script src="../js/script.js"/>
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
            <script src="../js/script.js"></script>
        </html>
    </xsl:template>

    <xsl:template match="/state/chapter">
        <h1><xsl:value-of select="@name"/></h1>
        <xsl:apply-templates select="section"/>
    </xsl:template>

    <xsl:template match="/state/chapter/section">
        <article class="section">
            <div class="collapsible">
                <h2><xsl:value-of select="@name"/></h2>
            </div>
            <div class="content">
                <xsl:apply-templates/>
            </div>
        </article>
    </xsl:template>

    <xsl:function name="my:format_data">
        <xsl:param name="node"/>
        <xsl:param name="inline"/>
        <xsl:if test="$inline=1">
            <xsl:value-of select="$node/@name"/>
        </xsl:if>
        <xsl:if test="$node/@value">
            <xsl:if test="$inline=1">
                <xsl:text>: </xsl:text>
            </xsl:if>
            <xsl:value-of select="$node/@value|$node/@unit" separator=" "/>
            <xsl:if test="$node/@year != ''">
                <xsl:text> (</xsl:text>
                <xsl:value-of select="$node/@year"/>
                <xsl:text>)</xsl:text>
            </xsl:if>
            <xsl:if test="$node/@description != ''">
                <xsl:text> (</xsl:text>
                <xsl:value-of select="$node/@year"/>
                <xsl:text>)</xsl:text>
            </xsl:if>
        </xsl:if>
    </xsl:function>

    <xsl:template match="paragraph">
        <p><xsl:value-of select="."/></p>
    </xsl:template>

    <xsl:template match="data">
        <p><xsl:value-of select="my:format_data(.,0)"/></p>
    </xsl:template>

    <xsl:template match="list">
        <xsl:if test="@name">
            <b><xsl:value-of select="@name"/>:</b>
        </xsl:if>
        <ul>
            <xsl:for-each select="item">
                <li>
                    <xsl:value-of select="my:format_data(., 1)"/>
                </li>
            </xsl:for-each>
        </ul>
    </xsl:template>

    <xsl:template match="subfield">
        <p>
            <b><xsl:value-of select="@name"/>: </b>
            <xsl:choose>
                <xsl:when test="@oneline='yes'">
                    <xsl:value-of select="my:format_data(., 0)"/>
                    <xsl:apply-templates/>
                </xsl:when>
                <xsl:otherwise>
                    <div class="tab">
                        <xsl:value-of select="my:format_data(., 0)"/>
                        <xsl:apply-templates/>
                    </div>
                </xsl:otherwise>
            </xsl:choose>
        </p>
    </xsl:template>

    <xsl:template match="img">
        <xsl:copy-of select="."/>
    </xsl:template>

    <xsl:template match="pdf">
        <a>
            <xsl:attribute name="href">
                <xsl:value-of select="@src"/>
            </xsl:attribute>
            <xsl:value-of select="@name"/>
        </a>
    </xsl:template>
</xsl:stylesheet>