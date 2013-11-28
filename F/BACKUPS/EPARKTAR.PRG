/*************************************************************************
* TITULO..: CREACION DE LA ESTRUCTURA                                    *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: JUL 28/2005 JUE A
       Colombia, Bucaramanga        INICIO: 11:27 AM   JUL 28/2005 JUE

OBJETIVOS:

1- Crea la estructura del archivo

2- Retorna NIL

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION CreaDbfTar(lShared,nModCry,PathArc,fArchvo,aStrDbf)

*>>>>DESCRIPCION DE PARAMETROS
/*     lShared                              // .T. Sistema Compartido
       nModCry                              // Modo de Protecci¢n
       PathArc                              // Path del Archivo
       fArchvo                              // Nombre del Archivo
       aStrDbf                              // Estructura del Archivo */
*>>>>FIN DESCRIPCION DE PARAMETROS

*>>>>DECLARACION DE VARIABLES
       LOCAL PathAct := ''                  // Path Actual

       LOCAL aDbfStr := {}                  // Estructura del Archivo

       LOCAL     j,i := 0                   // Contador
       LOCAL cTipVeh := ''                  // Tipo de Categor¡a
*>>>>FIN DECLARACION DE VARIABLES

*>>>>DECLARACION DE LA ESTRUCTURA
       AADD(aDbfStr,{'nIdeCodTar','Numeric'  ,16,0}) // Ide del Registro
      *Llave Principal

       AADD(aDbfStr,{'nCodigoTar','Numeric',12,2}) // Cantidad a Liquidar
       AADD(aDbfStr,{'cTipVehCat','Character',2,0}) // Tipo de Veh¡culo
       AADD(aDbfStr,{'nVlrFDiTar','Numeric',12,2}) // Valor de la Fracci¢n Diurna
       AADD(aDbfStr,{'nVlrFNoTar','Numeric',12,2}) // Valor de la Fracci¢n Nocturna
       AADD(aDbfStr,{'nVlrSegTar','Numeric',12,2}) // Valor del segundo
       AADD(aDbfStr,{'nVlrMDiTar','Numeric',12,2}) // Valor minuto diurno
       AADD(aDbfStr,{'nVlrMNoTar','Numeric',12,2}) // Valor minuto nocturno
       AADD(aDbfStr,{'nVlrHorTar','Numeric',12,2}) // Valor de la Hora
       AADD(aDbfStr,{'nVlrHDiTar','Numeric',12,2}) // Valor de la Hora Diurna
       AADD(aDbfStr,{'nVlrHNoTar','Numeric',12,2}) // Valor de la Hora Nocturna
       AADD(aDbfStr,{'nVlrDiaTar','Numeric',12,2}) // Valor del D¡a
       AADD(aDbfStr,{'nVlrMesTar','Numeric',12,2}) // Valor del Mes
       AADD(aDbfStr,{'nVlrAnoTar','Numeric',12,2}) // Valor del A¤o

       AADD(aDbfStr,{'cNomUsrTar','Character',10,0}) // Nombre del Usuario
       AADD(aDbfStr,{'dFecUsrTar','Date'     ,08,0}) // Fecha del Usuario
       AADD(aDbfStr,{'cHorUsrTar','Character',10,0}) // Hora del Usuario
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
       FOR i := 1 TO 2

	 cTipVeh := STR(i,2)
	 lCorrecion(@cTipVeh)

	 FOR j := 1 TO 59
	     IF ARC->(lRegLock(lShared,.T.))
		REPL ARC->nCodigoTar WITH j
		REPL ARC->cTipVehCat WITH cTipVeh
		REPL ARC->cNomUsrTar WITH 'system'
		REPL ARC->dFecUsrTar WITH DATE()
		REPL ARC->cHorUsrTar WITH TIME()
		REPL ARC->nIdeCodTar WITH RECNO()
		ARC->(DBCOMMIT())
	     ELSE
		WAIT 'NO SE GRABA EL REGISTRO INICIAL DE LA CONFIGURACION'
	     ENDIF
	 ENDFOR

       ENDFOR
       IF lShared
	  ARC->(DBUNLOCK())
       ENDIF
       CloseDbf('ARC',PathArc+'\'+fArchvo,nModCry)
       RETURN NIL
*>>>>FIN GRABACION DE LOS PARAMETROS POR DEFECTO

/*************************************************************************
* TITULO..: MANTENIMIENTO DEL ARCHIVO                                    *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: JUL 28/2005 JUE A
       Colombia, Bucaramanga        INICIO: 11:27 AM   JUL 28/2005 JUE

OBJETIVOS:

1- Permite el mantenimiento del archivo

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION MantenTar(lShared,nModCry,cNomSis,cCodEmp,cNitEmp,cEmpPal,;
		   cNomEmp,cNomSec,cNomUsr,cAnoUsr,aArchvo,lPrnArc,;
		   cOpcPrn,nCodPrn,lModReg,lDelReg,lInsReg,lHaySql)

*>>>>DESCRIPCION DE PARAMETROS
/*     lShared                              // .T. Sistema Compartido
       nModCry                              // Modo de Protecci¢n
       cNomSis                              // Nombre del Sistema
       cCodEmp                              // C¢digo de la Empresa
       cNitEmp                              // Nit de la Empresa
       cEmpPal                              // Nombre de la Empresa principal
       cNomEmp                              // Nombre de la Empresa
       cNomSec                              // Nombre de la Empresa Secundario
       cNomUsr                              // Nombre del Usuario
       cAnoUsr                              // A¤o del usuario
       aArchvo                              // Archivos en Uso
       lPrnArc                              // .T. Imprimir a Archivo
       cOpcPrn                              // Opciones de Impresi¢n
       nCodPrn                              // C¢digo de Impresi¢n 
       lModReg                              // .T. Modificar el Registro
       lDelReg                              // .T. Borrar Registros
       lInsReg                              // .T. Insertar Registro
       lHaySql                              // .T. Exportar a Sql */
*>>>>FIN DESCRIPCION DE PARAMETROS

*>>>>DECLARACION DE VARIABLES
       #INCLUDE 'inkey.ch'                  // Declaraci¢n de teclas

       LOCAL cSavPan := ''                  // Salvar Pantalla
       LOCAL cAnoSis := SUBS(cAnoUsr,3,2)   // A¤o del sistema
       LOCAL lHayErr := .F.                 // .T. Hay Error

       LOCAL       i := 0                   // Contador
       LOCAL lHayPrn := .F.                 // .T. Hay Archivo de Impresi¢n
       LOCAL aUseDbf := {}                  // Archivos en Uso
       LOCAL fArchvo := ''                  // Nombre del Archivo
       LOCAL fNtxArc := ''                  // Archivo Indice
       LOCAL cNalias := ''                  // Alias del Archivo
       LOCAL oBrowse := NIL                 // Browse
*>>>>FIN DECLARACION DE VARIABLES

*>>>>AREAS DE TRABAJO
       aUseDbf := {}
       FOR i := 1 TO LEN(aArchvo)
           fArchvo := aArchvo[i,1]
           fNtxArc := aArchvo[i,2]
           cNalias := aArchvo[i,3]
           AADD(aUseDbf,{.T.,fArchvo,cNalias,fNtxArc,lShared,nModCry})
           IF cNalias == 'PRN'
              lHayPrn := .T.
           ENDIF
       ENDFOR
*>>>>FIN AREAS DE TRABAJO

*>>>>SELECION DE LAS AREAS DE TRABAJO
       IF !lUseDbfs(aUseDbf)
          cError('ABRIENDO EL ARCHIVO')
          CloseAll()
          RETURN NIL
       ENDIF
*>>>>FIN SELECION DE LAS AREAS DE TRABAJO

*>>>>LOCALIZACION DE LA IMPRESORA
       IF lHayPrn
          IF !lLocCodigo('nCodigoPrn','PRN',nCodPrn)
             cError('NO EXISTE LA IMPRESORA QUE ESTA HABILITADA')
             CloseAll()
             RETURN NIL
          ENDIF
       ENDIF
*>>>>FIN LOCALIZACION DE LA IMPRESORA

*>>>>FILTRACION DEL ARCHIVO
       SELECT TAR
       SET FILTER TO TAR->cTipVehCat == CAT->cTipVehCat
       TAR->(DBGOTOP())
       IF TAR->(EOF())
	  SET FILTER TO
	  CloseAll()
	  RETURN NIL
       ENDIF
       TAR->(DBGOBOTTOM())
*>>>>FILTRACION DEL ARCHIVO

*>>>>PARAMETROS POR DEFECTO
       lModReg := IF(EMPTY(lModReg),.F.,lModReg)
       lModReg := IF(lModReg .AND. TAR->(RECCOUNT())==0,.F.,lModReg)

       lDelReg := IF(lDelReg==NIL,.F.,lDelReg)

       lInsReg := IF(lInsReg==NIL,.F.,lInsReg)

       lHaySql := IF(lHaySql==NIL,.F.,lHaySql)
*>>>>FIN PARAMETROS POR DEFECTO

*>>>>MANTENIMIENTO DEL ARCHIVO
       oBrowse := oBrwDbfTar(lShared,cNomUsr,cAnoUsr,03,00,22,79,;
                             lModReg,lDelReg,lInsReg,lHaySql)

       SETKEY(K_F2,{||lManRegTar(lShared,cNomUsr,3,oBrowse)})
     *ÀConsulta

       IF lModReg
          SETKEY(K_F4,{||lManRegTar(lShared,cNomUsr,2,oBrowse,;
                                    TAR->nCodigoTar)})
       ENDIF
     *ÀActualizar

       SETKEY(K_F5,{||BuscarTar(oBrowse)})

       SETKEY(K_F9,{||MenuOtrTar(lShared,nModCry,cNomSis,cCodEmp,cNitEmp,;
                                 cEmpPal,cNomEmp,cNomSec,cNomUsr,cAnoUsr,;
                                 aArchvo,lPrnArc,cOpcPrn,nCodPrn,lModReg,;
                                 lDelReg,lInsReg,lHaySql,oBrowse)})

       TAR->(CtrlBrw(lShared,oBrowse))

       SETKEY(K_F2,NIL)
       SETKEY(K_F4,NIL)
       SETKEY(K_F5,NIL)
       SETKEY(K_F9,NIL)
       CloseAll()
       RETURN NIL
*>>>>FIN MANTENIMIENTO DEL ARCHIVO

/*************************************************************************
* TITULO..: DEFINICION DEL OBJETO BROWSE                                 *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: JUL 28/2005 JUE A
       Colombia, Bucaramanga        INICIO: 11:27 AM   JUL 28/2005 JUE

OBJETIVOS:

1- Define el objeto Browse del archivo

SINTAXIS:

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION oBrwDbfTar(lShared,cNomUsr,cAnoUsr,nFilSup,nColSup,nFilInf,nColInf,;
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

       cTitSup := '<< TARIFAS. '+ALLTRIM(CAT->cNombreCat)+' >>'
       cTitInf := '<F2>Consultar <F5>Buscar'+;
                   IF(lModReg,' <F4>Actualizar','')+' <F9>Otros'+;
                   IF(lDelReg,' <DEL>Borrar','')+;
                   IF(lInsReg,' <INS>Incluir','')

       IF lInsReg
          oBrowse:Cargo := {cTitSup,cTitInf,{||lManRegTar(lShared,cNomUsr)}}
       ELSE
          oBrowse:Cargo := {cTitSup,cTitInf}
       ENDIF
     *ÀDefinici¢n de cabeceras y l¡neas de cabeceras

       SELECT TAR
       oColumn := TBCOLUMNNEW('No.',{||TAR->nCodigoTar})
       oColumn:Cargo := {{'MODI',.F.},{'ALIAS','TAR'},;
			 {'FIELD','nCodigoTar'},{'PICTURE','999999999.99'}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn := TBCOLUMNNEW('TIPO;VEHICULO',{||TAR->cTipVehCat})
       oColumn:Cargo := {{'MODI',lModReg},{'ALIAS','TAR'},;
			 {'FIELD','cTipVehCat'},{'PICTURE','@!'}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn := TBCOLUMNNEW('FRACCION;DIURNA',{||TAR->nVlrFDiTar})
       oColumn:Cargo := {{'MODI',lModReg},{'ALIAS','TAR'},;
			 {'FIELD','nVlrFDiTar'},{'PICTURE','999999999.99'}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn := TBCOLUMNNEW('FRACCION;NOCTURNA',{||TAR->nVlrFNoTar})
       oColumn:Cargo := {{'MODI',lModReg},{'ALIAS','TAR'},;
			 {'FIELD','nVlrFNoTar'},{'PICTURE','999999999.99'}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

/*

       oColumn := TBCOLUMNNEW('VALOR;SEGUNDO',{||TAR->nVlrSegTar})
       oColumn:Cargo := {{'MODI',lModReg},{'ALIAS','TAR'},;
			 {'FIELD','nVlrSegTar'},{'PICTURE','999999999.99'}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn := TBCOLUMNNEW('VALOR;MINUTO DIURNO',{||TAR->nVlrMDiTar})
       oColumn:Cargo := {{'MODI',lModReg},{'ALIAS','TAR'},;
			 {'FIELD','nVlrMDiTar'},{'PICTURE','999999999.99'}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn := TBCOLUMNNEW('VALOR;MINUTO NOCTURNO',{||TAR->nVlrMNoTar})
       oColumn:Cargo := {{'MODI',lModReg},{'ALIAS','TAR'},;
			 {'FIELD','nVlrMNoTar'},{'PICTURE','999999999.99'}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

*/

       oColumn := TBCOLUMNNEW('VALOR;HORA',{||TAR->nVlrHorTar})
       oColumn:Cargo := {{'MODI',lModReg},{'ALIAS','TAR'},;
			 {'FIELD','nVlrHorTar'},{'PICTURE','999999999.99'}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn := TBCOLUMNNEW('VALOR;HORA DIURNA',{||TAR->nVlrHDiTar})
       oColumn:Cargo := {{'MODI',lModReg},{'ALIAS','TAR'},;
			 {'FIELD','nVlrHDiTar'},{'PICTURE','999999999.99'}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn := TBCOLUMNNEW('VALOR;HORA NOCTURNA',{||TAR->nVlrHNoTar})
       oColumn:Cargo := {{'MODI',lModReg},{'ALIAS','TAR'},;
			 {'FIELD','nVlrHNoTar'},{'PICTURE','999999999.99'}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn := TBCOLUMNNEW('VALOR;DEL DIA',{||TAR->nVlrDiaTar})
       oColumn:Cargo := {{'MODI',lModReg},{'ALIAS','TAR'},;
			 {'FIELD','nVlrDiaTar'},{'PICTURE','999999999.99'}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn := TBCOLUMNNEW('VALOR;DEL MES',{||TAR->nVlrMesTar})
       oColumn:Cargo := {{'MODI',lModReg},{'ALIAS','TAR'},;
			 {'FIELD','nVlrMesTar'},{'PICTURE','999999999.99'}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn := TBCOLUMNNEW('VALOR;DEL A¥O',{||TAR->nVlrAnoTar})
       oColumn:Cargo := {{'MODI',lModReg},{'ALIAS','TAR'},;
			 {'FIELD','nVlrAnoTar'},{'PICTURE','999999999.99'}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn	     := TBCOLUMNNEW('NOMBRE;DEL USUARIO',{||TAR->cNomUsrTar})
       oColumn:Cargo := {{'MODI',.F.}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn	     := TBCOLUMNNEW('FECHA DE;PROCESO',;
				    {||cFecha(TAR->dFecUsrTar)})
       oColumn:Cargo := {{'MODI',.F.}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn	     := TBCOLUMNNEW('HORA DE;PROCESO',;
				    {||cHoraSys(TAR->cHorUsrTar)})
       oColumn:Cargo := {{'MODI',.F.}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn	     := TBCOLUMNNEW('CODIGO',{||TAR->nIdeCodTar})
       oColumn:Cargo := {{'MODI',.F.}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn	     := TBCOLUMNNEW('No.',{||TAR->(RECNO())})
       oColumn:Cargo := {{'MODI',.F.}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       RETURN oBrowse
*>>>>FIN DEFINICION DEL OBJETO BROWSE

/*************************************************************************
* TITULO..: VALIDAR LAS TARIFAS                                          *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: AGO 01/2005 LUN A
       Colombia, Bucaramanga        INICIO: 08:15 PM   AGO 01/2005 LUN

OBJETIVOS:

1- Verifica el valor de las tarifas

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION lTarifasOk()

*>>>>DECLARACION DE VARIABLES
       LOCAL lHayErr := .T.                 // .T. Hay Error
       LOCAL nNroReg := 0                   // N£mero de Registros
*>>>>FIN DECLARACION DE VARIABLES

*>>>>RECORRIDO POR CATEGORIAS
       SELECT CAT
       CAT->(DBGOTOP())
       DO WHILE .NOT. CAT->(EOF())

**********VALIDACION DEL TIPO DE LIQUIDACION
	    IF (!lValorTar() .AND. !lValorCat())
	       cError('LAS TARIFAS DE LA CATEGORIA '+;
		      CAT->cTipVehCat+' ESTAN MAL DEFINIDAS')
	       lHayErr := .T.
	       EXIT
	    ELSE
	       lHayErr := .F.
	    ENDIF
**********FIN VALIDACION DEL TIPO DE LIQUIDACION

**********FILTRACION DEL ARCHIVO
	    IF lValorTar()

	       lHayErr := .T.

	       SELECT TAR
	       SET FILTER TO TAR->cTipVehCat == CAT->cTipVehCat
	       TAR->(DBGOTOP())
	       IF TAR->(EOF())
		  EXIT
	       ENDIF
	    ENDIF
**********FIN FILTRACION DEL ARCHIVO

**********RECORRIDO POR TARIFAS
	    IF lValorTar()

	       nNroReg := 0
	       SELECT TAR
	       TAR->(DBGOTOP())
	       DO WHILE .NOT. TAR->(EOF())

*=================VALIDACION DE LAS TARIFAS
		    nNroReg++
		    lHayErr := .T.
		    DO CASE
		    CASE TAR->nCodigoTar # nNroReg
			 cError('LAS TARIFAS DE LA CATEGORIA '+;
				CAT->cTipVehCat+' '+;
				'NO ESTAN EN ORDEN SECUENCIAL')

		    CASE TAR->nVlrFDiTar == 0 .OR.;
			 TAR->nVlrFNoTar == 0 .OR.;
			 TAR->nVlrHDiTar == 0 .OR.;
			 TAR->nVlrHNoTar == 0 .OR.;
			 TAR->nVlrDiaTar == 0 .OR.;
			 TAR->nVlrMesTar == 0 .OR.;
			 TAR->nVlrAnoTar == 0

			 cError('LAS TARIFAS DE LA CATEGORIA '+;
				CAT->cTipVehCat+' '+;
				'TODAS DEBEN ESTAR DEFINIDAS')
		    OTHERWISE
			lHayErr := .F.
		    ENDCASE
		    IF lHayErr
		       EXIT
		    ENDIF
*=================FIN VALIDACION DE LAS TARIFAS

		  TAR->(DBSKIP())

	       ENDDO
	    ENDIF
**********FIN RECORRIDO POR TARIFAS

**********VALIDACION DEL ERROR
	    IF lHayErr
	       EXIT
	    ENDIF
**********FIN VALIDACION DEL ERROR

	  CAT->(DBSKIP())

       ENDDO
       SELECT TAR
       SET FILTER TO
       TAR->(DBGOTOP())
       SELECT CAT
       CAT->(DBGOTOP())
       RETURN !lHayErr
*>>>>FIN RECORRIDO POR CATEGORIAS

