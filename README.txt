Description of files:

plot_generator.m - Create a strain path that matches example experimental data or other assumed paths

BC_multijunction_new.m - Create crystal and slip system input (.sx) files for multijuction and copy output to a newly created folder

parallel_run.sh: bash script to call VPSC-Multi executable and run it in terminal for different strain paths. Works with multi processors and utilizing the parallelization function of Linux.

analysis_BC_Multi_new.m - Analyze output data

wts2cod_con.sh: script to convert wts (.OUT) files to COD, and then smooth (interested users need to download and compiling: wts2cod-25Apr14.f, smoothsod.f and sodcon.f from Prof. Rollett's website: http://pajarito.materials.cmu.edu/rollett/texture_subroutines/)


