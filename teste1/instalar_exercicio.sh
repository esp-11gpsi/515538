#!/bin/bash
source functions.sh
source exercicios.sh
# shopt -s histappend

VERSION_EXERCICE=$(cat info)
TIMESTAMP=$(date +"%Y%m%d-%H%M%S")
RANDOM_NUMBER=$(random_number 1 12000)
EXERCICE_ID=$USER-${TIMESTAMP}-$(hostname)-${RANDOM_NUMBER}

echo "INSTALL_DIR=$(pwd)" >> .env
echo "RESULTADOS_DIR=resultados" >> .env
echo "WORKING_DIR=$(pwd)/exercicio-aula-${EXERCICE_ID}" >> .env
echo "MAX_DEPTH_LEVEL=5" >> .env
echo "EXERCICE_ROOT_DIR=$(random_string)" >> .env
# Zip file
echo "ZIP_FILE=resultado_${EXERCICE_ID}.zip" >> .env
# resultados
echo "FILE_SOLUTION=$(pwd)/resultados/resultado_${EXERCICE_ID}.log" >> .env
echo "HISTORY_FILE=$(pwd)/resultados/history_${EXERCICE_ID}.log" >> .env
echo "LOG_FILE=$(pwd)/resultados/${EXERCICE_ID}.log" >> .env

echo LOCAL_EXERCICE_FOLDER=$HOME/manipulação_ficheiros_directorias-${EXERCICE_ID} >> .env

source .env
config_history
config_local_environment

echo "INICIO ----------" > ${LOG_FILE}
echo "$(date +%D-%T)" >> ${LOG_FILE}
echo "----------" >> ${LOG_FILE}
hostname >> $LOG_FILE
echo $USER >> $LOG_FILE
echo $(date '+%Y-%m-%d %H:%M:%S') >> $LOG_FILE
echo >> $LOG_FILE
echo "###############" >> $LOG_FILE
echo "" >> $LOG_FILE
echo "" >> $LOG_FILE

mkdir $EXERCICE_ROOT_DIR
cd $EXERCICE_ROOT_DIR

NUM_LINES=$(tree . | wc -l)
echo $NUM_LINES
until [ $NUM_LINES -ge 8 ]  && [ $NUM_LINES -lt 20 ];
do
  create_subdirs $(pwd) $MAX_DEPTH_LEVEL 
  NUM_LINES=$(tree $(pwd) | wc -l)
  echo $NUM_LINES
done

# cd $WORKING_DIR
cd ..
pwd 
create_exercices
tree ${WORKING_DIR} >> ${FILE_SOLUTION}

for file in $(find -name ficheiro*);
do 
  cat $file >> ${FILE_SOLUTION}
done  


clear
printf '1. Carregar em "ENTER" para abrir "outro" terminal onde os exercicios deverão ser realizados.\n\n'
printf '2. Depois dos exercícios realizados, "neste" terminal correr:\n  $ bash terminar_exercicio.sh\n\n'
read -p ""
launch_exercice_terminal

cd $INSTALL_DIR