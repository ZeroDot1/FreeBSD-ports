--- acinclude.m4.orig	2018-12-04 16:12:30 UTC
+++ acinclude.m4
@@ -971,15 +971,9 @@ dnl ------------------------------------
   if test "$3" != "shared" && test "$3" != "yes" && test "$4" = "cli"; then
 dnl ---------------------------------------------- CLI static module
     [PHP_]translit($1,a-z_-,A-Z__)[_SHARED]=no
-    case "$PHP_SAPI" in
-      cgi|embed|phpdbg[)]
-        PHP_ADD_SOURCES($ext_dir,$2,$ac_extra,)
-        EXT_STATIC="$EXT_STATIC $1;$ext_dir"
-        ;;
-      *[)]
-        PHP_ADD_SOURCES($ext_dir,$2,$ac_extra,cli)
-        ;;
-    esac
+
+	PHP_ADD_SOURCES(PHP_EXT_DIR($1),$2,$ac_extra,cgi)
+	PHP_ADD_SOURCES(PHP_EXT_DIR($1),$2,$ac_extra,fpm)
     EXT_CLI_STATIC="$EXT_CLI_STATIC $1;$ext_dir"
   fi
   PHP_ADD_BUILD_DIR($ext_builddir)
@@ -1029,12 +1023,6 @@ You either need to build $1 shared or bu
 build to be successful.
 ])
   fi
-  if test "x$is_it_enabled" = "xno" && test "x$3" != "xtrue"; then
-    AC_MSG_ERROR([
-You've configured extension $1, which depends on extension $2,
-but you've either not enabled $2, or have disabled it.
-])
-  fi
   dnl Some systems require that we link $2 to $1 when building
 ])
 
@@ -2970,8 +2958,7 @@ dnl in GNU Make which causes the .d file
 $abs_srcdir/$ac_provsrc:;
 
 $ac_bdir[$]ac_hdrobj: $abs_srcdir/$ac_provsrc
-	CFLAGS="\$(CFLAGS_CLEAN)" dtrace -h -C -s $ac_srcdir[$]ac_provsrc -o \$[]@.bak && \$(SED) -e 's,PHP_,DTRACE_,g' \$[]@.bak > \$[]@
-
+	CFLAGS="\$(CFLAGS_CLEAN)" dtrace -xnolibs -h -C -s $ac_srcdir[$]ac_provsrc -o \$[]@.bak && \$(SED) -e 's,PHP_,DTRACE_,g' \$[]@.bak > \$[]@
 \$(PHP_DTRACE_OBJS): $ac_bdir[$]ac_hdrobj
 
 EOF
@@ -2990,12 +2977,12 @@ dnl Always attempt to create both PIC an
 $ac_bdir[$]ac_provsrc.lo: \$(PHP_DTRACE_OBJS)
 	echo "[#] Generated by Makefile for libtool" > \$[]@
 	@test -d "$dtrace_lib_dir" || mkdir $dtrace_lib_dir
-	if CFLAGS="\$(CFLAGS_CLEAN)" dtrace -G -o $dtrace_d_obj -s $abs_srcdir/$ac_provsrc $dtrace_lib_objs 2> /dev/null && test -f "$dtrace_d_obj"; then [\\]
+	if CFLAGS="\$(CFLAGS_CLEAN)" dtrace -xnolibs -G -o $dtrace_d_obj -s $abs_srcdir/$ac_provsrc $dtrace_lib_objs 2> /dev/null && test -f "$dtrace_d_obj"; then [\\]
 	  echo "pic_object=['].libs/$dtrace_prov_name[']" >> \$[]@ [;\\]
 	else [\\]
 	  echo "pic_object='none'" >> \$[]@ [;\\]
 	fi
-	if CFLAGS="\$(CFLAGS_CLEAN)" dtrace -G -o $ac_bdir[$]ac_provsrc.o -s $abs_srcdir/$ac_provsrc $dtrace_nolib_objs 2> /dev/null && test -f "$ac_bdir[$]ac_provsrc.o"; then [\\]
+	if CFLAGS="\$(CFLAGS_CLEAN)" dtrace -xnolibs -G -o $ac_bdir[$]ac_provsrc.o -s $abs_srcdir/$ac_provsrc $dtrace_nolib_objs 2> /dev/null && test -f "$ac_bdir[$]ac_provsrc.o"; then [\\]
 	  echo "non_pic_object=[']$dtrace_prov_name[']" >> \$[]@ [;\\]
 	else [\\]
 	  echo "non_pic_object='none'" >> \$[]@ [;\\]
@@ -3007,7 +2994,7 @@ EOF
   *)
 cat>>Makefile.objects<<EOF
 $ac_bdir[$]ac_provsrc.o: \$(PHP_DTRACE_OBJS)
-	CFLAGS="\$(CFLAGS_CLEAN)" dtrace -G -o \$[]@ -s $abs_srcdir/$ac_provsrc $dtrace_objs
+	CFLAGS="\$(CFLAGS_CLEAN)" dtrace -xnolibs -G -o \$[]@ -s $abs_srcdir/$ac_provsrc $dtrace_objs
 
 EOF
     ;;
