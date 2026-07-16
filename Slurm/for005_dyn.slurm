#!/bin/bash
#SBATCH --job-name=O16_dyn
#SBATCH --output=/mnt/home/jinlaure/scratch/logs/sky3d/for005_dyn_%j.out
#SBATCH --error=/mnt/home/jinlaure/scratch/logs/sky3d/for005_dyn_%j.err
#SBATCH --time=00:30:00
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=8G

set -euo pipefail

module purge
module load GCCcore/12.3.0
module load OpenBLAS/0.3.23-GCC-12.3.0
module load FFTW/3.3.10-GCC-12.3.0

export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK
export OPENBLAS_NUM_THREADS=$SLURM_CPUS_PER_TASK


ROOT="$SLURM_SUBMIT_DIR"
CALC="O16_dyn"

OUTDIR="/mnt/home/jinlaure/scratch/output/sky3d/${CALC}_${SLURM_JOB_ID}"

mkdir -p "$OUTDIR"

cp "$ROOT/Test/GR/for005.gr" "$OUTDIR/"

cd "$OUTDIR"

/usr/bin/time -v "$ROOT/Code/sky3d.seq" for005.gr \
> for005.gr.out \
2> time_resource_usage.err
