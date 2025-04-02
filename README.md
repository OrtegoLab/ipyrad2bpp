# ipyrad2bpp

A simple script to transform the `.loci` file obtained with [iPyrad](https://github.com/dereneaton/ipyrad) into the format required to run [BPP](https://github.com/bpp/bpp). BPP can be computationally demanding, so you might want to run it using only a subset of loci from your dataset. To this end, I have created a second script that allows you to automatically create an input file for BPP including only a specific number of loci (e.g., 1000 loci).

## Usage and Examples

### Step 1: Convert `.loci` File to BPP Format

Run the script `ipyrad2bpp.sh`, using as input the `.loci` file obtained after running step 7 in iPyrad. You must also include in the same folder a file named `samples_map.txt`, which indicates the correspondence between the sample names in the `.loci` file (e.g., `sample01`, `sample02`, etc.) and the format required by BPP (i.e., sample names followed by a tag after `^`; e.g., `sample01^1`, `sample02^2`, etc.). See the provided `samples_map.txt` for an example.

#### Command:

```bash
chmod u+x ipyrad2bpp.sh
./ipyrad2bpp.sh <input_file>
```

#### Example:

```bash
./ipyrad2bpp.sh c85m25.loci
```

**Output:** A file named `BPP_All_Loci.txt`

---

### Step 2: Select a Subset of Loci

Run the script `select_loci.sh` to extract a specific number of loci from the output file obtained in the previous step (`BPP_All_Loci.txt`).

#### Command:

```bash
chmod u+x select_loci.sh
./select_loci.sh <input_file> <num_loci> <output_file>
```

#### Example: Extract 1000 loci

```bash
./select_loci.sh BPP_All_Loci.txt 1000 BPP_1000_Loci.txt
```

**Output:** A file named `BPP_1000_Loci.txt`

---



