#!/bin/bash

# Read the input text file
input_file="output.txt"
input_text=$(cat $input_file)
#1. How many chapters has the book
chapter_count=$(echo "$input_text" | grep -cE "^CHAPTER [IVX]+\. ")
echo "1. Number of chapters: $chapter_count"
#2. How many number of empty line.
emptyline_count=$(echo "$input_text" | grep -c '^[[:space:]]*$')
#emptyline_count=$(echo "$input_text" | grep -n '^[[:space:]]*$')
echo "2. Number of Emptyline: $emptyline_count"

#3. how often does the names "Tom" and "Huck" appears in the books.
Tom_count=$(echo "$input_text" | grep -c "Tom")
Huck_count=$(echo "$input_text" | grep -c "Huck")
echo "3. Number of Tom is: $Tom_count, Huck is: $Huck_count"

#4. How often do they appear together in one line?
count=0
while read -r line; do
  if [[ $line == *"Tom"* ]] && [[ $line == *"Huck"* ]]; then
	((count++))
  fi
done <<< "$input_text"
echo "4. Number of appear together in one line: $count"

#5. Go to line 1234 of the file. What is the third word?
num=0
while read -r line; do
  ((num++))
  if [[ $num == 1234 ]]
  then
        myarray=($line)
        myword=${myarray[2]}  
  fi
done <<< "$input_text"
echo "5. The third word at line 1234 is: $myword"

#6. get number of wornd number of line.
word=$(echo -n "$input_text" | wc -w)
line=$(echo -n "$input_text" | wc -l)
((line++))
echo "6. The number of words: $word, line: $line"

#7. Translate all words of the book into lowercase
lowercase=$(echo "$input_text" | tr '[:upper:]' '[:lower:]')
#echo "7. Convert to lowercase: $lowercase"
echo "7. Converted to lowercase"
#8. Count, how often each word in this book appears
echo "8. count,how often of each word in 20 words with highest frequency:" 
clean_text=$(echo "$lowercase" | sed 's/[[:punct:]]//g')

declare -A my_array

for word in ${clean_text[@]}; do
        ((my_array[$word]++))
done

for word in "${!my_array[@]}"; do
  count=${my_array[$word]}
  if ((count > 10)); then
   echo " $count: $word"
  fi
done |sort -nr | head -n 20

#9. Order the result, starting with the word with the highest frequency. Which word is it?
echo "9. The word with highest frequency:"
for word in "${!my_array[@]}"; do
  count=${my_array[$word]}
  if ((count > 10)); then
   echo " $count: $word"
  fi
done |sort -nr |  head -n 1

#10.Write all the above steps (7,8,9) in one statement (using pipes)
pipes=$(echo "$clean_text" | tr '[:upper:]' '[:lower:]' | sed 's/[[:punct:]]//g' | tr ' ' '\n' | sort | uniq -c | sort -nr | head -n 20 | awk '{ printf "%-3s:%s\n", $1, $2 }')
echo "10. Using pipes: $pipes"

#11. Compare the result with the result from the following book: 
#[http://www.gutenberg.org/files/2701/2701-0.txt](http://www.gutenberg.org/files/2701/2701-0.txt)
input_file1="output1.txt"
input_text1=$(cat $input_file1)
pipes1=$(echo "$input_text1" | tr '[:upper:]' '[:lower:]' | sed 's/[[:punct:]]//g' | tr ' ' '\n' | sort | uniq -c | sort -nr | head -n 20 | awk '{ printf "%-3s:%s\n", $1, $2 }')

#echo "$pipes1"

pipes_1=$(echo "$input_text" | tr '[:upper:]' '[:lower:]' | sed 's/[[:punct:]]//g' | tr ' ' '\n' | sort | uniq -c | sort -nr | head -n 20 | awk '{ printf "%s\n",$2 }')
pipes1_1=$(echo "$input_text1" | tr '[:upper:]' '[:lower:]' | sed 's/[[:punct:]]//g' | tr ' ' '\n' | sort | uniq -c | sort -nr | head -n 20 |awk '{ printf "%s\n", $2}')
count=0
for elem_1 in ${pipes_1[@]}; do
  for elem1_1 in ${pipes1_1[@]}; do
	if [[ "$elem_1" == "$elem1_1" ]]; then
		((count++))
	fi
done
done
echo "11. There are $count in common"




#File city.csv
echo ""
echo "File city.csv"
#1. Create a working copy of your file city.csv (for security reasons)
file="city.csv"
#copy file
cp "$file" "workingcp_city.csv"
echo ""
echo "1. Created working copy"
echo ""
#2.Exchange in the file all occurences of the Province "Amazonas" in Peru (Code PE) with "Province of Amazonas"
COLUMN_INDEX=2
old_word="Amazonas"
new_word="Province of Amazonas"
echo "2.Exchange 'Amazonas' to 'Province of Amazonas': "
while IFS=',' read -r -a line; do
    if [[ "${line[COLUMN_INDEX]}" == "${old_word}" ]] && [[ "${line[COLUMN_INDEX-1]}" == "PE" ]] ; then
	line[COLUMN_INDEX]="${new_word}"
	echo "${line[@]}"
    fi
done < "$file"
#3. Print all cities which have no population given.
COL_INDEX=3
echo "3.Print all cities which have no population given"
while IFS=',' read -r -a line; do
    if [[ "${line[COL_INDEX]}" == "NULL" ]]; then
        echo "${line[COL_INDEX-3]}"
    fi
done < "$file" | uniq
#4. Print the line numbers of the cities in Great Britain (Code: GB)
COL_IN=1
count=0
echo "4.Print the line numbers of the cities in Great Britain (Code: GB)"
while IFS=',' read -r -a line; do
    if [[ "${line[COL_IN]}" == "GB" ]]; then
        echo "${line[0]}"
	((count++))
    fi
#echo "The line numbers of the cities in GB: $count"
done < "$file"
echo "The line numbers of the cities in GB: $count"

#5. Delete the records 5-12 and 31-34 from city.csv and store the result in city.2.csv
count=1
temp_file="tempfile.csv"
city2="city.2.csv"
> "$temp_file"
while IFS=',' read -r -a line; do
 if [[ "$count" -ge 5 && "$count" -le 12 || "$count" -ge 31 && "$count" -le 34 ]]; then
	echo "${line[@]}" >> "$city2"
 else
	echo "${line[@]}" >> "$temp_file"
fi
	((count++))
done < "$file" 
rm "$file"
mv "$temp_file" "$file"
echo ""
echo "5. Removed from city.csv and stored in city.2.csv"
echo ""

#6.Combine the used commands from the last two tasks and write a bash-script (sequence of commands), which delete all british cities from the file city.csv

temp_file_1="tempfile_1.csv"
>"temp_file_1"
while IFS=',' read -r -a line; do 
 if [[ "${line[2]}" == "British" ]]; then
        echo "${line[@]}"
 else
        echo "${line[@]}" >> "$temp_file_1"
fi
done < "$file" 
rm "$file"
mv "$temp_file_1" "$file"
echo ""
echo "6. delete all british cities from the file city.csv"
echo ""

