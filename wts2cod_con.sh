#this script is for convert Texture output from vpsc to cod and then do smooth with a width of 7.5
#!/bin/bash
for i in 05 10 15
do
/home/minhsonpham/Documents/CMU-NIST/Texture\ analysis/wts2pop/wts2cod TEX_PH1_$i.OUT TEX_PH1_$i.cod 1
/home/minhsonpham/Documents/CMU-NIST/Texture\ analysis/wts2pop/smoothsod_7.5 TEX_PH1_$i.cod 
/home/minhsonpham/Documents/CMU-NIST/Texture\ analysis/wts2pop/sodcon TEX_PH1_$i.cmh
done
