# ipyrad2bpp

A simple script to transform the `.loci` file obtained with [iPyrad](https://github.com/dereneaton/ipyrad) into the format required to run [BPP](https://github.com/bpp/bpp). BPP is computationally highly demanding, so you might want to run it using only a subset of loci from your dataset. To this end, I have created a second script that allows you to automatically obtain an input file for BPP including only a specific number of loci (e.g., 1000 loci).

## Usage and examples

### Step 1: Convert `.loci` file to BPP format

Run the script `ipyrad2bpp.sh`, using as input the `.loci` file obtained after running step 7 in iPyrad. You must also include in the same folder a file named `samples_map.txt`, which indicates the correspondence between the sample names in the `.loci` file (e.g., `sample01`, `sample02`, etc.; first column in `samples_map.txt` file) and the format required by BPP (i.e., sample names followed by a tag after `^`; e.g., `sample01^1`, `sample02^2`, etc.; second column in `samples_map.txt`). See the provided `samples_map.txt` for an example.

#### Command:

```bash
chmod u+x ipyrad2bpp.sh
./ipyrad2bpp.sh <input_file>
```

#### Example:

```bash
chmod u+x ipyrad2bpp.sh
./ipyrad2bpp.sh c85m25.loci
```

**Output:** A file named `BPP_All_Loci.txt`

---

### Step 2: Select a subset of loci

Run the script `select_loci.sh` to extract a specific number of loci from the output file obtained in the previous step (`BPP_All_Loci.txt`).

#### Command:

```bash
chmod u+x select_loci.sh
./select_loci.sh <input_file> <num_loci> <output_file>
```

#### Example: Extract 1000 loci

```bash
chmod u+x select_loci.sh
./select_loci.sh BPP_All_Loci.txt 1000 BPP_1000_Loci.txt
```

**Output:** A file named `BPP_1000_Loci.txt`

---

# References

Relevant papers of interest:

Eaton D.A.R., Overcast I. (2020) ipyrad: Interactive assembly and analysis of RADseq datasets. Bioinformatics, 36(8):2592-2594. doi.org/10.1093/bioinformatics/btz966

Flouri T., Jiao X., Rannala B., Yang Z. (2018) Species Tree Inference with BPP using Genomic Sequences and the Multispecies Coalescent. Molecular Biology and Evolution, 35(10):2585-2593. doi:10.1093/molbev/msy147

Flouri T., Jiao X., Rannala B., Yang Z. (2020) A Bayesian Implementation of the Multispecies Coalescent Model with Introgression for Phylogenomic Analysis. Molecular Biology and Evolution, 37(4):1211-1223. doi:10.1093/molbev/msz296

Flouri T., Huang J., Jiao X., Kapli P., Rannala B., Yang Z. (2022) Bayesian phylogenetic inference using relaxed-clocks and the multispecies coalescent. Molecular Biology and Evolution, 39(8), 2022. doi:10.1093/molbev/msac161

Flouri T., Jiao X., Huang J., Rannala B., Yang Z. (2023) Efficient Bayesian inference under the multispecies coalescent with migration. Proceedings of the National Academy of Sciences, 120(44):e2310708120, 2023. doi:10.1073/pnas.2310708120

Rannala B., Yang Z. (2013) Improved reversible jump algorithms for Bayesian species delimitation. Genetics, 194:245-253. doi:10.1534/genetics.112.149039

Rannala B., Yang Z. (2017) Efficient Bayesian Species Tree Inference under the Multispecies Coalescent. Systematic Biology, 66(5):823-842. doi:0.1093/sysbio/syw119

Yang Z., Rannala B. (2010) Bayesian species delimitation using multilocus sequence data. Proceedings of the National Academy of Sciences, 107(20):9264-9269. doi:10.1073/pnas.0913022107

Yang Z., Rannala B. (2014) Unguided species delimitation using DNA sequence data from multiple loci. Molecular Biology and Evolution, 31(12):3125-3135. doi:10.1093/molbev/msu279
