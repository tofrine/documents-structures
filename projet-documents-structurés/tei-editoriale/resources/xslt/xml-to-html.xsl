<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns="http://www.w3.org/1999/xhtml" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:tei="http://www.tei-c.org/ns/1.0" exclude-result-prefixes="tei" version="2.0">
    <xsl:param name="ref"/>
    <xsl:template match="/">
        <div class="page-header">
            <h2 align="center">
                <xsl:for-each select="//tei:fileDesc/tei:titleStmt/tei:title">
                    <xsl:value-of select="."/>
                    <br/>
                </xsl:for-each>
            </h2>
        </div>
        <div>
            <div class="panel panel-default">
                <div class="panel-heading">
                    <h3 class="panel-title">
                        <h2 align="center">Informations (métadonnées)</h2>
                    </h3>
                </div>
                <div class="panel-body">
                    <table class="table table-striped">
                        <tbody>
                            <tr>
                                <th>
                                    Titre :
                                </th>
                                <td>
                                    <xsl:for-each select="//tei:fileDesc/tei:titleStmt/tei:title">
                                        <xsl:apply-templates/>
                                        <br/>
                                    </xsl:for-each>
                                </td>
                            </tr>
                            <tr>
                                <th>
                                    <p>Auteur :</p>
                                </th>
                                <td>
                                    <xsl:for-each select="//tei:fileDesc/tei:titleStmt/tei:author">
                                        <xsl:apply-templates/>
                                        <br/>
                                    </xsl:for-each>
                                </td>
                            </tr>
                                <tr>
                                    <th>
                                        Première édition
                                    </th>
                                    <td>
                                        <xsl:apply-templates select="//tei:editionStmt/tei:edition/tei:date/@when"/>
                                        <br/>
                                </td>
                                </tr>
                            
                                   <tr>
                                    <th>
                                        Dernière modification :
                                    </th>
                                    <td>
                                        <xsl:apply-templates select="//tei:revisionDesc/tei:listChange/tei:change/tei:date"/>
                                    </td>
                                </tr>
                                <tr>
                                    <th>
                                        Source :
                                    </th>
                                    <td>
                                        <xsl:element name="a">
                                            <xsl:attribute name="href">
                                            <xsl:apply-templates select="//tei:sourceDesc/tei:p[2]"/>
                                            </xsl:attribute>
                                     <xsl:apply-templates select="//tei:sourceDesc/tei:p[2]"/>
                                         </xsl:element>
                                    </td>
                                </tr>
                            <tr>
                                <th>
                                    License :
                                </th>
                                <td>
                                    <xsl:element name="a">
                                        <xsl:attribute name="href">
                                            <xsl:apply-templates select="//tei:publicationStmt/tei:availability/tei:licence/@target"/>
                                        </xsl:attribute>
                                        <xsl:apply-templates select="//tei:publicationStmt/tei:availability/tei:licence"/>
                                    </xsl:element>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                    <div class="panel-footer">
                        <p style="text-align:center;">
                            <a id="link_to_source"/><!-- sert pour le javascript qui crée un lien vers xml / trouvé sur un site  voir plus bas-->
                        </p>
                    </div>
                </div>
            </div>
        </div>
        <div class="panel panel-default">
            <div class="panel-heading">
                <h3 class="panel-title">
                    <h2 align="center">
                        Texte
                    </h2>
                </h3>
            </div>
            <div class="panel-body">
                <div class="row">
                    <div class="col-md-4">
                        <h4><!-- crée une liste cliquable des parties et sous chapitres -->
                            Navigation
                        </h4>
                        <xsl:element name="ul">
                            <xsl:for-each select="//tei:body//tei:head">
                                <xsl:element name="li">
                                    <xsl:element name="a">
                                        <xsl:attribute name="href">
                                            <xsl:text>#text_</xsl:text>
                                            <xsl:value-of select="."/>
                                        </xsl:attribute>
                                        <xsl:attribute name="id">
                                            <xsl:text>nav_</xsl:text>
                                            <xsl:value-of select="."/>
                                        </xsl:attribute>
                                        <xsl:value-of select="."/>
                                    </xsl:element>
                                </xsl:element>
                            </xsl:for-each>
                        </xsl:element>
                    </div>
                    <div class="col-md-8">
                        <xsl:apply-templates select="//tei:body"/>
                    </div>
                </div>
            </div>
            <script type="text/javascript"><!-- adapté avec un if/else car index.xml n'est pas dans data -->
                // creates a link to the xml version of the current docuemnt available via eXist-db's REST-API
                var params={};
                window.location.search
                .replace(/[?&amp;]+([^=&amp;]+)=([^&amp;]*)/gi, function(str,key,value) {
                params[key] = value;
                }
                );
                var path = window.location.origin+window.location.pathname;
                var replaced = path.replace("exist/apps/", "exist/rest/db/apps/");
                current_html = window.location.pathname.substring(window.location.pathname.lastIndexOf("/") + 1)
                if (current_html == 'index.html') {
                    var source_document = 'http://localhost:8080/exist/rest/db/apps/tei-editoriale/index.xml';
                  } else {
                    var source_document = replaced.replace("/"+current_html, "/data/"+params['document']);
                  }
                console.log(source_document)
                $( "#link_to_source" ).attr('href',source_document);
                $( "#link_to_source" ).text(source_document);
            </script>
        </div>
    </xsl:template>
<!-- titres  -->
    <xsl:template match="tei:head">
        <xsl:element name="h3">
            <xsl:element name="a">
                <xsl:attribute name="id">
                    <xsl:text>text_</xsl:text>
                    <xsl:value-of select="."/>
                </xsl:attribute>
                <xsl:attribute name="href">
                    <xsl:text>#nav_</xsl:text>
                    <xsl:value-of select="."/>
                </xsl:attribute>
                <xsl:apply-templates/>
            </xsl:element>
        </xsl:element>
    </xsl:template><!-- paragraphes    -->
    <xsl:template match="tei:p">
        <xsl:element name="p">
            <xsl:apply-templates/>
        </xsl:element>
    </xsl:template>
</xsl:stylesheet>