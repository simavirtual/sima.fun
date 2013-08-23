IF %2==E GOTO Error
GOTO NoError

:Error
clipper \Simaclip.v52\Clipper.Fun\f\%1 /w/m/b >a.prg
GOTO QUIT

:NoError
clipper \Simaclip.v52\Clipper.Fun\f\%1 /w/m/b
GOTO QUIT

:QUIT
copy %1.obj \Simaclip.v52\Clipper.Fun
del  *.obj
del  *.bak
