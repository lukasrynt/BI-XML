<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:my="cz/cvut/fit/ryntluka/my"
                xmlns:fo="http://www.w3.org/1999/XSL/Format">
    <xsl:output method="xml" indent="yes"/>

    <xsl:function name="my:country_short">
        <xsl:param name="name"/>
        <xsl:value-of select="tokenize(lower-case($name), ' ')[1]"/>
    </xsl:function>

    <xsl:template match="/">
        <fo:root>
            <fo:layout-master-set>
                <xsl:call-template name="layout"/>
            </fo:layout-master-set>

            <fo:page-sequence master-reference="intro">
                <xsl:call-template name="intro"/>
            </fo:page-sequence>

            <fo:page-sequence master-reference="content">
                <fo:flow flow-name="xsl-region-body">
                    <xsl:apply-templates select="countries/country | countries/country/chapter" mode="toc"/>
                </fo:flow>
            </fo:page-sequence>

            <fo:page-sequence master-reference="simple" id="{generate-id(.)}">
                <xsl:apply-templates select="/countries"/>
            </fo:page-sequence>
        </fo:root>
    </xsl:template>

    <xsl:template name="layout">
        <fo:simple-page-master master-name="simple"
                               page-height="29.7cm" page-width="21.0cm" margin="1in">
            <fo:region-body margin-bottom="15mm" margin-top="15mm"/>
            <fo:region-before extent="10mm"/>
            <fo:region-after extent="10mm"/>
        </fo:simple-page-master>
        <fo:simple-page-master master-name="intro"
                               page-height="297mm" page-width="210mm" margin="1in">
            <fo:region-body margin-bottom="15mm"/>
        </fo:simple-page-master>
        <fo:simple-page-master master-name="content"
                               page-height="297mm" page-width="210mm" margin="1in">
            <fo:region-body margin-bottom="15mm" margin-top="15mm"/>
            <fo:region-after extent="10mm"/>
        </fo:simple-page-master>
    </xsl:template>

    <xsl:template name="intro">
        <fo:flow flow-name="xsl-region-body">
            <fo:block font-size="50pt" text-align="center" font-weight="bold">
                <xsl:text>Semestral Work BI-XML</xsl:text>
                <fo:block text-align-last="justify">
                    <fo:leader leader-pattern="rule"/>
                </fo:block>
            </fo:block>
            <fo:block font-size="40pt" text-align="center" font-weight="bold" keep-with-previous.within-page="always">
                <fo:inline color="gray"><xsl:text>Countries</xsl:text></fo:inline>
                <fo:block text-align-last="justify" keep-with-previous.within-page="always">
                    <fo:leader leader-pattern="rule"/>
                </fo:block>
            </fo:block>
            <fo:block font-size="10pt" text-align="center">
                <xsl:apply-templates select="/countries/author"/>
            </fo:block>
        </fo:flow>
    </xsl:template>

    <xsl:template match="/countries">
        <fo:static-content flow-name="xsl-region-after">
            <fo:block font-size="6pt" text-align="center">
                <xsl:text>Page </xsl:text>
                <fo:page-number/>
                <xsl:text> of </xsl:text>
                <fo:page-number-citation ref-id="last_page"/>
            </fo:block>
        </fo:static-content>
        <fo:static-content flow-name="xsl-region-before">
            <fo:block text-align="center" font-size="6pt">
                <xsl:apply-templates select="author"/>
            </fo:block>
        </fo:static-content>
        <fo:flow flow-name="xsl-region-body" font-family="Arial,Helvetica,sans-serif"
                 font-size="12pt">
            <xsl:if test='position() = 1'>
                <xsl:attribute name='initial-page-number'>1</xsl:attribute>
            </xsl:if>
            <xsl:for-each select="country">
                <xsl:apply-templates select="."/>
            </xsl:for-each>
            <fo:block id="last_page"/>
        </fo:flow>
    </xsl:template>

    <xsl:template match="author">
            <xsl:value-of select="@name"/>
            <xsl:text> </xsl:text>
            <xsl:value-of select="@surname"/>
            <xsl:text>, </xsl:text>
            <xsl:value-of select="@email"/>
    </xsl:template>

    <xsl:template match="country" mode="toc">
        <fo:block text-align='justify' text-align-last="justify" space-after="3pt" keep-with-next="always">
            <fo:basic-link>
                <xsl:variable name="country-number">
                    <xsl:number level="multiple" count="country" format="1.1.1. "/>
                </xsl:variable>

                <xsl:variable name="reference">
                    <xsl:number level="multiple" count="country" format="1.1"/>
                </xsl:variable>

                <xsl:attribute name='internal-destination'>chapter-refid-<xsl:value-of select="$reference"/></xsl:attribute>

                <xsl:value-of select="$country-number"/>
                <xsl:value-of select='@name'/>

                &#160;
                <fo:leader leader-pattern='dots' rule-thickness='.2pt'
                           leader-alignment='reference-area' font-size="10pt"/>
                &#160;

                <fo:page-number-citation>
                    <xsl:attribute name='ref-id'>chapter-refid-<xsl:value-of select="$reference"/></xsl:attribute>
                </fo:page-number-citation>

            </fo:basic-link>

        </fo:block>
    </xsl:template>

    <xsl:template match="chapter" mode='toc'>
        <fo:block text-align='justify' text-align-last="justify" space-after="3pt" margin-left="1cm"
                  margin-right='.1cm'  font-size='0.9em'>

            <xsl:variable name="country-number">
                <xsl:number level="multiple" count="country | chapter" format="1.1. "/>
            </xsl:variable>

            <xsl:variable name="reference">
                <xsl:number level="multiple" count="country | chapter" format="1.1"/>
            </xsl:variable>
            <fo:basic-link>
                <xsl:attribute name='internal-destination'>chapter-refid-<xsl:value-of select="$reference"/></xsl:attribute>

                <xsl:value-of select='$country-number'/>
                <xsl:value-of select="@name"/>
                &#160;
                <fo:leader leader-pattern='dots' rule-thickness='.2pt'
                           leader-alignment='reference-area' font-size="10pt"/>
                &#160;

                <fo:page-number-citation>
                    <xsl:attribute name='ref-id'>chapter-refid-<xsl:value-of select="$reference"/></xsl:attribute>
                </fo:page-number-citation>
            </fo:basic-link>
        </fo:block>
    </xsl:template>

    <xsl:template match="country">
        <xsl:variable name="reference">
            <xsl:number level="multiple" count="country | chapter" format="1.1"/>
        </xsl:variable>
        <fo:block font-size="30pt" font-weight="bold" text-align="center" space-after="0">
            <xsl:attribute name='id'>chapter-refid-<xsl:value-of select="$reference"/></xsl:attribute>
            <xsl:value-of select="@name"/>
        </fo:block>
        <fo:block text-align-last="justify" keep-with-previous.within-page="always">
            <fo:leader leader-pattern="rule"/>
        </fo:block>
        <xsl:apply-templates select="intro | chapter"/>
    </xsl:template>

    <xsl:template match="intro">
        <fo:block text-align="center" keep-with-previous.within-page="always">
            <xsl:for-each select="img">
                <fo:external-graphic src="url({@src})" width="40%"
                    scaling="uniform" content-width="scale-to-fit"/>
            </xsl:for-each>
        </fo:block>
    </xsl:template>

    <xsl:template match="//img">
        <fo:block>
            <fo:external-graphic src="url({@src})" width="40%"/>
        </fo:block>
    </xsl:template>

    <xsl:template match="country/chapter">
        <xsl:variable name="reference">
            <xsl:number level="multiple" count="country | chapter" format="1.1"/>
        </xsl:variable>
        <fo:block keep-with-next.within-page="always" font-weight="bolder" font-size="30pt" color="#333333">
            <xsl:attribute name='id'>chapter-refid-<xsl:value-of select="$reference"/></xsl:attribute>
            <xsl:value-of select="@name"/>
        </fo:block>
        <xsl:apply-templates select="section"/>
    </xsl:template>

    <xsl:template match="country/chapter/section">
        <fo:block font-weight="bold" font-size="20pt" color="#999999">
            <xsl:value-of select="@name"/>
        </fo:block>
        <fo:block keep-with-previous.within-page="always">
            <xsl:value-of select="text()"/>
            <xsl:apply-templates select="*"/>
            <xsl:apply-templates select="@*[name() != 'name']"/>
        </fo:block>
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
        <fo:block text-align="justify">
            <xsl:value-of select="."/><xsl:apply-templates select="@*"/>
        </fo:block>
    </xsl:template>

    <xsl:template match="@value">
        <xsl:value-of select="."/>
    </xsl:template>

    <xsl:template match="data">
        <fo:block><xsl:value-of select="my:format_data(.,0)"/></fo:block>
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
            <fo:inline font-weight="bold"><xsl:value-of select="$ls_name"/>:</fo:inline>
        </xsl:if>
        <fo:list-block provisional-distance-between-starts="1em"
                       text-align="justify">
            <xsl:for-each select="*">
                <fo:list-item>
                    <fo:list-item-label end-indent="label-end()">
                        <fo:block>&#x2022;</fo:block>
                    </fo:list-item-label>
                    <fo:list-item-body start-indent="body-start()">
                        <fo:block><xsl:value-of select="my:format_data(., 1)"/></fo:block>
                    </fo:list-item-body>
                </fo:list-item>
            </xsl:for-each>
        </fo:list-block>
    </xsl:template>

    <xsl:template match="subfield">
        <fo:inline font-weight="bold"><xsl:value-of select="@name"/>: </fo:inline>
        <fo:block start-indent="1em">
            <fo:inline><xsl:value-of select="my:format_data(., 0)"/></fo:inline>
            <xsl:apply-templates/>
        </fo:block>
    </xsl:template>

    <xsl:template match="link">
        <fo:block>
            <fo:basic-link color="blue">
                <xsl:attribute name="external-destination">
                    <xsl:value-of select="@src"/>
                </xsl:attribute>
                <xsl:value-of select="@value"/>
            </fo:basic-link>
        </fo:block>
    </xsl:template>
</xsl:stylesheet>