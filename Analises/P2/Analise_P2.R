install.packages("ggplot2")
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
