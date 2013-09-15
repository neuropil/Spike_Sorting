#!/bin/sh
NAME=$1
ID=1

if [ -z "$NAME" -o -z "$ID" ]; then
  echo "input & update: $NAME.ntt"
  echo "output: $NAME.{det,ext,model,cla,log} All.{res,spk,fet,clu}._id_"
  echo "usage: NAME=$NAME ID=$ID TYPE=PCA|GLF|WMW $0"
  exit 1
fi

exec 2> ${NAME}.log

ntt2detspk ${NAME}.ntt ${NAME}.det All.spk.${ID}
etos2klusters_det2res ${NAME}.det > All.res.$ID

USE_CH=1111
SPK_PT=32
SPK_PK=8
POS1=-8
POS2=24
EXT_WAVE=CDF97
EXT_ALGO=KS
EXT_PARAM=mPCA #PICKUP
DIM_OF_EXTFILE=12
etos_spk2ext All.spk.${ID} $USE_CH $SPK_PT $SPK_PK $POS1 $POS2 $EXT_WAVE $EXT_ALGO "$EXT_PARAM" $DIM_OF_EXTFILE > ${NAME}.ext.orig

DIM_FOR_CLUSTERING=12
etos_normalize ${NAME}.ext.orig ${DIM_FOR_CLUSTERING} > ${NAME}.ext
etos2klusters_ext2fet ${NAME}.det ${NAME}.ext > All.fet.$ID

echo "# k-means clustering" >&2
INITIAL_NUMBER_OF_CLUSTERS=1000
SEED=1
etos_kmeans ${NAME}.ext $DIM_FOR_CLUSTERING $INITIAL_NUMBER_OF_CLUSTERS $SEED > ${NAME}.cla.kmeans

echo "# set up for clustering" >&2
GAMMA=$2   #60
NU=$3      #64
CLA_ALGO=SVB
CLA_PARAM="1 $GAMMA 1 $NU 1"
etos_classify_init ${NAME}.ext $DIM_FOR_CLUSTERING ${NAME}.cla.kmeans $CLA_ALGO "$CLA_PARAM" > ${NAME}.model.kmeans
cp ${NAME}.model.kmeans ${NAME}.model

echo "# clustering" >&2
CLA_EPS=1e-6
CLA_TEMP0=1.0
CLA_DTEMP=1.0
etos_classify_run ${NAME}.ext ${NAME}.model $CLA_EPS $CLA_TEMP0 $CLA_DTEMP

echo "# results" >&2
P_THR=1e-6
P_THR=0
Z_THR=0
etos_classify_out ${NAME}.ext ${NAME}.model $P_THR $Z_THR > ${NAME}.cla.etos
etos2klusters_cla2clu ${NAME}.cla.etos > All.clu.$ID
ntt_addcla ${NAME}.cla.etos ${NAME}.ntt
