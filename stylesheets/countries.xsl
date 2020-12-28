<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:my="cz/cvut/fit/ryntluka/my"
                xmlns:fo="http://www.w3.org/1999/XSL/Format">
    <xsl:output method="xml" indent="yes"/>

    <xsl:function name="my:country_short">
        <xsl:param name="name"/>
        <xsl:value-of select="tokenize(lower-case($name), ' ')[1]"/>
    </xsl:function>

    <xsl:template match="/countries">
        <fo:root>
            <fo:layout-master-set>
                <fo:simple-page-master master-name="simple"
                                       page-height="29.7cm" page-width="21.0cm" margin="1in">
                    <fo:region-body margin-bottom="15mm" margin-top="15mm"/>
                    <fo:region-before extent="10mm"/>
                    <fo:region-after extent="10mm"/>
                </fo:simple-page-master>
                <fo:simple-page-master master-name="intro"
                                       page-height="297mm" page-width="210mm" margin="1in">
                    <fo:region-body margin-bottom="15mm"/>
                    <fo:region-after extent="10mm"/>
                </fo:simple-page-master>
                <fo:page-sequence-master master-name="countries">
                    <fo:repeatable-page-master-alternatives>
                        <fo:conditional-page-master-reference master-reference="intro" page-position="first"/>
                        <fo:conditional-page-master-reference master-reference="simple" page-position="any"/>
                    </fo:repeatable-page-master-alternatives>
                </fo:page-sequence-master>
            </fo:layout-master-set>
            <fo:page-sequence master-reference="countries">
                <fo:static-content flow-name="xsl-region-after">
                    <fo:block font-size="6pt">
                        <xsl:text>Page </xsl:text>
                        <fo:page-number/>
                        <xsl:text> of </xsl:text>
                        <fo:page-number-citation ref-id="last_page"/>
                    </fo:block>
                </fo:static-content>
                <fo:static-content flow-name="xsl-region-before">
                    <xsl:apply-templates select="author"/>
                </fo:static-content>
                <fo:flow flow-name="xsl-region-body" font-family="Arial,Helvetica,sans-serif"
                         font-size="12pt">
                    <xsl:for-each select="country">
                        <xsl:apply-templates select="."/>
                    </xsl:for-each>
                </fo:flow>
            </fo:page-sequence>
        </fo:root>
    </xsl:template>

    <xsl:template match="author">
        <fo:block text-align-last="justify">
            <xsl:value-of select="@name"/>
            <xsl:text> </xsl:text>
            <xsl:value-of select="@surname"/>
            <xsl:text>, </xsl:text>
            <xsl:value-of select="@email"/>
        </fo:block>
    </xsl:template>

    <xsl:template match="country">
        <fo:block font-size="20pt" font-weight="bold">
            <xsl:value-of select="@name"/>
        </fo:block>
<!--        <xsl:apply-templates select="intro"/>-->
<!--        <xsl:apply-templates select="chapter"/>-->
    </xsl:template>

    <xsl:template mode="styles" match="//country">
        <xsl:element name="link">
            <xsl:attribute name="rel" select="'stylesheet'"/>
            <xsl:attribute name="href" select="concat('../design/', my:country_short(@name),'.css')"/>
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
        </xsl:if>
        <xsl:apply-templates select="$node/@year"/>
        <xsl:apply-templates select="$node/@*[contains(name(), 'description')]"/>
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

    <xsl:template match="link">
        <a>
            <xsl:attribute name="href">
                <xsl:value-of select="@src"/>
            </xsl:attribute>
            <xsl:value-of select="@value"/>
        </a>
    </xsl:template>
</xsl:stylesheet>