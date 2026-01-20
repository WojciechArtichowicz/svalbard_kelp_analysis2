# setup
Sys.setenv(LANGUAGE="en")
Sys.setlocale("LC_TIME", "English")

#theme_set(theme_bw(base_size = 22))
print("setting up ggplot theme and colours")
theme_set(theme_bw())

# colors set-up
pts.color <- c(`GF`='#E41A1C', `H`='#FF7F00', `S1`="blue" , `S2`='#377EB8')
