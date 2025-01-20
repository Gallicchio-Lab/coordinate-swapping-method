#!/bin/bash
#
#SBATCH -J tiam1-sdc1wt-sdc1A0M
#SBATCH --partition=any
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --gres=gpu:1
#SBATCH --cpus-per-task=3
#SBATCH --no-requeue
#SBATCH -t 25:00:00

jobname=tiam1-sdc1wt-sdc1A0M

. /nfs/egallicchio-d/miniforge3/bin/activate py311
echo "Running on $(hostname)"

if [ ! -f ${jobname}_0.xml ]; then
   ~/Dropbox/devel/atmforce-intcoord-displ/openmm-latest/runopenmm ~/Dropbox/devel/atmforce-intcoord-displ/AToM-OpenMM/rbfe_structprep.py ${jobname}_asyncre.cntl || exit 1
fi

echo "localhost,0:0,1,CUDA,,/tmp" > nodefile
~/Dropbox/devel/atmforce-intcoord-displ/openmm-latest/runopenmm ~/Dropbox/devel/atmforce-intcoord-displ/AToM-OpenMM/rbfe_explicit.py ${jobname}_asyncre.cntl
