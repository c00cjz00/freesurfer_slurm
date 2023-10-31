#!/work/u00cjz00/binary/bash5.0/bin/bash
#SBATCH -A MST109178                                                    ### project number, Example MST109178
#SBATCH -J _t3bio_                                                      ### Job name, Exmaple jupyterlab
#SBATCH -p ngs26G                                                       ### Partition Name, Example ngs1gpu
#SBATCH -c 4                                                            ### Cores assigned to each task, Example 4
#SBATCH --mem=26g                                                       ### 使用的記憶體量 請參考Queue資源設定
#SBATCH -o logs/freesurfer_%j.out                                       ### Log folder, Here %j is job ID
#SBATCH -e logs/freesurfer_%j.err                                       ### Log folder, Here %j is job ID

## Singularity
image=/work/u00cjz00/nvidia/freesurfer_7.1.1.sif
base_cmd="/opt/ohpc/Taiwania3/libs/singularity/3.10.2/bin/singularity exec \
-B /work/$(whoami) \
-B /usr/bin:/usr/bin33 \
-B /work/u00cjz00/pkg/MCRv84:/usr/local/freesurfer/MCRv84 \
-B /work/u00cjz00/nvidia/freesurfer_license/license.txt:/usr/local/freesurfer/license.txt \
-B /work/u00cjz00/pkg/freesurfer711_bug/quantifyThalamicNuclei.sh:/usr/local/freesurfer/bin/quantifyThalamicNuclei.sh \
${image}" 

## CMD
$base_cmd bash freesurfer.sh $SUBJECTS_DIR $inputFile &

## Get pid
pid0=$!
sleep 2
pid1=$(pgrep -P ${pid0})
pid=${pid1}
wait $pid0


