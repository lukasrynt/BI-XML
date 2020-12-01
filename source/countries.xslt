<?xml version="1.0"?>

<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:my="cz/cvut/fit/ryntluka/my">
    <xsl:output method="html" indent="yes"/>

    <xsl:function name="my:country_short">
        <xsl:param name="name"/>
        <xsl:value-of select="tokenize(lower-case($name), ' ')[1]"/>
    </xsl:function>

    <xsl:template match="/countries">
        <xsl:for-each select="country">
            <xsl:result-document method="html" indent="yes" href="build/{my:country_short(@name)}.html">
                <xsl:apply-templates select="."/>
            </xsl:result-document>
        </xsl:for-each>
    </xsl:template>


    <xsl:template match="country">
        <html lang="en">
            <head>
                <title><xsl:value-of select="@name"/></title>
                <link rel="stylesheet" href="../stylesheets/main.css"/>
                <xsl:apply-templates mode="styles" select="//country"/>
                <script src="../js/script.js"/>
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
            <script src="../js/script.js"/>
        </html>
    </xsl:template>

    <xsl:template mode="styles" match="//country">
        <xsl:element name="link">
            <xsl:attribute name="rel" select="'stylesheet'"/>
            <xsl:attribute name="href" select="concat('../stylesheets/', my:country_short(@name),'.css')"/>
        </xsl:element>
    </xsl:template>

    <xsl:template mode="nav" match="//country">
        <a class="nav_item">
            <xsl:attribute name="href">
                <xsl:value-of select="concat(my:country_short(@name),'.html')"/>
            </xsl:attribute>
            <xsl:value-of select="@name"/>
        </a>
    </xsl:template>

    <xsl:template match="intro">
        <div class="intro">
            <xsl:for-each select="img">
                <div class="img-wrap">
                    <xsl:apply-templates select="."/>
                </div>
            </xsl:for-each>
        </div>
    </xsl:template>

    <xsl:template match="country/chapter">
        <article class="chapter">
            <h2><xsl:value-of select="@name"/></h2>
            <xsl:apply-templates select="section"/>
        </article>
    </xsl:template>

    <xsl:template match="country/chapter/section">
        <article class="section">
            <div class="collapsible">
                <h3><xsl:value-of select="@name"/></h3>
            </div>
            <div class="content">
                <xsl:value-of select="text()"/>
                <xsl:apply-templates select="*"/>
                <xsl:apply-templates select="@*[name() != 'name']"/>
            </div>
        </article>
    </xsl:template>

    <xsl:function name="my:format_data">
        <xsl:param name="node"/>
        <xsl:param name="inline"/>
        <xsl:if test="$inline=1 and $node/@name">
            <xsl:value-of select="$node/@name"/>
        </xsl:if>
        <xsl:if test="$node/@value">
            <xsl:if test="$inline=1 and $node/@name">
                <xsl:text>: </xsl:text>
            </xsl:if>
            <xsl:value-of select="$node/@value|$node/@unit" separator=" "/>
            <xsl:apply-templates select="$node/@year"/>
            <xsl:apply-templates select="$node/@*[contains(name(), 'description')]"/>
        </xsl:if>
    </xsl:function>

    <xsl:template match="@year | @*[contains(name(), 'description')]">
        <xsl:text> (</xsl:text>
        <xsl:value-of select="."/>
        <xsl:text>)</xsl:text>
    </xsl:template>

    <xsl:template match="paragraph">
        <p><xsl:value-of select="."/><xsl:apply-templates select="@*"/></p>
    </xsl:template>

    <xsl:template match="@value">
        <xsl:value-of select="."/>
    </xsl:template>

    <xsl:template match="data">
        <p><xsl:value-of select="my:format_data(.,0)"/></p>
    </xsl:template>

    <xsl:template match="list">
        <xsl:variable name="ls_name">
            <xsl:choose>
                <xsl:when test="@name">
                    <xsl:value-of select="@name"/>
                </xsl:when>
                <xsl:when test="name(*[1]) != 'item'">
                    <xsl:value-of select="concat(name(*[1]), 's')"/>
                </xsl:when>
            </xsl:choose>
        </xsl:variable>

        <xsl:if test="$ls_name!=''">
            <b><xsl:value-of select="$ls_name"/>:</b>
        </xsl:if>
        <ul>
            <xsl:for-each select="*">
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

    <xsl:template match="img|audio">
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