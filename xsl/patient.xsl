<?xml version="1.0"?>
<xsl:stylesheet version="1.0"
                xmlns:cab="http://test/cabinet"
                xmlns:pat="http://www.ujf-grenoble.fr/l3miage/patient"
                xmlns:act="http://www.ujf-grenoble.fr/l3miage/actes"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
                xsi:schemaLocation="http://www.ujf-grenoble.fr/l3miage/patient ../xsd/patient.xsd">

    <xsl:output method="xml"/>

    <xsl:param name="destinedName">Oscare</xsl:param>

    <xsl:variable name="actes" select="document('../xml/actes.xml')/act:ngap/act:actes"/>

    <xsl:template match="/">
        <patient>
            <xsl:apply-templates select="cab:cabinet/cab:patients/cab:patient[cab:prenom/text()=$destinedName]"/>
        </patient>
    </xsl:template>

    <xsl:template match="cab:patient">
        <nom>
            <xsl:value-of select="cab:nom"/>
        </nom>
        <prenom>
            <xsl:value-of select="cab:prenom"/>
        </prenom>
        <sexe>
            <xsl:value-of select="cab:sexe"/>
        </sexe>
        <naissance>
            <xsl:value-of select="cab:naissance"/>
        </naissance>
        <numeroSS>
            <xsl:value-of select="cab:numero"/>
        </numeroSS>
        <adresse>
            <rue><xsl:value-of select="cab:adresse/cab:rue"/></rue>
            <codePostal><xsl:value-of select="cab:adresse/cab:codePostal"/></codePostal>
            <ville><xsl:value-of select="cab:adresse/cab:ville"/></ville>
        </adresse>

        <xsl:apply-templates select="cab:visite">
            <xsl:sort select="@date"/>
        </xsl:apply-templates>
    </xsl:template>
        <xsl:template match="cab:visite">
            <xsl:variable name="InterID" select="@intervenant"/>
            <xsl:element name="visite">
                <xsl:attribute name="date">
                    <xsl:value-of select="@date"/>
                </xsl:attribute>
                <intervenant>
                    <nom>
                        <xsl:value-of select="/cab:cabinet/cab:infirmiers/cab:infirmier[@id=$InterID]/cab:nom"/>
                    </nom>
                    <prenom>
                        <xsl:value-of select="/cab:cabinet/cab:infirmiers/cab:infirmier[@id=$InterID]/cab:prenom"/>
                    </prenom>
                </intervenant>
                <acte>
                    <xsl:apply-templates select="cab:acte"/>
                </acte>
            </xsl:element>
        </xsl:template>

    <xsl:template match="cab:acte">
        <xsl:variable name="acte" select="@id"/>
        <xsl:value-of select="$actes/act:acte[@id=$acte]/text()"/>
    </xsl:template>

    <xsl:template match="text()"/>
</xsl:stylesheet>