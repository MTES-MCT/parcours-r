load("../data/rpls2016 graph.RData")
library(ggplot2)
library(hrbrthemes)
library(dplyr)
library(forcats)
library(viridis)
theme_map <- function(...) {
  theme_minimal() +
    theme(
      text = element_text(family = "Ubuntu Regular", color = "#22211d"),
      axis.line = element_blank(),
      axis.text.x = element_blank(),
      axis.text.y = element_blank(),
      axis.ticks = element_blank(),
      axis.title.x = element_blank(),
      axis.title.y = element_blank(),
      # panel.grid.minor = element_line(color = "#ebebe5", size = 0.2),
      panel.grid.major = element_line(color = "#ffffff", size = 0.2),
      panel.grid.minor = element_blank(),
      plot.background = element_rect(fill = "#ffffff", color = NA), 
      panel.background = element_rect(fill = "#ffffff", color = NA), 
      legend.background = element_rect(fill = "#ffffff", color = NA),
      panel.border = element_blank(),
      ...
    )
}

quantiles <- quantile(Carte_EPCI_France$`DPE énergie classe ABC_pourcent`, 
                      probs = seq(0, 1, length.out = 6))

# define a new variable on the data set just as above
Carte_EPCI_France$brks <- cut(Carte_EPCI_France$`DPE énergie classe ABC_pourcent`, 
                     breaks = quantiles,
                     include.lowest = T)
labels<-round(quantiles, 1)
labels<-labels[2:length(labels)]

Carte_EPCI_France$brks<-factor(Carte_EPCI_France$brks)
levels(Carte_EPCI_France$brks)<-labels

ggplot(filter(Carte_EPCI_France,epci_2017_52 == 1)) + 
  geom_sf(aes(fill=brks,color="")) + 
  scale_colour_manual(values=NA,
                      guide = guide_legend(
                        "Pas de parc récent",
                        direction = "horizontal",
                        keyheight = unit(2, units = "mm"),
                        keywidth = unit(14, units = "mm"),
                        title.position = 'top',
                        title.hjust = 0.5,
                        label.hjust = 1,
                        nrow = 1,
                        byrow = T,
                        # also the guide needs to be reversed
                        reverse = T,
                        label.position = "bottom"
                      )) +
  theme_map()+
  theme(axis.text = element_blank(),
        panel.grid = element_blank(),
        legend.position = "bottom")+
  scale_fill_manual(values=rev(magma(8)[2:7]),
                    breaks=rev(levels(Carte_EPCI_France$brks)),
                    name="Logements avec DPE GES A,B ou C (en %)",
                    drop = FALSE,
                    labels = rev(levels(Carte_EPCI_France$brks)),
                    guide = guide_legend(
                      order=1,
                      direction = "horizontal",
                      keyheight = unit(2, units = "mm"),
                      keywidth = unit(70 / length(labels), units = "mm"),
                      title.position = 'top',
                      # I shift the labels around, the should be placed 
                      # exactly at the right end of each legend key
                      title.hjust = 0.5,
                      label.hjust = 1,
                      nrow = 1,
                      byrow = T,
                      # also the guide needs to be reversed
                      reverse = T,
                      label.position = "bottom"
                    ))
  


ggplot(Carte_EPCI_France) + 
  geom_sf(aes(fill=brks,color="")) + 
  scale_colour_manual(values=NA,
                      guide = guide_legend(
                        "Pas de parc récent",
                        direction = "horizontal",
                        keyheight = unit(2, units = "mm"),
                        keywidth = unit(14, units = "mm"),
                        title.position = 'top',
                        title.hjust = 0.5,
                        label.hjust = 1,
                        nrow = 1,
                        byrow = T,
                        # also the guide needs to be reversed
                        reverse = T,
                        label.position = "bottom"
                      )) +
  theme_map()+
  theme(axis.text = element_blank(),
        panel.grid = element_blank(),
        legend.position = "bottom")+
  scale_fill_manual(values=rev(magma(8)[2:7]),
                    breaks=rev(levels(Carte_EPCI_France$brks)),
                    name="Logements avec DPE GES A,B ou C (en %)",
                    drop = FALSE,
                    labels = rev(levels(Carte_EPCI_France$brks)),
                    guide = guide_legend(
                      order=1,
                      direction = "horizontal",
                      keyheight = unit(2, units = "mm"),
                      keywidth = unit(70 / length(labels), units = "mm"),
                      title.position = 'top',
                      # I shift the labels around, the should be placed 
                      # exactly at the right end of each legend key
                      title.hjust = 0.5,
                      label.hjust = 1,
                      nrow = 1,
                      byrow = T,
                      # also the guide needs to be reversed
                      reverse = T,
                      label.position = "bottom"
                    ))
