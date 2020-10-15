import csv 
import lxml.etree as et 


# INITIALIZING XML FILE 
root = et.Element('toilettes')
#adress-attri = {}
#adress-attri = dict()
#tree.docinfo.system_url = 'file://local.dtd'
# READING CSV FILE AND BUILD TREE 
with open('sanisettesparis.csv', newline='') as f:
    reader = csv.DictReader(f, delimiter = ';')
    for row in reader:
        #print(row)
        typ = str(row['TYPE'])
        statu = str(row['STATUT'])
        print(typ)
        #adress-attri = {"type": typ , "statut": statu}
        #print(attr-adr)
        #toilette = et.SubElement(toilettes, "toilette", attrib=adres-attri)
        toilette = et.SubElement(root, "toilette", attrib={"type": typ, "statut": statu})
        adresse = et.SubElement(toilette, 'adresse')
        libelle = et.SubElement(adresse, 'libelle')
        libelle.text = row['ADRESSE']
        arrondissement = et.SubElement(adresse, 'arrondissement')
        arrondissement.text = row['ARRONDISSEMENT']
        horaire = et.SubElement(toilette, 'horaire')
        horaire.text = row['HORAIRE']
        services = et.SubElement(toilette, 'services')
        equipement = et.SubElement(toilette, 'equipement')
        pmr = et.SubElement(services, 'acces-pmr')
        pmr.text = row['ACCES_PMR']
        bebe = et.SubElement(services, 'relais-bebe')
        bebe = row['RELAIS_BEBE']
                                 
        #toilettes.set ("type", typ)
        #toilettes.se (statut", statu)
        
        

# SAVE XML TO FILE 
tree_out = (et.tostring(root, pretty_print=True, xml_declaration=True, encoding="UTF-8", doctype="<!DOCTYPE toilettes SYSTEM 'wc.dtd'>")) 

# OUTPUTTING XML CONTENT TO FILE  
with open('toilettes.xml', 'wb') as t: 
    t.write(tree_out)
    #print(tree_out)
    print(type(tree_out))