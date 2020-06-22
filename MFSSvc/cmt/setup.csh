# echo "setup MFSSvc v0 in /hpcfs/juno/junogpu/yiph/Muon/software/sl7/J19v1r1-branch/offline/CommonSvc"

if ( $?CMTROOT == 0 ) then
  setenv CMTROOT /hpcfs/juno/junogpu/yiph/Muon/software/sl7/J19v1r1-branch/ExternalLibs/CMT/v1r26
endif
source ${CMTROOT}/mgr/setup.csh
set cmtMFSSvctempfile=`${CMTROOT}/mgr/cmt -quiet build temporary_name`
if $status != 0 then
  set cmtMFSSvctempfile=/tmp/cmt.$$
endif
${CMTROOT}/mgr/cmt setup -csh -pack=MFSSvc -version=v0 -path=/hpcfs/juno/junogpu/yiph/Muon/software/sl7/J19v1r1-branch/offline/CommonSvc  -no_cleanup $* >${cmtMFSSvctempfile}
if ( $status != 0 ) then
  echo "${CMTROOT}/mgr/cmt setup -csh -pack=MFSSvc -version=v0 -path=/hpcfs/juno/junogpu/yiph/Muon/software/sl7/J19v1r1-branch/offline/CommonSvc  -no_cleanup $* >${cmtMFSSvctempfile}"
  set cmtsetupstatus=2
  /bin/rm -f ${cmtMFSSvctempfile}
  unset cmtMFSSvctempfile
  exit $cmtsetupstatus
endif
set cmtsetupstatus=0
source ${cmtMFSSvctempfile}
if ( $status != 0 ) then
  set cmtsetupstatus=2
endif
/bin/rm -f ${cmtMFSSvctempfile}
unset cmtMFSSvctempfile
exit $cmtsetupstatus

