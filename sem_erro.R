setwd('/Users/u20151/Documents/Linguagem R/Trabalho R/analise-cepagri-main')
names <- c("horario", "temp", "vento", "umid", "sensa")
cepagri <- read.csv("./cepagri.csv", header = FALSE, sep = ";", col.names = names)

# Remove os erros
cepagri <- na.omit(cepagri)

# converte os valores de temperatura para valores numericos
cepagri$temp <- as.double(cepagri$temp)

# converte os valores de horario
cepagri$horario <- as.POSIXlt(cepagri$horario, format="%d/%m/%Y-%H:%M")

# Remove umidade 0
cepagri <- cepagri[cepagri$umid != 0,]

# retira as linhas antes de 2015 ou depois de 2021
cepagri <- cepagri[(cepagri$horario$year + 1900 > 2014 &
                      cepagri$horario$year + 1900 < 2022),]


