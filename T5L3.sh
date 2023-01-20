#!/bin/bash

decimal=( 1000 900 500 400 100 90 50 40 10 9 5 4 1 )
romano=( M CM D CD C XC L XL X IX V IV I )

function romADecimal() {

    pos=`expr ${#num} - 1`
    prev=0
    resultado=0
    while [ $pos -ge 0 ];do
    case "${num:$pos:1}" in
    M) factor=1000 ;;
    D) factor=500 ;;
    C) factor=100 ;;
    L) factor=50 ;;
    X) factor=10 ;;
    V) factor=5 ;;
    I) factor=1 ;;
    esac

    if [ $factor -lt $prev ];then
    resultado=`expr $resultado - $factor`
    else
    resultado=`expr $resultado + $factor`
    fi
    prev=$factor
    pos=`expr $pos - 1`
    done
    echo "El equivalente en decimal al año romano $num es $resultado"
}

function decimalARomano() {

    aux=$num
    pos=0

    for item in ${decimal[@]};do
    valor=`expr $aux / $item`
    resto=`expr $aux % $item`
    cont=0
    while [ $cont -lt $valor ];do
    resultado=`echo $resultado${romano[$pos]}`
    cont=`expr $cont + 1`
    done
    pos=`expr $pos + 1`
    aux=$resto
    done
    echo "El equivalente en números romanos al año decimal $num es $resultado"

}

if [[ -n $1 ]]; then
echo "Parámetro recibido"

num=$1

validarDecimal='^-?[0-9]+([.][0-9]+)?$'
if [[ $num =~ $validarDecimal ]]; then
    echo "Es entero"

#Si es un número entero comprobamos que esté entre el rango solicitado
if [[ ($num -ge 1) && (num -le 1999) ]]; then
    echo "El número está dentro del rango 0-1999"
    decimalARomano

else
    echo "El número está fuera del rango establecido (0-1999), por ello no se puede hacer la conversión"
fi
else
    echo "No es un entero."

if [ ${num:0:1} == "M" ] || [ ${num:0:1} == "D" ] || [ ${num:0:1} == "C" ] || [ ${num:0:1} == "V" ] || [ ${num:0:1} == "X" ] || [ ${num:0:1} == "I" ];then
    echo "Es un número romano"
    romADecimal
else
    echo "No es un número romano bien formado"
fi
fi

else
echo "No se ha recibido ningún parámetro válido"
fi