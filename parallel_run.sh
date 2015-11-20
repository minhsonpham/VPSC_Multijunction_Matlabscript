#!/bin/bash
#find . -name "*.ps" | xargs rm
#find . -name "*.png" | xargs rm
#parallel -j 8 ./parallel_run.sh&
load_type=('RDT00' 'RDTm1' 'PSRm1' 'PSRm0' 'PSR00' 'BB000' 'BBTRD' 'PST00' 'PSTm0' 'PSTm1' 'TDTm1' 'TDT00')
#BC_name='BC_New_29-Oct-2014'
#BC_name='BC_New_31-Oct-2014'
BC_name='BC_New_22-Oct-2015'

for i in 0 1 2 3 4 6 7 8 9 10 11
do

cd /home/minhsonpham/Documents/VPSC_code/VPSC7b_multijunctions/New/$BC_name/1/${load_type[$i]}
pwd
/home/minhsonpham/Documents/VPSC_code/VPSC7b_multijunctions/vpsc7_multi_22Oct2015&

done
