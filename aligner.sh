for file in sporecoat*.fasta
do
~/local/bin/muscle3.8.31_i86linux64 -in $file -out align.$file
done

for file in transporter*.fasta
do
~/local/bin/muscle3.8.31_i86linux64 -in $file -out align.$file
done
