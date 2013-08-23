/*************************************************************************
* TITULO..: DEFINICION DEL OBJETO BROWSE                                 *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: NOV 14/2007 MIE A
       Colombia, Bucaramanga        INICIO:  3:52 PM   NOV 14/2007 MIE

OBJETIVOS:

1- Define el objeto Browse del archivo

SINTAXIS:

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION oBrwDbfNov(lShared,cNomUsr,cAnoUsr,nFilSup,nColSup,nFilInf,nColInf,;
                    lModReg,lDelReg,lInsReg,lHaySql)

*>>>>DESCRIPCION DE PARAMETROS
/*     lShared                              // .T. Archivos Compartidos
       cNomUsr                              // Nombre del Usuario
       cAnoUsr                              // A¤o del Usuario
       nFilSup                              // Fila Superior
       nColSup                              // Columna Superior
       nFilInf                              // Fila Inferior
       nColInf                              // Columna Inferior
       lModReg                              // .T. Modificar el Registro
       lDelReg                              // .T. Borrar Registros
       lInsReg                              // .T. Insertar Registros
       lHaySql                              // .T. Exportar a Sql */
*>>>>FIN DESCRIPCION DE PARAMETROS

*>>>>DECLARACION DE VARIABLES
       LOCAL oColumn := NIL                 // Objeto Columna
       LOCAL oBrowse := NIL                 // Browse del Archivo

       LOCAL cTitSup := ''                  // T¡tulo Superior del Browse
       LOCAL cTitInf := ''                  // T¡tulo Inferior del Browse
*>>>>FIN DECLARACION DE VARIABLES

