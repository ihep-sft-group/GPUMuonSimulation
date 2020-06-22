# echo "cleanup GPUSvc v0 in /hpcfs/juno/junogpu/yiph/Muon/software/sl7/J19v1r1-branch/offline/CommonSvc"

if test "${CMTROOT}" = ""; then
  CMTROOT=/hpcfs/juno/junogpu/yiph/Muon/software/sl7/J19v1r1-branch/ExternalLibs/CMT/v1r26; export CMTROOT
fi
. ${CMTROOT}/mgr/setup.sh
cmtGPUSvctempfile=`${CMTROOT}/mgr/cmt -quiet build temporary_name`
if test ! $? = 0 ; then cmtGPUSvctempfile=/tmp/cmt.$$; fi
${CMTROOT}/mgr/cmt cleanup -sh -pack=GPUSvc -version=v0 -path=/hpcfs/juno/junogpu/yiph/Muon/software/sl7/J19v1r1-branch/offline/CommonSvc  $* >${cmtGPUSvctempfile}
if test $? != 0 ; then
  echo >&2 "${CMTROOT}/mgr/cmt cleanup -sh -pack=GPUSvc -version=v0 -path=/hpcfs/juno/junogpu/yiph/Muon/software/sl7/J19v1r1-branch/offline/CommonSvc  $* >${cmtGPUSvctempfile}"
  cmtcleanupstatus=2
  /bin/rm -f ${cmtGPUSvctempfile}
  unset cmtGPUSvctempfile
  return $cmtcleanupstatus
fi
cmtcleanupstatus=0
. ${cmtGPUSvctempfile}
if test $? != 0 ; then
  cmtcleanupstatus=2
fi
/bin/rm -f ${cmtGPUSvctempfile}
unset cmtGPUSvctempfile
return $cmtcleanupstatus

