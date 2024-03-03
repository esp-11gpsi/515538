#!/bin/bash
source .env

if [ ! -d outputs ];
then  
    echo "Exercicio não iniciado. Corra 'bash preparar_exercicio.sh'"
    exit 1
fi

cd $WORKING_DIR


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

tree >> ${FILE_SOLUTION}
# zip -Tro ../$FILE_SOLUTION.zip ${WORKING_DIR} ${WORKING_DIR}/../outputs outputs # &>/dev/null 
pwd

zip -r ${ZIP_FILE}.zip info ${LOG_FILE_DIR} ${WORKING_DIR} &>/dev/null 
rm -fr ${LOG_FILE_DIR} ${WORKING_DIR}

cd ..
echo "Entregar o ficheiro '${ZIP_FILE}.zip' na classroom".

