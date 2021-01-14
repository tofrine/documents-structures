<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet
  exclude-result-prefixes="office style text table draw fo xlink dc
			   meta number tei svg chart dr3d math form
			   script ooo ooow oooc dom xforms xs xsd xsi"
  office:version="1.0" version="2.0" 
  xmlns:xs="http://www.w3.org/2001/XMLSchema"
  xmlns="http://www.tei-c.org/ns/1.0"
  xmlns:tei="http://www.tei-c.org/ns/1.0"
  xmlns:chart="urn:oasis:names:tc:opendocument:xmlns:chart:1.0"
  xmlns:dc="http://purl.org/dc/elements/1.1/"
  xmlns:dom="http://www.w3.org/2001/xml-events"
  xmlns:dr3d="urn:oasis:names:tc:opendocument:xmlns:dr3d:1.0"
  xmlns:draw="urn:oasis:names:tc:opendocument:xmlns:drawing:1.0"
  xmlns:fo="urn:oasis:names:tc:opendocument:xmlns:xsl-fo-compatible:1.0"
  xmlns:form="urn:oasis:names:tc:opendocument:xmlns:form:1.0"
  xmlns:math="http://www.w3.org/1998/Math/MathML"
  xmlns:meta="urn:oasis:names:tc:opendocument:xmlns:meta:1.0"
  xmlns:number="urn:oasis:names:tc:opendocument:xmlns:datastyle:1.0"
  xmlns:office="urn:oasis:names:tc:opendocument:xmlns:office:1.0"
  xmlns:ooo="http://openoffice.org/2004/office"
  xmlns:oooc="http://openoffice.org/2004/calc"
  xmlns:ooow="http://openoffice.org/2004/writer"
  xmlns:script="urn:oasis:names:tc:opendocument:xmlns:script:1.0"
  xmlns:style="urn:oasis:names:tc:opendocument:xmlns:style:1.0"
  xmlns:svg="urn:oasis:names:tc:opendocument:xmlns:svg-compatible:1.0"
  xmlns:table="urn:oasis:names:tc:opendocument:xmlns:table:1.0"
  xmlns:text="urn:oasis:names:tc:opendocument:xmlns:text:1.0"
  xmlns:xforms="http://www.w3.org/2002/xforms"
  xmlns:xlink="http://www.w3.org/1999/xlink"
  xmlns:xsd="http://www.w3.org/2001/XMLSchema"
  xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  
  <xsl:param name="dir">.</xsl:param>

  <xsl:output encoding="utf-8" indent="yes"/>

  
  <xsl:variable name="META">
    <xsl:choose>
      <xsl:when test="doc-available(concat($dir,'/meta.xml'))">
        <xsl:copy-of select="document(concat($dir,'/meta.xml'))//office:meta"/>
      </xsl:when>
      <xsl:when test="/office:document/office:meta">
        <xsl:copy-of select="/office:document/office:meta"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:copy-of select="/office:document-meta/office:meta"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:variable>



  <xsl:template match="/">

    <xsl:variable name="pass1">
      <xsl:apply-templates/>
    </xsl:variable>
    <xsl:variable name="pass2">
      <xsl:apply-templates mode="pass2" select="$pass1"/>
    </xsl:variable>
    <xsl:apply-templates mode="pass3" select="$pass2"/>    
  </xsl:template>

  <xsl:template match="office:document-content|office:body">
    <TEI>
      <xsl:call-template name="teiHeader"/>
      <text>
	<xsl:apply-templates/>
      </text>
    </TEI>
  </xsl:template>



  <xsl:template name="teiHeader">
    <teiHeader>
      <fileDesc>
        <titleStmt>
          <title>
            <xsl:value-of select="$META/office:meta/meta:user-defined[@meta:name='Titre']"/>
          </title>
          <author>
            <xsl:value-of
              select="$META/office:meta/meta:user-defined[@meta:name='Auteur']"/>
          </author>
        </titleStmt>
        <editionStmt>
          <edition>
            <date>
              <xsl:attribute name="when">
                <xsl:value-of select="$META/office:meta/meta:user-defined[@meta:name='Date de la source']"/>
              </xsl:attribute>
              <xsl:value-of
                select="$META/office:meta/meta:user-defined[@meta:name='Date de publication']"/>
            </date>
          </edition>
        </editionStmt>
        <publicationStmt>
          <authority/>
          <availability>
            <licence><xsl:attribute name="target">
              <xsl:value-of select="$META/office:meta/meta:user-defined[@meta:name='Licence']"/>
            </xsl:attribute>Lien vers la licence</licence>
          </availability>=
        </publicationStmt>
        <sourceDesc>
          <p><xsl:value-of
            select="$META/office:meta/meta:user-defined[@meta:name='Description']"/>
          </p>
          <p><xsl:value-of
            select="$META/office:meta/meta:user-defined[@meta:name='Source']"/>
          </p>
        </sourceDesc>
      </fileDesc>
      <revisionDesc>
        <listChange>
          <change>
            <name>
              <xsl:apply-templates
                select="$META/office:meta/dc:creator"/>
            </name>
            <date>
              <xsl:apply-templates select="$META/office:meta/dc:date"/>
            </date>
          </change>
        </listChange>
      </revisionDesc>
    </teiHeader>
  </xsl:template>
  


  <xsl:template match="/office:document-content/office:body">
      <xsl:apply-templates/>
  </xsl:template>

  <!-- sections -->
  <xsl:template match="text:h">
	<HEAD level="1" style="{@text:style-name}">
	  <xsl:apply-templates/>
	</HEAD>
  </xsl:template>

  <xsl:template match="text:h[@text:outline-level]">
    <xsl:choose>
      <xsl:when test="ancestor::text:note-body">
	<p>
	  <xsl:attribute name="rend">
	    <xsl:choose>
	      <xsl:when test="@text:style-name">
		<xsl:value-of select="@text:style-name"/>
	      </xsl:when>
	      <xsl:otherwise>heading</xsl:otherwise>
	    </xsl:choose>
	  </xsl:attribute>
          <xsl:apply-templates/>
	</p>
      </xsl:when>
      <xsl:otherwise>
	<HEAD level="{@text:outline-level}" >
	  <xsl:attribute name="style">
	    <xsl:choose>
	      <xsl:when test="@text:style-name">
		<xsl:value-of select="@text:style-name"/>
	      </xsl:when>
	      <xsl:otherwise>nostyle</xsl:otherwise>
	    </xsl:choose>
	  </xsl:attribute>
	  <xsl:apply-templates/>
	</HEAD>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  


  <xsl:template match="text:p">
	<p>
	  <xsl:apply-templates select="text()|*[not(local-name(.)='frame')]"/>
	</p>
  </xsl:template>


  <xsl:template match="office:text">
    <body>
      <xsl:variable name="Body">
	<HEAD level="1" magic="true">Start</HEAD>
        <xsl:apply-templates/>
      </xsl:variable>
 
      <xsl:variable name="Body2">
	<xsl:for-each select="$Body">
	  <xsl:apply-templates mode="pass1"/>
	</xsl:for-each>
      </xsl:variable>
      <xsl:for-each select="$Body2">
        <xsl:for-each-group select="tei:*" group-starting-with="tei:HEAD[@level='1']">
          <xsl:choose>
            <xsl:when test="self::tei:HEAD[@level='1']">
	      <xsl:call-template name="group-by-section"/>
            </xsl:when>
            <xsl:otherwise>
	      <xsl:call-template name="inSection"/>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:for-each-group>
      </xsl:for-each>
    </body>
  </xsl:template>

  <xsl:template name="group-by-section">
    <xsl:variable name="ThisHeader" select="number(@level)"/>
    <xsl:variable name="NextHeader" select="number(@level)+1"/>
    <xsl:choose>
      <xsl:when test="@magic">
	  <xsl:for-each-group select="current-group() except ."
			      group-starting-with="tei:HEAD[number(@level)=$NextHeader]">
	    <xsl:choose>
	      <xsl:when test="self::tei:HEAD">
		<xsl:call-template name="group-by-section"/>
	      </xsl:when>
	    <xsl:otherwise>
	      <xsl:call-template name="inSection"/>
	    </xsl:otherwise>
	    </xsl:choose>
	  </xsl:for-each-group>
      </xsl:when>
      <xsl:otherwise>
	<div>
	  <xsl:if test="not(@interpolated='true')">
	    <head>
	      <xsl:apply-templates mode="pass1"/>
	    </head>
	  </xsl:if>
	  <xsl:for-each-group select="current-group() except ."
			      group-starting-with="tei:HEAD[number(@level)=$NextHeader]">
	    <xsl:choose>
	      <xsl:when test="self::tei:HEAD">
		<xsl:call-template name="group-by-section"/>
	      </xsl:when>
	    <xsl:otherwise>
		<xsl:call-template name="inSection"/>
	    </xsl:otherwise>
	    </xsl:choose>
	  </xsl:for-each-group>
	</div>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>


  <xsl:template name="inSection">
	  <xsl:for-each select="current-group()">
	    <xsl:apply-templates select="." mode="pass2"/>
	  </xsl:for-each>
  </xsl:template>
		
  <xsl:template match="@*|text()|comment()|processing-instruction()" mode="pass1">
    <xsl:copy-of select="."/>
  </xsl:template>


  <xsl:template match="tei:HEAD" mode="pass1">
    <xsl:if test="preceding-sibling::tei:HEAD">
      <xsl:variable name="prev"
		    select="xs:integer(number(preceding-sibling::tei:HEAD[1]/@level))"/>
      <xsl:variable name="current"
		    select="xs:integer(number(@level))"/>
	<xsl:if test="($current - $prev) &gt;1 ">
	  <!--<xsl:message>Walk from <xsl:value-of select="$prev"/> to <xsl:value-of select="$current"/></xsl:message>-->
	  <xsl:for-each
	      select="$prev + 1   to $current - 1 ">
	    <HEAD interpolated='true' level="{.}"/>
	  </xsl:for-each>
	</xsl:if>
    </xsl:if>
    <xsl:copy>
    <xsl:apply-templates
	select="*|@*|processing-instruction()|comment()|text()"
	mode="pass1"/>
    </xsl:copy>
  </xsl:template>

  <xsl:template match="*" mode="pass1">
    <xsl:copy>
      <xsl:apply-templates select="*|@*|processing-instruction()|comment()|text()" mode="pass1"/>
    </xsl:copy>
  </xsl:template>


  <!-- second pass -->


  <xsl:template match="tei:p[not(*) and normalize-space(.)='']"
		mode="pass2">
  </xsl:template>
  
  <xsl:template match="@*|comment()|processing-instruction()" mode="pass2">
    <xsl:copy-of select="."/>
  </xsl:template>
  
  <xsl:template match="*" mode="pass2">
    <xsl:copy>
      <xsl:apply-templates select="*|@*|processing-instruction()|comment()|text()" mode="pass2"/>
    </xsl:copy>
  </xsl:template>
  
  
  <xsl:template match="text()" mode="pass2">
    <xsl:value-of select="."/>
  </xsl:template>
  
  
  <xsl:template match="tei:title" mode="pass2">
    <xsl:choose>
      <xsl:when test="parent::tei:div|parent::tei:body">
	<head>
	  <xsl:apply-templates select="*|@*|processing-instruction()|comment()|text()" mode="pass2"/>
	</head>
      </xsl:when>
      <xsl:otherwise>
	<xsl:copy>
	  <xsl:apply-templates select="*|@*|processing-instruction()|comment()|text()" mode="pass2"/>
	</xsl:copy>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  
  <!-- third pass -->



    <xsl:template match="@*|comment()|processing-instruction()" mode="pass3">
        <xsl:copy-of select="."/>
    </xsl:template>
    
    <xsl:template match="*" mode="pass3">
        <xsl:copy>
            <xsl:apply-templates select="*|@*|processing-instruction()|comment()|text()" mode="pass3"/>
        </xsl:copy>
    </xsl:template>
    
    
    <xsl:template match="text()" mode="pass3">
        <xsl:value-of select="."/>
    </xsl:template>
    
    <xsl:template match="tei:div[not(@type)]" mode="pass3">
      <div n="{count(ancestor-or-self::tei:div)}">
	<xsl:apply-templates select="*|@*|processing-instruction()|comment()|text()" mode="pass3"/>
      </div>
    </xsl:template>
    

  
</xsl:stylesheet>
