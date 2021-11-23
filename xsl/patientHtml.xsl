<?xml version="1.0"?>
<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:pat="http://www.ujf-grenoble.fr/l3miage/patient">
    <xsl:output method="html"/>
    <xsl:template match="/">
        <html>
            <head>
                <title>Cabinet Medical - Page Patient</title>
                <link rel="stylesheet" href="../stylesheets/patientPage.css"/>
            </head>
            <body>
                <h2>Bonjour <xsl:value-of select="pat:patient/pat:prenom"/></h2>
                <h3>Aujourd'hui ,voici la liste de vos soins a effectuer</h3>
                <table>
                    <tr>
                        <td>Date</td>
                        <td>Intervenant</td>
                        <td>Liste des soins</td>
                    </tr>
                    <xsl:apply-templates select="pat:patient/pat:visite"/>
                </table>
            </body>
        </html>
    </xsl:template>

    <xsl:template match="pat:patient/pat:visite">
        <tr>
            <td><xsl:value-of select="@date"/></td>
            <td><xsl:value-of select="pat:intervenant/pat:nom/text()"/>  <xsl:value-of select="pat:intervenant/pat:prenom/text()"/></td>
            <td><xsl:apply-templates select="pat:visite"/></td>
            <td>
                <xsl:apply-templates select="pat:patient/pat:visite/pat:acte"/>
            </td>
        </tr>
    </xsl:template>

    <xsl:template match="pat:acte">
        <p><xsl:value-of select="pat:acte/text()"/></p>
    </xsl:template>
    <!--- ENG: Template for avoiding untreated text
          FR:Template permettant d'eviter l'affichage du text non-traite par notre programme -->
    <xsl:template match="text()"/>
</xsl:stylesheet>