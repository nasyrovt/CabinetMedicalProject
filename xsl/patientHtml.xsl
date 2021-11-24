<?xml version="1.0"?>
<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:pat="http://www.ujf-grenoble.fr/l3miage/patient">
    <xsl:output method="html"/>
    <xsl:template match="/">
        <html>
            <head>
                <title>Cabinet Medical - Page Patient</title>
                <link rel="stylesheet" href="../stylesheets/pagePatient.css"/>
            </head>
            <body>
                <h2>Bonjour <xsl:value-of select="pat:patient/pat:prenom"/></h2>
                <h3>Voici la liste de vos soins a effectuer</h3>
                <table>
                    <thead>
                        <tr>
                            <td>Date</td>
                            <td>Intervenant</td>
                            <td>Liste des soins</td>
                        </tr>
                    </thead>
                    <tbody>
                        <xsl:apply-templates select="pat:patient/pat:visite"/>
                    </tbody>
                </table>
            </body>
        </html>
    </xsl:template>

    <xsl:template match="pat:visite">
        <tr>
            <td><xsl:value-of select="@date"/></td>
            <td><xsl:value-of select="pat:intervenant/pat:nom/text()"/>  <xsl:value-of select="pat:intervenant/pat:prenom/text()"/></td>
            <td>
                <ul>
                    <xsl:apply-templates select="pat:acte"/>
                </ul>
            </td>
        </tr>
    </xsl:template>

    <xsl:template match="pat:acte">
        <li><xsl:value-of select="text()"/></li>
    </xsl:template>
    <!--- ENG: Template for avoiding untreated text
          FR:Template permettant d'eviter l'affichage du text non-traite par notre programme -->
    <xsl:template match="text()"/>
</xsl:stylesheet>