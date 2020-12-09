declare namespace local = "docs-structs";



declare function local:remove_punct($phrase as xs:string) as xs:string {replace($phrase, "[\.,\?!\(\):\\@#~¬`£€\$%\^\*=\+«»]+", "")};


declare function local:normaliser($text as xs:string*) as xs:string*

{for $line in $text
return local:remove_punct($line) => lower-case()};


declare function local:lesmots($text as xs:string*) as xs:string*

{for $line in local:normaliser($text)
for $mot in tokenize($line, ' ')
order by $mot
return $mot};


declare function local:compter_mots($text as xs:string*)

{element dictionnaire
{ let $mots := local:lesmots($text)
for $mot in distinct-values($mots)
let $freq := count($mots[. eq $mot])
return element mot
{attribute frequence {$freq}, $mot}}
};


local:compter_mots(("Je fais un petit test pour un exercice.", "et encore un TEST.", "Et le temps est pluvieux, c'est UN vrai cauchemar. Ce temps! "))
