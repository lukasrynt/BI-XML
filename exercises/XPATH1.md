1. Sestavte XPath vyrazy, ktere vyberou (Zvon XLab 1-4):  
http://zvon.org/comp/m/xlab.html

* Korenovy element:  
    `/*`

* Vsechny atributy:  
    `//@*`

* Vsechny elementy BBB, ktere obsahuji element CCC:  

    `//BBB/CCC/parent::*`  
    `//BBB[count(CCC)!=0]`
    

* Vsechny elementy, ktere maji atribut:  
    `//*[@*]`

* Vsechny elementy BBB a CCC:  
    `//BBB | //CCC`

* Posledni element na treti urovni:  
    `/*/*/*[last()]`

* Vsechny elementy CCC co nemaji nasledujiciho sourozence:  
    `//CCC[not(following-sibling::*)]`

* Elementy jejichz atribut ma hodnotu vetsi nez 3:  
    `//*[@*>3]`

* Druhy element, jehoz atribut ma hodnotu vetsi nez 3:  
    `//*[@*>3][2]`

* Elementy na druhe pozici nebo elementy jejichz atribut ma hodnotu vetsi
  nez 3:  
    `//*[2]|//*[@*>3]`


* Vsechny elementy, jez maji atribut s hodnotou vetsi nez 3, ale bez
  prvniho co ma takovy atribut:  
    `//*[@*>3][position()!=1]`

* Elementy, majici atribut s hodnotou mensi nebo vetsi nez 3:  
    `//*[@*>3] | //*[@*<3]`


* Elementy, majici vyhradne atribut(y) s hodnotou mensi nebo vetsi nez 3:  
    `//*[@*>3 and not(@*=3)] | //*[@*<3 and not(@*=3)]`


2. Sestavte XPath vyrazy, ktere vyberou (Zvon XLab 5):

* Vsechny adresy, ktere maji telefon:  
    `//address[child::tel]`


* Adresy, ktere maji vice telefonu:  
    `//address[count(child::tel) >1]`


* Vsechny adresy, kde je prijmeni "Smith":  
    `//address[surname="Smith"]`


* Telefon, jehoz hodnota zacina na "2":  
    `//tel[starts-with(.,'2')]`


* Telefon domu pro "Alice Brown":  
    `//address[firstName='Alice' and surname='Brown']/tel[@type='home']`

