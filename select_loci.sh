#!/bin/bash

# Check if the correct number of arguments is provided
if [ "$#" -ne 3 ]; then
    echo "Usage: $0 <input_file> <num_loci> <output_file>"
    exit 1
fi

# Assign arguments to variables
input_file=$1
num_loci=$2
output_file=$3

# Check if the input file exists
if [ ! -f "$input_file" ]; then
    echo "Error: The input file '$input_file' does not exist."
    exit 1
fi

# Initialize counters
loci_count=0
inside_locus=0

# Create or clear the output file
> "$output_file"

# Read through the input file line by line
while IFS= read -r line; do
    # Check if the line matches the pattern of "NUMBER NUMBER"
    if [[ "$line" =~ ^[0-9]+[[:space:]][0-9]+$ ]]; then
        if [[ $loci_count -ge $num_loci ]]; then
            break
        fi
        loci_count=$((loci_count + 1))
    fi

    # If we are still within the required number of loci, write the line to the output file
    if [[ $loci_count -le $num_loci ]]; then
        echo "$line" >> "$output_file"
    fi
done < "$input_file"

echo "Successfully extracted $num_loci loci to '$output_file'."