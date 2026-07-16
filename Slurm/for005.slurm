#!/bin/bash
#SBATCH --job-name=smoke
#SBATCH --output=/mnt/home/jinlaure/scratch/logs/sky3d/for005_%j.out
#SBATCH --error=/mnt/home/jinlaure/scratch/logs/sky3d/for005_%j.err
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
CALC="O16"

OUTDIR="/mnt/home/jinlaure/scratch/output/sky3d/${CALC}_${SLURM_JOB_ID}"

mkdir -p "$OUTDIR"

cp "$ROOT/Test/Static/for005.static" "$OUTDIR/for005"

cd "$OUTDIR"

/usr/bin/time -v "$ROOT/Code/sky3d.seq" > for005.static.out 2> time_resource_usage.err
