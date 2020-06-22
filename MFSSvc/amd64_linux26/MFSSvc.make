#-- start of make_header -----------------

#====================================
#  Library MFSSvc
#
#   Generated Tue Mar 24 15:27:23 2020  by yiph
#
#====================================

include ${CMTROOT}/src/Makefile.core

ifdef tag
CMTEXTRATAGS = $(tag)
else
tag       = $(CMTCONFIG)
endif

cmt_MFSSvc_has_no_target_tag = 1

#--------------------------------------------------------

ifdef cmt_MFSSvc_has_target_tag

tags      = $(tag),$(CMTEXTRATAGS),target_MFSSvc

MFSSvc_tag = $(tag)

#cmt_local_tagfile_MFSSvc = $(MFSSvc_tag)_MFSSvc.make
cmt_local_tagfile_MFSSvc = $(bin)$(MFSSvc_tag)_MFSSvc.make

else

tags      = $(tag),$(CMTEXTRATAGS)

MFSSvc_tag = $(tag)

#cmt_local_tagfile_MFSSvc = $(MFSSvc_tag).make
cmt_local_tagfile_MFSSvc = $(bin)$(MFSSvc_tag).make

endif

include $(cmt_local_tagfile_MFSSvc)
#-include $(cmt_local_tagfile_MFSSvc)

ifdef cmt_MFSSvc_has_target_tag

cmt_final_setup_MFSSvc = $(bin)setup_MFSSvc.make
cmt_dependencies_in_MFSSvc = $(bin)dependencies_MFSSvc.in
#cmt_final_setup_MFSSvc = $(bin)MFSSvc_MFSSvcsetup.make
cmt_local_MFSSvc_makefile = $(bin)MFSSvc.make

else

cmt_final_setup_MFSSvc = $(bin)setup.make
cmt_dependencies_in_MFSSvc = $(bin)dependencies.in
#cmt_final_setup_MFSSvc = $(bin)MFSSvcsetup.make
cmt_local_MFSSvc_makefile = $(bin)MFSSvc.make

endif

#cmt_final_setup = $(bin)setup.make
#cmt_final_setup = $(bin)MFSSvcsetup.make

#MFSSvc :: ;

dirs ::
	@if test ! -r requirements ; then echo "No requirements file" ; fi; \
	  if test ! -d $(bin) ; then $(mkdir) -p $(bin) ; fi

javadirs ::
	@if test ! -d $(javabin) ; then $(mkdir) -p $(javabin) ; fi

srcdirs ::
	@if test ! -d $(src) ; then $(mkdir) -p $(src) ; fi

help ::
	$(echo) 'MFSSvc'

binobj = 
ifdef STRUCTURED_OUTPUT
binobj = MFSSvc/
#MFSSvc::
#	@if test ! -d $(bin)$(binobj) ; then $(mkdir) -p $(bin)$(binobj) ; fi
#	$(echo) "STRUCTURED_OUTPUT="$(bin)$(binobj)
endif

${CMTROOT}/src/Makefile.core : ;
ifdef use_requirements
$(use_requirements) : ;
endif

#-- end of make_header ------------------
#-- start of libary_header ---------------

MFSSvclibname   = $(bin)$(library_prefix)MFSSvc$(library_suffix)
MFSSvclib       = $(MFSSvclibname).a
MFSSvcstamp     = $(bin)MFSSvc.stamp
MFSSvcshstamp   = $(bin)MFSSvc.shstamp

MFSSvc :: dirs  MFSSvcLIB
	$(echo) "MFSSvc ok"

cmt_MFSSvc_has_prototypes = 1

#--------------------------------------

ifdef cmt_MFSSvc_has_prototypes

MFSSvcprototype :  ;

endif

MFSSvccompile : $(bin)MFSSvc.o $(bin)MPIService.o $(bin)file.o $(bin)MFSHashAlg.o $(bin)threadPool.o $(bin)MFSHash.o $(bin)nodeAgent.o $(bin)server.o $(bin)client.o $(bin)taskMgr.o $(bin)watchDog.o $(bin)internalComm.o $(bin)internalQueue.o $(bin)masterContext.o $(bin)slaveContext.o $(bin)slave_handler.o $(bin)master_handler.o $(bin)sniper_handler.o ;

#-- end of libary_header ----------------
#-- start of libary ----------------------

MFSSvcLIB :: $(MFSSvclib) $(MFSSvcshstamp)
	$(echo) "MFSSvc : library ok"

