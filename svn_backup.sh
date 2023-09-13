#!/bin/bash

yyyy=$(date +'%Y')
yyyymm=$(date +'%Y%m')
date=$(date +'%Y%m%d')
dateht=$(date +'%Y%m%d-%H%M%S')

svndir=/svn/repos
backupdir=/data01/$yyyy/$yyyymm/$date/svn_backup

# 연월 폴더 생성
mkdir -p "$backupdir"

svnadmin dump $svndir/NCMS > $backupdir/$dateht.NCMS.svn.dump;
svnadmin dump $svndir/NPMS > $backupdir/$dateht.NPMS.svn.dump;
svnadmin dump $svndir/NKMS > $backupdir/$dateht.NKMS.svn.dump;

svnadmin dump $svndir/NDX_1_NOVOMICS > $backupdir/$dateht.NDX_1_NOVOMICS.svn.dump;
svnadmin dump $svndir/NDX_1_WEB      > $backupdir/$dateht.NDX_1_WEB.svn.dump;
svnadmin dump $svndir/NDX_1_CHINA    > $backupdir/$dateht.NDX_1_CHINA.svn.dump;
svnadmin dump $svndir/NDX_1          > $backupdir/$dateht.NDX_1.svn.dump

