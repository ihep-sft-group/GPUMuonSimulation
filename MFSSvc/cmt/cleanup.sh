# echo "cleanup MFSSvc v0 in /hpcfs/juno/junogpu/yiph/Muon/software/sl7/J19v1r1-branch/offline/CommonSvc"

if test "${CMTROOT}" = ""; then
  CMTROOT=/hpcfs/juno/junogpu/yiph/Muon/software/sl7/J19v1r1-branch/ExternalLibs/CMT/v1r26; export CMTROOT
fi
. ${CMTROOT}/mgr/setup.sh
cmtMFSSvctempfile=`${CMTROOT}/mgr/cmt -quiet build temporary_name`
if test ! $? = 0 ; then cmtMFSSvctempfile=/tmp/cmt.$$; fi
${CMTROOT}/mgr/cmt cleanup -sh -pack=MFSSvc -version=v0 -path=/hpcfs/juno/junogpu/yiph/Muon/software/sl7/J19v1r1-branch/offline/CommonSvc  $* >${cmtMFSSvctempfile}
if test $? != 0 ; then
  echo >&2 "${CMTROOT}/mgr/cmt cleanup -sh -pack=MFSSvc -version=v0 -path=/hpcfs/juno/junogpu/yiph/Muon/software/sl7/J19v1r1-branch/offline/CommonSvc  $* >${cmtMFSSvctempfile}"
  cmtcleanupstatus=2
  /bin/rm -f ${cmtMFSSvctempfile}
  unset cmtMFSSvctempfile
  return $cmtcleanupstatus
fi
cmtcleanupstatus=0
. ${cmtMFSSvctempfile}
if test $? != 0 ; then
  cmtcleanupstatus=2
fi
/bin/rm -f ${cmtMFSSvctempfile}
unset cmtMFSSvctempfile
return $cmtcleanupstatus

