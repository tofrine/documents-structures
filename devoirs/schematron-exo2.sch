<?xml version="1.0" encoding="UTF-8"?>
<sch:schema xmlns:sch="http://purl.oclc.org/dsdl/schematron">
    <sch:pattern>        
        <sch:rule context="teiheader">
            <sch:assert test="boolean(self)">L'élément "tei" doi têtre présent.</sch:assert>
        </sch:rule>
        <sch:rule context="text">
            <sch:assert test="boolean(self)">L'élément "text" doi têtre présent.</sch:assert>
        </sch:rule>
               
        
    </sch:pattern>
</sch:schema>