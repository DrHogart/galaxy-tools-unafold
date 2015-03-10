#!/bin/bash
set -e

#arguments are: -i input sequence file in fasta
#               -o output zip arhive
#               -t temp directory with results
#		-a DNA|RNA
#		-c tempreature (C)
#		-s [Na+] in M
#		-m [Mg++] in M
#		-b maxbp

# The original parametres of UNAFold:
#-n, --NA=(RNA | DNA) (defaults to RNA)
#-t, --temp=<temperature> (defaults to 37)
#-N, --sodium=<[Na+] in M> (defaults to 1)
#-M, --magnesium=<[Mg++] in M> (defaults to 0)
#-p, --polymer
#-C, --Ct=<total strand concentration>
#-I, --noisolate
#-m, --maxbp=<maximum basepair distance>
#-c, --constraints=<name of constraints file> (defaults to prefix.aux)
#-P, --percent=<energy increment percent> (defaults to 5)
#-W, --window=<window size> (default set by sequence length)
#-X, --max=<maximum number of foldings> (defaults to 100)
#    --ann=(none | p-num | ss-count) (defaults to none)
#    --mode=(auto | bases | lines) (defaults to auto)
#    --label=<base numbering frequency>
#    --rotate=<structure rotation angle>
#    --run-type=(text | html) (defaults to text)
#    --model=(EM | PF) (defaults to EM)
#    --circular
#Obscure options:
#    --allpairs
#    --maxloop=<maximum bulge/interior loop size> (defaults to 30)
#    --nodangle
#    --simple
#    --prefilter=<filter value>

NA=RNA
TM=37
NAT=1
MG=0

while getopts ":i:o:t:a:c:s:m:" OPTION;
do
	case $OPTION in
	i)      INPUT="$OPTARG";;
        o)	ZIP_ARHIVE="$OPTARG";;
        t)	TEMP_DIR="$OPTARG";;
	a)	NA="$OPTARG";;
	c)	TM="$OPTARG";;
	s)	NAT="$OPTARG";;
	m)	MG="$OPTARG";;
	esac
done
 
mkdir -p ${TEMP_DIR}/unafold
cd ${TEMP_DIR}/unafold

NA=$(echo $NA | tr '[:lower:]' '[:upper:]')

# calucalation of RNA don't need the concentraion of salts
if [[ ${NA} == 'DNA' ]]; then
	UNAFold.pl -n ${NA} -t ${TM} -N ${NAT} -M ${MG} ${INPUT}
else
	UNAFold.pl -n ${NA} -t ${TM} ${INPUT}
fi

echo ""
echo "Parametres of UNAFold run:"
cat *run

cd ../
zip -r -q unafold.zip unafold
mv unafold.zip ${ZIP_ARHIVE}

