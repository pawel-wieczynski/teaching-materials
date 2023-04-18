# Podstawowe typy zmiennych ----
x = 5 # typ numeryczny
y <- 5

z = 'tekst' # typ tekstowy
z1 = TRUE # typ logiczny
z2 = FALSE

# Podstawowe operacje matematyczne ----
x = 5
y = 10

x + y
x - y
x * y
x / y
x ^ y
x %% 2

x + z
x + z1 # TRUE = 1
x + z2 # FALSE = 0

# Wektory ----
x = 5
y = c(5)

x = c(1, 3, 5)
y = c('a', 'b', 'c')
z = c(TRUE, FALSE, FALSE)

x1 = c(123, 'tekst') # wektor nie może mieć typu mieszanego

# Operacje na wektorach ----
x = c(1, 3, 5)
y = c(5, 4, 2)

x + 5

x + y
x / y

x = c(1, 3, 5, 6)
z = c(2, 4)

x + z

z1 = c(1, 2, 5)
x + z1

print(x + y)

# Operatory logiczne ----
x = 5
y = 3

x > y
x >= y
x < y
x <= y
x == y

x != y
!(x == y)

x > z
x > z1

x == 3

# Wyrażenia logiczne ----
(2 > 1) & (5 > 2)
(2 > 1) & (5 < 2)

(2 > 1) | (5 > 2)
(2 > 1) | (5 < 2)

# Podzbiory wektora ----
x = c(1, 3, 5, 6, 8, 17, 5, 4)

x[1:4]
x[2:5]
x[2:length(x)]

x > 6
x[x > 6]
x %% 2 == 0
x[x %% 2 == 0]

# Kilka podstawowych funkcji ----
length(x)
sum(x)
mean(x)
weighted.mean()
sqrt(x)
round(sqrt(x), 2)
abs(-5)

# średnia wazona
wt <- c(5,  5,  4,  1)/15
x <- c(3.7,3.3,3.5,2.8)
xm <- weighted.mean(x, wt)

x = c(1,2,3,4,5)
x = 1:5
x1 = 1:100

seq(2, 8, by = 0.5)
seq(2, 8, length.out = 20)

rep(5, 10)
rep(c(1,2,3), 5)

rep(seq(2, 8, by = 0.5), 4)

x = 'przykladowy tekst'
toupper(x)

tolower('TEKST wielkimi I MALYMI literami')

paste('tekst1', 'tekst2', x, sep = '!!!')

# Ramki danych ----
df = data.frame(
  id = c(1,2,3)
  ,imie = c('Jan', 'Karol', 'Marzena')
  ,wiek = c(22, 18, 34)
)

df2 = data.frame(
  id = c(1,2,3)
  ,imie = c('Jan', 'Karol', 'Marzena')
  ,wiek = 22
)

df3 = data.frame(
  id = c(1,2,3)
  ,imie = c('Jan', 'Karol', 'Marzena')
  ,wiek = c(22, 18)
)

df4 = rbind(df, df2) # łączy ramki danych wierszowo (jedna pod drugą)
df5 = cbind(df, df2) # łączy ramki danych kolumnowo (jedna obok drugiej)

# Listy ----
lista1 = list(
  id = c(1,2,3)
  ,imie = c('Jan', 'Karol', 'Marzena')
  ,wiek = c(22, 18, 34)
)

lista2 = list(
  id = c(1,2,3)
  ,imie = c('Jan', 'Karol', 'Marzena')
  ,wiek = 22
)

lista3 = list(
  id = c(1,2,3)
  ,imie = c('Jan', 'Karol', 'Marzena')
  ,wiek = c(22, 18)
)

lista4 = list(df2, df4, lista3, x1)

# Faktory ----
plec = sample(c('Kobieta', 'Mężczyzna'), 100, replace = TRUE)
plec

plec2 = as.factor(plec)
# plec3 = factor(plec)

# Konwersja typów zmiennych ----
x = c('123', '245', 'tekst')
class(x)

x1 = as.numeric(x)
class(x1)
x1

is.na(x1) # sprawdzamy czy są wartości brakujące

as.character(x1)

dzisiaj = as.Date('12/03/2023', format = '%d/%m/%Y')
class(dzisiaj)

lista6 = as.list(df2)

as.data.frame(lista1)
as.data.frame(lista3)

# Pętle ----
for (n in 1:100) {
  print(n)
}

owoce = c('banan', 'gruszka', 'jabłko')

for (x in owoce) {
  print(x)
}

owoce[2:3]

macierz = matrix(1:9, nrow = 3)
macierz[1,2]
df[2, 2:3]
df[, 2:3]
df[2, ]

for (i in 1:nrow(macierz)) {
  for (j in 1:ncol(macierz)) {
    print(macierz[i,j])
  }
}

i = 1
while (i < 10) {
  print(i)
  i = i + 1
}

# Wyrażenia warunkowe ----
x = 5

if (x > 4){
  print('x jest większy od 4')
}

if (x > 4) print('x jest większy od 4')

if (x > 4){
  print('x jest większy od 4')
} else {
  print('x nie jest większy od 4')
}

if (x > 4){
  print('x jest większy od 4')
} else if (x < 4) { # else if może być dowolna ilość
  print('x jest mniejszy od 4')
} else {
  print('x nie jest ani większy ani mniejszy od 4')
}

# Funkcje z rodziny apply ----
apply(df, MARGIN = 2, FUN = class)
apply(df, MARGIN = 2, FUN = is.numeric)

sapply(df, class)
sapply(df, FUN = function(x) if (is.numeric(x)) sum(x))

# Funkcje ----
suma_wektora_numerycznego = function(x) {
  if (is.numeric(x)){
    sum(x)
  } else {
    print('x nie jest wektorem numerycznym')
  }
}

df$imie
df$wiek

suma_wektora_numerycznego(owoce)
suma_wektora_numerycznego(df$wiek)
suma_wektora_numerycznego(df$imie)
