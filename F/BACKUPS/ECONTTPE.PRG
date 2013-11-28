/*************************************************************************
* TITULO..: CREACION DE LA ESTRUCTURA                                    *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: JUN 15/2007 VIE A
       Colombia, Bucaramanga        INICIO:  1:58 PM   JUN 15/2007 VIE

OBJETIVOS:

1- Crea la estructura del archivo

2- Retorna NIL

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION CreaDbfTpe(lShared,nModCry,PathArc,fArchvo,aStrDbf)

*>>>>DESCRIPCION DE PARAMETROS
/*     lShared                              // .T. Sistema Compartido
       nModCry                              // Modo de Protecci¢n
       PathArc                              // Path del Archivo
       fArchvo                              // Nombre del Archivo
       aStrDbf                              // Estructura del Archivo */
*>>>>FIN DESCRIPCION DE PARAMETROS

*>>>>DECLARACION DE VARIABLES
       LOCAL       i := 0                   // Contador
       LOCAL PathAct := ''                  // Path Actual

       LOCAL aDbfStr := {}                  // Estructura del Archivo
       LOCAL aRegIni := {}                  // Registro inicial
*>>>>FIN DECLARACION DE VARIABLES

*>>>>DECLARACION DE LA ESTRUCTURA
       AADD(aDbfStr,{'nIdeCodTpe','Numeric'  ,16,0}) // Ide del Registro
      *Llave Principal

       AADD(aDbfStr,{'cCodigoTpe','Character',2,0}) // Tipo de Personal
       AADD(aDbfStr,{'cNombreTpe','Character',40,0}) // Nombre del tipo de persona
       AADD(aDbfStr,{'lCtrIngTpe','Logical',1,0}) // Control de Ingreso

       AADD(aDbfStr,{'nCodigoTpe','Numeric',3,0}) // Posici¢n del C¢digo
       AADD(aDbfStr,{'nLenCodTpe','Numeric',3,0}) // Longitud del C¢digo
       AADD(aDbfStr,{'nCodTipTpe','Numeric',3,0}) // Posici¢n del Tipo de Personal
       AADD(aDbfStr,{'nLenTipTpe','Numeric',3,0}) // Longitud del Tipo de Personal
       AADD(aDbfStr,{'nNitPerTpe','Numeric',3,0}) // Posici¢n de la Cedula de la persona
       AADD(aDbfStr,{'nLenNitSco','Numeric',3,0}) // Longitud de la Cedula de la persona
       AADD(aDbfStr,{'nTipNitTpe','Numeric',3,0}) // Posici¢n Tipo de documento
       AADD(aDbfStr,{'nLenTniTpe','Numeric',3,0}) // Longitud Tipo de documento
       AADD(aDbfStr,{'cTipCodTpe','Character',2,0}) // Tipo de Codigo. Espacios por defecto. 01=>De acuerdo a las p

       AADD(aDbfStr,{'cNomUsrTpe','Character',10,0}) // Nombre del Usuario
       AADD(aDbfStr,{'dFecUsrTpe','Date'     ,08,0}) // Fecha del Usuario
       AADD(aDbfStr,{'cHorUsrTpe','Character',10,0}) // Hora del Usuario
*>>>>FIN CREACION DE LA ESTRUCTURA

*>>>>RETORNO DE LA ESTRUCTURA
       IF !EMPTY(aStrDbf)
	  aStrDbf := aDbfStr
	  RETURN NIL
       ENDIF
*>>>>FIN RETORNO DE LA ESTRUCTURA

*>>>>CREACION DE LA ESTRUCTURA
       PathAct := cPathAct()
       DO CASE
       CASE nCd(PathArc) == 0
            DBCREATE(fArchvo,aDbfStr,'DBFNTX')

       CASE nCd(PathArc) == -3
            cError('NO EXISTE EL DIRECTORIO: '+PathArc)

       CASE nCd(PathArc) == -5
            cError('NO TIENE DERECHOS EN: '+PathArc)
       ENDCASE
       nCd(PathAct)
*>>>>FIN CREACION DE LA ESTRUCTURA