$(MFSSvclib) :: $(bin)MFSSvc.o $(bin)MPIService.o $(bin)file.o $(bin)MFSHashAlg.o $(bin)threadPool.o $(bin)MFSHash.o $(bin)nodeAgent.o $(bin)server.o $(bin)client.o $(bin)taskMgr.o $(bin)watchDog.o $(bin)internalComm.o $(bin)internalQueue.o $(bin)masterContext.o $(bin)slaveContext.o $(bin)slave_handler.o $(bin)master_handler.o $(bin)sniper_handler.o
	$(lib_echo) "static library $@"
	$(lib_silent) [ ! -f $@ ] || \rm -f $@
	$(lib_silent) $(ar) $(MFSSvclib) $(bin)MFSSvc.o $(bin)MPIService.o $(bin)file.o $(bin)MFSHashAlg.o $(bin)threadPool.o $(bin)MFSHash.o $(bin)nodeAgent.o $(bin)server.o $(bin)client.o $(bin)taskMgr.o $(bin)watchDog.o $(bin)internalComm.o $(bin)internalQueue.o $(bin)masterContext.o $(bin)slaveContext.o $(bin)slave_handler.o $(bin)master_handler.o $(bin)sniper_handler.o
	$(lib_silent) $(ranlib) $(MFSSvclib)
	$(lib_silent) cat /dev/null >$(MFSSvcstamp)

#------------------------------------------------------------------
#  Future improvement? to empty the object files after
#  storing in the library
#
##	  for f in $?; do \
##	    rm $${f}; touch $${f}; \
##	  done
#------------------------------------------------------------------

#
# We add one level of dependency upon the true shared library 
# (rather than simply upon the stamp file)
# this is for cases where the shared library has not been built
# while the stamp was created (error??) 
#

$(MFSSvclibname).$(shlibsuffix) :: $(MFSSvclib) requirements $(use_requirements) $(MFSSvcstamps)
	$(lib_echo) "shared library $@"
	$(lib_silent) if test "$(makecmd)"; then QUIET=; else QUIET=1; fi; QUIET=$${QUIET} bin="$(bin)" ld="$(shlibbuilder)" ldflags="$(shlibflags)" suffix=$(shlibsuffix) libprefix=$(library_prefix) libsuffix=$(library_suffix) $(make_shlib) "$(tags)" MFSSvc $(MFSSvc_shlibflags)
	$(lib_silent) cat /dev/null >$(MFSSvcshstamp)

$(MFSSvcshstamp) :: $(MFSSvclibname).$(shlibsuffix)
	$(lib_silent) if test -f $(MFSSvclibname).$(shlibsuffix) ; then cat /dev/null >$(MFSSvcshstamp) ; fi

MFSSvcclean ::
	$(cleanup_echo) objects MFSSvc
	$(cleanup_silent) /bin/rm -f $(bin)MFSSvc.o $(bin)MPIService.o $(bin)file.o $(bin)MFSHashAlg.o $(bin)threadPool.o $(bin)MFSHash.o $(bin)nodeAgent.o $(bin)server.o $(bin)client.o $(bin)taskMgr.o $(bin)watchDog.o $(bin)internalComm.o $(bin)internalQueue.o $(bin)masterContext.o $(bin)slaveContext.o $(bin)slave_handler.o $(bin)master_handler.o $(bin)sniper_handler.o
	$(cleanup_silent) /bin/rm -f $(patsubst %.o,%.d,$(bin)MFSSvc.o $(bin)MPIService.o $(bin)file.o $(bin)MFSHashAlg.o $(bin)threadPool.o $(bin)MFSHash.o $(bin)nodeAgent.o $(bin)server.o $(bin)client.o $(bin)taskMgr.o $(bin)watchDog.o $(bin)internalComm.o $(bin)internalQueue.o $(bin)masterContext.o $(bin)slaveContext.o $(bin)slave_handler.o $(bin)master_handler.o $(bin)sniper_handler.o) $(patsubst %.o,%.dep,$(bin)MFSSvc.o $(bin)MPIService.o $(bin)file.o $(bin)MFSHashAlg.o $(bin)threadPool.o $(bin)MFSHash.o $(bin)nodeAgent.o $(bin)server.o $(bin)client.o $(bin)taskMgr.o $(bin)watchDog.o $(bin)internalComm.o $(bin)internalQueue.o $(bin)masterContext.o $(bin)slaveContext.o $(bin)slave_handler.o $(bin)master_handler.o $(bin)sniper_handler.o) $(patsubst %.o,%.d.stamp,$(bin)MFSSvc.o $(bin)MPIService.o $(bin)file.o $(bin)MFSHashAlg.o $(bin)threadPool.o $(bin)MFSHash.o $(bin)nodeAgent.o $(bin)server.o $(bin)client.o $(bin)taskMgr.o $(bin)watchDog.o $(bin)internalComm.o $(bin)internalQueue.o $(bin)masterContext.o $(bin)slaveContext.o $(bin)slave_handler.o $(bin)master_handler.o $(bin)sniper_handler.o)
	$(cleanup_silent) cd $(bin); /bin/rm -rf MFSSvc_deps MFSSvc_dependencies.make

