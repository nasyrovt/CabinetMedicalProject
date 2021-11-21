<?xml version="1.0"?>
<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:cab="http://test/cabinet"
                xmlns:act="http://www.ujf-grenoble.fr/l3miage/actes">
    <xsl:output method="xml"/>
    <xsl:param name="destinedName" select="Fréchie"/>
    <xsl:variable name="actes" select="document('../xml/actes.xml')/act:ngap/act:actes"/>
    <xsl:template match="/cab:cabinet/cab:patients/cab:patient/cab:patient[cab:nom/text()=$destinedName]">
    
    </xsl:template>
    <xsl:template match="text()"/>
</xsl:stylesheet>