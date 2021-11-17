<?xml version="1.0"?>
<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:cab="http://test/cabinet"
                xmlns:act="../xml/actes.xml">
    <xsl:output method="html"/>
    <xsl:param name="destinedId" select="003"/>
    <xsl:variable name="actes" select="document('actes.xml', /)/act:ngap"/>
    <xsl:template match="/">
        <html>
            <style>
                table, th, td {
                padding: 10px;
                border: 1px solid black;
                border-collapse: collapse;
                }
            </style>
            <head>
                <title>Cabinet Medical</title>
            </head>
            <body>
                <h2>Bonjour <xsl:value-of select="cab:cabinet/cab:infirmiers/cab:infirmier[@id=$destinedId]/cab:nom"/></h2>
                <h3>Aujourd'hui ,vous avez <xsl:value-of select="count(cab:cabinet/cab:patients/cab:patient/cab:visite[@intervenant=$destinedId])"/> patients</h3>
                <xsl:apply-templates/>
            </body>
        </html>
    </xsl:template>

    <xsl:template match="cab:cabinet/cab:patients">
        <table>
            <tr>
                <td>Patient</td>
                <td>Adresse</td>
                <td>Liste des soins</td>
            </tr>
            <xsl:for-each select="cab:patient">
            <tr>
                <td><xsl:value-of select="cab:nom/text()"/>  <xsl:value-of select="cab:prenom/text()"/></td>
                <td><xsl:apply-templates select="cab:patient/cab:adresse"/> </td>
                <td><xsl:apply-templates select="cab:patients"/></td>
            </tr>
            </xsl:for-each>
        </table>
    </xsl:template>
    <xsl:template match="cab:patient/cab:adresse">
        <p><xsl:value-of select="cab:numero"/> <xsl:value-of select="cab:rue"/>
            <p><xsl:value-of select="cab:codePostal"/> <xsl:value-of
                select="cab:ville"/>   <xsl:value-of select="cab:etage"/>
            </p>
        </p>
    </xsl:template>
    <xsl:template match="cab:patients">
        <xsl:for-each select="//cab:acte">
            <xsl:variable name="actePatient" select="cab:patient/cab:visite/cab:acte/@id"/>
            <xsl:for-each select="$actes/act:actes/act:acte">
                <xsl:value-of select="cab:acte[@id=$actePatient]"/>
            </xsl:for-each>
        </xsl:for-each>
    </xsl:template>
    <xsl:template match="text()"/>
</xsl:stylesheet>