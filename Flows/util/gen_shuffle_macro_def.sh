#!/bin/tcsh

## Set to 1 to run refine_macro_place ##

setenv SYN_HANDOFF $argv[1]
setenv SEED $argv[2]
set util_dir="/home/fetzfs_projects/MacroPlacement/flow_scripts_run/MacroPlacement/Flows/util/"

if ($#argv != 3) then
    echo "Required Physical synthesis handoff path and seed to run shuffle macro"
endif

module unload innovus
module load innovus/21.1

innovus -64 -overwrite -log log/macro_shuffle_innovus.log -files ${util_dir}/gen_shuffle_macro_def.tcl

## Edit the design file to make sure flow2 reads the new macro placed def instead of the default one
set def_file=`ls *_fp_shuffled_macros.def | head -n1`
sed -i "s@\S*_fp_placed_macros.def@${def_file}@" design_setup.tcl
