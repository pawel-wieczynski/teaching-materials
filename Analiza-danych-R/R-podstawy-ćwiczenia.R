# Zadanie 1 ----
# Utworz wektor skladajacy sie z sumy, wartosci maksymalnej, minimalnej z liczb 3, 6, 9 

# Zadanie 2 ----
# Dla ponizszej ramki danych utworz kolumne z indeksem dla poszczegolnych wierszy 
df1 = data.frame(
  first_col = c(1112, 123143, 3554, 1245, 6346)
  ,Name = c("Kris", "Tom", "Ella", "Cloe", "John")
)

# Zadanie 3 ----
# Dla df1 z poprzedniego zadania dodaj kolumne, w ktorej bedzie informacja czy wiersz jest parzysty lub nieparzysty

# Zadanie 4 ----
# Wybierz 2 ostatnie wiersze df1

# Zadanie 5 ----
# Połącz text1 and text2 zamien duze litery na male oraz policz liczbe znakow w tekscie
text1 = "Marketing CaMpaign cost 1 BLN dollars, which was higher than in 2017"
text2 = "It is important to reduce the costs by 30%,,, next year"

# Zadanie 6 ----
# Zbuduj nowa ramke danych, która będzie wyglądać jak poniżej: 

##   Age   Name Gender
## 1  22  James      M
## 2  25 Mathew      M

# Zadanie 7 ----
# Policz sume dwoch ponizszych wektorow. Jaki bedzie rezultat? 
x = c(2, 4, 6, 8)
y = c(TRUE, TRUE, FALSE, TRUE)

# Zadanie 8 ----
# Jaki bedzie wymiar / wielkosc wektora ponizej? 
x = c(0:11)

# Zadanie 9 ----
# Sprawdz czy ponizszy wektor jest typem numerycznym oraz wyswietl jaki rodzaj danych jest w wektorze.
x = c('blue', 10, 'green', 20)

# Zadanie 10 ----
# Wygeneruj wektor od 23, 22.5, 22, 21.5, ..., 15 

# Zadanie 11 ----
# Utworz ponizsze wektory za pomoca funkcji sekwencyjnych i / lub powtarzających
c(1, 2, 3, 4, 1, 2, 3, 4, 1, 2, 3, 4)
c(1, 1, 1, 2, 2, 2, 3, 3, 3, 4, 4, 4)

# Zadanie 12 ----
# Odfiltruj puste wartosci z ponizszego wektora 
x = c(NA, 3, 14, NA, 33, 17, NA, 41)

# Zadanie 13 ----
# Odfiltruj wiersze, w ktorych sa puste wartosci. 
df = data.frame(
  Name = c(NA, "Kris", "John", NA, "Alex")
  ,Sales = c(15, 18, 21, 56, 60)
  ,Price = c(34, 52, 21, 44, 20)
) 

# Zadanie 14 ----
# Odfiltruj kolumny, w ktorych sa puste wartosci. 

# Zadanie 15 ----
# Ile znakow jest w ponizszym wektorze
zz = c("seaside's", "Best ")

# Zadanie 16  ----
# Stworz napis: "007 James, Bond" na podstawie ponizszych wektorow
apple = "James"
big_number = "Bond"
some_txt = 007

# Zadanie 17 ----
# Napisz funkcje zwracajaca sume 2 wartosci, ktora bedzie sprawdzac czy 2 argumenty sa cyframi. 

# Zadanie 18 ----
# Dodaj ponizsze wektory do ramki danych z cwiczenia 2.
x = c( 346, "Don") 
y = c( 369, "Katy")

# Zadanie 19 ----
# Utworz funkcje typu apply, ktora bedzie liczyc ilosc cyfr parzystych w wierszach i kolumnach
df2 = data.frame(col1 = c(1, 2, 3),
                  col2 = c(4, 5, 6),
                  col3 = c(7, 8, 9),
                  col4 = c(10, 1, 1))

# Zadanie 20 ----
# Policz sume kazdej macierzy z listy oraz policz sume dla wszystkich sum z poszczegolnych list. 
A = matrix(1:9, 3, 3)
B = matrix(4:15, 4, 3)
C = matrix(8:10, 3, 2)
MyList = list(A, B, C) 
