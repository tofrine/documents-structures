<?xml version="1.0" encoding="UTF-8"?>
<sch:schema xmlns:sch="http://purl.oclc.org/dsdl/schematron">
    <sch:pattern>        
        <sch:rule context="fermeture">
            <sch:assert test="boolean(text()) = false()">L'élément "fermeture ne doit pas contenir de texte.</sch:assert>
        </sch:rule>
               
            <sch:rule context="ouverture">
                <sch:assert test="@debut and @fin">L'élément ouverutre doit contenir début et fin</sch:assert>
            </sch:rule>
        
        <sch:rule context="ouverture">
            <sch:report test="contains(@saufjour,'')" role="warn">
                les points de vente sont ouverts tous les jours, devraient prendre des vacances.</sch:report>
        </sch:rule>
        <sch:rule context="ville">
            <sch:report test="matches(text(), '[a-z]')" role="warn">
                les noms des villes devraient être tous en majuscule pour la consistance.</sch:report>
        </sch:rule>
        
    </sch:pattern>
</sch:schema>