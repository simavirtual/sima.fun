/*************************************************************************
* TITULO..: MANTENIMIENTO DEL ARCHIVO                                    *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: OCT 15/2013 MAR A
       Colombia, Bucaramanga        INICIO:  4:22 PM   OCT 15/2013 MAR

OBJETIVOS:

1- Permite el mantenimiento del archivo

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION MantenMvt(lShared,nModCry,cNomSis,cCodEmp,cNitEmp,cEmpPal,;
		   cNomEmp,cNomSec,cNomUsr,cAnoUsr,aArchvo,lPrnArc,;
		   cOpcPrn,nCodPrn,lModReg,lDelReg,lInsReg,lHaySql,;
		   cPatSis,cMaeAlu,nMesIni)

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
       lHaySql                              // .T. Exportar a Sql
       cPatSis                              // Path del sistema
       cMaeAlu                              // Maestros Habilitados
       nMesIni                              // Mes Inicial */
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

*>>>>PARAMETROS POR DEFECTO
       lModReg := IF(EMPTY(lModReg),.F.,lModReg)
       lModReg := IF(lModReg .AND. MVT->(RECCOUNT())==0,.F.,lModReg)

       lDelReg := IF(lDelReg==NIL,.F.,lDelReg)

       lInsReg := IF(lInsReg==NIL,.F.,lInsReg)

       lHaySql := IF(lHaySql==NIL,.F.,lHaySql)
*>>>>FIN PARAMETROS POR DEFECTO

*>>>>MANTENIMIENTO DEL ARCHIVO
       oBrowse := oBrwDbfMvt(lShared,cNomUsr,cAnoUsr,03,00,22,79,;
                             lModReg,lDelReg,lInsReg,lHaySql)

       SETKEY(K_F2,{||lManRegMvt(lShared,cNomUsr,3,oBrowse)})
     *ÀConsulta

       IF lModReg
          SETKEY(K_F4,{||lManRegMvt(lShared,cNomUsr,2,oBrowse,;
                                    MVT->nNroMesMvt)})
       ENDIF
     *ÀActualizar

       SETKEY(K_F5,{||BuscarMvt(oBrowse)})

       SETKEY(K_F9,{||MenuOtrMvt(lShared,nModCry,cNomSis,cCodEmp,cNitEmp,;
                                 cEmpPal,cNomEmp,cNomSec,cNomUsr,cAnoUsr,;
                                 aArchvo,lPrnArc,cOpcPrn,nCodPrn,lModReg,;
				 lDelReg,lInsReg,lHaySql,oBrowse,cPatSis,;
				 cMaeAlu,nMesIni)})

       MVT->(CtrlBrw(lShared,oBrowse))

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

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: OCT 23/2013 MIE A
       Colombia, Bucaramanga        INICIO:  3:29 PM   OCT 23/2013 MIE

OBJETIVOS:

1- Define el objeto Browse del archivo

