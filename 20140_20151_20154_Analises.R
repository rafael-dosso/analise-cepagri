setwd('/Users/Windows10/Documents/E. Tecnico/R')
names <- c("horario", "temp", "vento", "umid", "sensa")
cepagri <- read.csv("./cepagri.csv", header = FALSE, sep = ";", col.names = names)

# Remove os erros
cepagri <- na.omit(cepagri)

# converte os valores de temperatura para valores numericos
cepagri$temp <- as.double(cepagri$temp)

# converte os valores de horario
cepagri$horario <- as.POSIXlt(cepagri$horario, format="%d/%m/%Y-%H:%M")
#cepagri$horario <- as.POSIXct(cepagri$horario, format="%d/%m/%Y-%H:%M")

# Remove umidade 0
cepagri <- cepagri[cepagri$umid != 0,]

# retira as linhas antes de 2015 ou depois de 2021
cepagri <- cepagri[(cepagri$horario$year + 1900 > 2014 &
                      cepagri$horario$year + 1900 < 2022),]

# ------------------------------------------------------------------------------

# Analise 1

library(ggplot2)

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

# Cria o grafico com os dados de 2016 e salva em um PDF
pdf("grafico2016.pdf")

g16 <- ggplot(t2016, aes(x = horario, y = temp))
g16 <- g16 + geom_line(aes(y = temp, colour = "Variação de temperatura")) 
g16 <- g16 + geom_smooth(aes(y = temp, colour = "Temperatura media"))
g16 <- g16 + labs(colour = "Legenda:", title = "Temperatura em 2016");
print(g16)

dev.off ()

# ------------------------------------------------------------------------------
# Analise 2

library(ggplot2)

tSensa21 <- data.frame(
  horario = cepagri$horario[(cepagri$horario$year + 1900 == 2021),],
  sensa = cepagri$sensa[cepagri$horario$year== 121]
)

tSensa21$horario <- as.POSIXct(tSensa21$horario, format="%d/%m/%Y-%H:%M")

pdf("graficoSensa21.pdf")

g21 <- ggplot(tSensa21, aes(x = sensa)) + geom_histogram(
  color = "White", bins=15
)
g21 <- g21 + labs(colour = "Legenda:", title = "Frequência de Sensação Térmica 2021");
print(g21)


dev.off ()

# ------------------------------------------------------------------------------
# Analise 3

# Tabela com as datas de 2017 e as umidades:
t17 <- data.frame(
  Year = cepagri$horario$year[(cepagri$horario$year + 1900 == 2017)] + 1900,
  umid = cepagri$umid[(cepagri$horario$year + 1900 == 2017)]
)

# Tabela com as frequencia das umidades de 2017, separadas em 4 grupos
# 1 a 25, 26 a 50, 51 a 75, 76 a 100.
tFreq <- data.frame(
  Umid = c("1-25", "26-50", "51-75", "76-100"),
  Freq = c(length(c(t17$umid[t17$umid <= 25])),
           length(c(t17$umid[(t17$umid > 25) & (t17$umid<=50)])),
           length(c(t17$umid[(t17$umid > 50) & (t17$umid<=75)])),
           length(c(t17$umid[(t17$umid > 75) & (t17$umid<=100)]))
  ),
  Rotulo = c("Quantidade","Quantidade","Quantidade","Quantidade")
)

# Grafico de Pizza:
pdf("graficoPizza.pdf")

gPizza <- ggplot(tFreq[tFreq$Rotulo == "Quantidade",],
                 aes(x = "Quantidade", weight = Freq, fill = Umid))
gPizza <- gPizza + geom_bar()
gPizza <- gPizza + coord_polar(theta = "y")
gPizza <- gPizza + theme(axis.title.x=element_blank(), axis.title.y=element_blank(), axis.ticks=element_blank(), panel.border=element_blank(), panel.grid=element_blank());
gPizza <- gPizza + labs(title = "Umidade em 2017");
print(gPizza)

dev.off () 


# ------------------------------------------------------------------------------
# Analise 4

library(ggplot2)

# Cria esqueleto da tabela principal
tMedias <- data.frame(
  Ano = double(),
  TempMedia = double()
)


# Metodo para preencher a tabela principal com as medias das temperaturas de cada mes
for(i in 0:6){
  
  tAno <- cepagri[(cepagri$horario$year + 1900 == 2015 + i),]
  
  for(a in 1:9){
    
    mes <- as.double(a/100)
    
    aux<-data.frame(
      ((tAno$horario$year + 1900)[1]) + mes,
      mean(tAno$temp[format(tAno$horario, "%m") == paste(c("0",a), collapse = "")])
    )
    names(aux)<-c("Ano", "TempMedia")
    
    tMedias <- rbind(tMedias, aux)
  }
  
  for(b in 10:12){
    
    mes <- as.double(b/100)
    
    aux<-data.frame(
      ((tAno$horario$year + 1900)[1]) + mes,
      mean(tAno$temp[format(tAno$horario, "%m") == paste(c("",b), collapse = "")])
    )
    names(aux)<-c("Ano","TempMedia")
    
    tMedias <- rbind(tMedias, aux)
  }
}

# Gráfico:

pdf("grafico7anos.pdf")

g7 <- ggplot(tMedias, aes(x = Ano, y = TempMedia))
g7 <- g7 + geom_line() 
g7 <- g7 + geom_point(aes(y = TempMedia, colour = "Meses")) 
g7 <- g7 + labs(colour = "Legenda:", title = "Variação de Temperatura");
print(g7)

dev.off ()