#-----------------------------------------------------------------
#
#  New section for automatic installation
#
#-----------------------------------------------------------------

install_dir = ${CMTINSTALLAREA}/$(tag)/lib
MFSSvcinstallname = $(library_prefix)MFSSvc$(library_suffix).$(shlibsuffix)

MFSSvc :: MFSSvcinstall ;

install :: MFSSvcinstall ;

MFSSvcinstall :: $(install_dir)/$(MFSSvcinstallname)
ifdef CMTINSTALLAREA
	$(echo) "installation done"
endif

$(install_dir)/$(MFSSvcinstallname) :: $(bin)$(MFSSvcinstallname)
ifdef CMTINSTALLAREA
	$(install_silent) $(cmt_install_action) \
	    -source "`(cd $(bin); pwd)`" \
	    -name "$(MFSSvcinstallname)" \
	    -out "$(install_dir)" \
	    -cmd "$(cmt_installarea_command)" \
	    -cmtpath "$($(package)_cmtpath)"
endif

##MFSSvcclean :: MFSSvcuninstall

uninstall :: MFSSvcuninstall ;

MFSSvcuninstall ::
ifdef CMTINSTALLAREA
	$(cleanup_silent) $(cmt_uninstall_action) \
	    -source "`(cd $(bin); pwd)`" \
	    -name "$(MFSSvcinstallname)" \
	    -out "$(install_dir)" \
	    -cmtpath "$($(package)_cmtpath)"
endif

#-- end of libary -----------------------
#-- start of dependencies ------------------
ifneq ($(MAKECMDGOALS),MFSSvcclean)
ifneq ($(MAKECMDGOALS),uninstall)
ifneq ($(MAKECMDGOALS),MFSSvcprototype)

$(bin)MFSSvc_dependencies.make : $(use_requirements) $(cmt_final_setup_MFSSvc)
	$(echo) "(MFSSvc.make) Rebuilding $@"; \
	  $(build_dependencies) -out=$@ -start_all $(src)MFSSvc.cpp $(src)MPIService.cpp $(src)util/file.cpp $(src)util/MFSHashAlg.cpp $(src)util/threadPool.cpp $(src)util/MFSHash.cpp $(src)com/nodeAgent.cpp $(src)com/server.cpp $(src)com/client.cpp $(src)control/taskMgr.cpp $(src)control/watchDog.cpp $(src)control/internalComm.cpp $(src)control/internalQueue.cpp $(src)core/masterContext.cpp $(src)core/slaveContext.cpp $(src)handler/slave_handler.cpp $(src)handler/master_handler.cpp $(src)handler/sniper_handler.cpp -end_all $(includes) $(app_MFSSvc_cppflags) $(lib_MFSSvc_cppflags) -name=MFSSvc $? -f=$(cmt_dependencies_in_MFSSvc) -without_cmt

-include $(bin)MFSSvc_dependencies.make

endif
endif
endif

MFSSvcclean ::
	$(cleanup_silent) \rm -rf $(bin)MFSSvc_deps $(bin)MFSSvc_dependencies.make
#-- end of dependencies -------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),MFSSvcclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)MFSSvc.d

$(bin)$(binobj)MFSSvc.d :

$(bin)$(binobj)MFSSvc.o : $(cmt_final_setup_MFSSvc)

$(bin)$(binobj)MFSSvc.o : $(src)MFSSvc.cpp
	$(cpp_echo) $(src)MFSSvc.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(MFSSvc_pp_cppflags) $(lib_MFSSvc_pp_cppflags) $(MFSSvc_pp_cppflags) $(use_cppflags) $(MFSSvc_cppflags) $(lib_MFSSvc_cppflags) $(MFSSvc_cppflags) $(MFSSvc_cpp_cppflags)  $(src)MFSSvc.cpp
endif
endif

else
$(bin)MFSSvc_dependencies.make : $(MFSSvc_cpp_dependencies)

$(bin)MFSSvc_dependencies.make : $(src)MFSSvc.cpp

$(bin)$(binobj)MFSSvc.o : $(MFSSvc_cpp_dependencies)
	$(cpp_echo) $(src)MFSSvc.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(MFSSvc_pp_cppflags) $(lib_MFSSvc_pp_cppflags) $(MFSSvc_pp_cppflags) $(use_cppflags) $(MFSSvc_cppflags) $(lib_MFSSvc_cppflags) $(MFSSvc_cppflags) $(MFSSvc_cpp_cppflags)  $(src)MFSSvc.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),MFSSvcclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)MPIService.d

$(bin)$(binobj)MPIService.d :

$(bin)$(binobj)MPIService.o : $(cmt_final_setup_MFSSvc)

