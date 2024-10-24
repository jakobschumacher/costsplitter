---
output: github_document
---

# What's `costsplitter` about? 
The package `costsplitter` is an R package designed to simplify the task of splitting costs for group activities. While evenly dividing expenses among participants is straightforward in many situations, real-world scenarios often require a more nuanced approach. The package `costsplitter` addresses various factors that can complicate cost-sharing:

* Partial participation (e.g., leaving early or joining late)
* Involvement in only select activities
* Unused reservations or no-shows
* Income disparities among group members
* Age-based consumption differences (e.g., children vs. adults)

By considering these variables, `costsplitter` calculates a fair distribution of expenses, ensuring that each participant contributes an amount proportional to their involvement and circumstances. Whether you're planning a hiking trip, shared vacation, or any group event with shared costs, `costsplitter` offers a sophisticated solution to the often challenging task of equitable expense allocation.

So you are convinced that this package is something for you? You want to give it a try? Go ahead. Follow the following steps to divide the costs of an activity fair amongst all participants


## Installation

``` r
# Install the package from github
devtools::install_github("github.com/jakobschumacher/costsplitter")
```

## Example
A group of friends go on a hike for two days together with kids

Here is an example of a suitable dataset. 

|name           |group   |age   |cost_day1 | pay_day1|cost_day2 | pay_day2|adjustment |
|:--------------|:-------|:-----|:---------|--------:|:---------|--------:|:----------|
|James Smith    |Smith   |adult |full      |       NA|full      |       NA|NA         |
|Olivia Johnson |Johnson |NA    |0.8       |       NA|full      |       NA|less       |
|Ethan Brown    |Brown   |3     |full      |       NA|full      |       NA|NA         |
|Amelia Taylor  |Smith   |adult |full      |       NA|full      |      657|NA         |
|Lucas Wilson   |Wilson  |adult |NA        |       NA|NA        |       NA|NA         |
|Emma Davis     |Smith   |NA    |full      |      800|full      |       NA|NA         |


