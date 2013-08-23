/*************************************************************************
* TITULO..: GRABACION DEL INFORME                                        *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: SEP 11/2007 MAR A
       Colombia, Bucaramanga        INICIO: 11:30 AM   SEP 11/2007 MAR

OBJETIVOS:

1- Permite inclusi¢n del informe en archivo informes del sistema

2- Returna .T.

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION nInsInfSys(lShared,cNomUsr,cCodInf,cTitulo,;
		    cObsInf,nOrdInf,nNroInf,cCodSui,lInfVar)

*>>>>DESCRIPCION DE PARAMETROS
/*     lShared                              // .T. Archivos Compartidos
       cNomUsr                              // Nombre del Usuario
       cCodInf                              // C¢digo del Informe
       cTitulo                              // T¡tulo del Informe
       cObsInf                              // Observaci¢n del Informe
       nOrdInf			            // N£mero de Orden del informe
       nNroInf                              // N£mero del informe
       cCodSui                              // C¢digo del Sistema
       lInfVar                              // .T. Informe variable */
*>>>>FIN DESCRIPCION DE PARAMETROS

*>>>>DECLARACION DE VARIABLES
       LOCAL nNroReg := 0                   // N£mero del Registro
       LOCAL GetList := {}                 // Variable del sistema
*>>>>FIN DECLARACION DE VARIABLES

*>>>>LOCALIZACION DEL INFORME
       IF lLocCodigo('cCodigoInf','INF',cCodInf)
	  nNroReg := INF->(RECNO())
	  RETURN nNroReg
       ENDIF
*>>>>FIN LOCALIZACION DEL INFORME

*>>>>GRABACION DEL REGISTRO
       SELECT INF

       IF INF->(lRegLock(lShared,.T.))

	  REPL INF->nIdeCodInf WITH INF->(RECNO())

	  REPL INF->cCodigoInf WITH cCodInf
	  REPL INF->cTituloInf WITH cTitulo
	  REPL INF->cObservInf WITH cObsInf
	  REPL INF->nNroOrdInf WITH nOrdInf
	  REPL INF->nNumeroInf WITH nNroInf
	  REPL INF->cCodSuiInf WITH cCodSui
	  REPL INF->lInfVarInf WITH lInfVar

	  REPL INF->cNomUsrInf WITH cNomUsr
	  REPL INF->dFecUsrInf WITH DATE()
	  REPL INF->cHorUsrInf WITH TIME()

	  INF->(DBCOMMIT())
	  nNroReg := INF->(RECNO())
       ENDIF

       IF lShared
	  INF->(DBUNLOCK())
       ENDIF

       RETURN nNroReg
*>>>>FIN GRABACION DEL REGISTRO