$(bin)$(binobj)MPIService.o : $(src)MPIService.cpp
	$(cpp_echo) $(src)MPIService.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(MFSSvc_pp_cppflags) $(lib_MFSSvc_pp_cppflags) $(MPIService_pp_cppflags) $(use_cppflags) $(MFSSvc_cppflags) $(lib_MFSSvc_cppflags) $(MPIService_cppflags) $(MPIService_cpp_cppflags)  $(src)MPIService.cpp
endif
endif

else
$(bin)MFSSvc_dependencies.make : $(MPIService_cpp_dependencies)

$(bin)MFSSvc_dependencies.make : $(src)MPIService.cpp

$(bin)$(binobj)MPIService.o : $(MPIService_cpp_dependencies)
	$(cpp_echo) $(src)MPIService.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(MFSSvc_pp_cppflags) $(lib_MFSSvc_pp_cppflags) $(MPIService_pp_cppflags) $(use_cppflags) $(MFSSvc_cppflags) $(lib_MFSSvc_cppflags) $(MPIService_cppflags) $(MPIService_cpp_cppflags)  $(src)MPIService.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),MFSSvcclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)file.d

$(bin)$(binobj)file.d :

$(bin)$(binobj)file.o : $(cmt_final_setup_MFSSvc)

$(bin)$(binobj)file.o : $(src)util/file.cpp
	$(cpp_echo) $(src)util/file.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(MFSSvc_pp_cppflags) $(lib_MFSSvc_pp_cppflags) $(file_pp_cppflags) $(use_cppflags) $(MFSSvc_cppflags) $(lib_MFSSvc_cppflags) $(file_cppflags) $(file_cpp_cppflags) -I../src/util $(src)util/file.cpp
endif
endif

else
$(bin)MFSSvc_dependencies.make : $(file_cpp_dependencies)

$(bin)MFSSvc_dependencies.make : $(src)util/file.cpp

$(bin)$(binobj)file.o : $(file_cpp_dependencies)
	$(cpp_echo) $(src)util/file.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(MFSSvc_pp_cppflags) $(lib_MFSSvc_pp_cppflags) $(file_pp_cppflags) $(use_cppflags) $(MFSSvc_cppflags) $(lib_MFSSvc_cppflags) $(file_cppflags) $(file_cpp_cppflags) -I../src/util $(src)util/file.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),MFSSvcclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)MFSHashAlg.d

$(bin)$(binobj)MFSHashAlg.d :

$(bin)$(binobj)MFSHashAlg.o : $(cmt_final_setup_MFSSvc)

$(bin)$(binobj)MFSHashAlg.o : $(src)util/MFSHashAlg.cpp
	$(cpp_echo) $(src)util/MFSHashAlg.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(MFSSvc_pp_cppflags) $(lib_MFSSvc_pp_cppflags) $(MFSHashAlg_pp_cppflags) $(use_cppflags) $(MFSSvc_cppflags) $(lib_MFSSvc_cppflags) $(MFSHashAlg_cppflags) $(MFSHashAlg_cpp_cppflags) -I../src/util $(src)util/MFSHashAlg.cpp
endif
endif

else
$(bin)MFSSvc_dependencies.make : $(MFSHashAlg_cpp_dependencies)

$(bin)MFSSvc_dependencies.make : $(src)util/MFSHashAlg.cpp

$(bin)$(binobj)MFSHashAlg.o : $(MFSHashAlg_cpp_dependencies)
	$(cpp_echo) $(src)util/MFSHashAlg.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(MFSSvc_pp_cppflags) $(lib_MFSSvc_pp_cppflags) $(MFSHashAlg_pp_cppflags) $(use_cppflags) $(MFSSvc_cppflags) $(lib_MFSSvc_cppflags) $(MFSHashAlg_cppflags) $(MFSHashAlg_cpp_cppflags) -I../src/util $(src)util/MFSHashAlg.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),MFSSvcclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)threadPool.d

$(bin)$(binobj)threadPool.d :

$(bin)$(binobj)threadPool.o : $(cmt_final_setup_MFSSvc)

$(bin)$(binobj)threadPool.o : $(src)util/threadPool.cpp
	$(cpp_echo) $(src)util/threadPool.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(MFSSvc_pp_cppflags) $(lib_MFSSvc_pp_cppflags) $(threadPool_pp_cppflags) $(use_cppflags) $(MFSSvc_cppflags) $(lib_MFSSvc_cppflags) $(threadPool_cppflags) $(threadPool_cpp_cppflags) -I../src/util $(src)util/threadPool.cpp
endif
endif

else
$(bin)MFSSvc_dependencies.make : $(threadPool_cpp_dependencies)

$(bin)MFSSvc_dependencies.make : $(src)util/threadPool.cpp

