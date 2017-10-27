<xsl:stylesheet
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform" exclude-result-prefixes="exsl xd string" version="1.0"
    xmlns:exsl="http://exslt.org/common"
    xmlns:string="my:string"
    xmlns:xd="http://www.pnp-software.com/XSLTdoc">
    <xsl:import href="site://UAS/_assets/stylesheets/bert/bs3/default.xslt"/>
    <xsl:template match="/system-data-structure">
        <xsl:variable name="sCaption">
            <xsl:choose>
                <xsl:when test="normalize-space(image/display-name) != ''">
                    <xsl:value-of select="normalize-space(image/display-name)" />
                </xsl:when>
                <xsl:when test="normalize-space(image/title) != ''">
                    <xsl:value-of select="normalize-space(image/title)" />
                </xsl:when>
            </xsl:choose>
        </xsl:variable>

        <xsl:variable name="rtfDropdown">
            <xsl:apply-templates select="faq" />
        </xsl:variable>

        <xsl:variable name="rtfFaq">
            <xsl:for-each select="exsl:node-set($rtfDropdown)">
                <xsl:call-template name="dropdown" />
            </xsl:for-each>
        </xsl:variable>

        <div id="mainContent">
            <xsl:if test="image[path != '/']">
                <div class="internprogram-featured-image thumbnail">
                    <img alt="{image/display-name}" src="{image/path}"/>
                    <xsl:if test="$sCaption != ''">
                        <div class="caption">
                            <xsl:value-of select="$sCaption" />
                        </div>
                    </xsl:if>
                </div>
            </xsl:if>

            <xsl:copy-of select="$rtfFaq" />

            <xsl:call-template name="paragraph-wrap">
                <xsl:with-param name="nodeToWrap" select="content"/>
            </xsl:call-template>
        </div>
    </xsl:template>

    <xsl:template match="faq">
        <dropdown>
            <xsl:copy-of select="*" />
        </dropdown>
    </xsl:template>
</xsl:stylesheet>
