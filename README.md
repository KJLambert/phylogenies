# phylogenies
I've made phylogenetic trees using a variety of publicly available programs. I keep track of the ones I've tried in this repository.

## Use the ncbi datasets API to pull genomes for phylogeny building eg...
datasets download genome taxon Paenibacillus --reference
Each phylogeny builder requires extracting the genomes into a specific directory structure..

## using VBCG (validated core genes)
#VBCG is highly preferred compared to the other methods for fast and validated workflow
## install based on instructions at https://github.com/tianrenmaogithub/vbcg
mamba activate vbcg
python3 vbcg/bin/vbcg.py -i genomes/ -o phylogeny-result/ -m raxml -n 4 
#raxml is slower but generates bootstrap values

# installation and use of joyltree on EC2
#mamba + jolytree was extremely strainghtforward
wget https://github.com/conda-forge/miniforge/releases/latest/download/Mambaforge-$(uname)-$(uname -m).sh
bash Mambaforge-$(uname)-$(uname -m).sh -b

# update path for mamba
PATH=/home/klambert/mambaforge/bin:$PATH

# install jolytree
mamba install -y -c bioconda jolytree
JolyTree.sh -h
JolyTree.sh  -i genomes/ -b strains -t 2
time JolyTree.sh  -i flexus/ -b flexus -t 2
time JolyTree.sh  -i simplex/ -b simplex -t 40 -> use 40 to bring compute time to 12hrs
time JolyTree.sh  -i megaterium/ -b megaterium -t 40
## use a resource or EC2 with 40+ cores

# using phylophlan - install using https://github.com/biobakery/phylophlan
# generate specific config file
# why is database a?
phylophlan_write_config_file \
    -o isolates_config.cfg \
    -d a \
    --force_nucleotides \
    --db_aa diamond \
    --map_aa diamond \
    --map_dna diamond \
    --msa mafft \
    --trim trimal \
    --tree1 fasttree \
    --tree2 raxml

#build phylogeny
# the program likely translates nt genomes, will need to determine if mixed genome/proteome will be an issue,
# might be easiest to default to all aa here.
# whats -t database type
# how to place diversity in my case? -> medium for genus level
# what are these thresholds?
# whats force nucleotides? -> if you have proteomes and genomes, this will force tree to run on nucs
phylophlan \
    -i input_genomes \
    -o output_enterotest1\
    -d phylophlan \
    --databases_folder enterobacter/databases/ \
    --trim greedy \
    --not_variant_threshold 0.99 \
    --remove_fragmentary_entries \
    --fragmentary_threshold 0.67 \
    -t a \
    -f phylo.config/supermatrix_aa.cfg \
    --diversity medium \
    --nproc 8 \
    --verbose 2>&1 | tee logs/entero_test1_output_isolates.log

# Visualize the nwk output from any of these methods using treeviz.R in this repository.