#!/bin/bash
source .env

DS_INFO_FILE="ds.info"

function config_history () {
  export HISTTIMEFORMAT="%F %T "
  if grep -q PROMPT_COMMAND ~/.bashrc
  then
    echo    
  else 
    echo 'export PROMPT_COMMAND="history -a; history -c; history -r; ${PROMPT_COMMAND}"' >> ~/.bashrc
  fi
  source ~/.bashrc  
}

function config_local_environment () {
  ## Prepare Ambiente
  rm -fr $(pwd)/exercicio-aula-$USER*
  [ -d $LOG_FILE_DIR  ] && rm -fr $LOG_FILE_DIR 
  ## [ -e resultado*.zip ] && rm resultado*.zip
  mkdir $WORKING_DIR 
  mkdir outputs
  cd $WORKING_DIR

set -xv
  local DONWLOAD_FOLDER=$(grep DOWNLOAD ~/.config/user-dirs.dirs  | awk -F= '{print $2}' | awk F=/ '{print $2} s/\"//g | sed s/\'//g)
  echo $DONWLOAD_FOLDER
  read -p "Espera, pa"  
  mkdir ${LOCAL_EXERCICE_FOLDER}
  mv ${DONWLOAD_FOLDER}/*.zip ${LOCAL_EXERCICE_FOLDER}/
  read -p "Espera"
set +xv  
}


function launch_exercice_terminal () {
  local MSG1="Realizar o exercicio neste terminal. As instruções para os exercicios estão nos ficheiros nos subdirectórios. "
  local MSG2='Começar pelo "ficheiro1" por ordem crescente'
  
  gnome-terminal -- bash -c "cd ${WORKING_DIR};echo ${MSG1}${MSG2};tree;exec bash"
}

function random_string () {
  tr -dc a-z0-9 </dev/urandom | head -c 3; echo
}

function random_number () {
  
  local INICIO=$1
  local FIM=$2    
  
  echo "$((${INICIO} + RANDOM % ${FIM}))"
}

function create_subdirs () {
  local DIR=$1
  local DIR_DEPTH_LEVEL=$2
  
  ## hack random seed
  for idx in range {100}; do (random_number 0 10); done

  if [ $DIR_DEPTH_LEVEL -gt 1 ];
  then    
    for num_dir in $(seq 1 $(( $DIR_DEPTH_LEVEL  ))); do

      local CREATE_DIR=$(random_number 0 10)
      if [ $CREATE_DIR -gt $(( 3 + $DIR_DEPTH_LEVEL )) ];
       then 
              
        DIR_DEPTH_LEVEL=$(( $2-1 )) 
        local SUB_DIR=d$(( $MAX_DEPTH_LEVEL - $DIR_DEPTH_LEVEL  ))-$(random_string)                
        mkdir $SUB_DIR              
        cd $SUB_DIR                          
        
        create_subdirs $SUB_DIR $DIR_DEPTH_LEVEL 
        cd ..
      fi
    done
  fi     
}

function random_dirs ()  (
#set -x    
    local DS_LENGTH=$(cat ${DS_INFO_FILE} | grep -v ":" | wc -l)
    
    local FIRST_RANDOM_NUMBER=$(random_number 1 ${DS_LENGTH})
    local SECOND_RANDOM_NUMBER=${FIRST_RANDOM_NUMBER}
    until [ ! ${SECOND_RANDOM_NUMBER} -eq ${FIRST_RANDOM_NUMBER} ];
    do 
        SECOND_RANDOM_NUMBER=$(random_number 1 ${DS_LENGTH} )        
    done
    local ORIGIN_DIR=$(cat ${DS_INFO_FILE}  | grep -v ":" | head -$(( ${FIRST_RANDOM_NUMBER} +1 )) | tail -1)
    local DEST_DIR=$(cat ${DS_INFO_FILE}  | grep -v ":" | head -${SECOND_RANDOM_NUMBER} | tail -1)
    
    #set -xv 
    local FULL_ORIG_DIR=$(find . -type d  -name ${ORIGIN_DIR})
    local FULL_DEST_DIR=$(find . -type d  -name ${DEST_DIR})    
    echo "${FULL_ORIG_DIR} ${FULL_DEST_DIR}"
    #set +xv
    #sleep 10
#set +x    
)

function random_dir ()  (
    local RANDOM_BEGIN=$1
    local RANDOM_END=$1
    
    local RANDOM_NUMBER=$(random_number ${RANDOM_BEGIN} ${RANDOM_END})
    local RANDOM_DIR=$(cat ${DS_INFO_FILE} | grep -v ":" | head -$(( ${RANDOM_BEGIN} +1 )) | tail -1)

    echo $(find . -type d  -name ${RANDOM_DIR})
)