*>>>>SELECCION DE LAS AREAS DE TRABAJO
       IF !lUseDbf(.T.,PathArc+'\'+fArchvo,'ARC',NIL,lShared,nModCry)
	  WAIT 'ABRIENDO EL ARCHIVO DE CONFIGURACION DE CARTERA'
	  CloseDbf('ARC',PathArc+'\'+fArchvo,nModCry)
	  RETURN NIL
       ENDIF
*>>>>FIN SELECCION DE LAS AREAS DE TRABAJO

*>>>>GRABACION DE LOS PARAMETROS POR DEFECTO
       AADD(aRegIni,{'01','ESTUDIANTES'})
       AADD(aRegIni,{'02','PROFESORES'})
       AADD(aRegIni,{'03','ADMINISTRATIVOS'})
       AADD(aRegIni,{'04','SERVICIOS GENERALES'})

       FOR i := 1 TO LEN(aRegIni)

	 IF ARC->(lRegLock(lShared,.T.))

	    REPL ARC->cCodigoTpe WITH aRegIni[i,1]
	    REPL ARC->cNombreTpe WITH aRegIni[i,2]

	    REPL ARC->nIdeCodTpe WITH ARC->(RECNO())
	    REPL ARC->cNomUsrTpe WITH 'system'
	    REPL ARC->dFecUsrTpe WITH DATE()
	    REPL ARC->cHorUsrTpe WITH TIME()
	    ARC->(DBCOMMIT())

	 ELSE
	    WAIT 'NO SE GRABA EL REGISTRO INICIAL DE LA CONFIGURACION'
	 ENDIF

       ENDFOR
       IF lShared
	  ARC->(DBUNLOCK())
       ENDIF
       CloseDbf('ARC',PathArc+'\'+fArchvo,nModCry)
       RETURN NIL
*>>>>FIN GRABACION DE LOS PARAMETROS POR DEFECTO

/*************************************************************************
* TITULO..: SELECCION DEL CODIGO                                         *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: JUN 15/2007 VIE A
       Colombia, Bucaramanga        INICIO:  1:58 PM   JUN 15/2007 VIE

OBJETIVOS:

1- Debe estar en uso el archivo

2- Permite escoger el registro de acuerdo al c¢digo o descripci¢n

3- Retorna el n£mero del registro escogido

SINTAXIS:

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION nSelTpe(nNroFil,nNroCol)

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
       IF TPE->(RECCOUNT()) == 0
          cError('NO EXISTEN REGISTROS GRABADOS')
          RETURN 0
       ENDIF
*>>>>FIN VALIDACION DE CONTENIDOS DE ARCHIVOS

*>>>>INICIALIZACION DE LAS COORDENADAS
       SELECT TPE
       nFilSup := nNroFil+1
       nColSup := nNroCol+2
       IF nFilSup+RECCOUNT() > 22
          nFilInf := 22
       ELSE
          nFilInf := nFilSup + RECCOUNT()
       ENDIF
       nColInf := nColSup+18
*>>>>FIN INICIALIZACION DE LAS COORDENADAS

*>>>>SELECCION DEL CODIGO
       TPE->(DBGOTOP())
       cSavPan := SAVESCREEN(0,0,24,79)
       @ nFilSup-1,nColSup-1 TO nFilInf,nColInf+1 DOUBLE
       nNroReg := nBrowseDbf(nFilSup,nColSup,nFilInf-1,nColInf,;
			     {||TPE->cNombreTpe})
       RESTSCREEN(0,0,24,79,cSavPan)
       RETURN nNroReg
*>>>>FIN SELECCION DEL CODIGO

/*************************************************************************
* TITULO..: LOCALIZAR EL TIPO DE PERSONAL                                *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: JUN 15/2007 VIE A
       Colombia, Bucaramanga        INICIO: 04:00 PM   JUN 15/2007 VIE

OBJETIVOS:

1- Deben estar en uso el archivo tipo de persona

2- Permite localizar el tipo de persona

3- Se debe pasar el Alias del Archivo del Browse

4- Retorna .T. si la Materia es Variable

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION cLocTipPer(cCodigo,cNalias)

*>>>>DESCRIPCION DE PERAMETROS
/*     cCodigo				    // C¢digo de b£squeda
       cNalias				    // Alias diferente al maestro*/
*>>>>FIN DESCRIPCION DE PERAMETROS

*>>>>DECLARACION DE VARIABLES
       LOCAL cNombreTtp := ''                 // Nombre tipo de persona
*>>>>FIN DECLARACION DE VARIABLES

*>>>>LOCALIZACION DEL CODIGO
       IF lLocCodigo('cCodigoTpe','TPE',cCodigo)
	  cNombreTtp := TPE->cNombreTpe
       ELSE
	  cNombreTtp := 'EL TIPO DE PERSONA NO EXISTE'
       ENDIF
       IF cNalias # NIL
	  SELECT &cNalias
       ENDIF
       RETURN cNombreTtp
*>>>>FIN LOCALIZACION DEL CODIGO


