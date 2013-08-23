/*************************************************************************
* TITULO..: SELECCION DEL CODIGO                                         *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: AGO  8/2006 MAR A
       Colombia, Bucaramanga        INICIO: 11:56 AM   AGO  8/2006 MAR

OBJETIVOS:

1- Debe estar en uso el archivo

2- Permite escoger el registro de acuerdo al c¢digo o descripci¢n

3- Retorna el n£mero del registro escogido

SINTAXIS:

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION nSelTob(nNroFil,nNroCol)

*>>>>DESCRIPCION DE PARAMETROS
/*     nNroFil                              // N£mero de la fila
       nNroCol                              // N£mero de la Columna */
*>>>>FIN DESCRIPCION DE PARAMETROS

*>>>>DECLARACION DE VARIABLES
       LOCAL cSavPan := ''                  // Salvar Pantalla
       LOCAL nFilSup := 0                   // Fila superior
       LOCAL nColSup := 0                   // Colunma superior
       LOCAL nFilInf := 0                   // Fila inferior
       LOCAL nColInf := 0                   // Columna inferior
       LOCAL nNroReg := 0                   // N£mero del Registro
*>>>>FIN DECLARACION DE VARIABLES

*>>>>VALIDACION DE CONTENIDOS DE ARCHIVOS
       IF TOB->(RECCOUNT()) == 0
          cError('NO EXISTEN REGISTROS GRABADOS')
          RETURN 0
       ENDIF
*>>>>FIN VALIDACION DE CONTENIDOS DE ARCHIVOS

*>>>>INICIALIZACION DE LAS COORDENADAS
       SELECT TOB
       nFilSup := nNroFil+1
       nColSup := nNroCol+2
       IF nFilSup+RECCOUNT() > 22
          nFilInf := 22
       ELSE
          nFilInf := nFilSup + RECCOUNT()
       ENDIF
       nColInf := nColSup+40
*>>>>FIN INICIALIZACION DE LAS COORDENADAS

*>>>>SELECCION DEL CODIGO
       TOB->(DBGOTOP())
       cSavPan := SAVESCREEN(0,0,24,79)
       @ nFilSup-1,nColSup-1 TO nFilInf,nColInf+1 DOUBLE
       nNroReg := nBrowseDbf(nFilSup,nColSup,nFilInf-1,nColInf,;
			     {||TOB->cNombreTob})
       RESTSCREEN(0,0,24,79,cSavPan)
       RETURN nNroReg
*>>>>FIN SELECCION DEL CODIGO

/*************************************************************************
* TITULO..: SELECCION DEL CODIGO POR USUARIO                             *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: AGO 15/2006 MAR A
       Colombia, Bucaramanga        INICIO: 10:45 AM   AGO 15/2006 MAR

OBJETIVOS:

1- Permite seleccionar los tipos de observaciones de acuerdo a los
   asignados a los usuarios.

2- Los tipos de observaciones no asociados con usuarios actuan por defecto

3- Retorna el n£mero del registro escogido

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION nUsrSelTob(nNroFil,nNroCol,cNomUsr)

*>>>>DESCRIPCION DE PARAMETROS
/*     nNroFil                              // N£mero de la fila
       nNroCol                              // N£mero de la Columna
       cNomUsr                              // Nombre del usuario */
*>>>>FIN DESCRIPCION DE PARAMETROS

*>>>>DECLARACION DE VARIABLES
       LOCAL aNroOpc := {}                  // C¢digo opciones del menu
       LOCAL oBrowse := NIL                 // Browse de Arreglos
       LOCAL oColumn := NIL                 // Columna del Objetos
       LOCAL aVector := NIL                 // Arreglo para el Browse
       LOCAL nIndice := 1                   // N£mero del indice
       LOCAL nLenEle := 0                   // Elementos del Arreglo

       LOCAL nFilSup := 0                   // Fila Superior
       LOCAL nColSup := 0                   // Columna Superior
       LOCAL nFilInf := 0                   // Fila Inferior
       LOCAL nColInf := 0                   // Columna Inferior

       LOCAL nNroReg := 0                   // N£mero del Registro

       MEMVA xClrSys			    // Color del Sistema

       LOCAL cCodigoTto := ''               // C¢digo del tipo de observaci¢n.
*>>>>FIN DECLARACION DE VARIABLES

*>>>>DEFINICION DE LAS OPCIONES
       aVector := {}
       DO WHILE .NOT. TOB->(EOF())

	  IF EMPTY(TOB->cUsrAutTob) .OR.;
	     UPPER(ALLTRIM(TOB->cUsrAutTob)) == UPPER(ALLTRIM(cNomUsr))

	     AADD(aNroOpc,TOB->cCodigoTob)
	     AADD(aVector,TOB->cNombreTob)

	  ENDIF

	  TOB->(DBSKIP())

       ENDDO
       nLenEle := LEN(aVector)
*>>>>FIN DEFINICION DE LAS OPCIONES

*>>>>INICIALIZACION DE LAS COORDENADAS
       nFilSup := nNroFil
       nColSup := nNroCol
       nFilInf := nFilSup+nLenEle
       IF nFilInf > 22
	  nFilInf := 21
       ENDIF
       nColInf := nFilSup+40
*>>>>FIN INICIALIZACION DE LAS COORDENADAS

*>>>>DEFINICION DEL OBJETO BROWSE
       @ nFilSup,nColSup TO nFilInf,nColInf DOUBLE
       oBrowse := TBrowseNew(nFilSup,nColSup,nFilInf,nColInf)
      *Definici¢n de Objeto y asignaci¢n de las coordenadas

       oBrowse:skipBlock     := {|n|nSkipArray(n,@nIndice,nLenEle,oBrowse)}
       oBrowse:GoTopBlock    := {||nIndice:= 1}
       oBrowse:GoBottomBlock := {||nIndice:= nLenEle}
       oBrowse:ColorSpec:=IF(!EMPTY(xClrSys),xClrSys[6],'')
     *ÀEspecificaciones del Objeto

       oColumn         := TBColumnNew()
       oColumn:Heading := 'TIPO DE OBSERVACION:'
       oColumn:Block   := {||aVector[nIndice]}
       oBrowse:addColumn(oColumn)
     *ÀDefinici¢n Columna No. 1

       SETCURSOR(0)
       BrwArray(oBrowse, aVector, @nIndice)
       SETCURSOR(1)
*>>>>FIN DEFINICION DEL OBJETO BROWSE

*>>>>LOCALIZACION DEL REGISTRO
       nNroReg := 0
       IF nIndice # 0
	  cCodigoTto := aNroOpc[nIndice]
	  IF lLocCodigo('cCodigoTob','TOB',cCodigoTto)
	     nNroReg := TOB->(RECNO())
	  ENDIF
       ENDIF
       RETURN nNroReg
*>>>>FIN LOCALIZACION DEL REGISTRO