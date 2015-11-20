#this script is for convert Texture output from vpsc to cod and then do smooth with a width of 7.5
#!/bin/bash

load_type=('RDT00' 'RDTm1' 'PSRm1' 'PSRm0' 'PSR00' 'BB000' 'BBTRD' 'PST00' 'PSTm0' 'PSTm1' 'TDTm1' 'TDT00')
BC_name='BC_New_22-Oct-2015'

for j in 0 1 2 3 4 6 7 8 9 10 11
do

cd /home/minhsonpham/Documents/VPSC_code/VPSC7b_multijunctions/New/$BC_name/1/${load_type[$j]}
find . -name "*.ps" | xargs rm

for i in 5 10 15 20
do
/home/minhsonpham/Documents/Texture\ analysis/wts2pop_subroutine/wts2cod TEX_PH1_$i.OUT TEX_PH1_$i.cod 1
/home/minhsonpham/Documents/Texture\ analysis/smoothsod_7.5 TEX_PH1_$i.cod 
/home/minhsonpham/Documents/Texture\ analysis/wts2pop_subroutine/sodcon_noquery TEX_PH1_$i.cmh
done

done
