#!/bin/bash
#SBATCH --job-name=Pb208_static_smoke
#SBATCH --output=/mnt/home/jinlaure/scratch/logs/sky3d/Pb208_static_smoke_%j.out
#SBATCH --error=/mnt/home/jinlaure/scratch/logs/sky3d/Pb208_static_smoke_%j.err
#SBATCH --time=00:20:00
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=4G

set -euo pipefail

module purge
module load GCCcore/12.3.0
module load OpenBLAS/0.3.23-GCC-12.3.0
module load FFTW/3.3.10-GCC-12.3.0

export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK
export OPENBLAS_NUM_THREADS=$SLURM_CPUS_PER_TASK

ROOT="$SLURM_SUBMIT_DIR"
CALC="Pb208_static_smoke"

OUTDIR="/mnt/home/jinlaure/scratch/output/sky3d/$CALC"
WORKDIR="/mnt/home/jinlaure/scratch/work/sky3d/work_$CALC_${SLURM_JOB_ID}"

mkdir -p "$WORKDIR"

ln -s "$OUTDIR" "$WORKDIR"

cd "$ROOT/Test/Static"

../../Code/sky3d.seq < for007.static > for007.static.out
