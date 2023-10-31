# freesurfer_slurm

## EXAMPLE

```
# 1. SUBJECTS_DIR and inputFile
SUBJECTS_DIR=/work/g00cjz00/github/TMU_COURSE/data
inputFile=fNC01.nii.gz

# 2. saveFolder
fname=$(basename $inputFile)
fbname=${fname%.*}
saveFolder=${fbname%.*}

# 3. JOB for freesurfer_7.1.1
scancel -n ${saveFolder} && rm -rf ${SUBJECTS_DIR}/${saveFolder} && rm -f ${SUBJECTS_DIR}/${saveFolder}.zip &&  sleep 1 
sbatch -J ${saveFolder} --export=SUBJECTS_DIR=${SUBJECTS_DIR},inputFile=${inputFile},IMAGE=${IMAGE} slurm_7.1.1.sh

```