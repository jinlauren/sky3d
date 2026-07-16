#!/bin/bash
#SBATCH --job-name=Pb208_static
#SBATCH --output=/mnt/home/jinlaure/scratch/logs/sky3d/for008_static_%j.out
#SBATCH --error=/mnt/home/jinlaure/scratch/logs/sky3d/for008_static_%j.err
#SBATCH --time=01:00:00
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
export OPENBLAS_NUM_THREADS=8
export FFTW_NUM_THREADS=$SLURM_CPUS_PER_TASK

ROOT="$SLURM_SUBMIT_DIR"
CALC="Pb208_static"

OUTDIR="/mnt/home/jinlaure/scratch/output/sky3d/${CALC}_${SLURM_JOB_ID}"

mkdir -p "$OUTDIR"

cp "$ROOT/Test/Static/for008.static" "$OUTDIR/"

cd "$OUTDIR"

/usr/bin/time -v "$ROOT/Code/sky3d.omp" for008.static \
> for008.static.out \
2> time_resource_usage.err
