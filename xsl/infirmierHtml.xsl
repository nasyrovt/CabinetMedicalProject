<?xml version="1.0"?>
<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:cab="http://test/cabinet"
                xmlns:act="http://www.ujf-grenoble.fr/l3miage/actes">

    <xsl:output method="html"/>
    <xsl:param name="destinedId" select="001"/>
    <xsl:variable name="actes" select="document('../xml/actes.xml')/act:ngap/act:actes"/>

    <!--- ENG: Initial template
          FR: Template initiale -->
    <xsl:template match="/">
        <html lang="en">
            <head>
                <title>Cabinet Medical - Page Infimier</title>
                <link rel="stylesheet" href="../stylesheets/infirmierPage.css"/>
            </head>
            <body>
                <h2>Bonjour <xsl:value-of select="cab:cabinet/cab:infirmiers/cab:infirmier[@id=$destinedId]/cab:nom"/></h2>
                <h3>Aujourd'hui ,vous avez <xsl:value-of select="count(cab:cabinet/cab:patients/cab:patient/cab:visite[@intervenant=$destinedId])"/> patients</h3>
                <xsl:apply-templates select="cab:cabinet/cab:patients"/>

                <!--- ENG: Script definition for a button "Facture"
                      FR: Definition d'un script pour le button "Facture" -->
                <xsl:element name="script">
                    <xsl:attribute name="type">text/javascript</xsl:attribute>
                    <xsl:attribute name="src">../scripts/buttonScript.js</xsl:attribute>
                </xsl:element>
            </body>
        </html>
    </xsl:template>

    <!--- ENG: Template define a table
          FR:Template cree un tableau avec l'entete-->
    <xsl:template match="cab:patients">
        <table>
            <tr>
                <td>Patient</td>
                <td>Adresse</td>
                <td>Liste des soins</td>
                <td>Facture</td>
            </tr>
            <xsl:apply-templates select="cab:patient[cab:visite/@intervenant=$destinedId]"/>
        </table>
    </xsl:template>

    <!--- ENG: Template print every patient's information and a button "Facture" in a table row
          FR:Template affiche les informations des patients et le button "Facture" dans une ligne du tableau -->
    <xsl:template match="cab:patient">
            <tr>
                <td><xsl:value-of select="cab:prenom/text()"/>&#160;<xsl:value-of select="cab:nom/text()"/></td>
                <td><xsl:apply-templates select="cab:adresse"/></td>
                <td><xsl:apply-templates select="cab:visite/cab:acte"/></td>
                <td>
                    <!--- ENG: Button creation
                          FR:Creation d'un button "Facture" -->
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
    </xsl:template>

    <!--- ENG: Template prints adresse in a table
          FR: Template permettant d'afficher l'adresse dans le tableau -->
    <xsl:template match="cab:adresse">
        <xsl:value-of select="cab:numero"/>&#160;<xsl:value-of select="cab:rue"/>, &#160;
            <xsl:value-of select="cab:codePostal"/>&#160;<xsl:value-of select="cab:ville"/>
            <xsl:if test="cab:etage">
                <p>
                    <xsl:value-of select="cab:etage"/> etage
                </p>
            </xsl:if>
    </xsl:template>

    <!--- ENG: Template for getting acte's names
          FR:Template permettant de trouver et afficher les noms des actes -->
    <xsl:template match="cab:acte">
        <xsl:variable name="acteID" select="@id"/>
        <p><xsl:value-of select="$actes/act:acte[@id=$acteID]/text()"/></p>
    </xsl:template>

    <!--- ENG: Template for avoiding untreated text
          FR:Template permettant d'eviter l'affichage du text non-traite par notre programme -->
    <xsl:template match="text()"/>

</xsl:stylesheet>