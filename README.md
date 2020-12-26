# XML - semestralka

## Oblasti
Czechia: https://www.cia.gov/library/publications/the-world-factbook/geos/ez.html  
Cote d'Ivoire: https://www.cia.gov/library/publications/the-world-factbook/geos/iv.html  
United Kingdom: https://www.cia.gov/library/publications/the-world-factbook/geos/uk.html  
Spain: https://www.cia.gov/library/publications/the-world-factbook/geos/sp.html

## Zadání
- Vytvořte XML dokumenty se všemi daty pro každou vybranou oblast (z
  https://www.cia.gov/library/publications/the-world-factbook/). Podrobnosti
  k výběru oblastí jsou v souboru "BI-XML-PROJEKT-VÝBĚR-ZADÁNÍ*.txt". Pokud
  nezvládnete v dokumentu uvést všechna data o dané oblasti (např. protože
  se rozhodnete vytvářet XML manuálně), uveďte alespoň základní data pro
  minimálně 6 hlavních sekcí (tj. Introduction, Geography, atd.). Dále
  spojte XML dokumenty pro jednotlivé oblasti do jediného dokumentu pomocí
  DTD.

- Vytvořte schema pomocí DTD i RelaxNG pro validaci struktury XML
  dokumentů. V RelaxNG schema se pokuste využít alespoň některé možnosti
  pokročilejší validace co jazyk nabízí navíc oproti DTD.

- Pomocí XSLT vygenerujte (X)HTML výstupy (tj. souhrný index obsahující
  odkazy na jednotlivé oblasti a samostatnou stránku pro každou oblast
  obsahující detailní informace).

- Pomocí XSL-FO vygenerujte PDF výstup (tj. dokument obsahující odkazy na
  jednotlivé oblasti a detailní informace o každé oblasti).

- Buď vygenerujte ePub výstup (tj. ebook připravený k načtení v software
  podporujícím ePub formát), nebo do (X)HTML a PDF výstupů přidejte obrázky
  (stačí vlajky nebo mapy a podobně), navigaci pro sekce s detailními
  informacemi (stačí pro hlavní sekce jako "Introduction", "Geography",
  atd.) a rozšiřte základní formátování aby byly výstupy více přehledné
  (použijte CSS a možnosti formátování v XSL-FO včetně číslování stran a
  přidání záhlaví či zápatí).

- Schema (DTD i RelaxNG), stylesheety (XSLT i XSL-FO) a další části
  projektu tvořte adekvátně obecné aby byla zajištěna funkčnost pro všechny
  zadané oblasti. Všechny XML dokumenty musí být "well-formed" + "valid". I
  základní výstupy bez rozšířeného formátování musí být adekvátně čitelné
  (tj. alespoň by mělo jít rozlišit nadpisy a odstavce, případně i další
  prvky jako seznamy, odkazy, atd.).

- Projekt tvořte pomocí veřejně přístupného GIT repozitáře a finální
  soubory projektu (bez použitého software) zabalte do ZIP nebo TAR archivu
  a pošlete na email vyučujícího spolu s odkazem na GIT repozitář.

- Do archivu i repozitáře také přidejte informace o projektu dle zadání v
  souboru "BI-XML-PROJEKT-PREZENTACE*.txt".

- Navrhněte jednoduchou XML strukturu pro zaznamenání vašeho jména,
  emailu a názvů oblastí co jste si vybrali pro zpracování do projektu.

- Po navržení XML struktury si vyberte 4 unikátní oblasti (z
  "https://www.cia.gov/library/publications/the-world-factbook/") a
  zaznamenejte je do "well-formed" XML dokumentu, který odešlete na email
  vyučujícího.
  
## Prezentace
- Pokud děláte projekt samostatně do repozitáře přidejte také krátký popis
  projektu (adresářová struktura, potřebný software, seznam použitých
  příkazů (nebo skript s čitelným zdrojovým kódem co tyto příkazy provede),
  atd.).

- Pokud děláte projekt ve skupině do repozitáře přidejte prezentaci
  projektu (na zhruba 10 až 20 minut), která bude obsahovat alespoň
  následující:

  - 1) informace o navržené XML struktuře pro datové XML dokumenty a jejich
       propojení do jednoho XML dokumentu (můžete popsat i postup převodu
       dat do XML struktury)

  - 2) informace o validaci pomocí DTD a RelaxNG schema

  - 3) informace o generování (X)HTML výstupů

  - 4) informace o generování PDF výstupů

  - 5) informace o generování ePub výstupů (pokud jste se rozhodli
       zpracovat tuto část)

  - 6) informace o pokročilém formátování (X)HTML a PDF výstupů (pokud jste
       se rozhodli zpracovat tuto část)

- Při prezentování ve skupině by měl každý člen skupiny odprezentovat
  alespoň jednu z částí (1-6) popsanou výše. Pokud má skupina menší nebo
  větší počet členů než je počet částí prezentace projektu rozdělte si
  prezentování částí rovnoměrně (tj. složitější části mohou prezentovat
  např. 2 lidé nebo více jednodušších částí zvládne 1 člen skupiny).

EXTRA INFO PRO ROK 2020:

- Pokud by opatření související s nákazou COVID-19 znemožnila na konci
  semestru běžné ústní ZK bude možné projekt obhájit a ZK zvládnout přes
  Internet.

- V tom případě doporučuji připravit si samostatnou krátkou prezentaci nebo
  krátký popis co a jak jste v projektu zpracovali. Struktura prezentace
  nebo popisu může vycházet z instrukcí pro prezentaci skupinového
  projektu, ale bude stačit stručnější provedení. Toto pak využijete při
  distanční ZK, kde se zejména první otázka bude zabývat obhajobou
  projektu. Samozřejmě i prezentace skupinového projektu bude při distanční
  ZK probíhat samostatně.