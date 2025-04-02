# ipyrad2bpp
A simple script to transform the ".loci" file obtained with iPyrad (https://github.com/dereneaton/ipyrad) to the format required to run BPP (https://github.com/bpp/bpp). The program BPP can be computationally highly demanding and you might want to run it only using a subset of loci from your dataset. To this end, I have created a second script that allow you to automatically create an input file for BPP only including a specific number of loci (e.g., 1000 loci). 

# Usage
chmod u+x ipyrad2bpp.sh
"./ipyrad2bpp.sh <input_file>"
chmod u+x ipyrad2bpp.sh
"./select_loci.sh <input_file> <num_loci> <output_file>"

# Examples 

The first step is to run the script "ipyrad2bpp.sh", using as input file the ".loci" file obtained after running "step 7" in iPyrad. You must include in the same folder a file (individual_map.txt) indicating the correspondence between the names of your samples in the ".loci" file (e.g., sample01, sample02, sample03, etc.) and the names in the format required by BPP (i.e., name of your sample with a tag after ^; e.g., sample01^1, sample02^2, sample03^3, etc) (for an example, see individual_map.txt)

./ipyrad2bpp.sh <input_file>

Example:

./ipyrad2bpp.sh c85m25.loci

The output is a file called "All_Loci.txt"

The second step is to run the script "select_loci.sh" to extract from the output file obtained in the previous step ("All_Loci.txt") a specific number of loci:

./select_loci.sh <input_file> <num_loci> <output_file>

Example to obtain a dataset only containing 1000 loci: 

./select_loci.sh All_Loci.txt 1000 1000_Loci.txt

The output is a file called "1000_Loci.txt"
