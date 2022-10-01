install.packages("ggplot2")
library(ggplot2)

# Criar tabela que contem dados apenas de 2015 e outra de 2016
t2015 <- cepagri[(cepagri$horario$year + 1900 == 2015),]
t2016 <- cepagri[(cepagri$horario$year + 1900 == 2016),]

# Altera a coluna horario para poder criar o grafico
t2015$horario <- as.POSIXct(t2015$horario, format="%d/%m/%Y-%H:%M")
t2016$horario <- as.POSIXct(t2016$horario, format="%d/%m/%Y-%H:%M")

# Cria o grafico com dados de 2015 e salva em um PDF
pdf("grafico2015.pdf")

g15 <- ggplot(t2015, aes(x = horario, y = temp))
g15 <- g15 + geom_line(aes(y = temp, colour = "Variação de temperatura"));
g15 <- g15 + geom_smooth(aes(y = temp, colour = "Temperatura media"))
g15 <- g15 + labs(colour = "Legenda:", title = "Temperatura em 2015");
print(g15)



dev.off () 

# Altera a coluna horario para poder criar o grafico


# Cria o grafico com os dados de 2016 e salva em um PDF
pdf("grafico2016.pdf")

g16 <- ggplot(t2016, aes(x = horario, y = temp))
g16 <- g16 + geom_line(aes(y = temp, colour = "Variação de temperatura")) 
g16 <- g16 + geom_smooth(aes(y = temp, colour = "Temperatura media"))
g16 <- g16 + labs(colour = "Legenda:", title = "Temperatura em 2016");
print(g16)

dev.off ()