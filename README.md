# freesurfer_slurm

## STEP 1
```
git clone https://github.com/c00cjz00/freesurfer_slurm.git
```

## STEP 2 (for slurm job)
1. cd freesurfer_slurm
2. use notebook to open File slurm_7.1.1.ipynb
3. edit SUBJECTS_DIR, and inputFile in every cell
4. click run button, then submit slurm job

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


## STEP 3 (for interactive job in notebook)
1. cd freesurfer_slurm
2. use notebook to open File notebook_7.1.1.ipynb
3. edit SUBJECTS_DIR, and inputFile in secondary cell
4. click run button, then exectute job

