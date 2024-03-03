#!/bin/bash
source functions.sh
source exercicios.sh
# shopt -s histappend

config_history


VERSION_EXERCICE=$(cat info)
TIMESTAMP=$(date +"%Y-%m-%d %H:%M:%S")
echo "INSTALL_DIR=$(pwd)" >> .env
echo "WORKING_DIR=$(pwd)/exercicio-aula-$USER-$(hostname)-"$(random_number 1 12000) > .env
echo "LOG_FILE_DIR=$(pwd)/outputs" >> .env
echo "LOG_FILE=$(pwd)/outputs/resultado_$TIMESTAMP_$(hostname)_${USER}.info" >> .env
echo "MAX_DEPTH_LEVEL=4" >> .env
echo "ROOT_DIR=$(random_string)" >> .env
echo "FILE_SOLUTION=$(pwd)/outputs/resultado_$TIMESTAMP_$(hostname)_${USER}.solution" >> .env
echo "ZIP_FILE=$(pwd)/resultado_$TIMESTAMP_$(hostname)_${USER}.solution" >> .env
echo "HISTORY_FILE=$(pwd)/outputs/history_$TIMESTAMP_$(hostname)_${USER}.solution" >> .env
echo 'LOCAL_EXERCICE_FOLDER="$HOME/manipulação_ficheiros_directorias-${VERSION_EXERCICE}"' >> .env

source .env

config_local_environment 

echo "INICIO ###############:"$(date +%D-%T) > $LOG_FILE
echo "###############" >> $LOG_FILE
hostname >> $LOG_FILE
echo $USER >> $LOG_FILE
echo $(date '+%Y-%m-%d %H:%M:%S') >> $LOG_FILE
echo >> $LOG_FILE
echo "###############" >> $LOG_FILE
echo "" >> $LOG_FILE
echo "" >> $LOG_FILE

mkdir $ROOT_DIR
cd $ROOT_DIR

NUM_LINES=$(tree $(pwd)  | wc -l)
echo $NUM_LINES
until [ $NUM_LINES -ge 8 ]  && [ $NUM_LINES -lt 20 ];
do
  create_subdirs $(pwd) $MAX_DEPTH_LEVEL 
  NUM_LINES=$(tree $(pwd) | wc -l)
  echo $NUM_LINES
done

cd $WORKING_DIR
create_exercices
tree >> ${FILE_SOLUTION}
for file in $(find -name ficheiro*);
do 
  cat $file >> ${FILE_SOLUTION}
done  

clear
printf 'Depois dos exercícios realizados, "neste" terminal corram\n  $ bash terminar_exercicio.sh\n\n'
read -p 'Carregar em "ENTER" para abrir "outro" terminal onde os exercicios deverão ser realizados'
launch_exercice_terminal

cd $INSTALL_DIR