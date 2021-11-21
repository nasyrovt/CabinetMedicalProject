<?xml version="1.0"?>
<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:cab="http://test/cabinet"
                xmlns:act="http://www.ujf-grenoble.fr/l3miage/actes">
    <xsl:output method="html"/>
    <xsl:param name="destinedId" select="001"/>
    <xsl:variable name="actes" select="document('../xml/actes.xml')/act:ngap/act:actes"/>
    <xsl:template match="/">
        <html>
            <head>
                <title>Cabinet Medical</title>
                <link rel="stylesheet" href="../stylesheets/infirmierPage.css"/>
            </head>
            <body>
                <h2>Bonjour <xsl:value-of select="cab:cabinet/cab:infirmiers/cab:infirmier[@id=$destinedId]/cab:nom"/></h2>
                <h3>Aujourd'hui ,vous avez <xsl:value-of select="count(cab:cabinet/cab:patients/cab:patient/cab:visite[@intervenant=$destinedId])"/> patients</h3>
                <xsl:apply-templates select="cab:cabinet/cab:patients"/>
                <xsl:element name="script">
                    <xsl:attribute name="type">text/javascript</xsl:attribute>
                    <xsl:attribute name="src">../scripts/buttonScript.js</xsl:attribute>
                </xsl:element>
            </body>
        </html>
    </xsl:template>

    <xsl:template match="cab:cabinet/cab:patients">
        <table>
            <tr>
                <td>Patient</td>
                <td>Adresse</td>
                <td>Liste des soins</td>
                <td>Facture</td>
            </tr>
            <xsl:for-each select="cab:patient[cab:visite/@intervenant=$destinedId]">
                <tr>
                    <td><xsl:value-of select="cab:nom/text()"/>  <xsl:value-of select="cab:prenom/text()"/></td>
                    <td><xsl:apply-templates select="cab:adresse"/> </td>
                    <td><xsl:apply-templates select="cab:visite"/></td>
                    <td>
                        <xsl:element name="button">
                            <xsl:attribute name="class">button button_style</xsl:attribute>
                            <xsl:attribute name="onclick">
                                openFacture('<xsl:value-of select="cab:prenom/text()"/>',
                                '<xsl:value-of select="cab:nom/text()"/>',
                                '<xsl:value-of select="cab:visite/*[@id]"/>')
                            </xsl:attribute>
                            Facture
                        </xsl:element>
                    </td>
                </tr>
            </xsl:for-each>
        </table>
    </xsl:template>
    <xsl:template match="cab:adresse">
        <p>
            <xsl:value-of select="cab:numero"/> <xsl:value-of select="cab:rue"/>
            <p><xsl:value-of select="cab:codePostal"/> <xsl:value-of select="cab:ville"/> <xsl:value-of select="cab:etage"/>
            </p>
        </p>
    </xsl:template>
    <!--- ENG: Template for getting acte's names
          FR:Template permettant de trouver et afficher les noms des actes -->
    <xsl:template match="cab:visite">
        <xsl:for-each select="cab:acte">
            <xsl:variable name="acteID" select="@id"/>
            <p><xsl:value-of select="$actes/act:acte[@id=$acteID]/text()"/></p>
        </xsl:for-each>
    </xsl:template>
    <!--- ENG: Template for avoiding untreated text
          FR:Template permettant d'eviter l'affichage du text non-traite par notre programme -->
    <xsl:template match="text()"/>
</xsl:stylesheet>