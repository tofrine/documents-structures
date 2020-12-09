<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs" version="3.0">

    <xsl:template match="pdv_liste">
        <html>
            <head>
                <title>Les poindts de vente</title>
            </head>
            <ul><xsl:apply-templates/></ul>
            
            <body/>
         </html>
    </xsl:template>

    <xsl:template match="pdv">
          <li>
            <xsl:apply-templates select="ville"/>
        </li>
        
        
        
    </xsl:template>
    
</xsl:stylesheet>
