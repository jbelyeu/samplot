#set -e

#download hg19 reference for cram
FILE="hg19.fa.gz"
if [ ! -f $FILE ]; then
    wget http://hgdownload.cse.ucsc.edu/goldenPath/hg19/bigZips/hg19.fa.gz
    gunzip hg19.fa.gz
    bgzip hg19.fa
fi

mkdir -p manuscript_imgs

#Figure 1: DEL/DUP with Illumina, PB, 10X
python ~/Desktop/temp_smplt/samplot/src/samplot.py -n Illumina PacBio "10X Genomics" -t DEL -c 1 -s 24804397 -e 24807302 -o manuscript_imgs/DEL_1_24804397_24807302.png -b HG002_Illumina.bam HG002_PacBio.bam HG002_10X.bam  -T UCSC_knowngene_grch37.gtf.gz
python ~/Desktop/temp_smplt/samplot/src/samplot.py -n Illumina ONT "10X Genomics" -t DUP -c 4 -s 99813786 -e 99817098 -o manuscript_imgs/DUP_4_99813786_99817098.png -b HG002_Illumina.bam HG002_ONT.cram HG002_10X.bam -r hg19.fa.gz -T UCSC_knowngene_grch37.gtf.gz
#python ~/Desktop/temp_smplt/samplot/src/samplot.py -n Illumina PacBio 10X -t DUP -c 4 -s 99813786 -e 99817098 -o manuscript_imgs/DUP_4_99813786_99817098.png -b HG002_Illumina.bam HG002_PacBio.bam HG002_10X.bam -r hg19.fa.gz

#supp fig with INV, with Illumina, PB, 10X
python ~/Desktop/temp_smplt/samplot/src/samplot.py -n Illumina PacBio "10X Genomics" -t INV -c 12 -s 12544867 -e 12546613 -o manuscript_imgs/INV_12_12544867_12546613.png -b HG002_Illumina.bam HG002_PacBio.bam HG002_ONT.cram HG002_10X.bam -r hg19.fa.gz -T UCSC_knowngene_grch37.gtf.gz

#supp fig with zoom, Illumina
python ~/Desktop/temp_smplt/samplot/src/samplot.py -n "Illumina (with kilobase zoom)" -t DUP -c 4 -s 99813786 -e 99817098 -o manuscript_imgs/DUP_4_99813786_99817098_zoom.png -b HG002_Illumina.bam --zoom 1000 -T UCSC_knowngene_grch37.gtf.gz

#supp fig with ONT (panel for DEL, INV) and PB (DUP)
python ~/Desktop/temp_smplt/samplot/src/samplot.py -n ONT -t DEL -c 1 -s 24804397 -e 24807302 -o manuscript_imgs/DEL_1_24804397_24807302_ONT.png -b HG002_ONT.cram -r hg19.fa.gz -T UCSC_knowngene_grch37.gtf.gz
python ~/Desktop/temp_smplt/samplot/src/samplot.py -n ONT -t INV -c 12 -s 12544867 -e 12546613 -o manuscript_imgs/INV_12_12544867_12546613_ONT.png -b HG002_ONT.cram -r hg19.fa.gz -T UCSC_knowngene_grch37.gtf.gz
python ~/Desktop/temp_smplt/samplot/src/samplot.py -n PacBio -t DUP -c 4 -s 99813786 -e 99817098 -o manuscript_imgs/DUP_4_99813786_99817098_PacBio.png -b HG002_PacBio.bam  -T UCSC_knowngene_grch37.gtf.gz

#supp fig with gene overlap, no variant, PacBio
python ~/Desktop/temp_smplt/samplot/src/samplot.py -n "PacBio (no variant)" -c 1 -s 43059290 -e 43059950 -o manuscript_imgs/1_43059290_43059950.png -b HG002_PacBio.bam -T UCSC_knowngene_grch37.gtf.gz
python ~/Desktop/temp_smplt/samplot/src/samplot.py -n "PacBio (no variant)" -c 15 -s 41861116 -e 41862116 -o manuscript_imgs/15_41861116_41862116.png -b HG002_PacBio.bam -T UCSC_knowngene_grch37.gtf.gz


#
##zoom example
#python ../../src/samplot.py -n Illumina PacBio ONT 10X -t DUP -c 4 -s 99813786 -e 99817098 -o manuscript_imgs/DUP_4_99813786_99817098_zoom.png -b HG002_Illumina.bam HG002_PacBio.bam HG002_ONT.cram HG002_10X.bam -r hg19.fa.gz --zoom 1000
#
##trios with no variant
#python ../../src/samplot.py -n HG002 HG003 HG004 -c 1 -s 43059290 -e 43059950 -o manuscript_imgs/1_43059290_43059950.png -b HG002_Illumina.bam HG003_Illumina.bam HG004_Illumina.bam
#
##trios of each type
#python ../../src/samplot.py -n HG002 HG003 HG004 -t DEL -c 1 -s 24804397 -e 24807302 -o manuscript_imgs/trio_DEL_1_24804397_24807302.png -b HG002_Illumina.bam HG003_Illumina.bam HG004_Illumina.bam
#python ../../src/samplot.py -n HG002 HG003 HG004 -t DUP -c 4 -s 99813786 -e 99817098 -o manuscript_imgs/trio_DUP_4_99813786_99817098.png -b HG002_Illumina.bam HG003_Illumina.bam HG004_Illumina.bam
#python ../../src/samplot.py -n HG002 HG003 HG004 -t DUP -c 11 -s 67974431 -e 67975639 -o manuscript_imgs/trio_DUP_11_67974431_67975639.png -b HG002_Illumina.bam HG003_Illumina.bam HG004_Illumina.bam
#python ../../src/samplot.py -n HG002 HG003 HG004 -t INV -c 12 -s 12544867 -e 12546613 -o manuscript_imgs/trio_INV_12_12544867_12546613.png -b HG002_Illumina.bam HG003_Illumina.bam HG004_Illumina.bam
#
##create a temporary example website
#mkdir -p test_site
#python ../../src/samplot_vcf.py -d test_site/ --vcf test.vcf --sample_ids HG002 HG003 HG004 -b HG002_Illumina.bam HG003_Illumina.bam HG004_Illumina.bam > test_site_cmds.sh
#bash test_site_cmds.sh