$(bin)$(binobj)threadPool.o : $(threadPool_cpp_dependencies)
	$(cpp_echo) $(src)util/threadPool.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(MFSSvc_pp_cppflags) $(lib_MFSSvc_pp_cppflags) $(threadPool_pp_cppflags) $(use_cppflags) $(MFSSvc_cppflags) $(lib_MFSSvc_cppflags) $(threadPool_cppflags) $(threadPool_cpp_cppflags) -I../src/util $(src)util/threadPool.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),MFSSvcclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)MFSHash.d

$(bin)$(binobj)MFSHash.d :

$(bin)$(binobj)MFSHash.o : $(cmt_final_setup_MFSSvc)

$(bin)$(binobj)MFSHash.o : $(src)util/MFSHash.cpp
	$(cpp_echo) $(src)util/MFSHash.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(MFSSvc_pp_cppflags) $(lib_MFSSvc_pp_cppflags) $(MFSHash_pp_cppflags) $(use_cppflags) $(MFSSvc_cppflags) $(lib_MFSSvc_cppflags) $(MFSHash_cppflags) $(MFSHash_cpp_cppflags) -I../src/util $(src)util/MFSHash.cpp
endif
endif

else
$(bin)MFSSvc_dependencies.make : $(MFSHash_cpp_dependencies)

$(bin)MFSSvc_dependencies.make : $(src)util/MFSHash.cpp

$(bin)$(binobj)MFSHash.o : $(MFSHash_cpp_dependencies)
	$(cpp_echo) $(src)util/MFSHash.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(MFSSvc_pp_cppflags) $(lib_MFSSvc_pp_cppflags) $(MFSHash_pp_cppflags) $(use_cppflags) $(MFSSvc_cppflags) $(lib_MFSSvc_cppflags) $(MFSHash_cppflags) $(MFSHash_cpp_cppflags) -I../src/util $(src)util/MFSHash.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),MFSSvcclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)nodeAgent.d

$(bin)$(binobj)nodeAgent.d :

$(bin)$(binobj)nodeAgent.o : $(cmt_final_setup_MFSSvc)

$(bin)$(binobj)nodeAgent.o : $(src)com/nodeAgent.cpp
	$(cpp_echo) $(src)com/nodeAgent.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(MFSSvc_pp_cppflags) $(lib_MFSSvc_pp_cppflags) $(nodeAgent_pp_cppflags) $(use_cppflags) $(MFSSvc_cppflags) $(lib_MFSSvc_cppflags) $(nodeAgent_cppflags) $(nodeAgent_cpp_cppflags) -I../src/com $(src)com/nodeAgent.cpp
endif
endif

else
$(bin)MFSSvc_dependencies.make : $(nodeAgent_cpp_dependencies)

$(bin)MFSSvc_dependencies.make : $(src)com/nodeAgent.cpp

$(bin)$(binobj)nodeAgent.o : $(nodeAgent_cpp_dependencies)
	$(cpp_echo) $(src)com/nodeAgent.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(MFSSvc_pp_cppflags) $(lib_MFSSvc_pp_cppflags) $(nodeAgent_pp_cppflags) $(use_cppflags) $(MFSSvc_cppflags) $(lib_MFSSvc_cppflags) $(nodeAgent_cppflags) $(nodeAgent_cpp_cppflags) -I../src/com $(src)com/nodeAgent.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),MFSSvcclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)server.d

$(bin)$(binobj)server.d :

$(bin)$(binobj)server.o : $(cmt_final_setup_MFSSvc)

$(bin)$(binobj)server.o : $(src)com/server.cpp
	$(cpp_echo) $(src)com/server.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(MFSSvc_pp_cppflags) $(lib_MFSSvc_pp_cppflags) $(server_pp_cppflags) $(use_cppflags) $(MFSSvc_cppflags) $(lib_MFSSvc_cppflags) $(server_cppflags) $(server_cpp_cppflags) -I../src/com $(src)com/server.cpp
endif
endif

else
$(bin)MFSSvc_dependencies.make : $(server_cpp_dependencies)

$(bin)MFSSvc_dependencies.make : $(src)com/server.cpp

$(bin)$(binobj)server.o : $(server_cpp_dependencies)
	$(cpp_echo) $(src)com/server.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(MFSSvc_pp_cppflags) $(lib_MFSSvc_pp_cppflags) $(server_pp_cppflags) $(use_cppflags) $(MFSSvc_cppflags) $(lib_MFSSvc_cppflags) $(server_cppflags) $(server_cpp_cppflags) -I../src/com $(src)com/server.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),MFSSvcclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)client.d

$(bin)$(binobj)client.d :

$(bin)$(binobj)client.o : $(cmt_final_setup_MFSSvc)