*>>>>DEFINICION DEL OBJETO BROWSE
       oBrowse := TBROWSEDB(nFilSup+1,nColSup+1,nFilInf-1,nColInf-1)
      *Definici¢n de Objeto y asignaci¢n de las coordenadas

       oBrowse:ColSep    := '³'
       oBrowse:HeadSep   := 'Ä'

       cTitSup := '<< INGRESO DE NOVEDADES >>'
       cTitInf := '<F2>Consultar <F5>Buscar'+;
                   IF(lModReg,' <F4>Actualizar','')+' <F9>Otros'+;
                   IF(lDelReg,' <DEL>Borrar','')+;
                   IF(lInsReg,' <INS>Incluir','')

       IF lInsReg
          oBrowse:Cargo := {cTitSup,cTitInf,{||lManRegNov(lShared,cNomUsr)}}
       ELSE
          oBrowse:Cargo := {cTitSup,cTitInf}
       ENDIF
     *ÀDefinici¢n de cabeceras y l¡neas de cabeceras

       SELECT NOV
       oColumn := TBCOLUMNNEW('CODIGO',{||NOV->cCodPnlNov})
       oColumn:Cargo := {{'MODI',.F.},{'ALIAS','NOV'},;
			 {'FIELD','cCodPnlNov'},{'PICTURE','999999'}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn := TBCOLUMNNEW('TIPO',{||NOV->cTipPerNov})
       oColumn:Cargo := {{'MODI',.F.},{'ALIAS','NOV'},;
			 {'FIELD','cTipPerNov'},{'PICTURE','99'}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       IF lModReg
	   oColumn := TBCOLUMNNEW('FECHA;INGRESO',{||NOV->dFecIngNov})
       ELSE
	   oColumn := TBCOLUMNNEW('FECHA;INGRESO',{||cFecIng()})
       ENDIF
       oColumn:Cargo := {{'MODI',lModReg},{'ALIAS','NOV'},;
			 {'FIELD','dFecIngNov'},{'PICTURE','@!D'}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       IF lModReg
	  oColumn := TBCOLUMNNEW('HORA;INGRESO',{||NOV->cHorIngNov})
       ELSE
	  oColumn := TBCOLUMNNEW('HORA;INGRESO',{||cHoraSys(NOV->cHorIngNov)})
       ENDIF
       oColumn:Cargo := {{'MODI',lModReg},{'ALIAS','NOV'},;
			 {'FIELD','cHorIngNov'},{'PICTURE','@!'}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       IF lModReg
	  oColumn := TBCOLUMNNEW('HORA;SALIDA',{||NOV->cHorOutNov})
       ELSE
	  oColumn := TBCOLUMNNEW('HORA;SALIDA',{||cHoraSys(NOV->cHorOutNov)})
       ENDIF
       oColumn:Cargo := {{'MODI',lModReg},{'ALIAS','NOV'},;
			 {'FIELD','cHorOutNov'},{'PICTURE','@!'}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       IF lModReg
	  oColumn := TBCOLUMNNEW('FECHA;SALIDA',{||NOV->dFecOutNov})
       ELSE
	  oColumn := TBCOLUMNNEW('FECHA;SALIDA',{||cDia(DOW(NOV->dFecOutNov),3)+' '+cFecha(NOV->dFecOutNov,3)})
       ENDIF
       oColumn:Cargo := {{'MODI',lModReg},{'ALIAS','NOV'},;
			 {'FIELD','dFecOutNov'},{'PICTURE','@!D'}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn := TBCOLUMNNEW('OBSERVACION',{||NOV->cObservNov})
       oColumn:Cargo := {{'MODI',lModReg},{'ALIAS','NOV'},;
			 {'FIELD','cObservNov'},{'PICTURE','@!'}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn	     := TBCOLUMNNEW('NOMBRE;DEL USUARIO',{||NOV->cNomUsrNov})
       oColumn:Cargo := {{'MODI',.F.}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn	     := TBCOLUMNNEW('FECHA DE;PROCESO',;
				    {||cFecha(NOV->dFecUsrNov)})
       oColumn:Cargo := {{'MODI',.F.}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn	     := TBCOLUMNNEW('HORA DE;PROCESO',;
				    {||cHoraSys(NOV->cHorUsrNov)})
       oColumn:Cargo := {{'MODI',.F.}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       RETURN oBrowse

       FUNCTION cFecIng()
       LOCAL cFecIng := ''
       cFecIng := cDia(DOW(NOV->dFecIngNov),3)+' '+;
		  cFecha(NOV->dFecIngNov,3)
       IF NOV->dFecIngNov # NOV->dFecOutNov
	  cFecIng := '*'+cFecIng
       ENDIF
       RETURN cFecIng
*>>>>FIN DEFINICION DEL OBJETO BROWSE

/*************************************************************************
* TITULO..: AUSENCIAS DEL ESTUDIANTE                                     *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: AGO 27/2009 JUE A
       Colombia,Bucaramanga         INICIO: 10:00 AM   AGO 27/2009 JUE

OBJETIVOS:

1- Visualiza las novedades de asistencias del personal

4- Retorna NIL

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION VerAusPnl(lShared,cNomUsr,cAnoUsr,lModReg,;
		   lDelReg,lInsReg,lHaySql,cNalias)

*>>>>DESCRIPCION DE PARAMETROS
/*     lShared                              // .T. Archivos Compartidos
       cNomUsr                              // Nombre del usuario
       cAnoUsr                              // A¤o del usuario
       lModReg                              // .T. Modificar el Registro
       lDelReg                              // .T. Borrar Registros
       lInsReg                              // .T. Insertar Registro
       lHaySql                              // .T. Exportar a Sql
       cNalias                              // Alias del que Invoca */
*>>>>FIN DESCRIPCION DE PARAMETROS

*>>>>DECLARACION DE VARIABLES
       #INCLUDE 'inkey.ch'                  // Declaraci¢n de teclas

       LOCAL cSavPan := ''                  // Salvar Pantalla
       LOCAL cAnoSis := SUBS(cAnoUsr,3,2)   // A¤o del sistema

       LOCAL nNroFil := 0                   // Fila de lectura
       LOCAL nNroCol := 0                   // Columna de lectura
       LOCAL cNomEst := ''                  // Nombre del Estudiante
       LOCAL cCodGru := ''                  // C¢digo del Grupo
       LOCAL cNotCli := ''                  // Nota del Cliente
       LOCAL cTxtTem := ''                  // Texto Temporal
       LOCAL oBrowse := NIL                 // Browse del Archivo

       LOCAL bCodF02 := NIL                 // Code Block asignado a F2
       LOCAL bCodF03 := NIL                 // Code Block asignado a F3
       LOCAL bCodF04 := NIL                 // Code Block asignado a F4
       LOCAL bCodF05 := NIL                 // Code Block asignado a F5
       LOCAL bCodF06 := NIL                 // Code Block asignado a F6

       MEMVA xClrSys			    // Color del Sistema
       LOCAL cSayTxt := ''                  // Color del Texto fijo
       LOCAL cSayDat := ''                  // Color para los datos
       LOCAL cClrMar := ''                  // Color del Marco y Fondo
       LOCAL cClrTit := ''                  // Color T¡tulo del Marco
*>>>>FIN DECLARACION DE VARIABLES

*>>>>DESACTIVACION DE LAS TECLAS DE FUNCION
      bCodF02 := SETKEY(K_F2)
      bCodF03 := SETKEY(K_F3)
      bCodF04 := SETKEY(K_F4)
      bCodF05 := SETKEY(K_F5)

      SETKEY(K_F2,NIL)
      SETKEY(K_F4,NIL)
      SETKEY(K_F3,NIL)
      SETKEY(K_F5,NIL)
*>>>>FIN DESACTIVACION DE LAS TECLAS DE FUNCION

*>>>>ANALISIS DEL COLOR
       Colores(xColores(IF(!EMPTY(xClrSys),xClrSys[7],'')),;
	       @cSayTxt,@cSayDat,@cClrMar,@cClrTit)
*>>>>IF ANALISIS DEL COLOR

*>>>>IMPRESION DEL NOMBRE
       cSavPan := SAVESCREEN(0,0,24,79)
       nNroFil := nMarco(03,'NOVEDADES DEL PERSONAL',22,'°',;
			 cClrMar+','+cClrTit)

       cNombreTpe := cLocNomPer(PNL->nIdePerPnl,'PNL')
       cSay(nNroFil,nNroCol+15,'NOMBRE:',cNombreTpe)

       nNroCol := 1
       @ nNroFil,nNroCol+00 SAY 'CODIGO: '+PNL->cCodigoPnl
       cSay(nNroFil,nNroCol,'CODIGO:',PNL->cCodigoPnl)
*>>>>FIN IMPRESION DEL NOMBRE

*>>>>IMPRESION DE LOS TITULOS
       cCodPnl := PNL->cCodigoPnl

       SELECT NOV
       SET FILTER TO NOV->cCodPnlNov == cCodPnl
       NOV->(DBGOTOP())

       IF NOV->(EOF())
	  cError('AL ESTUDIANTE NO LE FIGURAN AUSENCIAS DE NINGUN TIPO')
       ELSE

	  IF lModReg
	     SETKEY(K_F12,{||ModNovAsi(lShared)})
	  ENDIF

	  oBrowse := oBrwDbfNov(lShared,cNomUsr,cAnoUsr,03,00,22,79,;
				lModReg,lDelReg,lInsReg,lHaySql)
	  NOV->(CtrlBrw(lShared,oBrowse))
       ENDIF
*>>>>FIN IMPRESION DE LOS DATOS

*>>>>ACTIVACION DE LAS TECLAS DE FUNCION
       SETKEY(K_F2,bCodF02)
       SETKEY(K_F3,bCodF03)
       SETKEY(K_F4,bCodF04)
       SETKEY(K_F5,bCodF05)
       SETKEY(K_F12,NIL)

       RESTSCREEN(0,0,24,79,cSavPan)

       SELECT PNL
       IF !EMPTY(cNalias)
	  SELECT &cNalias
       ENDIF

       RETURN NIL
*>>>>FIN ACTIVACION DE LAS TECLAS DE FUNCION

/*************************************************************************
* TITULO..: MODIFICACION DE NOVEDADAD DE ASISTENCIA                      *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: SEP 18/2009 VIE A
       Colombia,Bucaramanga         INICIO: 04:30 PM   SEP 18/2009 VIE

OBJETIVOS:

1- Permite modificar la novedad de asistencia.

2- Retorna NIL

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION ModNovAsi(lShared)

*>>>>DESCRIPCION DE PARAMETROS
/*     lShared                              // .T. Archivos Compartidos */
*>>>>FIN DESCRIPCION DE PARAMETROS

*>>>>DECLARACION DE VARIABLES
       LOCAL cSavPan := ''                  // Salvar Pantalla

       LOCAL nNroFil := 0                   // Fila de lectura
       LOCAL nNroCol := 0                   // Columna de lectura

       LOCAL cHorIng := ''                  // Hora de Ingreso
       LOCAL cHorOut := ''                  // Hora de Salida

       LOCAL GetList := {}                 // Variable del sistema
*>>>>FIN DECLARACION DE VARIABLES

*>>>>DETALLES DE LA LECTURA
       cSavPan := SAVESCREEN(0,0,24,79)
       SETCURSOR(1)
       TitBuscar(20,@nNroFil,@nNroCol,cFecha(NOV->dFecIngNov)+' '+;
				      cDia(DOW(NOV->dFecIngNov),3),;
				      'FECHA',15)

       cHorIng := NOV->cHorIngNov
       cHorOut := NOV->cHorOutNov
       @ nNroFil,nNroCol   SAY 'SALIDA :' GET cHorIng PICT '99:99:99'
       @ nNroFil+1,nNroCol SAY 'INGRESO:' GET cHorOut PICT '99:99:99'
       READ

       IF !lPregunta('DESEA CONTINUAR? Si No')
	  SETCURSOR(0)
	  RESTSCREEN(0,0,24,79,cSavPan)
       ENDIF

       SETCURSOR(0)
       RESTSCREEN(0,0,24,79,cSavPan)
*>>>>FIN DETALLES DE LA LECTURA

*>>>>GRABACION DEL REGISTRO
       IF NOV->(lRegLock(lShared,.F.))

	  REPL NOV->cHorIngNov WITH cHorIng
	  REPL NOV->cHorOutNov WITH cHorOut

	  REPL NOV->cNomUsrNov WITH 'system'
	  IF NOV->dFecOutNov == CTOD('  /  /    ')
	     REPL NOV->dFecUsrNov WITH NOV->dFecIngNov
	     REPL NOV->cHorUsrNov WITH NOV->cHorIngNov
	  ELSE
	     REPL NOV->dFecUsrNov WITH NOV->dFecOutNov
	     REPL NOV->cHorUsrNov WITH NOV->cHorOutNov
	  ENDIF
	  NOV->(DBCOMMIT())
       ENDIF

       IF lShared
	  NOV->(DBUNLOCK())
       ENDIF
       RETURN NIL
*>>>>FIN GRABACION DEL REGISTRO