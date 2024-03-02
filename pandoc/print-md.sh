#!/bin/bash

# Define input and output directories
input_dir="/data"
output_dir="$input_dir/output"
output_notes="$output_dir/notes.pdf"

# Ensure the output directory exists
mkdir -p "$output_dir"

# Loop through directories matching the pattern [0-9][0-9]-*
for dir in "$input_dir"/[0-9][0-9]-*; do
    if [ -d "$dir" ]; then
        # Extract directory name
        dir_name=$(basename "$dir")
        # Define output directory for current directory
        current_output_dir="$output_dir/$dir_name"
        
        # Ensure the output directory for this directory exists
        mkdir -p "$current_output_dir"
        
        title=$(basename "$dir")
        # Process all .md files within the current directory
        for file in "$dir"/*.md; do
            if [ -f "$file" ]; then
                # Extract the filename without the extension
                filename=$(basename -- "$file")
                filename_no_ext="${filename%.*}"
                
                # Generate PDF using Pandoc with WeasyPrint
                pandoc --pdf-engine=weasyprint "$file" \
                       --variable papersize="A4" \
                       --variable margin-right="0in" \
                       --variable margin-left="0in" \
                       --variable margin-top="0in" \
                       --variable margin-bottom="0in" \
                       --metadata title="$title" \
                       -o "$current_output_dir/${filename_no_ext}.pdf"
            fi
        done
    fi
done

# Merge all PDFs in the output directory into a single file
pdftk $(find "$output_dir" -type f -name '*.pdf' | sort) cat output "$output_notes"

# Delete all files in the output directory except notes.pdf
find "$output_dir" -mindepth 1 -not -name 'notes.pdf' -delete

echo "PDF files merged successfully!"
