#Data Wrangling Exercise 1: Basic Data Manipulation

#0: Load the data in RStudio
#Save the data set as a CSV file called refine_original.csv and load it in RStudio into a data frame.

library(dplyr)
library(tidyr)
refine_original <- read_csv("C:/Users/Chobani/Desktop/Spring Board - Intro to Data Science/refine_original.csv")
df <- refine_original


#1: Clean up brand names
#Clean up the 'company' column so all of the misspellings of the brand names are standardized. 
#For example, you can transform the values in the column to be: philips, akzo, van houten and unilever (all lowercase).

#lowercase
df$company <- tolower(df$company)

#correct spelling
df$company <- sub(pattern = ".*\\ps$" , replacement = "philips", x = df$company)
df$company <- sub(pattern = "^ak.*" , replacement = "akzo", x = df$company)
df$company <- sub(pattern = "^u.*" , replacement = "unilever", x = df$company)
df$company <- sub(pattern = "^v.*" , replacement = "van houten", x = df$company)

#2: Separate product code and number
#Separate the product code and product number into separate columns i.e. add two new columns called 
#product_code and product_number, containing the product code and number respectively.

df <- separate (df, "Product code / number" , c("product_code", "product_number"), sep = "-")

#3: Add product categories
#You learn that the product codes actually represent the following product categories:
# p = Smartphone
# v = TV
# x = Laptop
# q = Tablet 

df$product_category <-sub(pattern = "^p$", replacement = "Smartphone", sub("^x$", "Laptop", sub("^v$", "TV", sub("^q$", "Tablet", df$product_code))))

#4: Add full address for geocoding
#You'd like to view the customer information on a map. In order to do that, the addresses need to be 
#in a form that can be easily geocoded. Create a new column full_address that concatenates the three 
#address fields (address, city, country), separated by commas.


df <- df %>% 
  mutate(full_address = paste(address, city, country, sep = ", "))


#5: Create dummy variables for company and product category
#Both the company name and product category are categorical variables i.e. they take only a fixed set of values. 
#In order to use them in further analysis you need to create dummy variables. Create dummy binary variables for 
#each of them with the prefix company_ and product_ i.e.,

#Add four binary (1 or 0) columns for company: company_philips, company_akzo, company_van_houten and company_unilever.

#Add four binary (1 or 0) columns for product category: product_smartphone, product_tv, product_laptop 
#and product_tablet.

df <- mutate(df, company_philips = ifelse(company == "philips", 1, 0))
df <- mutate(df, company_akzo = ifelse(company == "akzo", 1, 0))
df <- mutate(df, company_van_houten = ifelse(company == "van houten", 1, 0))
df <- mutate(df, company_unilever = ifelse(company == "unilever", 1, 0))
df <- mutate(df, product_smartphone = ifelse(product_category == "Smartphone", 1, 0))
df <- mutate(df, product_tv = ifelse(product_category == "TV", 1, 0))
df <- mutate(df, product_laptop = ifelse(product_category == "Laptop", 1, 0))
df <- mutate(df, product_tablet = ifelse(product_category == "Tablet", 1, 0))


#6: Submit the project on Github

#Include your code, the original data as a CSV file refine_original.csv, and the cleaned up data 
#as a CSV file called refine_clean.csv.

write.csv(df, "refine_clean.csv")

