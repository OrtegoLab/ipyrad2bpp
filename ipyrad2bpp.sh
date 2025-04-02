#!/bin/bash

# Ensure an input filename is provided
if [ $# -ne 1 ]; then
    echo "Usage: $0 <input_file>"
    exit 1
fi

# Assign input filename from argument
input_file="$1"
edited_file="edited_${input_file}"
length_file="length.txt"
count_file="count.txt"
header_file="header.txt"
bpp_input="input_BPP.txt"
output_file="BPP_All_loci.txt"

# Ensure the input file exists
if [ ! -f "$input_file" ]; then
    echo "Error: File '$input_file' not found!"
    exit 1
fi

# Prepend '//' to the first line of input file and save to a new file
sed '1i //' "$input_file" > "$edited_file"

# Extract sequence lengths
awk '/\/\// {flag=1; next} flag { print length($0); flag=0 }' "$edited_file" > "$length_file"

# Adjust sequence lengths
name_length=$(awk 'NR == 2 {print index($0, "     ") + 4}' "$edited_file")
awk -v value="$name_length" '{print $1 - value}' "$length_file" > temp.txt && mv temp.txt "$length_file"

# Count the number of individuals per locus
awk '/\/\// {if (count) print count; count=0; next} {count++} END {if (count) print count}' "$edited_file" > "$count_file"

# Merge individual count and sequence length
paste -d ' ' "$count_file" "$length_file" > "$header_file"
echo "header" >> "$header_file"

# Insert header data into loci file
awk 'NR==FNR{line[++count]=$0; next} /^\/\//{if (i < count) print line[++i]; else print; next} {print}' "$header_file" "$edited_file" > "$bpp_input"

# Remove last line
sed -i '$d' "$bpp_input"

# Convert multiple spaces to tabs
sed -i 's/     /\t/g' "$bpp_input"

# Rename sample names using "samples_map.txt"
if [ -f "samples_map.txt" ]; then
    awk '{print "s/"$1"/"$2"/g"}' samples_map.txt | sed -f - "$bpp_input" > "$output_file"
else
    echo "Warning: 'samples_map.txt' not found. Skipping name replacement."
    cp "$bpp_input" "$output_file"
fi

# Clean up temporary files
rm "$length_file" "$count_file" "$header_file" "$bpp_input" "$edited_file"

echo "Processing complete! Output saved to '$output_file'."