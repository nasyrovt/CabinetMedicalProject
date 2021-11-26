<?xml version="1.0"?>
<xsl:stylesheet version="1.0"
                xmlns:cab="http://test/cabinet"
                xmlns="http://www.ujf-grenoble.fr/l3miage/patient"
                xmlns:act="http://www.ujf-grenoble.fr/l3miage/actes"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
                xsi:schemaLocation="http://www.ujf-grenoble.fr/l3miage/patient ../xsd/patient.xsd">

    <xsl:output method="xml"/>
    <xsl:param name="destinedName">Oscare</xsl:param>
    <xsl:variable name="actes" select="document('../xml/actes.xml')/act:ngap/act:actes"/>

    <!--- ENG: Initial template
          FR: Template initiale -->
    <xsl:template match="/">
        <patient xmlns="http://www.ujf-grenoble.fr/l3miage/patient"
                 xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
                 xsi:schemaLocation="http://www.ujf-grenoble.fr/l3miage/patient ../xsd/patient.xsd">
            <xsl:apply-templates select="cab:cabinet/cab:patients/cab:patient[cab:prenom/text()=$destinedName]"/>
        </patient>
    </xsl:template>

    <!--- ENG: Patient information template
          FR: Template qui copie les informations personnelles d'un patient -->
    <xsl:template match="cab:patient">
        <nom><xsl:value-of select="cab:nom"/></nom>
        <prenom><xsl:value-of select="cab:prenom"/></prenom>
        <sexe><xsl:value-of select="cab:sexe"/></sexe>
        <naissance><xsl:value-of select="cab:naissance"/></naissance>
        <numeroSS><xsl:value-of select="cab:numero"/></numeroSS>
        <adresse>
            <rue><xsl:value-of select="cab:adresse/cab:rue"/></rue>
            <codePostal><xsl:value-of select="cab:adresse/cab:codePostal"/></codePostal>
            <ville><xsl:value-of select="cab:adresse/cab:ville"/></ville>
        </adresse>

        <!--- ENG: Call a template with sort by visit's @date attribute
              FR: Appel de template trie par l'attribut @date de visite -->
        <xsl:apply-templates select="cab:visite">
            <xsl:sort select="@date"/>
        </xsl:apply-templates>

    </xsl:template>

    <!--- ENG: Refactoring of visite by using intervenant's Name instead of id
          FR: Redefinition de visite en utilisant Nom-Prenom de l'intervenant
                a la place de son ID-->
    <xsl:template match="cab:visite">
        <xsl:variable name="InterID" select="@intervenant"/>
        <visite date="{@date}">
            <intervenant>
                <nom>
                    <xsl:value-of select="/cab:cabinet/cab:infirmiers/cab:infirmier[@id=$InterID]/cab:nom"/>
                </nom>
                <prenom>
                    <xsl:value-of select="/cab:cabinet/cab:infirmiers/cab:infirmier[@id=$InterID]/cab:prenom"/>
                </prenom>
            </intervenant>
            <xsl:apply-templates select="cab:acte"/>
        </visite>
    </xsl:template>

    <!--- ENG: Search for an acte's text by it's ID in actes.xml
          FR: Cherche le texte d'un acte par son ID dans le fichier actes.xml -->
    <xsl:template match="cab:acte">
        <acte>
            <xsl:variable name="acte" select="@id"/>
            <xsl:value-of select="$actes/act:acte[@id=$acte]/text()"/>
        </acte>
    </xsl:template>

    <!--- ENG: Avoids yntreated text
          FR: Pour eviter le texte non-traite -->
    <xsl:template match="text()"/>

</xsl:stylesheet>