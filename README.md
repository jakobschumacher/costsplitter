
# What's this package `dividefair` about? 
This package splits the costs of a group activity. For example: if you go hiking with your friends the whole group has some costs that need to be divided. Somebody pays for the stay another one for the food. In the end you need to split fairly. In many cases you can split evenly. But sometimes this can be unfair. What if somebody had to leave early? What if somebody only participated in some activities? What if somebody booked a bed but couldnt show up? What if there is a person who earns less and others would like to chip in? What if there were children who eat less than a full grown adult? This R package tries to balance these problems to have a fair distribution. Friendship is great 


# Installation
```
# Install devtools first
install.packages("devtools")

# Install the package from github
devtools::install_github(github.com/jakobschumacher/dividefair)

# Start using the package
library(dividefair)
```

# How to use this package
So you are convinced that this package is something for you? You want to give it a try? Go ahead. Follow the following steps to divide the costs of an activity fair amongst all participants

First **prepare the input files**. This is the tricky part of the undertaking. You need to have two files where you collect all the information that you need. Fortunately you can use those files also during the planning of the group activity - so next time you start with a group activity write down the information acording to the following scheme. 

> The `participants.csv` file. This should be a csv file. There should be 4 types of columns in that file: person columns (something like *id*, *name* or *age*), grouping columns (usually called *group*), cost columns (that all start with the prefix *cost_* and the continue with the name of the cost) and lastely and adjustment column (called *adjustment*). You can have a look at the example file [participants.csv](inst/participants.csv)

> The `costs.csv` file. This file contains all the costs. One column must be *id*, one column must be the name of the cost and one column should contain the actual cost. You can have a look at the example file [costs.csv](inst/costs.csv)


Then **do the analysis**. This is the easy part. If the input files are in structured in the right way, all you need to do is run:

```
divide_fairly(participants_file = "link_to_participants_file.csv", costs_file = "link_to_costs_file.csv")
```

What this will do is: It reads in the files, checks if the files are structured in the right way, changes categorical values into numerical values, it calculates a weight based on the age, adjustment and the grade of involvement. In the end it gives out the amount that everybody needs to pay and whom the money should be paid.
