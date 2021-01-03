#XML - semestrální práce (countries)
##Potřebný software
Pro spuštění je potřeba mít nainstalovaný make, fop a xmllint. Saxon je součástí repozitáře, ale ne zipu. V Makefile je obsažena proměnná SAXON_EXEC, kterou lze upravit v případě jiného spuštění Saxonu.

##Použitelné příkazy
`make all` - vygeneruje pdf a html výstup projektu + zvaliduje projekt

`make validate` - zvaliduje projekt

`make html` - vygeneruje html výstup projektu

`make pdf` - vygeneruje pdf výstup projektu

`make zip` - vytvoří zip projektu bez softwaru a cvičení

`make czechia/cote/uk/spain` - vytvoří html výstup pro danou zemi (testování)

##Struktura projektu
`design` - obsahuje css styly a obrázky potřebné pro html

`exercises` - slouží pouze k procvičení témat, není přímo součástí semestrální práce

`validation` - obsahuje validační schemata ke xml souborům - dtd a rng

`source` - obsahuje xml zdrojové soubory

`stylesheets` - obsahuje a xslt a xsl-fo stylesheety

`js` - obsahuje javascript soubory

`build` obsahuje generovaný výstup projektu (pdf, html)


## Oblasti
Czechia: 
-   https://www.cia.gov/library/publications/the-world-factbook/geos/ez.html  

Cote d'Ivoire:
-   https://www.cia.gov/library/publications/the-world-factbook/geos/iv.html  

United Kingdom:
-   https://www.cia.gov/library/publications/the-world-factbook/geos/uk.html  

Spain:
-   https://www.cia.gov/library/publications/the-world-factbook/geos/sp.html

##Návrh xml struktury
Struktura byla převedena ručně. Root elementem je zde element `countries`, který obsahuje informace o autorovi v elementu `author` a dále jednotlivé země v elementech `country`. Jednotlivé země jsou zvlášť ve vlastních souborech a nakonec jsou pomocí XInclude propojeny do výsledného parsed.xml souboru. Soubor countries.xml působí jako prostředník pro propojení. Jednotlivé země pak obsahují elementy `chapter` a `section` kopírující strukturu používanou na původní stránce. Nakonec `section` obsahuje jednotlivá data v podobě elementů `subfield`, `paragraph`, `list`, samostatný text nebo odkazy.

##Validace pomocí RNG a DTD
Validační schemata přirozeně kopírují strukturu popsanou v návrhu xml. V RNG je využívaný navíc pattern match na určité atributy a možnosti výběru.

##Generování HTML souborů
HTML je generováno pomocí souboru countries.xslt. Převádí zparsovaný soubor na html formát a přidává javascript a kaskádové styly. Navíc je přidán index pro lepší orientaci a soubory jsou dozdobené kolapsujícími sekcemi a barevně odlišenými styly u jednotlivých zemí. Součástí html výstupů jsou také obrázky, odkazy na pdf a hudbu, které se odkazují na zdrojovou stránku.

##Generování PDF výstupů
PDF je generováno pomocí XSL stylesheetu v souboru countries.xsl, který vytváří .fo soubor, ten je pak pomocí fop přetvořený do výsledného pdf souboru. V pdf je navíc obsažen obsah dokumentu s odkazy na jednotlivé sekce a vloženy obrázky.