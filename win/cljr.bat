@echo off
setLocal EnableDelayedExpansion

set CLJR_HOME="C:\Documents and Settings\owner\.cljr"
set USER_HOME="C:\Documents and Settings\owner"

if not defined "%CLOJURE_HOME%" set CLOJURE_HOME=""
if not defined "%JVM_OPTS%" set JVM_OPTS=-Xmx1G

if (%1) == (repl) goto SET_CLOJURE_JARS
if (%1) == (swingrepl) goto SET_CLOJURE_JARS
if (%1) == (swank) goto SET_CLOJURE_JARS
if (%1) == (run) goto SET_CLOJURE_JARS
if (%1) == () goto SET_CLOJURE_JARS

goto LAUNCH_CLJR_ONLY

:SET_CLOJURE_JARS
     if not defined %CLOJURE_HOME% goto SET_CLASSPATH
     set CLASSPATH="
        for /R %CLOJURE_HOME% %%a in (*.jar) do (
           set CLASSPATH=!CLASSPATH!;%%a
        )
        set CLASSPATH=!CLASSPATH!"
goto SET_CLASSPATH

:SET_CLASSPATH
  set CLASSPATH="
     for /R "C:\Documents and Settings\owner\.cljr\lib" %%a in (*.jar) do (
        set CLASSPATH=!CLASSPATH!;%%a
     )
     set CLASSPATH=!CLASSPATH!"
  set CLASSPATH=%CLASSPATH%;src;test;lib/"*";lib/dev/"*";.;"C:\Documents and Settings\owner\.cljr"
goto LAUNCH

:LAUNCH_CLJR_ONLY
  java %JVM_OPTS% -Dcljr.home="C:\Documents and Settings\owner\.cljr" -Duser.home="C:\Documents and Settings\owner" -jar "C:\Documents and Settings\owner\.cljr\cljr.jar" %*
goto EOF

:LAUNCH
  java %JVM_OPTS% -Dinclude.cljr.repo.jars=false -Dcljr.home="C:\Documents and Settings\owner\.cljr" -Duser.home="C:\Documents and Settings\owner" -Dclojure.home=%CLOJURE_HOME% -cp %CLASSPATH% cljr.App %*
goto EOF

:EOF
