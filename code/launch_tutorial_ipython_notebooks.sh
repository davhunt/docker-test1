#!/bin/sh
if [ "$#" -ne 2 ] || ! [ -d "$1" ] || ! [ -d "$2" ]; then
  echo "Usage: $0 /path/to/cmtk-tutorial-repo /path/to/dataset-directory"
  exit 1
else
  cmtktutorialsrepo=${1}
  datasetdir=${2}
fi


docker run -it --rm -v ${cmtktutorialsrepo}/notebooks/:/app/cmtk_tutorials \
					-v ${datasetdir}/:/data \
					-v ${datasetdir}/derivatives/:/output \
					-p 8888:8888 \
					sebastientourbier/connectomemappingtoolkit-tutorials:latest


