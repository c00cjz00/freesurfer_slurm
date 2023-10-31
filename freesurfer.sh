#!/bin/bash
# -> 環境目錄 
#SUBJECTS_DIR=/work/g00cjz00/github/TMU_COURSE/data
#inputFile=fNC01.nii.gz
SUBJECTS_DIR=$1
inputFile=$2

# -> 新增執行目錄
export PATH=$PATH:$HOME/.local/bin
export PATH=$PATH:/usr/bin33

# 更換目錄
mkdir -p $SUBJECTS_DIR
cd $SUBJECTS_DIR
export SUBJECTS_DIR=$PWD

# -> 環境初始設定
source $FREESURFER_HOME/SetUpFreeSurfer.sh

# -> 環境變數 3
fname=$(basename $inputFile)
fbname=${fname%.*}
saveFolder=${fbname%.*}


# -> 執行程式 1 (recon-all )
echo "STEP01"
recon-all -openmp 8 -i $inputFile -s $saveFolder -all

echo "STEP02"
segmentThalamicNuclei.sh $saveFolder $PWD
segmentHA_T1.sh $saveFolder $PWD
segmentBS.sh $saveFolder $PWD

echo "STEP03"
mri_convert $saveFolder/mri/brainstemSsLabels.v12.FSvoxelSpace.mgz $saveFolder/brainstemSsLabels.v12.FSvoxelSpace.nii --out_orientation LAS
mri_convert $saveFolder/mri/aparc+aseg.mgz $saveFolder/aparc+aseg.nii --out_orientation LAS
mri_convert $saveFolder/mri/orig.mgz $saveFolder/orig.nii --out_orientation LAS
mri_convert $saveFolder/mri/wmparc.mgz $saveFolder/wmparc.nii --out_orientation LAS
mri_convert $saveFolder/mri/lh.hippoAmygLabels-T1.v21.FSvoxelSpace.mgz $saveFolder/lh.hippoAmygLabels-T1.v21.FSvoxelSpace.nii --out_orientation LAS
mri_convert $saveFolder/mri/rh.hippoAmygLabels-T1.v21.FSvoxelSpace.mgz $saveFolder/rh.hippoAmygLabels-T1.v21.FSvoxelSpace.nii --out_orientation LAS
mri_convert $saveFolder/mri/ThalamicNuclei.v12.T1.FSvoxelSpace.mgz $saveFolder/ThalamicNuclei.v12.T1.FSvoxelSpace.nii --out_orientation LAS
mri_convert $saveFolder/mri/aparc.DKTatlas+aseg.mgz $saveFolder/aparc.DKTatlas+aseg.nii --out_orientation LAS
zip -r $saveFolder.zip $saveFolder