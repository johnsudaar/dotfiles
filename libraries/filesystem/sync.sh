#! /bin/bash

function installFile() {
  srcFile=$1
  dstFile=$2

  dstDir=$(dirname $dstFile)

  if [ ! -d $dst ]; then
    mkdir -p $dstDir
  fi

  diff $srcFile $dstFile >/dev/null 2>&1

  if [ $? -ne 0 ] ; then
    info "Copying $srcFile to $dstFile"
    cp $srcFile $dstFile
    if [ $? -ne 0 ] ; then
      error "Error while copying file (status code $?)"
      return 2
    fi
    return 1
  fi
  return 0
}

function installDir() {
  srcDir=$1
  dstDir=$2
  ret=0

  mkdir -p $dstDir

  for file in $(ls $srcDir); do
    srcFile=$srcDir/$file
    dstFile=$dstDir/$file

    if [ -f $srcFile ]; then
      installFile $srcFile $dstFile
      tempRet=$?
    fi

    if [ -d $srcFile ]; then
      installDir $srcFile $dstFile
      tempRet=$?
    fi

    if [ $ret -eq 0 ] ; then
      ret=$tempRet
    fi
  done

  return $ret
}

