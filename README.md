
# What’s this package `costsplitter` about?

The package `costsplitter` is an R package designed to simplify the
complex task of splitting costs for group activities. While evenly
dividing expenses among participants is straightforward in many
situations, real-world scenarios often require a more nuanced approach.
The package `costsplitter` addresses various factors that can complicate
cost-sharing:

- Partial participation (e.g., leaving early or joining late)
- Involvement in only select activities
- Unused reservations or no-shows
- Income disparities among group members
- Age-based consumption differences (e.g., children vs. adults)

By considering these variables, `costsplitter` calculates a fair
distribution of expenses, ensuring that each participant contributes an
amount proportional to their involvement and circumstances. Whether
you’re planning a hiking trip, shared vacation, or any group event with
shared costs, `costsplitter` offers a sophisticated solution to the
often challenging task of equitable expense allocation.

# Installation

``` r
# Install the package from github
devtools::install_github(github.com/jakobschumacher/costsplitter)
```

# Step 1: Prepare the data

So you are convinced that this package is something for you? You want to
give it a try? Go ahead. Follow the following steps to divide the costs
of an activity fair amongst all participants

First **prepare the input files**. This is the tricky part of the
undertaking. You need to have your data in a correct format, otherwise
the function will not work correctly. Use a spreadsheet that can also be
helpful during the planning of the group activity. The data should
conatin the following columns:

> The `name` column. This column indicates the names of the person
> involved. This is a must have column otherwise the package will throw
> an error. The names must be unique.

> The `pay_` columns. These columns hold the amount that somebody paid
> for one activity. At least one `pay_` column must be available. All
> `pay_` columns should either start with `pay_` or a string given by
> `var_pay`. For everything slightly more complicated you want to match
> the `pay_`column with the `share_`columns. This must be done by a
> corresponding part after the `_` e.g. `pay_breakfast`and
> `share_breakfast`. The value should be numeric.

> The `share_`columns. These columns hold the share that everyone has to
> pay for the activity. All `share_` columns should either start with
> `share_` or a string given by `var_share`. The second part of the name
> after the `_` must correspond to the `pay_`column. The value can be
> numeric between 0 (meaning does not hove to pay) and 1 (pays his full
> share) and they can also hold categorical values `full` or `reduced`
> or `half` or `some`. These categorical values will be transformed to
> numerical values. The corresponding value can be controlled with the
> function arguments `value_full`, `value_reduced`, `value_half` or
> `value_some` respectively. NA values and empty values will be
> translated into 0.

> The `group` column. Several persons can be put together to form a
> group. This can be indicated in this column.

> The `age` column. This column indicates the age of the persons
> involved. The value should be an integer value between 0 and 120. The
> value could also be either `adult` or `kid`, that will be translated
> into 1 and 0.5 respectively. NA values and empty values will be
> translated into 1.

> The `adjustment` column. To give a general bonus or malus that will
> apply the complete amount somebody has to pay you can use the
> adjustment column. This column can be numeric between 0 (indicating no
> pay) and 100 (indicating 100x times the normal share). The value can
> also be categorical with `more` indicating that the person should pay
> 1.2 times more and `less` indicating that the person should pay only
> 0.8 of the usual amount. NA values and empty values will be translated
> into 1.

Here is an example of a suitable dataset.

| name           | group   | age   | cost_day1 | pay_day1 | cost_day2 | pay_day2 | adjustment |
|:---------------|:--------|:------|:----------|---------:|:----------|---------:|:-----------|
| James Smith    | Smith   | adult | full      |       NA | full      |       NA | NA         |
| Olivia Johnson | Johnson | NA    | 0.8       |       NA | full      |       NA | less       |
| Ethan Brown    | Brown   | 3     | full      |       NA | full      |       NA | NA         |
| Amelia Taylor  | Smith   | adult | full      |       NA | full      |      657 | NA         |
| Lucas Wilson   | Wilson  | adult | NA        |       NA | NA        |       NA | NA         |
| Emma Davis     | Smith   | NA    | full      |      800 | full      |       NA | NA         |

# Step 2: Do the analysis

This is the easy part. If the input files are in structured in the right
way, all you need to do is run:

``` r
# Load the package
library(costsplitter)

# Read in the data
data <- read.csv('your_data_set.csv')

# Do the analysis
costsplitter(data)
```

What this will do is: It reads in the files, checks if the files are
structured in the right way, changes categorical values into numerical
values, it calculates a weight based on the age, adjustment and the
grade of involvement. In the end it gives out the amount that everybody
needs to pay and whom the money should be paid.

Here is an example of an analysis where many features are controlled

``` r
# Load the package
library(costsplitter)

# Read in the data
data <- read.csv('your_data_set.csv')

# Do the analysis
costsplitter(data,
    var_share = "payindicator_", # Replacing the *share_* to *payindicator_*
    use_adjustment = FALSE, # Explicitly state that no adjustment should be used
    use_age = TRUE, # Explicitly stating that age should be used
    value_kid = 0.8) # Setting the percentage what kids should pay
```
