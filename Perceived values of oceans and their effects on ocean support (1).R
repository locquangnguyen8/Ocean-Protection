# Load data and package
data1<-read.csv("C:/Users/ACER/Dropbox/Research/@_Team/@_Fandom/BMF collaborative projects/2023/Datasets/Marine and coastal ecosystems and climate change/Survey_Fonsecaetal_07122022.csv",header = TRUE,stringsAsFactors = TRUE)
library(bayesvl)
library(cowplot)
library(ggplot2)

data1$SupportforOcean <- data1$Q12_6

keeps <- c("SupportforOcean","Economic_Food","Culture_Recreation","Culture_MentalHealth_Wellbeing","Economic_Transport",
           "Economic_RenewableEnergy","Economic_RawMaterial","Culture_Aesthetics","Culture_SenseofIdentity","Economic_OilandGas","Culture_HistoryandHeritage")
data1 <- data1[keeps]
data1<-na.omit(data1)


# Model construction: Model 1
model1<-bayesvl()
model1<-bvl_addNode(model1,"SupportforOcean","norm")
model1<-bvl_addNode(model1,"Economic_Food","binom")
model1<-bvl_addNode(model1,"Economic_Transport","binom")
model1<-bvl_addNode(model1,"Economic_RenewableEnergy","binom")
model1<-bvl_addNode(model1,"Economic_RawMaterial","binom")
model1<-bvl_addNode(model1,"Economic_OilandGas","binom")

model1<-bvl_addArc(model1,"Economic_Food","SupportforOcean","slope")
model1<-bvl_addArc(model1,"Economic_Transport","SupportforOcean","slope")
model1<-bvl_addArc(model1,"Economic_RenewableEnergy","SupportforOcean","slope")
model1<-bvl_addArc(model1,"Economic_RawMaterial","SupportforOcean","slope")
model1<-bvl_addArc(model1,"Economic_OilandGas","SupportforOcean","slope")

bvl_bnPlot(model1)

# Generate Stan code
model_string1<- bvl_model2Stan(model1)
cat(model_string1) 

# Model Fit
model1<-bvl_modelFit(model1, data1, warmup = 2000, iter = 5000, chains = 1,cores = 4)
summary(model1)


# Model construction: Model 1
model2<-bayesvl()
model2<-bvl_addNode(model2,"SupportforOcean","norm")
model2<-bvl_addNode(model2,"Culture_Recreation","binom")
model2<-bvl_addNode(model2,"Culture_MentalHealth_Wellbeing","binom")
model2<-bvl_addNode(model2,"Culture_Aesthetics","binom")
model2<-bvl_addNode(model2,"Culture_SenseofIdentity","binom")
model2<-bvl_addNode(model2,"Culture_HistoryandHeritage","binom")

model2<-bvl_addArc(model2,"Culture_Recreation","SupportforOcean","slope")
model2<-bvl_addArc(model2,"Culture_MentalHealth_Wellbeing","SupportforOcean","slope")
model2<-bvl_addArc(model2,"Culture_Aesthetics","SupportforOcean","slope")
model2<-bvl_addArc(model2,"Culture_SenseofIdentity","SupportforOcean","slope")
model2<-bvl_addArc(model2,"Culture_HistoryandHeritage","SupportforOcean","slope")

bvl_bnPlot(model2)

# Generate Stan code
model_string1<- bvl_model2Stan(model2)
cat(model_string1) 

# Model Fit
model2<-bvl_modelFit(model2, data1, warmup = 2000, iter = 5000, chains = 1,cores = 4)
summary(model2)