SINTAXIS:

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION oBrwDbfMvt(lShared,cNomUsr,cAnoUsr,nFilSup,nColSup,nFilInf,nColInf,;
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

       cTitSup := '<< MOVIMIENTOS >>'
       cTitInf := '<F2>Consultar <F5>Buscar'+;
                   IF(lModReg,' <F4>Actualizar','')+' <F9>Otros'+;
                   IF(lDelReg,' <DEL>Borrar','')+;
                   IF(lInsReg,' <INS>Incluir','')

       IF lInsReg
          oBrowse:Cargo := {cTitSup,cTitInf,{||lManRegMvt(lShared,cNomUsr)}}
       ELSE
          oBrowse:Cargo := {cTitSup,cTitInf}
       ENDIF
     *ÀDefinici¢n de cabeceras y l¡neas de cabeceras

       SELECT MVT
       oColumn := TBCOLUMNNEW('MES',{||MVT->nNroMesMvt})
       oColumn:Cargo := {{'MODI',lModReg},{'ALIAS','MVT'},;
			 {'FIELD','nNroMesMvt'},{'PICTURE','99'}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn := TBCOLUMNNEW('CODIGO;DEL ESTUDIANTE',{||MVT->cCodigoEst})
       oColumn:Cargo := {{'MODI',.F.},{'ALIAS','MVT'},;
			 {'FIELD','cCodigoEst'},{'PICTURE','999999'}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn := TBCOLUMNNEW('CODIGO;DEL GRUPO',{||MVT->cCodigoGru})
       oColumn:Cargo := {{'MODI',.F.},{'ALIAS','MVT'},;
			 {'FIELD','cCodigoGru'},{'PICTURE','9999'}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn := TBCOLUMNNEW('MES;INICIAL',{||MVT->nMesIniPag})
       oColumn:Cargo := {{'MODI',lModReg},{'ALIAS','MVT'},;
			 {'FIELD','nMesIniPag'},{'PICTURE','99'}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn := TBCOLUMNNEW('MES;FINAL',{||MVT->nMesFinPag})
       oColumn:Cargo := {{'MODI',lModReg},{'ALIAS','MVT'},;
			 {'FIELD','nMesFinPag'},{'PICTURE','99'}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn := TBCOLUMNNEW('CONCEPTO',{||MVT->cCodigoCon})
       oColumn:Cargo := {{'MODI',.F.},{'ALIAS','MVT'},;
			 {'FIELD','cCodigoCon'},{'PICTURE','@!'}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn := TBCOLUMNNEW('DESCRIPCION',{||MVT->cDescriMvt})
       oColumn:Cargo := {{'MODI',.F.},{'ALIAS','MVT'},;
			 {'FIELD','cDescriMvt'},{'PICTURE','@!'}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn := TBCOLUMNNEW('CREDITOS',{||MVT->nCreditMvt})
       oColumn:Cargo := {{'MODI',lModReg},{'ALIAS','MVT'},;
			 {'FIELD','nCreditMvt'},{'PICTURE','9999999999.99'}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn := TBCOLUMNNEW('DEBITOS',{||MVT->nDebitoMvt})
       oColumn:Cargo := {{'MODI',lModReg},{'ALIAS','MVT'},;
			 {'FIELD','nDebitoMvt'},{'PICTURE','9999999999.99'}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn := TBCOLUMNNEW('CAUSACION',{||MVT->nTotCauPag})
       oColumn:Cargo := {{'MODI',lModReg},{'ALIAS','MVT'},;
			 {'FIELD','nTotCauPag'},{'PICTURE','9999999999.99'}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn := TBCOLUMNNEW('SDOANT',{||MVT->nSdoAntPag})
       oColumn:Cargo := {{'MODI',lModReg},{'ALIAS','MVT'},;
			 {'FIELD','nSdoAntPag'},{'PICTURE','9999999999.99'}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn := TBCOLUMNNEW('MORANT',{||MVT->nMorAntPag})
       oColumn:Cargo := {{'MODI',lModReg},{'ALIAS','MVT'},;
			 {'FIELD','nMorAntPag'},{'PICTURE','9999999999.99'}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn := TBCOLUMNNEW('VLRMES',{||MVT->nVlrMesPag})
       oColumn:Cargo := {{'MODI',lModReg},{'ALIAS','MVT'},;
			 {'FIELD','nVlrMesPag'},{'PICTURE','9999999999.99'}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn := TBCOLUMNNEW('VLRPAG',{||MVT->nVlrPagPag})
       oColumn:Cargo := {{'MODI',lModReg},{'ALIAS','MVT'},;
			 {'FIELD','nVlrPagPag'},{'PICTURE','9999999999.99'}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn := TBCOLUMNNEW('VLRTRA',{||MVT->nValorTra })
       oColumn:Cargo := {{'MODI',lModReg},{'ALIAS','MVT'},;
			 {'FIELD','nValorTra '},{'PICTURE','9999999999.99'}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn := TBCOLUMNNEW('VLRDIF',{||MVT->nVlrDifMvt})
       oColumn:Cargo := {{'MODI',lModReg},{'ALIAS','MVT'},;
			 {'FIELD','nVlrDifMvt'},{'PICTURE','9999999999.99'}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn := TBCOLUMNNEW('INTMES',{||MVT->nIntMesPag})
       oColumn:Cargo := {{'MODI',lModReg},{'ALIAS','MVT'},;
			 {'FIELD','nIntMesPag'},{'PICTURE','9999999999.99'}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn := TBCOLUMNNEW('ESTADO',{||MVT->cEstadoPag})
       oColumn:Cargo := {{'MODI',.F.},{'ALIAS','MVT'},;
			 {'FIELD','cEstadoPag'},{'PICTURE','@!'}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn := TBCOLUMNNEW('FECHA;PAGO',{||MVT->dFecPagPag})
       oColumn:Cargo := {{'MODI',lModReg},{'ALIAS','MVT'},;
			 {'FIELD','dFecPagPag'},{'PICTURE','@!D'}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn := TBCOLUMNNEW('FECHA;TRANSACION',{||MVT->dFechaTra })
       oColumn:Cargo := {{'MODI',lModReg},{'ALIAS','MVT'},;
			 {'FIELD','dFechaTra '},{'PICTURE','@!D'}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn := TBCOLUMNNEW('BANCO',{||MVT->cCodigoBan})
       oColumn:Cargo := {{'MODI',.F.},{'ALIAS','MVT'},;
			 {'FIELD','cCodigoBan'},{'PICTURE','@!'}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn := TBCOLUMNNEW('REFERENCIA',{||MVT->cCodRefTra})
       oColumn:Cargo := {{'MODI',.F.},{'ALIAS','MVT'},;
			 {'FIELD','cCodRefTra'},{'PICTURE','@!'}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn := TBCOLUMNNEW('CODIGO;DEL ESTUDIANTE',{||MVT->cCodEstTra})
       oColumn:Cargo := {{'MODI',.F.},{'ALIAS','MVT'},;
			 {'FIELD','cCodEstTra'},{'PICTURE','999999'}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn := TBCOLUMNNEW('VLRTRA',{||MVT->nValorTra })
       oColumn:Cargo := {{'MODI',lModReg},{'ALIAS','MVT'},;
			 {'FIELD','nValorTra '},{'PICTURE','9999999999.99'}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn := TBCOLUMNNEW('FECHA;TRANSACION',{||MVT->dFechaTra })
       oColumn:Cargo := {{'MODI',lModReg},{'ALIAS','MVT'},;
			 {'FIELD','dFechaTra '},{'PICTURE','@!D'}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn := TBCOLUMNNEW('VLRDIF',{||MVT->nVlrDifMvt})
       oColumn:Cargo := {{'MODI',lModReg},{'ALIAS','MVT'},;
			 {'FIELD','nVlrDifMvt'},{'PICTURE','9999999999.99'}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn := TBCOLUMNNEW('CONCEPTO',{||MVT->nCodigoCmv})
       oColumn:Cargo := {{'MODI',lModReg},{'ALIAS','MVT'},;
			 {'FIELD','nCodigoCmv'},{'PICTURE','9999'}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn := TBCOLUMNNEW('OBSERVACION',{||MVT->cObservMvt})
       oColumn:Cargo := {{'MODI',.F.},{'ALIAS','MVT'},;
			 {'FIELD','cObservMvt'},{'PICTURE','@!'}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn	     := TBCOLUMNNEW('NOMBRE;DEL USUARIO',{||MVT->cNomUsrMvt})
       oColumn:Cargo := {{'MODI',.F.}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn	     := TBCOLUMNNEW('FECHA DE;PROCESO',;
				    {||cFecha(MVT->dFecUsrMvt)})
       oColumn:Cargo := {{'MODI',.F.}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn	     := TBCOLUMNNEW('HORA DE;PROCESO',;
				    {||cHoraSys(MVT->cHorUsrMvt)})
       oColumn:Cargo := {{'MODI',.F.}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn	     := TBCOLUMNNEW('CODIGO',{||MVT->nIdeCodMvt})
       oColumn:Cargo := {{'MODI',.F.}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn	     := TBCOLUMNNEW('No.',{||MVT->(RECNO())})
       oColumn:Cargo := {{'MODI',.F.}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       RETURN oBrowse
*>>>>FIN DEFINICION DEL OBJETO BROWSE


/*************************************************************************
* TITULO..: BUSQUEDA DEL CODIGO                                          *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: OCT 31/2013 JUE A
       Colombia, Bucaramanga        INICIO:  9:58 AM   OCT 31/2013 JUE

OBJETIVOS:

1- Permite localizar un c¢digo dentro del archivo.

2- Retorna NIL

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION BuscarMvt(oBrowse)

*>>>>DESCRIPCION DE PARAMETROS
/*     oBrowse                              // Browse del Archivo */
*>>>>FIN DESCRIPCION DE PARAMETROS

*>>>>DECLARACION DE VARIABLES
       LOCAL nNroFil := 0                   // Fila de lectura
       LOCAL nNroCol := 0                   // Columna de lectura
       LOCAL nNroReg := 0                   // N£mero del Registro
       LOCAL lBuscar := .T.                 // .T. Realizar la b£squeda
       LOCAL GetList := {}                  // Variable del sistema

       LOCAL cCodigo := ''                  // C¢digo de b£squeda
*>>>>FIN DECLARACION DE VARIABLES

*>>>>CAPTURA DEL CODIGO
       SET CURSOR ON
       cCodigo := cSpaces('MVT','cCodigoEst')
       TitBuscar(LEN(cCodigo),@nNroFil,@nNroCol)
       @ nNroFil,nNroCol GET cCodigo PICT '@!';
			 VALID lValMvt(ROW(),COL()-3,@cCodigo)
       READ
*>>>>FIN CAPTURA DEL CODIGO

*>>>>VALIDACION DEL CODIGO
       IF cCodigo == cSpaces('MVT','cCodigoEst')
	  cError('PATRON DE BUSQUEDA NO ESPECIFICADO',;
		 'ADVERTENCIA')
	  lBuscar := .F.
       ENDIF
*>>>>FIN VALIDACION DEL CODIGO

*>>>>BUSQUEDA DEL CODIGO
       SELECT MVT
       IF lBuscar .AND. lLocCodigo('cCodigoEst','MVT',cCodigo)
	  nNroReg := MVT->(RECNO())
	  MVT->(DBGOTOP())
	  oBrowse:GOTOP()
	  MVT->(DBGOTO(nNroReg))
	  oBrowse:FORCESTABLE()
       ELSE
          oBrowse:GOTOP()
       ENDIF
       RETURN NIL
*>>>>FIN BUSQUEDA DEL CODIGO

/*************************************************************************
* TITULO..: VALIDACION DEL CODIGO                                        *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: OCT 31/2013 JUE A
       Colombia, Bucaramanga        INICIO:  9:58 AM   OCT 31/2013 JUE

OBJETIVOS:

1- Debe estar en uso el archivo

2- Realiza la validaci¢n del c¢digo

3- Retorna .T. si hay problemas

SINTAXIS:

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION lValMvt(nNroFil,nNroCol,cCodigo)

*>>>>DESCRIPCION DE PARAMETROS
/*     nNroFil                              // Fila de lectura
       nNroCol                              // Columna de lectura
       cCodigo                              // C¢digo a Validar */
*>>>>FIN DESCRIPCION DE PARAMETROS

*>>>>DECLARACION DE VARIABLES
       LOCAL nNroReg := 0                   // N£mero del Registro
*>>>>FIN DECLARACION DE VARIABLES

*>>>>VALIDACION DEL CODIGO
       IF !lLocCodigo('cCodigoEst','MVT',cCodigo)
	  nNroReg := nSelMvt(nNroFil,nNroCol)
	  IF nNroReg == 0
	     cCodigo := cSpaces('MVT','cCodigoEst')
	  ELSE
	     MVT->(DBGOTO(nNroReg))
	     cCodigo := MVT->cCodigoEst
          ENDIF
       ENDIF
       RETURN .T.
*>>>>FIN VALIDACION DEL CODIGO

/*************************************************************************
* TITULO..: SELECCION DEL CODIGO                                         *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: OCT 31/2013 JUE A
       Colombia, Bucaramanga        INICIO:  9:58 AM   OCT 31/2013 JUE

OBJETIVOS:

1- Debe estar en uso el archivo

2- Permite escoger el registro de acuerdo al c¢digo o descripci¢n

3- Retorna el n£mero del registro escogido

SINTAXIS:

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION nSelMvt(nNroFil,nNroCol)

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
       IF MVT->(RECCOUNT()) == 0
          cError('NO EXISTEN REGISTROS GRABADOS')
          RETURN 0
       ENDIF
*>>>>FIN VALIDACION DE CONTENIDOS DE ARCHIVOS

*>>>>INICIALIZACION DE LAS COORDENADAS
       SELECT MVT
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
       MVT->(DBGOTOP())
       cSavPan := SAVESCREEN(0,0,24,79)
       @ nFilSup-1,nColSup-1 TO nFilInf,nColInf+1 DOUBLE
       nNroReg := nBrowseDbf(nFilSup,nColSup,nFilInf-1,nColInf,;
			     {||MVT->cCodigoEst})
       RESTSCREEN(0,0,24,79,cSavPan)
       RETURN nNroReg
*>>>>FIN SELECCION DEL CODIGO


/*************************************************************************
* TITULO..: MENU DE OTROS PARA EL ARCHIVO                                *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: OCT 15/2013 MAR A
       Colombia, Bucaramanga        INICIO:  4:22 PM   OCT 15/2013 MAR

OBJETIVOS:

1- Menu de Otros para el archivo

2- Retorna NIL

SINTAXIS:

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION MenuOtrMvt(lShared,nModCry,cNomSis,cCodEmp,cNitEmp,cEmpPal,;
                    cNomEmp,cNomSec,cNomUsr,cAnoUsr,aArchvo,lPrnArc,;
                    cOpcPrn,nCodPrn,lModReg,lDelReg,lInsReg,lHaySql,;
		    oBrowse,cPatSis,cMaeAlu,nMesIni)

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
       aArchvo                              // Archivo en Uso
       lPrnArc                              // .T. Imprimir a Archivo
       cOpcPrn                              // Opciones de Impresi¢n
       nCodPrn                              // C¢digo de Impresi¢n
       lModReg                              // .T. Modificar el Registro
       lDelReg                              // .T. Borrar Registros
       lInsReg                              // .T. Insertar Registro
       lHaySql                              // .T. Exportar a Sql
       oBrowse                              // Browse del Archivo
       cPatSis                              // Path del sistema
       cMaeAlu                              // Maestros Habilitados
       nMesIni                              // Mes Inicial */
*>>>>FIN DESCRIPCION DE PARAMETROS

*>>>>DECLARACION DE VARIABLES
       LOCAL cSavPan := ''                  // Salvar Pantalla
       LOCAL cAnoSis := SUBS(cAnoUsr,3,2)   // A¤o del sistema
       LOCAL lHayErr := .F.                 // .T. Hay Error

       LOCAL aMenus  := {}                  // Vector de declaracion de men£
       LOCAL aAyuda  := {}                  // Vector de ayudas para el men£
       LOCAL nNroOpc := 1                   // Numero de la opcion

       LOCAL GetList := {}                  // Variable del Sistema
*>>>>FIN DECLARACION DE VARIABLES

*>>>>DECLARCION Y EJECUCION DEL MENU
       aMenus := {}
       AADD(aMenus,'1<MOVIMIENTOS>')
       AADD(aMenus,'2<IMPRIMIR   >')

       aAyuda := {}
       AADD(aAyuda,'Generar los Movimientos')
       AADD(aAyuda,'Imprime los Detalles de los Movimientos')

       cSavPan := SAVESCREEN(0,0,24,79)
       nNroOpc := nMenu(aMenus,aAyuda,10,25,'MENU OTROS',NIL,1,.F.)
       RESTSCREEN(0,0,24,79,cSavPan)
       IF nNroOpc == 0
          RETURN NIL
       ENDIF
*>>>>FIN DECLARCION Y EJECUCION DEL MENU

*>>>>ANALISIS DE OPCION ESCOGIDA
       DO CASE
       CASE nNroOpc == 1
	    OtrMvt012(lShared,nModCry,cNomSis,cCodEmp,cNitEmp,cEmpPal,;
		      cNomEmp,cNomSec,cNomUsr,cAnoUsr,aArchvo,lPrnArc,;
		      cOpcPrn,nCodPrn,lModReg,lDelReg,lInsReg,lHaySql,;
		      oBrowse,cPatSis,cMaeAlu,nMesIni)
	   *Movimientos Contables

       CASE nNroOpc == 2
	    OtrMvt011(lShared,nModCry,cNomSis,cCodEmp,cNitEmp,cEmpPal,;
		      cNomEmp,cNomSec,cNomUsr,cAnoUsr,aArchvo,lPrnArc,;
		      cOpcPrn,nCodPrn,lModReg,lDelReg,lInsReg,lHaySql,;
		      oBrowse)
	   *Impresi¢n de los campos del Archivo

       ENDCASE
       RETURN NIL
*>>>>FIN ANALISIS DE OPCION ESCOGIDA

/*************************************************************************
* TITULO..: IMPRESION CAMPOS DEL MANTENIMIENTO                           *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: OCT 28/2013 LUN A
       Colombia, Bucaramanga        INICIO:  2:37 PM   OCT 28/2013 LUN

OBJETIVOS:

1- Imprime los campos del archivo de mantenimiento

2- Retorna NIL

SINTAXIS:

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION OtrMvt011(lShared,nModCry,cNomSis,cCodEmp,cNitEmp,cEmpPal,;
              cNomEmp,cNomSec,cNomUsr,cAnoUsr,aArchvo,lPrnArc,;
              cOpcPrn,nCodPrn,lModReg,lDelReg,lInsReg,lHaySql,;
              oBrowse)

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
       lHaySql                              // .T. Exportar a Sql
       oBrowse                              // Browse del Archivo */
*>>>>FIN DESCRIPCION DE PARAMETROS

*>>>>DECLARACION DE VARIABLES
       #INCLUDE "ARC-FACT.PRG"              // Archivos del Sistema

       LOCAL cSavPan := ''                  // Salvar Pantalla
     *ÀVariables generales

       LOCAL nRegPrn := 0                   // Registro de Impresi¢n
       LOCAL cFecPrn := ''                  // @Fecha de Impresi¢n
       LOCAL cHorPrn := ''                  // @Hora de Impresi¢n
       LOCAL cDiaPrn := ''                  // @D¡a de Impresi¢n
       LOCAL nNroPag := 1                   // N£mero de p gina
       LOCAL lTamAnc := .F.                 // .T. Tama¤o Ancho
       LOCAL nLinTot := 0                   // L¡neas totales de control
       LOCAL nTotReg := 0                   // Total de registros
       LOCAL aCabPrn := {}                  // Encabezado del informe General
       LOCAL aCabeza := {}                  // Encabezado del informe
       LOCAL cCodIni := ''                  // C¢digos de impresi¢n iniciales
       LOCAL cCodFin := ''                  // C¢digos de impresi¢n finales
       LOCAL aNroCol := {}                  // Columnas de impresi¢n
       LOCAL aTitPrn := {}                  // T¡tulos para impresi¢n
       LOCAL aRegPrn := {}                  // Registros para impresi¢n
       LOCAL cCabCol := ''                  // Encabezado de Columna
       LOCAL aCabSec := {}                  // Encabezado Secundario
       LOCAL nLenPrn := 0                   // Longitud l¡nea de impresi¢n
       LOCAL lCentra := .F.                 // .T. Centrar el informe
       LOCAL nColCab := 0                   // Columna del encabezado
       LOCAL bPagina := NIL                 // Block de P gina
       LOCAL bCabeza := NIL                 // Block de Encabezado
       LOCAL bDerAut := NIL                 // Block Derechos de Autor
       LOCAL nLinReg := 1                   // L¡neas del registro
       LOCAL cTxtPrn := ''                  // Texto de impresi¢n
       LOCAL nOpcPrn := 0                   // Opci¢n de Impresi¢n
     *ÀVariables de informe

       LOCAL nAvance := 0                   // Avance de registros
       LOCAL Getlist := {}                  // Variable del sistema
     *ÀVariables espec¡ficas
*>>>>FIN DECLARACION DE VARIABLES

*>>>>ACTIVACION DE LA IMPRESORA
       nRegPrn := PRN->(RECNO())
       nLenPrn := PCL('n17Stan')

       IF lPrnArc
	  SET DEVICE TO PRINT
       ELSE
	  FilePrn := 'InMvt'+cMes(MVT->nNroMesMvt,3)
	  nOpcPrn := nPrinter_On(cNomUsr,@FilePrn,cOpcPrn,.F.,.T.,NIL,PathDoc)
	  IF EMPTY(nOpcPrn)
             RETURN NIL
          ENDIF
       ENDIF
*>>>>FIN ACTIVACION DE LA IMPRESORA

*>>>>DEFINICION DEL ENCABEZADO
       nNroPag := 0
       lTamAnc := .F.

       nTotReg := 0

       aCabPrn := {cNomEmp,cNomSis,;
                   'MOVIMIENTOS',;
                   '',;
                   ''}

       aCabeza := {aCabPrn[1],aCabPrn[2],aCabPrn[3],aCabPrn[4],aCabPrn[5],;
                   nNroPag++,;
                   cTotPagina(nTotReg),lTamAnc}

       cCodIni := PCL({'DraftOn','Elite','CondenOn'})
       cCodFin := PCL({'NegraOf','DobGolOf'})
*>>>>FIN DEFINICION DEL ENCABEZADO

*>>>>ENCABEZADOS DE COLUMNA
       aNroCol := {}
       aTitPrn := {}

       AADD(aNroCol,4)
       AADD(aTitPrn,'MES')

       AADD(aNroCol,6)
       AADD(aTitPrn,'CODIGO')

       AADD(aNroCol,6)
       AADD(aTitPrn,'GRUPO')

       AADD(aNroCol,6)
       AADD(aTitPrn,'MESINI')

       AADD(aNroCol,6)
       AADD(aTitPrn,'MESFIN')

       AADD(aNroCol,40)
       AADD(aTitPrn,'CODIGO')

/*
       AADD(aNroCol,10)
       AADD(aTitPrn,'DEBITOS')

       AADD(aNroCol,10)
       AADD(aTitPrn,'CREDITOS')

       AADD(aNroCol,10)
       AADD(aTitPrn,'CAUSACION')

       AADD(aNroCol,10)
       AADD(aTitPrn,'SDOANT')

       AADD(aNroCol,10)
       AADD(aTitPrn,'MORANT')

       AADD(aNroCol,10)
       AADD(aTitPrn,'MORANT')

*/

       AADD(aNroCol,10)
       AADD(aTitPrn,'VLRPAG')

       AADD(aNroCol,10)
       AADD(aTitPrn,'INTMES')

       AADD(aNroCol,6)
       AADD(aTitPrn,'ESTADO')

       AADD(aNroCol,12)
       AADD(aTitPrn,'F.PAGO')

       AADD(aNroCol,6)
       AADD(aTitPrn,'BANCO')

       AADD(aNroCol,12)
       AADD(aTitPrn,'REFERENCIA')

       AADD(aNroCol,6)
       AADD(aTitPrn,'CODTRA')

       AADD(aNroCol,10)
       AADD(aTitPrn,'VLRTRA')

       AADD(aNroCol,12)
       AADD(aTitPrn,'F.TRAN')

       AADD(aNroCol,10)
       AADD(aTitPrn,'VLRDIF')

       AADD(aNroCol,8)
       AADD(aTitPrn,'CONCEPTO')

       AADD(aNroCol,40)
       AADD(aTitPrn,'CODIGO')

       cCabCol := cRegPrint(aTitPrn,aNroCol)
*>>>>FIN ENCABEZADOS DE COLUMNA

*>>>>ANALISIS PARA CENTRAR EL INFORME
       lCentra := .F.
       nColCab := 0
       IF lCentra
          nColCab := (nLenPrn-LEN(cCabCol))/2
       ENDIF
       aCabSec := NIL
       bPagina := {||lPagina(nLinReg)}
       bCabeza := {||CabezaPrn(cCodIni,aCabeza,cCabCol,;
                               nColCab,cCodFin,aCabSec,;
                               @cFecPrn,@cHorPrn,@cDiaPrn)}
       bDerAut := {||DerechosPrn(cNomSis,cNomEmp,nLenPrn)}
*>>>>FIN ANALISIS PARA CENTRAR EL INFORME

*>>>>IMPRESION DEL ENCABEZADO
       SendCodes(PCL('Reset'))

       EVAL(bCabeza)
      *Impresi¢n del Encabezado

       AADD(aCabPrn,cFecPrn)
       AADD(aCabPrn,cHorPrn)
       AADD(aCabPrn,cDiaPrn)

       nHanXml := CreaFrmPrn(lShared,FilePrn,aNroCol,nOpcPrn,aCabPrn,aTitPrn)
*>>>>FIN IMPRESION DEL ENCABEZADO

*>>>>RECORRIDO DE LOS REGISTROS
       cSavPan := SAVESCREEN(0,0,24,79)
       SET DEVICE TO SCREEN
       Termometro(0,'IMPRIMIENDO')
       SET DEVICE TO PRINT

       SELECT MVT
       MVT->(DBGOTOP())
       DO WHILE .NOT. MVT->(EOF())

**********VISUALIZACION DE AVANCE
            nAvance := INT(( MVT->(RECNO()) / MVT->(RECCOUNT()) )*100)

            IF STR(nAvance,3) $ '25 50 75100'
               SET DEVICE TO SCREEN
               Termometro(nAvance)
               SET DEVICE TO PRINT
            ENDIF
**********FIN VISUALIZACION DE AVANCE

**********ANALISIS DE DECISION
	    IF EMPTY(MVT->dFecPagPag)
	       MVT->(DBSKIP())
	       LOOP
	    ENDIF

	    IF !EMPTY(MVT->cCodRefTra) .AND.;
	       MVT->nVlrDifMvt == 0

	       MVT->(DBSKIP())
	       LOOP

	    ENDIF
**********FIN ANALISIS DE DECISION

**********IMPRESION DEL REGISTRO
            aRegPrn := {}
            AADD(aRegPrn,STR(MVT->nNroMesMvt,2,0))
            AADD(aRegPrn,MVT->cCodigoEst)
            AADD(aRegPrn,MVT->cCodigoGru)
            AADD(aRegPrn,STR(MVT->nMesIniPag,2,0))
            AADD(aRegPrn,STR(MVT->nMesFinPag,2,0))
	    AADD(aRegPrn,MVT->cDescriMvt)
/*
	    AADD(aRegPrn,STR(MVT->nDebitoMvt,10,2))
	    AADD(aRegPrn,STR(MVT->nCreditMvt,10,2))
	    AADD(aRegPrn,STR(MVT->nTotCauPag,10,2))
	    AADD(aRegPrn,STR(MVT->nSdoAntPag,10,2))
	    AADD(aRegPrn,STR(MVT->nMorAntPag,10,2))
	    AADD(aRegPrn,STR(MVT->nVlrMesPag,10,2))
*/
	    AADD(aRegPrn,STR(MVT->nVlrPagPag,10,2))
	    AADD(aRegPrn,STR(MVT->nIntMesPag,10,2))
	    AADD(aRegPrn,MVT->cEstadoPag)
	    AADD(aRegPrn,cFecha(MVT->dFecPagPag))
	    AADD(aRegPrn,MVT->cCodigoBan)
            AADD(aRegPrn,MVT->cCodRefTra)
            AADD(aRegPrn,MVT->cCodEstTra)
            AADD(aRegPrn,STR(MVT->nValorTra,10,2))
            AADD(aRegPrn,cFecha(MVT->dFechaTra))
            AADD(aRegPrn,STR(MVT->nVlrDifMvt,10,2))
            AADD(aRegPrn,STR(MVT->nCodigoCmv,4,0))
            AADD(aRegPrn,MVT->cObservMvt)

            lPrnOpc(lShared,nOpcPrn,FilePrn,nHanXml,01,nColCab,;
                    aTitPrn,aRegPrn,aNroCol,bPagina,bDerAut,bCabeza)
**********FIN IMPRESION DEL REGISTRO

**********AVANCE DEL SIGUIENTE REGISTRO
	    SELECT MVT
	    MVT->(DBSKIP())
	    IF MVT->(EOF())
	       SET DEVICE TO SCREEN
	       Termometro(100)
	       SET DEVICE TO PRINT
	    ENDIF
**********FIN AVANCE DEL SIGUIENTE REGISTRO

       ENDDO
       RESTSCREEN(0,0,24,79,cSavPan)
*>>>>FIN RECORRIDO DE LOS REGISTROS

*>>>>IMPRESION DERECHOS
       EVAL(bDerAut)
      *Derechos de Autor

       VerPrn(nOpcPrn,FilePrn,nHanXml)
       PRN->(DBGOTO(nRegPrn))

       SET DEVICE TO SCREEN
       RETURN NIL
*>>>>FIN IMPRESION DERECHOS


/*************************************************************************
* TITULO..: GENERACION DE LOS MOVIMIENTOS                                *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: OCT 16/2013 MIE A
       Colombia, Bucaramanga        INICIO:  8:00 AM   OCT 16/2013 MIE

OBJETIVOS:

1- Genera los movimientos contables de un mes

2- Retorna NIL

SINTAXIS:

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION OtrMvt012(lShared,nModCry,cNomSis,cCodEmp,cNitEmp,cEmpPal,;
		   cNomEmp,cNomSec,cNomUsr,cAnoUsr,aArchvo,lPrnArc,;
		   cOpcPrn,nCodPrn,lModReg,lDelReg,lInsReg,lHaySql,;
		   oBrowse,cPatSis,cMaeAlu,nMesIni)

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
       lHaySql                              // .T. Exportar a Sql
       oBrowse                              // Browse del Archivo
       cPatSis                              // Path del sistema
       cMaeAlu                              // Maestros Habilitados
       nMesIni                              // Mes Inicial  */
*>>>>FIN DESCRIPCION DE PARAMETROS

*>>>>DECLARACION DE VARIABLES
       #INCLUDE "FILES.PRG"                 // Archivos Compartidos

       #DEFINE nDEUANT 1                    // Deuda Anterior
       #DEFINE nMORANT 2                    // Mora Anterior
       #DEFINE nVLRMES 3                    // Valor del Mes

       LOCAL cSavPan := ''                  // Salvar Pantalla
       LOCAL lHayErr := .F.                 // .T. Hay Error
       LOCAL cAnoSis := SUBS(cAnoUsr,3,2)   // A¤o del sistema

       LOCAL     i,k := 1                   // Contador
       LOCAL lPrnFec := .F.                 // .T. Imprimir por Fechas
       LOCAL dFecPrn := CTOD('00/00/00')    // Fecha de Corte de Impresi¢n
       LOCAL lFPagOk := .T.                 // Fecha de Pago de Acuerdo al Corte
       LOCAL lFinMes := .F.                 // .T. Hay pagos de fin de Mes
       LOCAL lMesAct := .T.                 // .T. Mes Actual.
       LOCAL nNroPos := 0                   // N£mero de la posici¢n

       LOCAL cGruFin := ''                  // Grupo Final
       LOCAL lHayAlu := .F.                 // .T. Hay Alumno
       LOCAL cNalias := ''                  // Alias del Maestro
       LOCAL lHayPag := .F.                 // .T. Hay pago
       LOCAL nMesRet := 0                   // Mes del ultimo recibo

       LOCAL nVlrDes := 0                   // Valor del Descuento
       LOCAL nVlrRec := 0                   // Valor del Recargo
       LOCAL nVlrBec := 0                   // Valor de la Beca

       LOCAL nVlrInt := 0                   // Valor de los intereses
       LOCAL nIntNoP := 0                   // Valor de los intereses no pago
       LOCAL aRegEst := {}                  // Valor del Estudiante
       LOCAL aDeuAnt := {}                  // Codigos deuda Anterior

       LOCAL aTotCon := {}                  // Total Conceptos
       LOCAL nTotAnc := 0                   // Total Anticipos
       LOCAL nTotRec := 0                   // Total Recargos
       LOCAL nTotAyu := 0                   // Total Becas o Ayudas
       LOCAL nTotDes := 0                   // Total Descuentos
       LOCAL nTotInt := 0                   // Total Intereses
       LOCAL nTotNoP := 0                   // Total Intereses no pago

       LOCAL nDeuInt := 0                   // Deuda Anterior para calcular los intereses por cobrar
       LOCAL nAboDes := 0                   // Abonos Descuentos
       LOCAL nAboEst := 0                   // Abonos del Estudiante
       LOCAL nAboOtr := 0                   // Abonos otros Meses

       LOCAL nAboMes := 0                   // Abonos del Mes
       LOCAL nDesMes := 0                   // Total de Abonos como Descuentos

       LOCAL nAboFin := 0                   // Total Abonos de fin de mes
       LOCAL nOtrFin := 0                   // Total Abonos otros meses de fin de mes
       LOCAL nDesFin := 0                   // Total Abonos Descuentos de fin de mes

       LOCAL nIntPag := 0                   // Intereses pagados
       LOCAL nTotPag := 0                   // Total Pagos
       LOCAL nFinMes := 0                   // Total de pagos de fin de mes

       LOCAL nFacMes := 0                   // Facturaci¢n del Mes
       LOCAL aFacMes[16]                    // Facturaci¢n del Mes. 8 Conceptos
       LOCAL nVlrTar := ''                  // Valor de las tarifas

       LOCAL aAntEst[16]		    // Valor de los Anticipos del Mes
       LOCAL aAntici[16]                    // Anticipos. 8 Conceptos
       LOCAL nNroAde := 0                   // N£mero de anticipos
       LOCAL nFinAde := 0                   // N£mero de anticipos fin de a¤o
       LOCAL nAntici := 0                   // Valor de los Anticipos

       LOCAL nVlrSdo := 0                   // Valor del saldo
       LOCAL nVlrDeu := 0                   // Valor de la deuda
       LOCAL nPorCob := 0                   // Intereses por Cobrar
       LOCAL nIntCob := 0                   // Intereses por Cobrar

       LOCAL nDeuAnt := 0                   // Deuda Anterior
       LOCAL nMorAnt := 0                   // Mora Anterior
       LOCAL nSdoMor := 0                   // Saldo de la Mora
       LOCAL nDeuRet := 0                   // Deuda Anterior del Retirado
       LOCAL nMorRet := 0                   // Mora Anterior del Retirado
       LOCAL nPagPar := 0                   // Pago Parcial

       LOCAL nRegPag := 0                   // Registro de pagos
       LOCAL cDescri := ''                  // Descripci¢n del Movimiento
       LOCAL cCodCon := ''                  // C¢digo del Concepto
       LOCAL nVlrCau := 0                   // Valor de la Causaci¢n
       LOCAL nTotCau := 0                   // Total de Causaci¢n.
       LOCAL nVlrPag := 0                   // Valor Pagado
       LOCAL cMesPag := ''                  // Mes del pago
       LOCAL cAnoPag := ''                  // A¤o del Pago

       LOCAL aVlrPag := {}                  // Total Pagos

       LOCAL FileAnt := 'X'                 // Archivo Anterior
       LOCAL cPatExt := ''                  // Path del Extracto
       LOCAL lHayExt := .F.                 // .T. Hay Extracto

       LOCAL cMesIni := ''                  // Mes Inicial
       LOCAL cMesFin := ''                  // Mes Inicial

       LOCAL cCodRef := ''                  // Referencia del pago
       LOCAL cCodEst := ''                  // C¢digo del Estudiante
       LOCAL nVlrTra := 0                   // Valor de la Transaci¢n
       LOCAL dFecTra := CTOD('00/00/00')    // Fecha de la Transaci¢n
       LOCAL nDifTra := 0                   // Valor diferencia
       LOCAL nCodCmv := 0                   // Codigo de Concepto del Movimiento
       LOCAL cObserv := ''                  // Observaci¢n

       LOCAL cCodigoTes := ''               // C¢digo del Estudiante
       LOCAL cNombreTes := ''               // Nombre del Estudiante
       LOCAL lRetadoTes := .T.              // .T. Estudiante retirado
       LOCAL cCodigoTgr := ''               // C¢digo del Grupo

       LOCAL cCodigoTco := ''               // C¢digo del Concepto
*>>>>FIN DECLARACION DE VARIABLES


*>>>>VALIDACION DE CONTENIDOS DE ARCHIVOS
       lHayErr := .T.
       DO CASE
       CASE CAR->(RECCOUNT()) == 0
	    cError('NO EXISTE CONFIGURACION GENERAL')

       CASE PRN->(RECCOUNT()) == 0
	    cError('NO EXISTEN IMPRESIORAS GRABADAS')

       CASE CAA->(RECCOUNT()) == 0
	    cError('NO EXISTEN CONFIGURACION PARA EL A¥O')

       CASE GRU->(RECCOUNT()) == 0
	    cError('NO EXISTE GRUPOS GRABADOS')

       CASE CON->(RECCOUNT()) == 0
	    cError('NO EXISTEN CONCEPTOS GRABADOS')

       CASE TAR->(RECCOUNT()) == 0
	    cError('NO EXISTEN TARIFAS CREADAS')

       CASE CNC->(RECCOUNT()) == 0
	    cError('NO EXISTEN REGISTROS EN CONCILIACIONES')

       CASE MVT->(RECCOUNT()) # 0
	    cError('YA ESTAN CREADOS LOS MOVIMIENTOS')

       OTHERWISE
	    lHayErr :=.F.
       ENDCASE
       IF lHayErr
	  RETURN NIL
       ENDIF
       AFILL(aAntici,0)
*>>>>FIN VALIDACION DE CONTENIDOS DE ARCHIVOS

*>>>>ANALISIS DE DECISION
       IF !lLocCodigo('nNroMesCnc','CNC',nMesIni)
	  cError('NO SE HA CREADO EL MES DE '+cMes(nMesIni,3)+' '+;
		 'DE LA CONCIALIACION')
	  RETURN NIL
       ENDIF
*>>>>FIN ANALISIS DE DECISION

*>>>>VALIDACION DE CONTENIDOS DE ARCHIVOS
       lHayErr := .T.
       DO CASE
       CASE CNC->nTotCauCnc == 0
	     cError('NO HA GENERADO EL INFORME DE LA FACTURACION DEL MES DE '+;
		    cMes(nMesIni,3))

       CASE CNC->nPagValCnc == 0
	     cError('NO HA GENERADO EL INFORME DE PAGOS DEL MES DE '+;
		    cMes(nMesIni,3))

       OTHERWISE
	    lHayErr :=.F.
       ENDCASE
       IF lHayErr
	  RETURN NIL
       ENDIF
*>>>>FIN VALIDACION DE CONTENIDOS DE ARCHIVOS

*>>>>FILTRACION DEL ARCHIVO
       SELECT DES
       SET FILTER TO DES->nNroMesDes == nMesIni .OR.;
		     DES->nMesModDes == nMesIni
       DES->(DBGOTOP())
       IF DES->(EOF())
	  SET FILTER TO
       ENDIF
*>>>>FIN FILTRACION DEL ARCHIVO

*>>>>RECORRIDO POR GRUPOS
       GRU->(DBGOBOTTOM())
       cGruFin = GRU->cCodigoGru

       SELECT GRU
       GRU->(DBGOTOP())
*lLocCodigo('cCodigoGru','GRU','0601')  // ojo
       DO WHILE .NOT. GRU->(EOF())

**********PREPARACION DE LAS VARIABLES DE ARCHIVO
	    FileCli := cPatSis+'\CLIENTES\CL'+;
				GRU->cCodigoGru+cAnoSis+ExtFile

	    FilePag := cPatSis+'\PAGOS\PA'+;
				GRU->cCodigoGru+cAnoSis+ExtFile
**********FIN PREPARACION DE LAS VARIABLES DE ARCHIVO

**********SELECION DE LAS AREAS DE TRABAJO
	    IF !lUseDbf(.T.,FileCli,'CLI',NIL,lShared,nModCry) .OR.;
	       !lUseDbf(.T.,FilePag,'PAG',NIL,lShared,nModCry)

	       cError('ABRIENDO LOS ARCHIVOS DE CLIENTES PAGOS')
	       CloseDbf('CLI',FileCli,nModCry)
	       CloseDbf('PAG',FilePag,nModCry)
	       RETURN NIL
	    ENDIF
**********FIN SELECION DE LAS AREAS DE TRABAJO

**********VALIDACION DE CONTENIDOS DE ARCHIVOS
	    lHayErr := .T.
	    DO CASE
	    CASE CLI->(RECCOUNT()) == 0
		 IF AT('PENSIONES',cNomSis) # 0
		    cError('NO EXISTEN CLIENTES GRABADOS')
		 ENDIF
	    OTHERWISE
		 lHayErr :=.F.
	    ENDCASE

	    IF lHayErr
	       CloseDbf('CLI',FileCli,nModCry)
	       CloseDbf('PAG',FilePag,nModCry)

	       IF AT('PENSIONES',cNomSis) # 0
		  RETURN NIL
	       ELSE
		  GRU->(DBSKIP())
		  LOOP
	       ENDIF
	    ENDIF
**********FIN VALIDACION DE CONTENIDOS DE ARCHIVOS

**********RECORRIDO DEL GRUPO
	    SELECT CLI
	    CLI->(DBGOTOP())
*GO 19  // ojo
	    DO WHILE .NOT. CLI->(EOF())

*==============IMPRESION DE LA LINEA DE ESTADO
		 LineaEstado('MES : '+cMes(nMesIni)+;
			     'ºGRUPO: '+GRU->cCodigoGru+'/'+cGruFin+;
			     'ºNo. '+STR(CLI->(RECNO()),2)+'/'+;
				     STR(CLI->(RECCOUNT()),2),cNomSis)
*==============FIN IMPRESION DE LA LINEA DE ESTADO

*==============ANALISIS SI EL ESTUDIANTE PERTENECE AL GRUPO
		 IF CLI->lRetGruCli
		    SELECT CLI
		    CLI->(DBSKIP())
		    LOOP
		 ENDIF
*==============FIN ANALISIS SI EL ESTUDIANTE PERTENECE AL GRUPO

*==============INICIALIZACION
		 aRegEst := {0,; // Deuda Anterior
			     0,; // Mora Anterior
			     0}  // Valor del Mes

		 cCodRef := ''
		 cCodEst := ''
		 nVlrTra := 0
		 dFecTra := CTOD('00/00/00')
		 nDifTra := 0
		 nCodCmv := 0
		 cObserv := ''
*==============FIN INICIALIZACION

*==============ANALISIS SI ESTUDIANTE ESTA RETIRADO
		 lRetadoTes := .F.
		 cCodigoTgr := SPACE(04)
		 lHayAlu := lSekCodMae(CLI->cCodigoEst,;
				       cMaeAlu,@cNalias,.F.)
		 IF lHayAlu
		    cCodigoTes := &cNalias->cCodigoEst
		    IF &cNalias->lRetiroEst
		       lRetadoTes := .T.
		    ENDIF
		    cNombreTes := RTRIM(&cNalias->cApelliEst)+' '+;
				  &cNalias->cNombreEst
		    cCodigoTgr := &cNalias->cCodigoGru
		 ENDIF
*==============FIN ANALISIS SI ESTUDIANTE ESTA RETIRADO

*==============LOCALIZACION DEL PAGO
		 lHayPag := .F.
		 IF lHayAlu
		    lHayPag := lLocCodPag(CLI->cCodigoEst,nMesIni,.F.)
		 ENDIF
*==============FIN LOCALIZACION DEL PAGO

*==============ANALISIS DE LA FECHA DE PAGO
		 lFPagOk := .T.
		 IF lPrnFec .AND. lHayPag
		    IF PAG->cEstadoPag == 'P' .OR. PAG->cEstadoPag == 'A'
		       IF PAG->dFecPagPag > dFecPrn
			  lFPagOk := .F.
		       ENDIF
		    ENDIF
		 ENDIF
*==============FIN ANALISIS DE LA FECHA DE PAGO

*==============ANALISIS DEL PAGO DEL FIN DEL MES
		 lFinMes := .F.
		 IF !lPrnFec .AND.;
		    (YEAR(PAG->dFecPagPag) == VAL(cAnoUsr) .AND.;
		     MONTH(PAG->dFecPagPag) <= nMesIni     .OR.;
		     YEAR(PAG->dFecPagPag)  < VAL(cAnoUsr))
		    lFinMes := .T.
		 ENDIF
*==============FIN ANALISIS DEL PAGO DEL FIN DEL MES

*==============CALCULO DE LA CAUSACION
		 AFILL(aFacMes,0)
		 nFacMes := 0
		 nVlrCau := 0
		 IF lHayAlu .AND. lHayPag

*-------------------CONCEPTOS
		      nFacMes := 0
		      FOR i := 1 TO LEN(ALLTRIM(PAG->cConcepPag))/2

*                         LOCALIZACION DEL VALOR DEL CONCEPTO
			    SELECT PAG
			    cCodigoTco := SUBS(PAG->cConcepPag,i*2-1,2)
			    IF cCodigoTco $ PAG->cConcepPag
			       nNroPos := (AT(cCodigoTco,PAG->cConcepPag)+1)/2
			       nVlrTar := &('nVlrCo'+STR(nNroPos,1)+'Pag')
			    ELSE
			       nVlrTar := 0
			    ENDIF
*                         FIN LOCALIZACION DEL VALOR DEL CONCEPTO


*                         FACTURACION DEL MES PARA CADA CONCEPTO
			   IF lLocCodigo('cCodigoCon','CON',cCodigoTco)

			      IF CON->lDesEfeDes
				     nFacMes  -= nVlrTar
				 aFacMes[i]   := nVlrTar
			      ELSE
				     nFacMes += nVlrTar
				 aFacMes[i]  := nVlrTar

			      ENDIF

			   ELSE
				  nFacMes += nVlrTar
			       aFacMes[i] := nVlrTar

			   ENDIF
*                         FIN FACTURACION DEL MES PARA CADA CONCEPTO

*                         ANALISIS DE DECISION
			    IF CON->lDesEfeDes
			       cDescri := ALLTRIM(CON->cNombreCon)+' '+;
					  cMes(PAG->nMesIniPag,3)
			    ELSE
			       cDescri := ALLTRIM(CON->cNombreCon)+' '+;
					  cMes(PAG->nMesIniPag,3)
			    ENDIF
*                         FIN ANALISIS DE DECISION

*                         GRABACION DEL MOVIMIENTO
			    IF CON->lDesEfeDes
			       nVlrCau -= nVlrTar
			    ELSE
			       nVlrCau += nVlrTar
			    ENDIF

			    TotConCau(CON->cCodigoCon,;
				      CON->cNombreCon,;
				      nVlrTar,;
				      CON->lDesEfeDes,;
				      aTotCon)

			    lSaveCausa(CLI->cCodigoEst,;
				       cCodigoTgr,;
				       nMesIni,;
				       PAG->nMesIniPag,;
				       PAG->nMesIniPag,;
				       CON->cCodigoCon,;
				       cDescri,;
				       IF(!CON->lDesEfeDes,nVlrTar,0),;  // Credito
				       IF(!CON->lDesEfeDes,0,nVlrTar),;  // Debito
				       9901,;                            // nCodCmv
				       lShared,;                         // lShared
				       .T.,;                             // lInsReg
				       cNomUsr)
*                         FIN GRABACION DEL MOVIMIENTO


		      ENDFOR
*-------------------FIN CONCEPTOS

*-------------------ANTICIPOS
		      IF PAG->cEstadoPag == 'P' .OR. PAG->cEstadoPag == 'A'

			 IF PAG->nMesIniPag # PAG->nMesFinPag .OR.;
			    lHayAntici(nMesIni,PAG->cIniFinPag)

			    nNroAde++
			    IF PAG->nMesFinPag == CAA->nMesFinCaA
			       nFinAde++
			    ENDIF

			    IF CAA->nMtdFacCaA == 2 // Tabla de Tarifas por meses

			       aAntEst := AnticiVar(GRU->cCodigoGru,;
						    aFacMes,;
						    PAG->nMesIniPag,;
						    PAG->nMesFinPag,;
						    aAntici,;
						    PAG->cIniFinPag,;
						    PAG->cConcepPag,;
						    PAG->cConcepPag)

			    ELSE
			       aAntEst := Anticipos(aFacMes,;
					     (nNroMesFac(PAG->nMesIniPag,;
					      PAG->nMesFinPag)-1),aAntici,;
					      PAG->cIniFinPag,PAG->cConcepPag,;
					      PAG->cConcepPag)
			    ENDIF

			    nAntici := nSuma(aAntEst)
			    nTotAnc += nAntici

			    FOR k := 1 TO LEN(aAntEst)

				IF aAntEst[k] == 0
				   LOOP
				ENDIF

				cCodigoTco := SUBS(PAG->cConcepPag,;
						   k*2-1,2)

				IF lLocCodigo('cCodigoCon','CON',;
					      cCodigoTco)
				   cDescri := ALLTRIM(CON->cNombreCon)
				ELSE
				   cDescri := cCodigoTco
				ENDIF

				IF CON->lDesEfeDes
				   cDescri := 'ANTICIPOS'+' '+;
					      cMes(PAG->nMesIniPag+1,3)+;
					      ' A '+;
					      cMes(PAG->nMesFinPag,3)+' '+;
					      cDescri
				ELSE
				   cDescri := 'ANTICIPOS'+' '+;
					      cMes(PAG->nMesIniPag+1,3)+;
					      ' A '+;
					      cMes(PAG->nMesFinPag,3)+' '+;
					      cDescri
				ENDIF

				nVlrCau += aAntEst[k]
				lSaveCausa(CLI->cCodigoEst,;
					   cCodigoTgr,;
					   nMesIni,;
					   PAG->nMesIniPag+1,;
					   PAG->nMesFinPag,;
					   CON->cCodigoCon,;
					   cDescri,;
					   IF(!CON->lDesEfeDes,ABS(aAntEst[k]),0),;   // Credito
					   IF(!CON->lDesEfeDes,0,aAntEst[k]),;        // Debito
					   9902,;                                    // nCodCmv
					   lShared,;                                 // lShared
					   .T.,;                                     // lInsReg
					   cNomUsr)

			    ENDFOR
			  *ÀGrabaci¢n del Movimiento

			 ENDIF

		      ENDIF
*-------------------FIN ANTICIPOS

*-------------------RECARGOS
		      nVlrRec := PAG->nVlrRecPag+PAG->nRecGenPag

		      IF nVlrRec # 0

			 SELECT DES
			 DES->(DBGOTOP())
			 LOCATE FOR DES->cCodigoEst == CLI->cCodigoEst .AND.;
				    DES->nNroMesDes == PAG->nMesIniPag .AND.;
				    DES->nTipDesDes == 2

			 IF DES->(FOUND())
			    cCodCon := DES->cCodigoCon
			    cDescri := 'RECARGO'+' '+;
				       cMes(PAG->nMesIniPag,3)+' '+;
				       ALLTRIM(DES->cDescriDes)

			 ELSE
			    cDescri := 'recardo'+' '+;
				       cMes(PAG->nMesIniPag,3)
			    cCodCon := ''
			 ENDIF


			 nTotRec += nVlrRec
			 nVlrCau += nVlrRec
			 lSaveCausa(CLI->cCodigoEst,;
				    cCodigoTgr,;
				    nMesIni,;
				    PAG->nMesIniPag,;
				    PAG->nMesIniPag,;
				    cCodCon,;
				    cDescri,;
				    nVlrRec,;                 // Credito
				    0,;                       // Debito
				    9903,;                    // nCodCmv
				    lShared,;                 // lShared
				    .T.,;                     // lInsReg
				    cNomUsr)

		      ENDIF
*-------------------FIN RECARGOS

*-------------------AYUDAS
		      nVlrBec := PAG->nVlrBecPag

		      IF nVlrBec # 0

			 cDescri := 'AYUDAS'+' '+;
				    cMes(PAG->nMesIniPag,3)

			 nTotAyu += nVlrBec
			 nVlrCau -= nVlrBec
			 lSaveCausa(CLI->cCodigoEst,;
				    cCodigoTgr,;
				    nMesIni,;
				    PAG->nMesIniPag,;
				    PAG->nMesIniPag,;
				    'PE',;
				    cDescri,;
				    0,;                       // Credito
				    nVlrBec,;                 // Debito
				    9904,;                    // nCodCmv
				    lShared,;                 // lShared
				    .T.,;                     // lInsReg
				    cNomUsr)

		      ENDIF
*-------------------FIN AYUDAS

*-------------------DESCUENTOS
		      nVlrDes := PAG->nVlrDesPag+PAG->nDesGenPag
		      IF nVlrDes # 0

			 SELECT DES
			 DES->(DBGOTOP())
			 LOCATE FOR DES->cCodigoEst == CLI->cCodigoEst .AND.;
				    DES->nNroMesDes == PAG->nMesIniPag .AND.;
				    DES->nTipDesDes == 1

			 IF DES->(FOUND())
			    cDescri := 'DESCUENTOS'+' '+;
				       cMes(PAG->nMesIniPag,3)+' '+;
				       ALLTRIM(DES->cDescriDes)
			    cCodCon := ALLTRIM(DES->cConcepDes)
			 ELSE
			    cDescri := 'descuentos'+' '+;
				       cMes(PAG->nMesIniPag,3)
			    cCodCon := SPACE(02)
			 ENDIF

			 nTotDes += nVlrDes
			 nVlrCau -= nVlrDes
			 lSaveCausa(CLI->cCodigoEst,;
				    cCodigoTgr,;
				    nMesIni,;
				    PAG->nMesIniPag,;
				    PAG->nMesIniPag,;
				    cCodCon,;
				    cDescri,;
				    0,;                       // Credito
				    nVlrDes,;                 // Debito
				    9905,;                    // nCodCmv
				    lShared,;                 // lShared
				    .T.,;                     // lInsReg
				    cNomUsr)

		      ENDIF
*-------------------FIN DESCUENTOS

*-------------------LOCALIZACION DEL ABONO
		      nDeuInt := 0
		      nAboDes := 0
		      SELECT DES
		      GO TOP
		      LOCATE FOR DES->cCodigoEst == CLI->cCodigoEst .AND.;
				 DES->nTipDesDes == 3

		      IF DES->(FOUND())

*************************TOTALIZACION DE LOS ABONOS
			   nAboEst := 0
			   nAboEst += nVlrAbo(CLI->cCodigoEst,cAnoUsr,;
					      PAG->nMesIniPag,@nDeuInt,;
					      @nAboOtr,@nAboDes,;
					      @nAboFin,@nOtrFin,@nDesFin,;
					      lPrnFec,dFecPrn,aRegEst)
			   nAboMes += nAboEst
			   nDesMes += nAboDes
*************************FIN TOTALIZACION DE LOS ABONOS


*************************DEUDA ANTERIOR
			   nDeuAnt += PAG->nSdAbonPag
			   nMorAnt += PAG->nMoAbonPag

			   IF PAG->nSdAbonPag+PAG->nMoAbonPag # 0
			      AADD(aDeuAnt,{CLI->cCodigoEst,;
					    &cNalias->cCodigoGru,;
					    PAG->nSdAbonPag,;
					    PAG->nMoAbonPag,;
					    nAboEst,;
					    nAboOtr})
			   ENDIF
*************************FIN DEUDA ANTERIOR

		      ELSE

*************************DEUDA ANTERIOR
			   nDeuAnt += PAG->nSdoAntPag
			   nMorAnt += PAG->nMorAntPag

			   IF PAG->nSdoAntPag+PAG->nMorAntPag # 0
			      AADD(aDeuAnt,{CLI->cCodigoEst,;
					    &cNalias->cCodigoGru,;
					    PAG->nSdoAntPag,;
					    PAG->nMorAntPag,;
					    0,0})
			   ENDIF

			   IF PAG->nMesAmnPag == PAG->nMesIniPag
			      nDeuInt := nVlrMes()
			   ELSE
			      nDeuInt := PAG->nSdoAntPag+nVlrMes()
			   ENDIF
*************************FIN DEUDA ANTERIOR


		      ENDIF
*-------------------FIN LOCALIZACION DEL ABONO

*-------------------INTERESES PAGOS DEL MES
		      nVlrInt := 0
		      IF PAG->cEstadoPag == 'A'

			 cDescri := 'INT PAGO MES'+' '+;
				    cMes(PAG->nMesIniPag,3)

			 nVlrInt := nIntMesPag(CAA->lIntPenCaA,;
					       PAG->nSdoAntPag,;
					       PAG->nVlrMesPag,;
					       PAG->nMesIniPag,;
					       CAA->nMesAmnCaA)

			 IF nVlrInt > 0

			    nTotInt += nVlrInt
			    nVlrCau += nVlrInt

			    lSaveCausa(CLI->cCodigoEst,;
				       cCodigoTgr,;
				       nMesIni,;
				       PAG->nMesIniPag,;
				       PAG->nMesIniPag,;
				       SPACE(02),;               // Concepto
				       cDescri,;
				       nVlrInt,;                 // Credito
				       0,;                       // Debito
				       9906,;                    // nCodCmv
				       lShared,;                 // lShared
				       .T.,;                     // lInsReg
				       cNomUsr)
			 ENDIF


		      ENDIF
*-------------------FIN INTERESES PAGOS DEL MES

*-------------------INTERESES POR COBRAR DEL MES
		      IF PAG->cEstadoPag == 'D'

			 cDescri := 'INT X COBRAR MES'+' '+;
				    cMes(PAG->nMesIniPag,3)

			 nIntCob := nIntNoP(nDeuInt)


			 IF nIntCob > 0

			    nTotNoP += nIntCob
			    nVlrCau += nIntCob

			    lSaveCausa(CLI->cCodigoEst,;
				       cCodigoTgr,;
				       nMesIni,;
				       PAG->nMesIniPag,;
				       PAG->nMesIniPag,;
				       SPACE(02),;               // Concepto
				       cDescri,;
				       nIntCob,;                 // Credito
				       0,;                       // Debito
				       9907,;                    // nCodCmv
				       lShared,;                 // lShared
				       .T.,;                     // lInsReg
				       cNomUsr)
			 ENDIF

		      ENDIF
*-------------------FIN INTERESES POR COBRAR DEL MES

*-------------------ABONOS DESCUENTOS
		      IF nAboDes > 0

			 cDescri := 'ABONOS DESCUENTOS MES'+' '+;
				    cMes(PAG->nMesIniPag,3)

			 lSaveCausa(CLI->cCodigoEst,;
				    cCodigoTgr,;
				    nMesIni,;
				    PAG->nMesIniPag,;
				    PAG->nMesIniPag,;
				    SPACE(02),;               // Concepto
				    cDescri,;
				    0,;                       // Credito
				    nAboDes,;                 // Debito
				    9900,;                    // nCodCmv
				    lShared,;                 // lShared
				    .T.,;                     // lInsReg
				    cNomUsr)

		      ENDIF
*-------------------FIN ABONOS DESCUENTOS

*-------------------VALOR PAGADO
		      nVlrPag := 0
		      IF PAG->cEstadoPag == 'P' .OR. PAG->cEstadoPag == 'A'

			 cDescri := 'VALOR PAGADO EN'+' '+;
				    cMes(MONTH(PAG->dFecPagPag),3)

			 nVlrPag := PAG->nVlrPagPag
			 IF PAG->cEstadoPag == 'A'
			    nVlrPag += nVlrInt
			 ENDIF
			 nTotPag += nVlrPag
		      ENDIF
*-------------------FIN VALOR PAGADO


*-------------------VALOR DE LA TRANSACION
		      lHayExt := .F.
		      IF PAG->cEstadoPag == 'P' .OR. PAG->cEstadoPag == 'A'

*************************SELECION DE LAS AREAS DE TRABAJO
			   cAnoPag := STR(YEAR(PAG->dFecPagPag),4)
			   cMesPag := STR(MONTH(PAG->dFecPagPag),2)
			   lCorrecion(@cMesPag,2)

			   cPatExt := cAnoPag+'.'+;
				      SUBS(cPatSis,LEN(ALLTRIM(cPatSis))-2,3)

			   FileMoB := cPatExt+'\MODEM\'+PAG->cCodigoBan+'\'+;
				      PAG->cCodigoBan+cAnoPag+cMesPag+ExtFile



			   IF FileMob == FileAnt

			      lHayExt := .T.

			   ELSE

			      lHayExt := lUseDbf(.T.,FileMoB,'EXT',;
						 NIL,lShared,nModCry)

			      FileAnt := FileMob

			   ENDIF
*************************FIN SELECION DE LAS AREAS DE TRABAJO

*************************LOCALIZACION DE LA CONSIGNACION
			   cCodRef := ''
			   IF lHayExt

			      cMesIni := STR(PAG->nMesIniPag,2)
			      lCorrecion(@cMesIni,2)

			      cMesFin := STR(PAG->nMesFinPag,2)
			      lCorrecion(@cMesFin,2)

			      cCodRef := PAG->cCodigoEst+cMesIni+cMesFin

			      SELECT EXT
			      EXT->(DBGOTOP())
			      LOCATE FOR ALLTRIM(EXT->cCodRefTra) == cCodRef

			      SELECT EXT
			      IF FOUND()

				 cCodRef := EXT->cCodRefTra
				 cCodEst := EXT->cCodigoEst
				 nVlrTra := EXT->nValorTra
				 dFecTra := EXT->dFechaTra
				 nCodCmv := EXT->nCodigoCmv
				 cObserv := ''

				 aVlrPagos(EXT->dFechaTra,;
					   EXT->nValorTra,;
					   @aVlrPag,;
					   1,;              // Recibos
					   PAG->cCodigoBan)

				 lValPagExt(lShared,PAG->nVlrPagPag,;
					    nVlrInt,;
					    PAG->dFecPagPag)
			       *ÀValidaci¢n del extracto con los pagos

			      ELSE

				 cCodRef := ''

			      ENDIF

			   ENDIF
*************************FIN LOCALIZACION DE LA CONSIGNACION


		      ENDIF
*-------------------FIN VALOR DE LA TRANSACION

*-------------------GRABACION DE LOS INGRESOS
		      nTotCau += nVlrCau
		      IF PAG->cEstadoPag # '*'

			 IF PAG->cEstadoPag == 'D'
			    cDescri := 'NO PAGO'+' '+cMes(PAG->nMesIniPag,3)
			 ELSE
			    cDescri := 'RECIBO DE '+;
				       cMes(PAG->nMesIniPag,3)+' '+;
				       'PAGADO EN'+' '+;
				       cMes(MONTH(PAG->dFecPagPag),3)
			 ENDIF

			 nRegPag := 0
			 lSavePagos(CLI->cCodigoEst,;
				    cCodigoTgr,;
				    nMesIni,;
				    PAG->nMesIniPag,;
				    PAG->nMesFinPag,;
				    cDescri,;
				    nVlrCau,;
				    PAG->nSdoAntPag,;
				    PAG->nMorAntPag,;
				    PAG->nVlrMesPag,;
				    PAG->nVlrPagPag,;
				    nVlrInt,;
				    PAG->cEstadoPag,;
				    PAG->dFecPagPag,;
				    PAG->cCodigoBan,;
				    9900,;
				    @nRegPag,;
				    lShared,.T.,cNomUsr)
			*ÀPagos

			 IF PAG->cEstadoPag == 'P' .OR.;
			    PAG->cEstadoPag == 'A'

			    MVT->(DBGOTO(nRegPag))

			    IF !EMPTY(cCodRef)

			       cObserv := ''
			       lPagoTrans(nMesIni,;
					  cCodRef,;
					  cCodEst,;
					  nVlrTra,;
					  dFecTra,;
					  nCodCmv,;
					  cObserv,;
					  lShared,.F.,cNomUsr)
			    ENDIF

			 ENDIF
		       *ÀBanco

		      ENDIF
*-------------------FIN GRABACION DE LOS INGRESOS


		 ENDIF
*==============FIN CALCULO DE LA CAUSACION


*==============AVANCE DEL SIGUIENTE REGISTRO
		 SELECT CLI
		 CLI->(DBSKIP())
*EXIT
*==============FIN AVANCE DEL SIGUIENTE REGISTRO


	    ENDDO
**********FIN RECORRIDO DEL GRUPO


	  GRU->(DBSKIP())
*EXIT

       ENDDO

*>>>>FIN RECORRIDO POR GRUPOS

*>>>>GRABACION TOTALES DE LA CAUSACION
       FOR i := 1 TO LEN(aTotCon)

	   lSaveCausa(SPACE(02),;                       // C¢digo del Estudiante
		      SPACE(02),;                       // C¢digo del Grupo
		      nMesIni,;                         // Mes Inicial
		      0,0,;                             // Mes Inicial y Final
		      aTotCon[i,1],;                    // Concepto
		      aTotCon[i,2],;                    // Descripci¢n
		      IF(aTotCon[i,4],0,aTotCon[i,3]),; // Credito
		      IF(aTotCon[i,4],aTotCon[i,3],0),; // Debito
		      0000,;                            // nCodCmv
		      lShared,;                         // lShared
		      .T.,;                             // lInsReg
		      cNomUsr)
	 *ÀSERVICIOS EDUCATIVOS

       ENDFOR

       lSaveCausa(SPACE(02),;                       // C¢digo del Estudiante
		  SPACE(02),;                       // C¢digo del Grupo
		  nMesIni,;                         // Mes Inicial
		  0,0,;                             // Mes Inicial y Final
		  SPACE(02),;                       // Concepto
		  '+ANTICIPOS',;                    // Descripci¢n
		  nTotAnc,;                         // Credito
		  0,;                               // Debito
		  0000,;                            // nCodCmv
		  lShared,;                         // lShared
		  .T.,;                             // lInsReg
		  cNomUsr)
     *À+ANTICIPOS

       lSaveCausa(SPACE(02),;                       // C¢digo del Estudiante
		  SPACE(02),;                       // C¢digo del Grupo
		  nMesIni,;                         // Mes Inicial
		  0,0,;                             // Mes Inicial y Final
		  SPACE(02),;                       // Concepto
		  '+RECARGOS',;                     // Descripci¢n
		  nTotRec,;                         // Credito
		  0,;                               // Debito
		  0000,;                            // nCodCmv
		  lShared,;                         // lShared
		  .T.,;                             // lInsReg
		  cNomUsr)
     *À+RECARGOS

       lSaveCausa(SPACE(02),;                       // C¢digo del Estudiante
		  SPACE(02),;                       // C¢digo del Grupo
		  nMesIni,;                         // Mes Inicial
		  0,0,;                             // Mes Inicial y Final
		  SPACE(02),;                       // Concepto
		  '-AYUDAS',;                       // Descripci¢n
		  0,;                               // Credito
		  nTotAyu,;                         // Debito
		  0000,;                            // nCodCmv
		  lShared,;                         // lShared
		  .T.,;                             // lInsReg
		  cNomUsr)
     *ÀAYUDAS

       lSaveCausa(SPACE(02),;                       // C¢digo del Estudiante
		  SPACE(02),;                       // C¢digo del Grupo
		  nMesIni,;                         // Mes Inicial
		  0,0,;                             // Mes Inicial y Final
		  SPACE(02),;                       // Concepto
		  '-DESCUENTOS',;                   // Descripci¢n
		  0,;                               // Credito
		  nTotDes,;                         // Debito
		  0000,;                            // nCodCmv
		  lShared,;                         // lShared
		  .T.,;                             // lInsReg
		  cNomUsr)
     *ÀDESCUENTOS

       lSaveCausa(SPACE(02),;                       // C¢digo del Estudiante
		  SPACE(02),;                       // C¢digo del Grupo
		  nMesIni,;                         // Mes Inicial
		  0,0,;                             // Mes Inicial y Final
		  SPACE(02),;                       // Concepto
		  '+INT PAGO MES',;                 // Descripci¢n
		  nTotInt,;                         // Credito
		  0,;                               // Debito
		  0000,;                            // nCodCmv
		  lShared,;                         // lShared
		  .T.,;                             // lInsReg
		  cNomUsr)
     *À+INT PAGO MES

       lSaveCausa(SPACE(02),;                       // C¢digo del Estudiante
		  SPACE(02),;                       // C¢digo del Grupo
		  nMesIni,;                         // Mes Inicial
		  0,0,;                             // Mes Inicial y Final
		  SPACE(02),;                       // Concepto
		  '+INTxCobMes',;                   // Descripci¢n
		  nTotNoP,;                         // Credito
		  0,;                               // Debito
		  0000,;                            // nCodCmv
		  lShared,;                         // lShared
		  .T.,;                             // lInsReg
		  cNomUsr)
     *À+INTxCobMes

       lSaveCausa(SPACE(02),;                       // C¢digo del Estudiante
		  SPACE(02),;                       // C¢digo del Grupo
		  nMesIni,;                         // Mes Inicial
		  0,0,;                             // Mes Inicial y Final
		  SPACE(02),;                       // Concepto
		  'TOTAL CAUSACION',;               // Descripci¢n
		  nTotCau,;                         // Credito
		  0,;                               // Debito
		  0000,;                            // nCodCmv
		  lShared,;                         // lShared
		  .T.,;                             // lInsReg
		  cNomUsr)
     *ÀTOTAL CAUSACION
*>>>>FIN GRABACION TOTALES DE LA CAUSACION

*>>>>VALIDACION DE LA CAUSACION
       IF CNC->nTotCauCnc == nTotCau
	  lSavCauVal(nMesIni,nTotCau,lShared,.F.,cNomUsr)
       ELSE
	  cError('LA CAUSACION ESTA INCORRECTA')
	  lSavCauVal(nMesIni,0,lShared,.F.,cNomUsr)
       ENDIF
*>>>>FIN VALIDACION DE LA CAUSACION

*>>>>GRABACION LAS CONSIGNACIONES
       FOR i := 1 TO LEN(aVlrPag)

/*
	   wait  STR(aVlrPag[i][1],4)+' '+;
		 cMes(aVlrPag[i][2],3)+' '+;
		 TRANS(aVlrPag[i][3],"####,###,###")
*/

	   cDescri := 'RECIBO DE '+;
		      cMes(nMesIni,3)+' '+;
		      'PAGADO EN'+' '+;
		      cMes(aVlrPag[i][2],3)+' '+;
		      STR(aVlrPag[i][1],4)


	   lSaveCausa(SPACE(02),;                       // C¢digo del Estudiante
		      SPACE(02),;                       // C¢digo del Grupo
		      nMesIni,;                         // Mes Inicial
		      0,0,;                             // Mes Inicial y Final
		      SPACE(02),;                       // Concepto
		      cDescri,;                         // Descripci¢n
		      0,;                               // Credito
		      aVlrPag[i][3],;                   // Debito
		      0000,;                            // nCodCmv
		      lShared,;                         // lShared
		      .T.,;                             // lInsReg
		      cNomUsr)




       ENDFOR
       RETURN NIL
*>>>>FIN GRABACION LAS CONSIGNACIONES

/*************************************************************************
* TITULO..: GRABACION DE LA CUASACION                                    *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: OCT 16/2013 MIE A
       Colombia, Bucaramanga        INICIO:  2:30 PM   OCT 16/2013 MIE

OBJETIVOS:

1- Graba un registro en la tabla

2- Retorna NIL

SINTAXIS:

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION lSaveCausa(cCodEst,cCodGru,nNroMes,nMesIni,nMesFin,;
		    cCodCon,cDescri,nCredit,nDebito,nCodCmv,;
		    lShared,lInsReg,cNomUsr)


*>>>>DESCRIPCION DE PARAMETROS
/*     cCodEst                              // C¢digo del Estudiante
       cCodGru                              // C¢dogp del Grupo
       nMesIni                              // Mes Inicial
       nMesFin                              // Mes Final
       cCodCon                              // C¢digo del Concepto
       cDescri                              // Descripci¢n
       nCredit                              // Cr‚dito
       nDebito                              // Debito
       nCodCmv                              // Codigo de Concepto del Movimiento
       lShared                              // .T. Sistema Compartido
       lInsReg                              // .T. Insertar Registros
       cNomUsr                              // Nombre del usuario */
*>>>>FIN DESCRIPCION DE PARAMETROS

*>>>>GRABACION DEL REGISTRO
       lInsReg := IF(lInsReg == NIL,.T.,lInsReg)
       IF MVT->(lRegLock(lShared,lInsReg))

	  IF lInsReg
	     REPL MVT->nIdeCodMvt WITH MVT->(RECNO())
	     REPL MVT->nNroMesMvt WITH nNroMes
	  ENDIF

	  REPL MVT->cCodigoEst WITH cCodEst
	  REPL MVT->cCodigoGru WITH cCodGru
	  REPL MVT->nMesIniPag WITH nMesIni
	  REPL MVT->nMesFinPag WITH nMesFin
	  REPL MVT->cCodigoCon WITH cCodCon
	  REPL MVT->cDescriMvt WITH cDescri
	  REPL MVT->nCreditMvt WITH nCredit
	  REPL MVT->nDebitoMvt WITH nDebito
	  REPL MVT->nCodigoCmv WITH nCodCmv

	  REPL MVT->cNomUsrMvt WITH cNomUsr
	  REPL MVT->dFecUsrMvt WITH DATE()
	  REPL MVT->cHorUsrMvt WITH TIME()
	  MVT->(DBCOMMIT())

       ENDIF

       IF lShared
	  MVT->(DBUNLOCK())
       ENDIF
       RETURN NIL
*>>>>FIN GRABACION DEL REGISTRO

/*************************************************************************
* TITULO..: GRABACION DE LOS PAGOS                                       *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: OCT 23/2013 MIE A
       Colombia, Bucaramanga        INICIO:  2:50 PM   OCT 23/2013 MIE

OBJETIVOS:

1- Graba un registro en la tabla

2- Retorna NIL

SINTAXIS:

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION lSavePagos(cCodEst,cCodGru,nNroMes,nMesIni,nMesFin,cDescri,;
		    nTotCau,nSdoAnt,nMorAnt,nVlrMes,nVlrPag,nVlrInt,;
		    cEstado,dFecPag,cCodBan,nCodCmv,nRegPag,lShared,;
		    lInsReg,cNomUsr)

*>>>>DESCRIPCION DE PARAMETROS
/*     cCodEst                              // C¢digo del Estudiante
       cCodGru                              // C¢dogp del Grupo
       nMesIni                              // Mes Inicial
       nMesFin                              // Mes Final
       cDescri                              // Descripci¢n
       nTotCau                              // Total Causaci¢n
       nSdoAnt                              // Saldo Anterior
       nMorAnt                              // Mora Anterior
       nVlrMes                              // Valor del Mes
       nVlrPag                              // Valor a Pagar
       nVlrInt                              // Valor de los Intereses
       cEstado                              // Estado de Pago
       dFecPag                              // Fecha de Pago
       cCodBan                              // C¢digo del Banco
       nCodCmv                              // Codigo de Concepto del Movimiento
       nRegPag                              // @Registro del pago
       lShared                              // .T. Sistema Compartido
       lInsReg                              // .T. Insertar Registros
       cNomUsr                              // Nombre del usuario */
*>>>>FIN DESCRIPCION DE PARAMETROS

*>>>>GRABACION DEL REGISTRO
       lInsReg := IF(lInsReg == NIL,.T.,lInsReg)
       IF MVT->(lRegLock(lShared,lInsReg))

	  IF lInsReg
	     REPL MVT->nIdeCodMvt WITH MVT->(RECNO())
	     REPL MVT->nNroMesMvt WITH nNroMes
	  ENDIF

	  REPL MVT->cCodigoEst WITH cCodEst
	  REPL MVT->cCodigoGru WITH cCodGru
	  REPL MVT->nMesIniPag WITH nMesIni
	  REPL MVT->nMesFinPag WITH nMesFin
	  REPL MVT->cDescriMvt WITH cDescri

	  REPL MVT->nTotCauPag WITH nTotCau

	  REPL MVT->nSdoAntPag WITH nSdoAnt
	  REPL MVT->nMorAntPag WITH nMorAnt
	  REPL MVT->nVlrMesPag WITH nVlrMes
	  REPL MVT->nVlrPagPag WITH nVlrPag
	  REPL MVT->cEstadoPag WITH cEstado
	  REPL MVT->dFecPagPag WITH dFecPag
	  REPL MVT->cCodigoBan WITH cCodBan
	  REPL MVT->nIntMesPag WITH nVlrInt   // Cambiar la Extesi¢n

	  REPL MVT->nCodigoCmv WITH nCodCmv

	  REPL MVT->cNomUsrMvt WITH cNomUsr
	  REPL MVT->dFecUsrMvt WITH DATE()
	  REPL MVT->cHorUsrMvt WITH TIME()
	  MVT->(DBCOMMIT())

	  nRegPag := MVT->(RECNO())

       ENDIF

       IF lShared
	  MVT->(DBUNLOCK())
       ENDIF
       RETURN NIL
*>>>>FIN GRABACION DEL REGISTRO

/*************************************************************************
* TITULO..: GRABACION DE LAS CONSIGNACIONES                              *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: OCT 28/2013 LUN A
       Colombia, Bucaramanga        INICIO:  2:50 PM   OCT 28/2013 LUN

OBJETIVOS:

1- Graba un registro en la tabla

2- Retorna NIL

SINTAXIS:

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION lPagoTrans(nNroMes,cCodRef,cCodEst,nVlrTra,dFecTra,;
		    nCodCmv,cObserv,lShared,lInsReg,cNomUsr)



*>>>>DESCRIPCION DE PARAMETROS
/*     nNroMes                              // N£mero del Mes
       cCodRef                              // C¢digo de la Referencia
       cCodEst                              // C¢digo del Estudiante
       nVlrTra                              // Valor de la transaci¢n
       dFecTra                              // Fecha de la transaci¢n
       nCodCmv                              // Codigo de Concepto del Movimiento
       cObserv                              // Observaci¢n */
*>>>>FIN DESCRIPCION DE PARAMETROS

*>>>>DECLARACION DE VARIABLES
       LOCAL nVlrDif := 0                   // Valor de la diferencia
*>>>>FIN DECLARACION DE VARIABLES

*>>>>CONCILIACION DEL PAGO
       nVlrDif := nVlrTra - MVT->nVlrPagPag
*>>>>FIN CONCILIACION DEL PAGO

*>>>>GRABACION DEL REGISTRO
       lInsReg := IF(lInsReg == NIL,.T.,lInsReg)
       IF MVT->(lRegLock(lShared,lInsReg))

	  IF lInsReg
	     REPL MVT->nIdeCodMvt WITH MVT->(RECNO())
	     REPL MVT->nNroMesMvt WITH nNroMes
	  ENDIF

	  REPL MVT->cCodRefTra  WITH cCodRef
	  REPL MVT->cCodEstTra  WITH cCodEst
	  REPL MVT->nValorTra   WITH nVlrTra
	  REPL MVT->dFechaTra   WITH dFecTra

	  REPL MVT->nVlrDifMvt  WITH ABS(nVlrTra - (MVT->nVlrPagPag+;
						    MVT->nIntMesPag))

	  REPL MVT->nCodigoCmv  WITH nCodCmv
	  REPL MVT->cObservMvt  WITH cObserv

	  REPL MVT->cNomUsrMvt WITH cNomUsr
	  REPL MVT->dFecUsrMvt WITH DATE()
	  REPL MVT->cHorUsrMvt WITH TIME()
	  MVT->(DBCOMMIT())

       ENDIF

       IF lShared
	  MVT->(DBUNLOCK())
       ENDIF
       RETURN NIL
*>>>>FIN GRABACION DEL REGISTRO


/*************************************************************************
* TITULO..: TOTAL DE CONCEPTO CAUSADOS                                   *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: OCT 31/2013 JUE A
       Colombia, Bucaramanga        INICIO: 10:45 AM   OCT 31/2013 JUE

OBJETIVOS:

1- Totaliza el valor de los conceptos causados

2- Retorna NIL

SINTAXIS:

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION TotConCau(cCodCon,cNomCon,nVlrCon,lDesEfe,aTotCon)

*>>>>DESCRIPCION DE PARAMETROS
/*     cCodCon                              // C¢digo del Concepto
       cNomCon                              // Nombre del Concepto
       nVlrCon                              // Valor del Concepto
       lDesEfe                              // Descuento Efectivo
       aTotCon                              // Total de los conceptos */
*>>>>FIN DESCRIPCION DE PARAMETROS

*>>>>DECLARACION DE VARIABLES
       LOCAL i := 0                         // Contador
*>>>>FIN DECLARACION DE VARIABLES

*>>>>TOTALIZACION
       IF EMPTY(aTotCon)
	  AADD(aTotCon,{cCodCon,cNomCon,0,lDesEfe})
	  i := LEN(aTotCon)
       ELSE
	  i := ASCAN(aTotCon,{|aArr|aArr[1] == cCodCon})
	  IF i == 0
	     AADD(aTotCon,{cCodCon,cNomCon,0,lDesEfe})
	     i := LEN(aTotCon)
	  ENDIF
       ENDIF
       aTotCon[i,3] += nVlrCon
       RETURN NIL
*>>>>FIN TOTALIZACION



