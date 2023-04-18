library(tidyverse)
library(gapminder)
data(mtcars)

# Zadanie 1 ----
# Wyfiltruj samochody, które mają co najmniej 100KM oraz mogą przejechać co maksymalnie 20 mil na galonie bezyny
# Wybierz tylko kolumny disp, hp, drat, wt

# Zadanie 2 ----
# Oblicz średnią ilość koni mechanicznych oraz średnią ilość przejechanych mil na galonie benzyny w podziale na liczbę cylindrów

# Zadanie 3 ----
# Obblicz średnią moc silnika samochodów, które mogą przejechać więcej niż 20 mil na jednym galonie benzyny

# Zadanie 4 ----
# Oblicz średnie spalanie litr/100km w podziale na rodzaj skrzyni biegów

data(gapminder)

# Zadanie 5 ----
# Stwórz ramkę danych przestawiającą średnią długość życia w podziale na kontynenty, dla lat 1957 oraz 2007

# Zadanie 6 ----
# Stwórz nową kolumnę, która oblicza gęstość zaludnienia (populacja/powierzchnia) dla każdego kraju

# Zadanie 7 ----
# Stwórz nową kolumnę, która kategoryzuje wielkość populacji każdego kraju do jednej z trzech grup:
# "mała" (populacja < 10 milionów)
# "średnia" (populacja między 10 a 100 milionów)
# "duża" (populacja > 100 milionów)

# Zadanie 8 ----
# Przekonwertuj kolumnę continent na czynnik (factor) i zmień kolejność poziomów

# Zadanie 9 ----
# Stwórz nową kolumnę, która oblicza procentową zmianę w długości życia (life expectancy) dla każdego kraju między rokiem 1952 a 2007

# Zadanie 10 ----
# Przetwórz zestaw danych gapminder tak, aby każdy wiersz przedstawiał jeden rok, a każda kolumna przedstawiała jeden kontynent, a wartościami była średnia długość życia (life expectancy) dla każdego kontynentu w danym roku
# year Africa Americas  Asia Europe Oceania
# <int>  <dbl>    <dbl> <dbl>  <dbl>   <dbl>
# 1  1952   39.1     53.3  46.3   64.4    69.3
# 2  1957   41.3     56.0  49.3   66.7    70.3
# 3  1962   43.3     58.4  51.6   68.5    71.1
# 4  1967   45.3     60.4  54.7   69.7    71.3
# 5  1972   47.5     62.4  57.3   70.8    71.9
# 6  1977   49.6     64.4  59.6   71.9    72.9
# 7  1982   51.6     66.2  62.6   72.8    74.3
# 8  1987   53.3     68.1  64.9   73.6    75.3
# 9  1992   53.6     69.6  66.5   74.4    76.9
# 10  1997   53.6     71.2  68.0   75.5    78.2
# 11  2002   53.3     72.4  69.2   76.7    79.7
# 12  2007   54.8     73.6  70.7   77.6    80.7

# Zadanie 11 ----
# Stwórz kolumnę dekada na podstawie kolumny year

# Zadanie 12 ----
# Stwórz nową kolumnę, która zawiera liczbę lat, jakie upłynęły od pierwszej obserwacji dla każdego kraju w zestawie danych

# Zadanie 13 ----
# Stwórz nowy zestaw danych, który zawiera tylko kraje z Ameryki Południowej, posortowane według wzrostu populacji (pop) między rokiem 1952 a 2007

# Zadanie 14 ----
# Stwórz nowy zestaw danych, który zawiera tylko kraje, których nazwa składa się z dwóch wyrazów

# Zadanie 15 ----
# Stwórz nowy zestaw danych, który zawiera tylko kraje, których nazwa zaczyna się od litery "M" i kończy na "a"

# Zadanie 16 ----
# Stwórz nowy zestaw danych, który zawiera tylko kraje, których populacja przekroczyła 50 milionów w dowolnym momencie między rokiem 1952 a 2007