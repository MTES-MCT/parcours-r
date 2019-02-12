getwd()
tt<-bind_rows(
  indicateur311 %>%
    select(`Parent Country or Area Code`, `Country or Area Code`,`Country or Area Name`) %>%
    distinct,
  indicateur111 %>%
    select(`Parent Country or Area Code`,`Country or Area Code`,`Country or Area Name`) %>%
    distinct
  ) %>%
  distinct()

write.csv(tt,"../data/pays.csv")

indicateur0 %>%
  select(`Country or Area Name`) %>%
  distinct %>%
  left_join(tt) %>%
  write.csv("../data/pays2.csv")

