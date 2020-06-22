#-- start of make_header -----------------

#====================================
#  Document MFSSvc_python
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

cmt_MFSSvc_python_has_no_target_tag = 1

#--------------------------------------------------------

ifdef cmt_MFSSvc_python_has_target_tag

tags      = $(tag),$(CMTEXTRATAGS),target_MFSSvc_python

MFSSvc_tag = $(tag)

#cmt_local_tagfile_MFSSvc_python = $(MFSSvc_tag)_MFSSvc_python.make
cmt_local_tagfile_MFSSvc_python = $(bin)$(MFSSvc_tag)_MFSSvc_python.make

else

tags      = $(tag),$(CMTEXTRATAGS)

MFSSvc_tag = $(tag)

#cmt_local_tagfile_MFSSvc_python = $(MFSSvc_tag).make
cmt_local_tagfile_MFSSvc_python = $(bin)$(MFSSvc_tag).make

endif

include $(cmt_local_tagfile_MFSSvc_python)
#-include $(cmt_local_tagfile_MFSSvc_python)

ifdef cmt_MFSSvc_python_has_target_tag

cmt_final_setup_MFSSvc_python = $(bin)setup_MFSSvc_python.make
cmt_dependencies_in_MFSSvc_python = $(bin)dependencies_MFSSvc_python.in
#cmt_final_setup_MFSSvc_python = $(bin)MFSSvc_MFSSvc_pythonsetup.make
cmt_local_MFSSvc_python_makefile = $(bin)MFSSvc_python.make

else

cmt_final_setup_MFSSvc_python = $(bin)setup.make
cmt_dependencies_in_MFSSvc_python = $(bin)dependencies.in
#cmt_final_setup_MFSSvc_python = $(bin)MFSSvcsetup.make
cmt_local_MFSSvc_python_makefile = $(bin)MFSSvc_python.make

endif

#cmt_final_setup = $(bin)setup.make
#cmt_final_setup = $(bin)MFSSvcsetup.make

#MFSSvc_python :: ;

dirs ::
	@if test ! -r requirements ; then echo "No requirements file" ; fi; \
	  if test ! -d $(bin) ; then $(mkdir) -p $(bin) ; fi

javadirs ::
	@if test ! -d $(javabin) ; then $(mkdir) -p $(javabin) ; fi

srcdirs ::
	@if test ! -d $(src) ; then $(mkdir) -p $(src) ; fi

help ::
	$(echo) 'MFSSvc_python'

binobj = 
ifdef STRUCTURED_OUTPUT
binobj = MFSSvc_python/
#MFSSvc_python::
#	@if test ! -d $(bin)$(binobj) ; then $(mkdir) -p $(bin)$(binobj) ; fi
#	$(echo) "STRUCTURED_OUTPUT="$(bin)$(binobj)
endif

${CMTROOT}/src/Makefile.core : ;
ifdef use_requirements
$(use_requirements) : ;
endif

#-- end of make_header ------------------
#-- start of install_python_header ------


installarea = ${CMTINSTALLAREA}
install_python_dir = $(installarea)

ifneq ($(strip "$(source)"),"")
src = ../$(source)
dest = $(install_python_dir)/python
else
src = ../python
dest = $(install_python_dir)
endif

ifneq ($(strip "$(offset)"),"")
dest = $(install_python_dir)/python
endif

MFSSvc_python :: MFSSvc_pythoninstall

install :: MFSSvc_pythoninstall

MFSSvc_pythoninstall :: $(install_python_dir)
	@if [ ! "$(installarea)" = "" ] ; then\
	  echo "installation done"; \
	fi

$(install_python_dir) ::
	@if [ "$(installarea)" = "" ] ; then \
	  echo "Cannot install header files, no installation source specified"; \
	else \
	  if [ -d $(src) ] ; then \
	    echo "Installing files from $(src) to $(dest)" ; \
	    if [ "$(offset)" = "" ] ; then \
	      $(install_command) --exclude="*.py?" $(src) $(dest) ; \
	    else \
	      $(install_command) --exclude="*.py?" $(src) $(dest) --destname $(offset); \
	    fi ; \
	  else \
	    echo "no source  $(src)"; \
	  fi; \
	fi

MFSSvc_pythonclean :: MFSSvc_pythonuninstall

uninstall :: MFSSvc_pythonuninstall

MFSSvc_pythonuninstall ::
	@if test "$(installarea)" = ""; then \
	  echo "Cannot uninstall header files, no installation source specified"; \
	else \
	  echo "Uninstalling files from $(dest)"; \
	  $(uninstall_command) "$(dest)" ; \
	fi


#-- end of install_python_header ------
#-- start of cleanup_header --------------

clean :: MFSSvc_pythonclean ;
#	@cd .

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(MFSSvc_python.make) $@: No rule for such target" >&2
else
.DEFAULT::
	$(error PEDANTIC: $@: No rule for such target)
endif

MFSSvc_pythonclean ::
#-- end of cleanup_header ---------------