$(bin)$(binobj)client.o : $(src)com/client.cpp
	$(cpp_echo) $(src)com/client.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(MFSSvc_pp_cppflags) $(lib_MFSSvc_pp_cppflags) $(client_pp_cppflags) $(use_cppflags) $(MFSSvc_cppflags) $(lib_MFSSvc_cppflags) $(client_cppflags) $(client_cpp_cppflags) -I../src/com $(src)com/client.cpp
endif
endif

else
$(bin)MFSSvc_dependencies.make : $(client_cpp_dependencies)

$(bin)MFSSvc_dependencies.make : $(src)com/client.cpp

$(bin)$(binobj)client.o : $(client_cpp_dependencies)
	$(cpp_echo) $(src)com/client.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(MFSSvc_pp_cppflags) $(lib_MFSSvc_pp_cppflags) $(client_pp_cppflags) $(use_cppflags) $(MFSSvc_cppflags) $(lib_MFSSvc_cppflags) $(client_cppflags) $(client_cpp_cppflags) -I../src/com $(src)com/client.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),MFSSvcclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)taskMgr.d

$(bin)$(binobj)taskMgr.d :

$(bin)$(binobj)taskMgr.o : $(cmt_final_setup_MFSSvc)

$(bin)$(binobj)taskMgr.o : $(src)control/taskMgr.cpp
	$(cpp_echo) $(src)control/taskMgr.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(MFSSvc_pp_cppflags) $(lib_MFSSvc_pp_cppflags) $(taskMgr_pp_cppflags) $(use_cppflags) $(MFSSvc_cppflags) $(lib_MFSSvc_cppflags) $(taskMgr_cppflags) $(taskMgr_cpp_cppflags) -I../src/control $(src)control/taskMgr.cpp
endif
endif

else
$(bin)MFSSvc_dependencies.make : $(taskMgr_cpp_dependencies)

$(bin)MFSSvc_dependencies.make : $(src)control/taskMgr.cpp

$(bin)$(binobj)taskMgr.o : $(taskMgr_cpp_dependencies)
	$(cpp_echo) $(src)control/taskMgr.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(MFSSvc_pp_cppflags) $(lib_MFSSvc_pp_cppflags) $(taskMgr_pp_cppflags) $(use_cppflags) $(MFSSvc_cppflags) $(lib_MFSSvc_cppflags) $(taskMgr_cppflags) $(taskMgr_cpp_cppflags) -I../src/control $(src)control/taskMgr.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),MFSSvcclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)watchDog.d

$(bin)$(binobj)watchDog.d :

$(bin)$(binobj)watchDog.o : $(cmt_final_setup_MFSSvc)

$(bin)$(binobj)watchDog.o : $(src)control/watchDog.cpp
	$(cpp_echo) $(src)control/watchDog.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(MFSSvc_pp_cppflags) $(lib_MFSSvc_pp_cppflags) $(watchDog_pp_cppflags) $(use_cppflags) $(MFSSvc_cppflags) $(lib_MFSSvc_cppflags) $(watchDog_cppflags) $(watchDog_cpp_cppflags) -I../src/control $(src)control/watchDog.cpp
endif
endif

else
$(bin)MFSSvc_dependencies.make : $(watchDog_cpp_dependencies)

$(bin)MFSSvc_dependencies.make : $(src)control/watchDog.cpp

$(bin)$(binobj)watchDog.o : $(watchDog_cpp_dependencies)
	$(cpp_echo) $(src)control/watchDog.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(MFSSvc_pp_cppflags) $(lib_MFSSvc_pp_cppflags) $(watchDog_pp_cppflags) $(use_cppflags) $(MFSSvc_cppflags) $(lib_MFSSvc_cppflags) $(watchDog_cppflags) $(watchDog_cpp_cppflags) -I../src/control $(src)control/watchDog.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),MFSSvcclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)internalComm.d

$(bin)$(binobj)internalComm.d :

$(bin)$(binobj)internalComm.o : $(cmt_final_setup_MFSSvc)

$(bin)$(binobj)internalComm.o : $(src)control/internalComm.cpp
	$(cpp_echo) $(src)control/internalComm.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(MFSSvc_pp_cppflags) $(lib_MFSSvc_pp_cppflags) $(internalComm_pp_cppflags) $(use_cppflags) $(MFSSvc_cppflags) $(lib_MFSSvc_cppflags) $(internalComm_cppflags) $(internalComm_cpp_cppflags) -I../src/control $(src)control/internalComm.cpp
endif
endif

else
$(bin)MFSSvc_dependencies.make : $(internalComm_cpp_dependencies)

$(bin)MFSSvc_dependencies.make : $(src)control/internalComm.cpp

