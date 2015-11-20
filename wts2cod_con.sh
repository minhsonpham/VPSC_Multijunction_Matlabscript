#this script is for convert Texture output from vpsc to cod and then do smooth with a width of 7.5
#!/bin/bash
find . -name "*.ps" | xargs rm
for i in 5 10 15 20
do
/home/minhsonpham/Documents/Texture\ analysis/wts2pop_subroutine/wts2cod TEX_PH1_$i.OUT TEX_PH1_$i.cod 1
/home/minhsonpham/Documents/Texture\ analysis/smoothsod_7.5 TEX_PH1_$i.cod 
/home/minhsonpham/Documents/Texture\ analysis/sodcon_4scale TEX_PH1_$i.cmh
done
