#!/usr/bin/env bash

# Main driver to submit jobs 
# Author AMIT PATHAK <amit@ihep.ac.cn>
# Created [2019-05-07 tue 09:44]

usage() {
    printf "NAME\n\tsubmit.sh - Main driver to submit jobs\n"
    printf "\nSYNOPSIS\n"
    printf "\n\t%-5s\n" "./submit.sh [OPTION]" 
    printf "\nOPTIONS\n" 

    printf "\n\t%-9s  %-40s"  "0.1"      "[run on jpsiantisigmaminussigmaplus]"
    printf "\n\t%-9s  %-40s"  "0.1.1"    "simulation --10 signal MC sample interactively for jpsiantisigmaminussigmaplus events..."
    printf "\n\t%-9s  %-40s"  "0.1.2"    "Generate -- 20000 jpsiantisigmaminussigmaplus MC signal..."
    printf "\n\t%-9s  %-40s"  "0.1.3"    "Reconstruction -- 20000 jpsiantisigmaminussigmaplus MC signal..."
   

    printf "\n\n" 


}


if [[ $# -eq 0 ]]; then
    usage
    echo "Please enter your option: "
    read option
else
    option=$1    
fi

case $option in
    
    # --------------------------------------------------------------------------
    #  0.1 MC  
    # --------------------------------------------------------------------------


0.1) echo "[run on signal MC--jpsiantisigmaminussigmaplus]"
	 ;;


    0.1.1) echo "simulation --10 signal MC sample interactively for jpsiantisigmaminussigmaplus events..."
        echo "have you changed event number for 10 events to run interactively?(yes / NO)"
        
        read opt
        if [ $opt == "yes" ]
            then
            echo "now in yes"

            cd scripts/jpsiantisigmaminussigmaplus/jobs_jpsiantisigmaminussigmaplus
            boss.exe jobOptions_sim_jpsiantisigmaminussigmaplus.txt
            cd $HOME/bes/hypermiss
        else
            echo "Default value is 'NO', please change event number."
        fi
        ;;
    
     0.1.2) echo "submitting the condor job for simulation -- 20000 signal MC sample jpsiantisigmaminussigmaplus events..."
        echo "have you checked the lxslc7 machine? Condor job is only applicable on lxslc7 machine.(yes / NO)"
        
        read opt
        if [ $opt == "yes" ]
            then
            echo "now in yes"
        
            cd scripts/jpsiantisigmaminussigmaplus/jobs_jpsiantisigmaminussigmaplus
            boss.condor -g physics jobOptions_sim_jpsiantisigmaminussigmaplus.txt
            cd $HOME/bes/hypermiss
        else
            echo "Default value is 'NO'."
        fi
        ;;
    
    0.1.3) echo "reconstruction -- generate 20000 signal MC sample..."
            
	    cd scripts/jpsiantisigmaminussigmaplus/jobs_jpsiantisigmaminussigmaplus
        boss.condor -g physics jobOptions_rec_jpsiantisigmaminussigmaplus.txt
        ;;

esac