$(bin)$(binobj)internalComm.o : $(internalComm_cpp_dependencies)
	$(cpp_echo) $(src)control/internalComm.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(MFSSvc_pp_cppflags) $(lib_MFSSvc_pp_cppflags) $(internalComm_pp_cppflags) $(use_cppflags) $(MFSSvc_cppflags) $(lib_MFSSvc_cppflags) $(internalComm_cppflags) $(internalComm_cpp_cppflags) -I../src/control $(src)control/internalComm.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),MFSSvcclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)internalQueue.d

$(bin)$(binobj)internalQueue.d :

$(bin)$(binobj)internalQueue.o : $(cmt_final_setup_MFSSvc)

$(bin)$(binobj)internalQueue.o : $(src)control/internalQueue.cpp
	$(cpp_echo) $(src)control/internalQueue.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(MFSSvc_pp_cppflags) $(lib_MFSSvc_pp_cppflags) $(internalQueue_pp_cppflags) $(use_cppflags) $(MFSSvc_cppflags) $(lib_MFSSvc_cppflags) $(internalQueue_cppflags) $(internalQueue_cpp_cppflags) -I../src/control $(src)control/internalQueue.cpp
endif
endif

else
$(bin)MFSSvc_dependencies.make : $(internalQueue_cpp_dependencies)

$(bin)MFSSvc_dependencies.make : $(src)control/internalQueue.cpp

$(bin)$(binobj)internalQueue.o : $(internalQueue_cpp_dependencies)
	$(cpp_echo) $(src)control/internalQueue.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(MFSSvc_pp_cppflags) $(lib_MFSSvc_pp_cppflags) $(internalQueue_pp_cppflags) $(use_cppflags) $(MFSSvc_cppflags) $(lib_MFSSvc_cppflags) $(internalQueue_cppflags) $(internalQueue_cpp_cppflags) -I../src/control $(src)control/internalQueue.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),MFSSvcclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)masterContext.d

$(bin)$(binobj)masterContext.d :

$(bin)$(binobj)masterContext.o : $(cmt_final_setup_MFSSvc)

$(bin)$(binobj)masterContext.o : $(src)core/masterContext.cpp
	$(cpp_echo) $(src)core/masterContext.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(MFSSvc_pp_cppflags) $(lib_MFSSvc_pp_cppflags) $(masterContext_pp_cppflags) $(use_cppflags) $(MFSSvc_cppflags) $(lib_MFSSvc_cppflags) $(masterContext_cppflags) $(masterContext_cpp_cppflags) -I../src/core $(src)core/masterContext.cpp
endif
endif

else
$(bin)MFSSvc_dependencies.make : $(masterContext_cpp_dependencies)

$(bin)MFSSvc_dependencies.make : $(src)core/masterContext.cpp

$(bin)$(binobj)masterContext.o : $(masterContext_cpp_dependencies)
	$(cpp_echo) $(src)core/masterContext.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(MFSSvc_pp_cppflags) $(lib_MFSSvc_pp_cppflags) $(masterContext_pp_cppflags) $(use_cppflags) $(MFSSvc_cppflags) $(lib_MFSSvc_cppflags) $(masterContext_cppflags) $(masterContext_cpp_cppflags) -I../src/core $(src)core/masterContext.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),MFSSvcclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)slaveContext.d

$(bin)$(binobj)slaveContext.d :

$(bin)$(binobj)slaveContext.o : $(cmt_final_setup_MFSSvc)

$(bin)$(binobj)slaveContext.o : $(src)core/slaveContext.cpp
	$(cpp_echo) $(src)core/slaveContext.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(MFSSvc_pp_cppflags) $(lib_MFSSvc_pp_cppflags) $(slaveContext_pp_cppflags) $(use_cppflags) $(MFSSvc_cppflags) $(lib_MFSSvc_cppflags) $(slaveContext_cppflags) $(slaveContext_cpp_cppflags) -I../src/core $(src)core/slaveContext.cpp
endif
endif

else
$(bin)MFSSvc_dependencies.make : $(slaveContext_cpp_dependencies)

$(bin)MFSSvc_dependencies.make : $(src)core/slaveContext.cpp

$(bin)$(binobj)slaveContext.o : $(slaveContext_cpp_dependencies)
	$(cpp_echo) $(src)core/slaveContext.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(MFSSvc_pp_cppflags) $(lib_MFSSvc_pp_cppflags) $(slaveContext_pp_cppflags) $(use_cppflags) $(MFSSvc_cppflags) $(lib_MFSSvc_cppflags) $(slaveContext_cppflags) $(slaveContext_cpp_cppflags) -I../src/core $(src)core/slaveContext.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),MFSSvcclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)slave_handler.d

$(bin)$(binobj)slave_handler.d :

$(bin)$(binobj)slave_handler.o : $(cmt_final_setup_MFSSvc)

