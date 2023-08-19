# NLP Data Analysis and Processing

## Problem Statement

The AI Natural Language Processing (NLP) team has requested a basic analysis of some data files to provide preliminary insights before further processing. However, due to security reasons, the files need to be processed and analyzed on a server where Python isn't installed. Therefore, Data Engineer support is required to fulfill this task.

## Requirements

### Data Samples
- Book Text: [Link to Book Text](https://www.gutenberg.org/files/74/74-0.txt)
- City Data: [Link to City Data](http://www.smiffy.de/dbkda-2017/city.csv)

### Analysis

#### Book: The Adventures of Tom Sawyer
1. How many chapters does the book have?
2. Count the number of empty lines.
3. How often do the names "Tom" and "Huck" appear in the book?
4. How often do they appear together in one line?
5. What is the third word on line 1234?
6. Count the words and lines in the book.
7. Translate all words in the book to lowercase.
8. Count the frequency of each word in the book.
9. Order the words by frequency, starting with the highest.
10. Combine the steps 7, 8, and 9 using pipes.
11. Compare the results with another book: [Link to Another Book](http://www.gutenberg.org/files/2701/2701-0.txt)
12. Compare the 20 most frequent words in each book. How many are in common?

#### City Data
1. Create a working copy of the city data file for security.
2. Replace occurrences of "Amazonas" in Peru with "Province of Amazonas".
3. Print cities without population data.
4. Print line numbers of cities in Great Britain.
5. Delete records 5-12 and 31-34 from the city data.
6. Write a script that combines the commands from tasks 4 and 5 to delete British cities.

## Usage

To use the provided bash script for data analysis and processing, follow these steps:

Run the script: `./Src/result.sh`
