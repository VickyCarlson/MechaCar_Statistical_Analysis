# Import dplyr and ggplot libraries
library(dplyr)
library(ggplot2)
library(reshape2)

# read in .csv file
cars_table <- read.csv(file='MechaCar_mpg.csv',check.names=F,stringsAsFactors = F) 

# Multiple linear regression for several variables.
lm(mpg ~ vehicle_length + vehicle_weight + spoiler_angle + ground_clearance + AWD,data=cars_table)

# summary() Function to obtain statistical metrics
summary(lm(mpg ~ vehicle_length + vehicle_weight + spoiler_angle + ground_clearance + AWD,data=cars_table))

# Create plot to view variable values
cars_table2 = melt(cars_table, id.vars='mpg')
ggplot(cars_table2) +
  geom_point(aes(value,mpg, color=variable),) + geom_smooth(aes(value,mpg, color=variable), method=lm, se=FALSE) +
  facet_wrap(~variable, scales="free_x") +
  labs(x = "Variable Value", y = "MPG")

# read in .csv file
susp_table <- read.csv(file='Suspension_Coil.csv',check.names=F,stringsAsFactors = F) 

# Create summary statistics table for the suspension coil's PSI column.
total_summary <- susp_table %>% summarize(Mean=mean(PSI), Median=median(PSI), Variance=var(PSI),
  SD=sqrt(var(PSI)),.groups='keep')

# Create a data frame to group each manufacturing lot by the mean, 
# median, variance, and standard deviation of the suspension coil's PSI column.
lot_summary <- susp_table %>% group_by(Manufacturing_Lot) %>% summarize(Mean=mean(PSI), 
  Median=median(PSI), Variance=var(PSI), SD=sqrt(var(PSI)),.groups='keep')

# Create a data frame to group each manufacturing lot by the mean, 
# median, variance, and standard deviation of the suspension coil's PSI column.
lot_summary2 <- susp_table %>% group_by(Manufacturing_Lot) %>% summarize(Mean=mean(PSI), 
  Median=median(PSI), Variance=var(PSI), SD=sqrt(var(PSI)), Max=max(PSI), Min=min(PSI),.groups='keep')

# Test if the PSI across all manufacturing lot is statistically different 
# from the population mean of 1,500 pounds per square inch.
t.test(susp_table$PSI,mu=1500)

#Script 1
t.test(subset(susp_table,Manufacturing_Lot=="Lot1")$PSI,mu = 1500)

#Script 2
t.test(subset(susp_table,Manufacturing_Lot=="Lot2")$PSI,mu = 1500)

#Script 3
t.test(subset(susp_table,Manufacturing_Lot=="Lot3")$PSI,mu = 1500)

# Plot Manufacturing Lots 1-3
plt <- ggplot(susp_table,aes(x=Manufacturing_Lot,y=PSI, fill=Manufacturing_Lot)) 
plt + geom_boxplot() + theme(axis.text.x=element_text(angle=45,hjust=1)) 