$(bin)$(binobj)slave_handler.o : $(src)handler/slave_handler.cpp
	$(cpp_echo) $(src)handler/slave_handler.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(MFSSvc_pp_cppflags) $(lib_MFSSvc_pp_cppflags) $(slave_handler_pp_cppflags) $(use_cppflags) $(MFSSvc_cppflags) $(lib_MFSSvc_cppflags) $(slave_handler_cppflags) $(slave_handler_cpp_cppflags) -I../src/handler $(src)handler/slave_handler.cpp
endif
endif

else
$(bin)MFSSvc_dependencies.make : $(slave_handler_cpp_dependencies)

$(bin)MFSSvc_dependencies.make : $(src)handler/slave_handler.cpp

$(bin)$(binobj)slave_handler.o : $(slave_handler_cpp_dependencies)
	$(cpp_echo) $(src)handler/slave_handler.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(MFSSvc_pp_cppflags) $(lib_MFSSvc_pp_cppflags) $(slave_handler_pp_cppflags) $(use_cppflags) $(MFSSvc_cppflags) $(lib_MFSSvc_cppflags) $(slave_handler_cppflags) $(slave_handler_cpp_cppflags) -I../src/handler $(src)handler/slave_handler.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),MFSSvcclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)master_handler.d

$(bin)$(binobj)master_handler.d :

$(bin)$(binobj)master_handler.o : $(cmt_final_setup_MFSSvc)

$(bin)$(binobj)master_handler.o : $(src)handler/master_handler.cpp
	$(cpp_echo) $(src)handler/master_handler.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(MFSSvc_pp_cppflags) $(lib_MFSSvc_pp_cppflags) $(master_handler_pp_cppflags) $(use_cppflags) $(MFSSvc_cppflags) $(lib_MFSSvc_cppflags) $(master_handler_cppflags) $(master_handler_cpp_cppflags) -I../src/handler $(src)handler/master_handler.cpp
endif
endif

else
$(bin)MFSSvc_dependencies.make : $(master_handler_cpp_dependencies)

$(bin)MFSSvc_dependencies.make : $(src)handler/master_handler.cpp

$(bin)$(binobj)master_handler.o : $(master_handler_cpp_dependencies)
	$(cpp_echo) $(src)handler/master_handler.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(MFSSvc_pp_cppflags) $(lib_MFSSvc_pp_cppflags) $(master_handler_pp_cppflags) $(use_cppflags) $(MFSSvc_cppflags) $(lib_MFSSvc_cppflags) $(master_handler_cppflags) $(master_handler_cpp_cppflags) -I../src/handler $(src)handler/master_handler.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),MFSSvcclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)sniper_handler.d

$(bin)$(binobj)sniper_handler.d :

$(bin)$(binobj)sniper_handler.o : $(cmt_final_setup_MFSSvc)

$(bin)$(binobj)sniper_handler.o : $(src)handler/sniper_handler.cpp
	$(cpp_echo) $(src)handler/sniper_handler.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(MFSSvc_pp_cppflags) $(lib_MFSSvc_pp_cppflags) $(sniper_handler_pp_cppflags) $(use_cppflags) $(MFSSvc_cppflags) $(lib_MFSSvc_cppflags) $(sniper_handler_cppflags) $(sniper_handler_cpp_cppflags) -I../src/handler $(src)handler/sniper_handler.cpp
endif
endif

else
$(bin)MFSSvc_dependencies.make : $(sniper_handler_cpp_dependencies)

$(bin)MFSSvc_dependencies.make : $(src)handler/sniper_handler.cpp

$(bin)$(binobj)sniper_handler.o : $(sniper_handler_cpp_dependencies)
	$(cpp_echo) $(src)handler/sniper_handler.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(MFSSvc_pp_cppflags) $(lib_MFSSvc_pp_cppflags) $(sniper_handler_pp_cppflags) $(use_cppflags) $(MFSSvc_cppflags) $(lib_MFSSvc_cppflags) $(sniper_handler_cppflags) $(sniper_handler_cpp_cppflags) -I../src/handler $(src)handler/sniper_handler.cpp

endif

#-- end of cpp_library ------------------
#-- start of cleanup_header --------------

clean :: MFSSvcclean ;
#	@cd .

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(MFSSvc.make) $@: No rule for such target" >&2
else
.DEFAULT::
	$(error PEDANTIC: $@: No rule for such target)
endif

MFSSvcclean ::
#-- end of cleanup_header ---------------
#-- start of cleanup_library -------------
	$(cleanup_echo) library MFSSvc
	-$(cleanup_silent) cd $(bin) && \rm -f $(library_prefix)MFSSvc$(library_suffix).a $(library_prefix)MFSSvc$(library_suffix).$(shlibsuffix) MFSSvc.stamp MFSSvc.shstamp
#-- end of cleanup_library ---------------
