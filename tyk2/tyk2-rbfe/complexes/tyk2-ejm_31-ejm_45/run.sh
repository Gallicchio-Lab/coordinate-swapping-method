#!/bin/bash
#
#SBATCH -J tyk2-ejm_31-ejm_45
#SBATCH --partition=any
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --gres=gpu:1
#SBATCH --cpus-per-task=3
#SBATCH --no-requeue
#SBATCH -t 48:00:00

jobname=tyk2-ejm_31-ejm_45

. /nfs/egallicchio-d/miniforge3/bin/activate atm8.1.1
echo "Running on $(hostname)"

if [ ! -f ${jobname}_0.xml ]; then
   python /home/users/egallicchio/Dropbox/src/AToM-OpenMM/rbfe_structprep.py ${jobname}_asyncre.cntl || exit 1
fi

echo "localhost,0:0,1,CUDA,,/tmp" > nodefile
python /home/users/egallicchio/Dropbox/src/AToM-OpenMM/rbfe_explicit.py ${jobname}_asyncre.cntl
