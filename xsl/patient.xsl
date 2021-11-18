<?xml version="1.0"?>
<xsl:stylesheet version="1.0"
            xmlns:cab="http://test/cabinet"
            xmlns:act="http://www.ujf-grenoble.fr/l3miage/actes"
            xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:output method="xml"/>
    <xsl:param name="destinedName" >Oscare</xsl:param>
    <xsl:variable name="actes" select="document('../xml/actes.xml')/act:ngap/act:actes"/>
    <xsl:template match="/">
        <patient>
            <xsl:apply-templates/>
        </patient>
    </xsl:template>
    <xsl:template match="cab:cabinet/cab:patients/cab:patient/cab:prenom[text()=$destinedName]">
        <nom><xsl:value-of select="../cab:nom"/></nom>
        <prenom><xsl:value-of select="../cab:prenom"/></prenom>
        <sexe><xsl:value-of select="../cab:sexe"/></sexe>
        <naissance><xsl:value-of select="../cab:naissance"/></naissance>
        <numeroSS><xsl:value-of select="../cab:numero"/></numeroSS>
        <xsl:copy-of select="../cab:adresse"/>
        <xsl:for-each select="../cab:visite">
            <xsl:sort select="@date"/>
        </xsl:for-each>
        <xsl:for-each select="../cab:visite/cab:acte">
            <xsl:variable name="acteID" select="@id"/>
            <xsl:variable name="InterID" select="../@intervenant"/>
            <xsl:element name="visite">
                <xsl:attribute name="date"><xsl:value-of select="../@date"/></xsl:attribute>
                <intervenant>
                    <nom><xsl:value-of select="/cab:cabinet/cab:infirmiers/cab:infirmier[@id=$InterID]/cab:nom"/></nom>
                    <prenom><xsl:value-of select="/cab:cabinet/cab:infirmiers/cab:infirmier[@id=$InterID]/cab:prenom"/></prenom>
                </intervenant>
                <acte>
                    <xsl:value-of select="$actes/act:acte[@id=$acteID]/text()"/>
                </acte>
            </xsl:element>
        </xsl:for-each>
    </xsl:template>

    <xsl:template match="text()"/>
</xsl:stylesheet>