setwd('/Users/u20154/Documents/analise-cepagri')
names <- c("horario", "temp", "vento", "umid", "sensa")
cepagri <- read.csv("./cepagri.csv", header = FALSE, sep = ";", col.names = names)

# converte os valores de temperatura para valores numericos
cepagri$temp <- as.numeric(cepagri$temp)

cepagri$horario <- as.POSIXlt(cepagri$horario, format="%d/%m/%Y-%H:%M")

# retira as linhas antes de 2015 ou depois de 2021
cepagri <- cepagri[(cepagri$horario$year + 1900 > 2014 &
    cepagri$horario$year + 1900 < 2022),]

# retira linhas com temperaturas e umidades improvaveis
cepagri <- cepagri[cepagri$temp > -10.0 & cepagri$temp < 45.0,]    
cepagri <- cepagri[(cepagri$umid != 100.0 & cepagri$umid != 0),]    

# retira as linhas que contém erros, ou seja, são NA
# cepagri <- cepagri[!(is.na(cepagri$horario) | is.na(cepagri$temp) |
#     is.na(cepagri$vento) | is.na(cepagri$umid) | is.na(cepagri$sensa)), ]

# summary(cepagri)
tail(cepagri, 5)