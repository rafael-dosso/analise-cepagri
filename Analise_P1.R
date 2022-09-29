install.packages("ggplot2")
library(ggplot2)

# Criar tabela que contem dados de 2015 only
t2015 <- cepagri[(cepagri$horario$year + 1900 == 2015),]
t2016 <- cepagri[(cepagri$horario$year + 1900 == 2016),]

pdf("grafico2015.pdf")

g15 <- ggplot(t2015, aes(x = horario, y = temp))
g15 <- g15 + geom_line() 
g15 <- g15 + geom_smooth()
print(g15)

dev.off () # Fecha o arquivo


t2015$horario <- as.POSIXct(t2015$horario, format="%d/%m/%Y-%H:%M")

t <- ggplot(t2015, aes(x = horario, y = temp))
t <- t + geom_point() # Adiciona camada: Gráfico de Pontos
t <- t + geom_line() # Adiciona camada: Gráfico de Linha 
t <- t + geom_smooth()
print(t) # Salva o gráfico no arquivo indicado

tabelaAnos <- cepagri[cepagri$horario >= as.POSIXct("01/01/2015-00:00", "%d/%m/%Y-%H:%M", tz=Sys.timezone()) 
                     & cepagri$horario >= as.POSIXct("01/01/2016-00:00", "%d/%m/%Y-%H:%M", tz=Sys.timezone()),]