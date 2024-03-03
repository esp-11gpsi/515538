#!/bin/bash
source functions.sh
source .env
clear

function create_exercice_mv {
    local NUMERO=$1
    local TEXTO;
      
    local DIRS=$(random_dirs)
    local FIRST_DIR=$(echo $DIRS | awk '{print $1}')
    local SECOND_DIR=$(echo $DIRS | awk '{print $2}')

    TEXTO="Mover este ficheiro para a directoria '"${SECOND_DIR}"'"
    echo "ficheiro${NUMERO} :$TEXTO" >> ${FIRST_DIR}/ficheiro${NUMERO}
}

function create_exercice_ren {
    local NUMERO=$1
    local TEXTO;
      
    local DIRS=$(random_dirs)
    local FIRST_DIR=$(echo $DIRS | awk '{print $1}')    

    TEXTO="Renomear este ficheiro para 'fich_renomeado.txt'" 
    echo "ficheiro${NUMERO} :$TEXTO" >> ${FIRST_DIR}/ficheiro${NUMERO}
}

function create_exercice_cp {
    local NUMERO=$1
    local TEXTO;
          
    local DIRS=$(random_dirs)
    local FIRST_DIR=$(echo $DIRS | awk '{print $1}')
    local SECOND_DIR=$(echo $DIRS | awk '{print $2}')

    TEXTO="Copiar este ficheiro para a directoria '"${SECOND_DIR}"'"    
    echo "ficheiro${NUMERO} :$TEXTO" >> ${FIRST_DIR}/ficheiro${NUMERO}
}

function create_exercice_rm {
    local NUMERO=$1
    local TEXTO=$2;
              
    local DIRS=$(random_dirs)
    local FIRST_DIR=$(echo $DIRS | awk '{print $1}')
    local SECOND_DIR=$(echo $DIRS | awk '{print $2}')
    
    echo "ficheiro${NUMERO} :$TEXTO" >> ${FIRST_DIR}/ficheiro${NUMERO}    
}


function create_exercice_mkdir {
    
    local NUMERO=$1
    local TEXTO;
          
    local DIRS=$(random_dirs)
    local FIRST_DIR=$(echo $DIRS | awk '{print $1}')
    local SECOND_DIR=$(echo $DIRS | awk '{print $2}')

    TEXTO="Criar a directoria '"${FIRST_DIR}"' dentro da directoria '"${SECOND_DIR}"'" 
    echo "ficheiro${NUMERO} :$TEXTO" >> ${FIRST_DIR}/ficheiro${NUMERO}        
    
}

function create_exercice_mvdir {
    local NUMERO=$1
    local TEXTO;
          
    local DIRS=$(random_dirs)
    local FIRST_DIR=$(echo $DIRS | awk '{print $1}')
    local SECOND_DIR=$(echo $DIRS | awk '{print $2}')

    TEXTO="Mover a directoria '"${FIRST_DIR}"' para dentro da directoria '"${SECOND_DIR}"'"
    echo ficheiro${NUMERO} :$TEXTO >> ${FIRST_DIR}/ficheiro${NUMERO}    
}

function create_exercice_rmdir {
    local NUMERO=$1
    local TEXTO;
                  
    TEXTO="Remover uma qualquer directoria ou sub-directoria vazia, caso exista."
    echo "ficheiro${NUMERO} :$TEXTO" >> ${WORKING_DIR}/${ROOT_DIR}/ficheiro${NUMERO}    
}

function create_refresh_ds_file () {
    for d in $(ls -R $ROOT_DIR ); do echo $d; done > ${DS_INFO_FILE}
}

function create_exercices () {
    local EXERCICIO_NUM=$1
    local EXERCICIO_TEXT=$2

    create_refresh_ds_file

    create_exercice_cp 1
    create_exercice_cp 2
    create_exercice_cp 3
    create_exercice_cp 4
    create_exercice_cp 5
    
    
    
    rm ${DS_INFO_FILE}
}