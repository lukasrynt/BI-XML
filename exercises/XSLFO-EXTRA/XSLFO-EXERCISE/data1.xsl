<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:fo="http://www.w3.org/1999/XSL/Format">
    <xsl:output method="xml" indent="yes"/>
    <xsl:template match="/">
        <fo:root>
            <fo:layout-master-set>
                <fo:simple-page-master master-name="A4-my"
                                       page-height="29.7cm" page-width="21.0cm" margin="1in">
                    <!-- obsah stránky -->
                    <fo:region-body margin-bottom="15mm" margin-top="15mm"/>

                    <!-- záhlaví stránky -->
                    <fo:region-before extent="10mm"/>

                    <!-- zápatí stránky -->
                    <fo:region-after extent="10mm"/>
                </fo:simple-page-master>
            </fo:layout-master-set>
            <fo:page-sequence master-reference="A4-my">
                <fo:static-content flow-name="xsl-region-after">
                    <fo:block>
                        <xsl:text>Page </xsl:text>
                        <fo:page-number/>
                        <xsl:text>/</xsl:text>
                        <fo:page-number-citation ref-id="last_page"/>
                    </fo:block>
                </fo:static-content>

                <fo:flow flow-name="xsl-region-body"
                         font-family="Arial,Helvetica,sans-serif"
                         font-size="12pt">
                    <xsl:apply-templates/>
                    <fo:block id="last_page"/>
                </fo:flow>
            </fo:page-sequence>
        </fo:root>
    </xsl:template>

    <xsl:template match="item">
        <fo:block keep-together.within-column="always">
            <xsl:apply-templates select="title"/>
            <fo:block text-align-last="justify" font-size="6pt"
                      space-after="1.5pt">
                <fo:block>
                    Producer: <fo:inline color="red"><xsl:value-of select="producer"/></fo:inline>
                </fo:block>
                <fo:block>
                    Price: <xsl:value-of select="price"/>
                    <xsl:text> </xsl:text>
                    <xsl:value-of select="price/@currency"/>
                </fo:block>
                <fo:block>
                    Category: <xsl:value-of select="category"/>
                </fo:block>
                <fo:block text-align="left" text-align-last="left">
                    <xsl:if test="description">
                       Description: <xsl:value-of select="description"/>
                    </xsl:if>
                </fo:block>
            </fo:block>
        </fo:block>

        <xsl:if test="following-sibling::item">
            <fo:block text-align-last="justify" space-after="0pt"
                      keep-with-next="always" clear="both">
                <fo:leader leader-pattern="rule"/>
            </fo:block>
        </xsl:if>
    </xsl:template>

    <xsl:template match="title">
        <fo:block font-size="14pt" font-weight="bold">
            <xsl:value-of select="."/>
        </fo:block>
    </xsl:template>
</xsl:stylesheet>