#!/bin/bash
source .env

if [ ! -d ${RESULTADOS_DIR} ];
then  
    echo "Exercicio não iniciado. Corra 'bash preparar_exercicio.sh'"
    exit 1
fi


cd ${INSTALL_DIR}
echo INSTALL_DIR-${INSTALL_DIR}
echo WORKING_DIR-${WORKING_DIR}
echo LOG_FILE-${LOG_FILE}
pwd

echo "###############" >> $LOG_FILE
echo "FIM ###############" >> $LOG_FILE
hostname >> $LOG_FILE
echo $USER >> $LOG_FILE
echo $(date '+%Y-%m-%d %H:%M:%S') >> $LOG_FILE
echo "###############" >> $LOG_FILE
echo "###############" >> $LOG_FILE
journalctl --list-boots  >> $LOG_FILE
echo "###############" >> $LOG_FILE
echo >> $LOG_FILE

history -a; history -r
HISTFILE=~/.bash_history
HISTTIMEFORMAT="%F %T "
set -o history
history > $HISTORY_FILE

tree ${WORKING_DIR} >> ${FILE_SOLUTION}

# zip -Tro ../$FILE_SOLUTION.zip ${WORKING_DIR} ${WORKING_DIR}/../outputs outputs # &>/dev/null 

zip -r ${ZIP_FILE}.zip info ${RESULTADOS_DIR} &>/dev/null 
rm -fr ${RESULTADOS_DIR} ${WORKING_DIR}

cd ..
echo "Entregar o ficheiro '${ZIP_FILE}.zip' na classroom".

