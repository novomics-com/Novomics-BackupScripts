#!/bin/bash
svndir=/svn/repos
backupdir=/data01/svn_backup
yyyymm=$(date +'%Y%m')
dateht=$(date +'%Y%m%d-%H%M%S')

# 연월 폴더 생성
mkdir -p "$backupdir/$yyyymm/$date"

svnadmin dump $svndir/NCMS > $backupdir/$yyyymm/$dateht.NCMS.svn.dump;
svnadmin dump $svndir/NPMS > $backupdir/$yyyymm/$dateht.NPMS.svn.dump;
svnadmin dump $svndir/NKMS > $backupdir/$yyyymm/$dateht.NKMS.svn.dump;

svnadmin dump $svndir/NDX_1_NOVOMICS > $backupdir/$yyyymm/$dateht.NDX_1_NOVOMICS.svn.dump;
svnadmin dump $svndir/NDX_1_WEB      > $backupdir/$yyyymm/$dateht.NDX_1_WEB.svn.dump;
svnadmin dump $svndir/NDX_1_CHINA    > $backupdir/$yyyymm/$dateht.NDX_1_CHINA.svn.dump;
svnadmin dump $svndir/NDX_1          > $backupdir/$yyyymm/$dateht.NDX_1.svn.dump

