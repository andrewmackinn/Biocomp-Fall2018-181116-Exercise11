#usage bash muscled.sh
#assume that all gene sequence and proteome directory  are in current working directory, proteome sequences are only files with capital letters in title 
#for loop to add next line characters to all transporter sequences and cat them together in one fulltransporter
for file in transporter*.fasta
do
sed -i -e '$a\' $file| cat $file  >> fulltransporter.fasta
#using muscle to align full transporter
/afs/nd.edu/user34/amackinn/local/bin/muscle3.8.31_i86linux64 -in fulltransporter.fasta -out align.fulltransporter.fasta
done
#using hmmbuild to build full profile
/afs/nd.edu/user34/amackinn/local/bin/hmmbuild builtfulltransporter.fasta align.fulltransporter.fasta
#for loop to search all of the proteome sequences against the profile from the transporter sequences
for file in /afs/nd.edu/user34/amackinn/local/exercise11/proteomes/*.fasta
do
/afs/nd.edu/user34/amackinn/local/bin/hmmsearch --tblout $file.results builtfulltransporter.fasta $file
done
#compile all the filenames and hits in one text document
for file in *.results
do
echo $file >> fullresults.txt
cat $file | grep -v '#' | wc -l >> fullresults.txt
done
