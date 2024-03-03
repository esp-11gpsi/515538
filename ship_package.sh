#!/bin/bash
VERSAO_EXERCICIO=$1
FILE_PACKAGE=exercicio_cmd_fic_dir.zip
FILE_EXERCICIOS=exercicios/exercicios${VERSAO_EXERCICIO}.sh

if [ -z $VERSAO_EXERCICIO ]; 
then 
  echo "sintaxe: ship_version <version>"
  exit 1
fi

if [ ! -e ${FILE_EXERCICIOS} ]; 
then 
  echo "Erro: ficheiro ${FILE_EXERCICIOS} não existe."
  exit 1
fi

cp ${FILE_EXERCICIOS} exercicios.sh
[[ -f $FILE_PACKAGE ]] && rm $FILE_PACKAGE

echo ${VERSAO_EXERCICIO} > info 

zip $FILE_PACKAGE  \
    terminar_exercicio.sh  \
    info  \
    instalar_exercicio.sh  \
    functions.sh  \
    exercicios.sh
    
    
