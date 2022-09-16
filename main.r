setwd('/Users/u20154/Documents/analise-cepagri')
names <- c("horario", "temp", "vento", "umid", "sensa")
cepagri <- read.csv("./cepagri.csv", header = FALSE, sep = ";", col.names = names)

# converte os valores para numericos
cepagri <- as.numeric(cepagri)
# aqueles que estavam em string, como "[ERRO]"", ficam como NA, e logo sao
# retirados da tabela
cepagri <- cepagri[!(is.na(cepagri$horario) | is.na(cepagri$temp) |
is.na(cepagri$vento) | is.na(cepagri$umid) | is.na(cepagri$sensa)), ]

# ainda nao esta funcionando