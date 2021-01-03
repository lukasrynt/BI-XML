#XML - semestrální práce (countries)
##Potřebný software
Pro spuštění je potřeba mít nainstalovaný make a fop. Saxon je součástí repozitáře

##Použitelné příkazy
`make html` - vygeneruje html výstup projektu

`make pdf` - vygeneruje pdf výstup projektu

`make czechia/cote/uk/spain` - vytvoří html výstup pro danou zemi (testování)

##Struktura projektu
`design` - obsahuje css styly a obrázky potřebné pro html

`exercises` - slouží pouze k procvičení témat, není přímo součástí semestrální práce

`validation` - obsahuje validační schemata ke xml souborům - dtd a rng

`source` - obsahuje xml zdrojové soubory

`stylesheets` - obsahuje a xslt a xsl-fo stylesheety

`js` - obsahuje javascript soubory

`build` obsahuje generovaný výstup projektu (pdf, html)