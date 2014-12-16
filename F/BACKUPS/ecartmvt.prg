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
       LOCAL cJorTxt := ''                  // Jornada

       LOCAL FileMvt := ''                  // Archivo de Movimientos
       LOCAL PathArc := ''                  // Path del Archivo
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

	   IF cNalias == 'MVT'
	      FileMvt := fArchvo
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

*>>>>ANALISIS DE DECISION
       IF !lLocCodigo('nNroMesCnc','CNC',nMesIni)
	  cError('NO SE HA CREADO EL MES DE '+cMes(nMesIni,3)+' '+;
		 'DE LA CONCIALIACION')
	  RETURN NIL
       ENDIF
*>>>>FIN ANALISIS DE DECISION

*>>>>ANALISIS DE DECISION
       IF !CNC->lReportCnc .AND. MVT->(RECCOUNT()) # 0

	  IF lPregunta('DESEA GENERAR NUEVAMENTE LOS MOVIMIENTOS? No Si')

	     fArchvo(@FileMvt,@PathArc)

	     CloseDbf('MVT')

	     CreaDbfMvt(lShared,nModCry,PathArc,FileMvt)

	     lUseDbf(.T.,PathArc+'\'+FileMvt,'MVT',NIL,lShared,nModCry)

	  ENDIF

       ENDIF
*>>>>FIN ANALISIS DE DECISION

*>>>>ANALISIS DE DECISION

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


       cJorTxt := SUBS(cPatSis,5,4)

       SETKEY(K_F3,{||EstadoCta(lShared,nModCry,cNomSis,cNomEmp,;
				cNomUsr,cAnoUsr,cPatSis,cJorTxt,;
				2,1,NIL,NIL,NIL,;
				MVT->cCodigoEst,cMaeAlu,'MVT')})

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
       cTitInf := '<F3>Pagos <F2>Consultar <F5>Buscar'+;
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

       oColumn := TBCOLUMNNEW('MES;FINAL MVT',{||MVT->nMesFinMvt})
       oColumn:Cargo := {{'MODI',lModReg},{'ALIAS','MVT'},;
			 {'FIELD','nMesFinMvt'},{'PICTURE','99'}}
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

       oColumn := TBCOLUMNNEW('SALDO',{||MVT->nSaldosMvt})
       oColumn:Cargo := {{'MODI',lModReg},{'ALIAS','MVT'},;
			 {'FIELD','nSaldosMvt'},{'PICTURE','9999999999.99'}}
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

       oColumn := TBCOLUMNNEW('NROFAC',{||MVT->nNroFacCaA})
       oColumn:Cargo := {{'MODI',lModReg},{'ALIAS','MVT'},;
			 {'FIELD','nNroFacCaA'},{'PICTURE','999999999999'}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn := TBCOLUMNNEW('FECHA;FACTURACION',{||MVT->dFecFacPag})
       oColumn:Cargo := {{'MODI',lModReg},{'ALIAS','MVT'},;
			 {'FIELD','dFecFacPag'},{'PICTURE','@!D'}}
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
       AADD(aMenus,'1<MOVIMIENTOS   >')
       AADD(aMenus,'2<IMPRIMIR      >')
       AADD(aMenus,'3<IMPRIMIR CTA T>')
       AADD(aMenus,'4<ARCHIVO ASCII>')

       aAyuda := {}
       AADD(aAyuda,'Generar los Movimientos')
       AADD(aAyuda,'Imprime los Detalles de los Movimientos')
       AADD(aAyuda,'Imprime la cuenta T')
       AADD(aAyuda,'Crea el archivo plano contable')

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

       CASE nNroOpc == 3
	    OtrMvt014(lShared,nModCry,cNomSis,cCodEmp,cNitEmp,cEmpPal,;
		      cNomEmp,cNomSec,cNomUsr,cAnoUsr,aArchvo,lPrnArc,;
		      cOpcPrn,nCodPrn,lModReg,lDelReg,lInsReg,lHaySql,;
		      oBrowse)
	   *Impresi¢n de la Cuenta T

       CASE nNroOpc == 4
	    OtrMvt013(lShared,nModCry,cNomSis,cCodEmp,cNitEmp,cEmpPal,;
		      cNomEmp,cNomSec,cNomUsr,cAnoUsr,aArchvo,lPrnArc,;
		      cOpcPrn,nCodPrn,lModReg,lDelReg,lInsReg,lHaySql,;
		      oBrowse,cPatSis,cMaeAlu,nMesIni)
	   *Archivo plano contable

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
       LOCAL aVlrAbo := {}                  // Total Abonos

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

       LOCAL aFecTra := {}                  // Fecha de la Transaci¢n
       LOCAL cNroMes := ''                  // N£mero del Mes
       LOCAL nVlrCre := 0                   // Valor del Cr‚dito
       LOCAL nVlrDeb := 0                   // Valor del D‚bito
       LOCAL nSaldos := 0                   // Valor del Saldo
       LOCAL aVlrDif := {}                  // Valor Diferencia
       LOCAL aDifRec := {}                  // Diferencia en Pagos
       LOCAL aDifAbo := {}                  // Diferencia en Pagos

       LOCAL cCodigoTes := ''               // C¢digo del Estudiante
       LOCAL cNombreTes := ''               // Nombre del Estudiante
       LOCAL lRetadoTes := .T.              // .T. Estudiante retirado
       LOCAL cCodigoTgr := ''               // C¢digo del Grupo

       LOCAL cCodigoTco := ''               // C¢digo del Concepto
*>>>>FIN DECLARACION DE VARIABLES


*>>>>VALIDACION DE CONTENIDOS DE ARCHIVOS
       lHayErr := .T.
       DO CASE
       CASE SCA->(RECCOUNT()) == 0
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

/*

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

*/

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
*lLocCodigo('cCodigoGru','GRU','1103')  // ojo
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
*GO 30  // ojo
	    DO WHILE .NOT. CLI->(EOF())

*==============IMPRESION DE LA LINEA DE ESTADO
		 LineaEstado('MES : '+cMes(nMesIni)+;
			     'ºGRUPO: '+GRU->cCodigoGru+'/'+cGruFin+;
			     'ºCODIGO: '+CLI->cCodigoEst+;
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
				       PAG->nMesFinPag,;
				       PAG->nMesIniPag,;
				       PAG->dFecFacPag,;
				       CON->cCodigoCon,;
				       cDescri,;
				       PAG->nNroFacCaA,;
				       IF(!CON->lDesEfeDes,nVlrTar,0),;  // Credito
				       IF(!CON->lDesEfeDes,0,nVlrTar),;  // Debito
				       0,;                               // Saldos
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
					   PAG->nMesFinPag,;
					   PAG->dFecFacPag,;
					   CON->cCodigoCon,;
					   cDescri,;
					   PAG->nNroFacCaA,;
					   IF(!CON->lDesEfeDes,ABS(aAntEst[k]),0),;  // Credito
					   IF(!CON->lDesEfeDes,0,ABS(aAntEst[k])),;  // Debito
					   0,;                                       // Saldos
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
			    cCodCon := SUBS(DES->cConcepDes,1,2)
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
				    PAG->nMesFinPag,;
				    PAG->nMesIniPag,;
				    PAG->dFecFacPag,;
				    cCodCon,;
				    cDescri,;
				    PAG->nNroFacCaA,;
				    nVlrRec,;                 // Credito
				    0,;                       // Debito
				    0,;                       // Saldos
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
				    PAG->nMesFinPag,;
				    PAG->nMesIniPag,;
				    PAG->dFecFacPag,;
				    'PE',;
				    cDescri,;
				    PAG->nNroFacCaA,;
				    0,;                       // Credito
				    nVlrBec,;                 // Debito
				    0,;                       // Saldos
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
				    PAG->nMesFinPag,;
				    PAG->nMesIniPag,;
				    PAG->dFecFacPag,;
				    cCodCon,;
				    cDescri,;
				    PAG->nNroFacCaA,;
				    0,;                       // Credito
				    nVlrDes,;                 // Debito
				    0,;                       // Saldos
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
				       PAG->nMesFinPag,;
				       PAG->nMesIniPag,;
				       PAG->dFecFacPag,;
				       SPACE(02),;               // Concepto
                                       cDescri,;
				       PAG->nNroFacCaA,;
				       nVlrInt,;                 // Credito
				       0,;                       // Debito
				       0,;                       // Saldos
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
				       PAG->nMesFinPag,;
				       PAG->nMesIniPag,;
				       PAG->dFecFacPag,;
				       SPACE(02),;               // Concepto
				       cDescri,;
				       PAG->nNroFacCaA,;
				       nIntCob,;                 // Credito
				       0,;                       // Debito
				       0,;                       // Saldos
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
				    PAG->nMesFinPag,;
				    PAG->nMesIniPag,;
				    PAG->dFecFacPag,;
				    SPACE(02),;               // Concepto
				    cDescri,;
				    PAG->nNroFacCaA,;
				    0,;                       // Credito
				    nAboDes,;                 // Debito
				    0,;                       // Saldos
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

*-------------------GRABACION DE LA CAUSACION
		      nTotCau += nVlrCau
		      IF nVlrCau > 0

			 cDescri := 'CAUSACION DE '+cMes(PAG->nMesIniPag,3)

			 lSaveCausa(CLI->cCodigoEst,;
				    cCodigoTgr,;
				    nMesIni,;
				    PAG->nMesIniPag,;
				    PAG->nMesFinPag,;
				    PAG->nMesIniPag,;
				    PAG->dFecFacPag,;
				    '++',;
				    cDescri,;
				    0,;                          // N£mero de la factura
				    nVlrCau,;                    // Credito
				    0,;                          // Debito
				    0,;                          // Saldos
				    9901,;                       // nCodCmv
				    lShared,;                    // lShared
				    .T.,;                        // lInsReg
				    cNomUsr)

		      ENDIF
*-------------------FIN GRABACION DE LA CAUSACION

*-------------------GRABACION DE LOS INGRESOS
		      IF PAG->cEstadoPag # '*'

			 IF PAG->cEstadoPag == 'P' .OR.;
			    PAG->cEstadoPag == 'A'

			    cDescri := 'RECIBO DE '+;
				       cMes(PAG->nMesIniPag,3)+' '+;
				       'PAGADO EN'+' '+;
				       cMes(MONTH(PAG->dFecPagPag),3)

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


			    MVT->(DBGOTO(nRegPag))

*			    IF !EMPTY(cCodRef)

			       cObserv := ''
			       lPagoTrans(nMesIni,;
					  cCodRef,;
					  cCodEst,;
					  nVlrTra,;
					  dFecTra,;
					  nCodCmv,;
					  cObserv,;
					  lShared,.F.,cNomUsr,aVlrDif)
			    ENDIF

*			 ENDIF
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


*>>>>RECORRIDO DE LOS ABONOS
       aDifRec := aVlrDif

       SELECT DES
       DES->(DBGOTOP())

       FileAnt := 'X'                 // Archivo Anterior
       DO WHILE .NOT. DES->(EOF())

**********IMPRESION DE LA LINEA DE ESTADO
	    LineaEstado('MES : '+cMes(nMesIni)+;
			'ºABONO: '+DES->cCodigoEst+;
			'ºNo. '+STR(DES->(RECNO()),4)+'/'+;
				STR(DES->(RECCOUNT()),4),cNomSis)
**********FIN IMPRESION DE LA LINEA DE ESTADO

**********ANALISIS DE DECISION
	    IF !(DES->nTipDesDes == 3 .AND. !DES->lDesEfeDes)

	       DES->(DBSKIP())
	       LOOP

	    ENDIF
**********FIN ANALISIS DE DECISION

**********ANALISIS SI ESTUDIANTE ESTA RETIRADO
	    lRetadoTes := .F.
	    cCodigoTgr := SPACE(04)
	    lHayAlu := lSekCodMae(DES->cCodigoEst,;
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
**********FIN ANALISIS SI ESTUDIANTE ESTA RETIRADO

**********SELECION DE LAS AREAS DE TRABAJO
	    cAnoPag := STR(YEAR(DES->dFechaDes),4)
	    cMesPag := STR(MONTH(DES->dFechaDes),2)
	    lCorrecion(@cMesPag,2)

	    cPatExt := cAnoPag+'.'+;
		       SUBS(cPatSis,LEN(ALLTRIM(cPatSis))-2,3)


	    FileMoB := cPatExt+'\MODEM\'+'01'+'\'+;
		       '01'+cAnoPag+cMesPag+ExtFile

	    IF !FILE(FileMoB)
	       cError('01'+cAnoPag+cMesPag+ExtFile)
	       DES->(DBSKIP())
	       LOOP
	    ENDIF

	    IF FileMob == FileAnt

	       lHayExt := .T.

	    ELSE

	       lHayExt := lUseDbf(.T.,FileMoB,'EXT',;
				  NIL,lShared,nModCry)

	       FileAnt := FileMob

	    ENDIF
**********FIN SELECION DE LAS AREAS DE TRABAJO

**********LOCALIZACION DE LA CONSIGNACION DEL ABONO
	    cCodRef := ''
	    IF lHayExt

	       cMesIni := STR(DES->nNroMesDes,2)
	       lCorrecion(@cMesIni,2)

	       cMesFin := '14'
	       lCorrecion(@cMesFin,2)

	       cCodRef := DES->cCodigoEst+cMesFin+cMesIni

	       SELECT EXT
	       EXT->(DBGOTOP())
	       LOCATE FOR ALLTRIM(EXT->cCodRefTra) == cCodRef .AND.;
			  EXT->nValorTra == DES->nValorDes

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
			    @aVlrAbo,;
			    3,;              // Abonos
			    '01')            // cCodigoBan)

		  lValPagExt(lShared,DES->nValorDes,;
			     0,;
			     DES->dFechaDes)
		*ÀValidaci¢n del extracto con los abonos

		 aFecTra := aFecha(EXT->dFechaTra)

		 cDescri := 'ABONO:'+DES->cCodigoEst+'-'+cCodigoTgr+' DE '+;
			    cMes(VAL(cMesIni),3)+' '+;
			    'PAG EN'+' '+;
			    cMes(VAL(aFecTra[1]),3)+' '+;
			    aFecTra[3]

		 nRegPag := 0
		 lSavePagos(DES->cCodigoEst,;
			    cCodigoTgr,;
			    VAL(cMesIni),;
			    VAL(cMesIni),;
			    VAL(cMesFin),;
			    cDescri,;
			    0,;
			    0,;
			    0,;
			    0,;
			    DES->nValorDes,;
			    0,;
			    '',;
			    DES->dFechaDes,;
			    '01',;
			    0,;
			    @nRegPag,;
			    lShared,.T.,cNomUsr)
		*ÀAbono


		 MVT->(DBGOTO(nRegPag))


		 aVlrDif := {}
		 cObserv := ''
		 lPagoTrans(nMesIni,;
			    cCodRef,;
			    cCodEst,;
			    nVlrTra,;
			    dFecTra,;
			    nCodCmv,;
			    cObserv,;
			    lShared,.F.,cNomUsr,aVlrDif)

	       ELSE

		  cCodRef := ''


	       ENDIF

	    ENDIF
**********FIN LOCALIZACION DE LA CONSIGNACION DEL ABONO

	  DES->(DBSKIP())

       ENDDO
       aDifAbo := aVlrDif
*>>>>FIN RECORRIDO DE LOS ABONOS

*>>>>GRABACION TOTALES DE LA CAUSACION
      nSaldos := 0
       FOR i := 1 TO LEN(aTotCon)

	   nVlrCre := IF(aTotCon[i,4],0,aTotCon[i,3])
	   nVlrDeb := IF(aTotCon[i,4],aTotCon[i,3],0)

	   IF nVlrCre > 0
	     nSaldos += ABS(nVlrCre - nVlrDeb)
	   ENDIF

	   IF nVlrDeb > 0
	     nSaldos -= ABS(nVlrCre - nVlrDeb)
	   ENDIF


	   lSaveCausa(SPACE(02),;                       // C¢digo del Estudiante
		      SPACE(02),;                       // C¢digo del Grupo
		      nMesIni,;                         // Mes Inicial
		      0,0,0,;                           // Mes Inicial y Final
		      CTOD('00/00/00'),;                // Fecha Facturaci¢n
		      aTotCon[i,1],;                    // Concepto
		      aTotCon[i,2],;                    // Descripci¢n
		      0,;                               // N£mero de la Factura
		      nVlrCre,;                         // Credito
		      nVlrDeb,;                         // Debito
		      nSaldos,;                         // Saldos
		      0000,;                            // nCodCmv
		      lShared,;                         // lShared
		      .T.,;                             // lInsReg
		      cNomUsr)
	 *ÀSERVICIOS EDUCATIVOS

       ENDFOR

       nVlrCre := nTotAnc
       nVlrDeb := 0
       nSaldos += ABS(nVlrCre - nVlrDeb)


       lSaveCausa(SPACE(02),;                       // C¢digo del Estudiante
		  SPACE(02),;                       // C¢digo del Grupo
		  nMesIni,;                         // Mes Inicial
		  0,0,0,;                           // Mes Inicial y Final
		  CTOD('00/00/00'),;                // Fecha Facturaci¢n
		  SPACE(02),;                       // Concepto
		  'MAS ANTICIPOS',;                 // Descripci¢n
		  0,;                               // N£mero de la factura
		  nVlrCre,;                         // Credito
		  nVlrDeb,;                         // Debito
		  nSaldos,;                         // Saldos
		  0000,;                            // nCodCmv
		  lShared,;                         // lShared
		  .T.,;                             // lInsReg
		  cNomUsr)
     *À+ANTICIPOS

       nVlrCre := nTotRec
       nVlrDeb := 0
       nSaldos += ABS(nVlrCre - nVlrDeb)

       lSaveCausa(SPACE(02),;                       // C¢digo del Estudiante
		  SPACE(02),;                       // C¢digo del Grupo
		  nMesIni,;                         // Mes Inicial
		  0,0,0,;                           // Mes Inicial y Final
		  CTOD('00/00/00'),;                // Fecha Facturaci¢n
		  SPACE(02),;                       // Concepto
		  'MAS RECARGOS',;                  // Descripci¢n
		  0,;                               // N£mero de la factura
		  nVlrCre,;                         // Credito
		  nVlrDeb,;                         // Debito
		  nSaldos,;                         // Saldos
		  0000,;                            // nCodCmv
		  lShared,;                         // lShared
		  .T.,;                             // lInsReg
		  cNomUsr)
     *À+RECARGOS

       nVlrCre := 0
       nVlrDeb := nTotAyu
       nSaldos -= ABS(nVlrCre - nVlrDeb)

       lSaveCausa(SPACE(02),;                       // C¢digo del Estudiante
		  SPACE(02),;                       // C¢digo del Grupo
		  nMesIni,;                         // Mes Inicial
		  0,0,0,;                           // Mes Inicial y Final
		  CTOD('00/00/00'),;                // Fecha Facturaci¢n
		  SPACE(02),;                       // Concepto
		  'MENOS AYUDAS',;                  // Descripci¢n
		  0,;                               // N£mero de la factura
		  nVlrCre,;                         // Credito
		  nVlrDeb,;                         // Debito
		  nSaldos,;                         // Saldos
		  0000,;                            // nCodCmv
		  lShared,;                         // lShared
		  .T.,;                             // lInsReg
		  cNomUsr)
     *ÀAYUDAS

       nVlrCre := 0
       nVlrDeb := nTotDes
       nSaldos -= ABS(nVlrCre - nVlrDeb)

       lSaveCausa(SPACE(02),;                       // C¢digo del Estudiante
		  SPACE(02),;                       // C¢digo del Grupo
		  nMesIni,;                         // Mes Inicial
		  0,0,0,;                           // Mes Inicial y Final
		  CTOD('00/00/00'),;                // Fecha Facturaci¢n
		  SPACE(02),;                       // Concepto
		  'MENOS DESCUENTOS',;              // Descripci¢n
		  0,;                               // N£mero de la factura
		  nVlrCre,;                         // Credito
		  nVlrDeb,;                         // Debito
		  nSaldos,;                         // Saldos
		  0000,;                            // nCodCmv
		  lShared,;                         // lShared
		  .T.,;                             // lInsReg
		  cNomUsr)
     *ÀDESCUENTOS

       nVlrCre := nTotInt
       nVlrDeb := 0
       nSaldos += ABS(nVlrCre - nVlrDeb)

       lSaveCausa(SPACE(02),;                       // C¢digo del Estudiante
		  SPACE(02),;                       // C¢digo del Grupo
		  nMesIni,;                         // Mes Inicial
		  0,0,0,;                           // Mes Inicial y Final
		  CTOD('00/00/00'),;                // Fecha Facturaci¢n
		  SPACE(02),;                       // Concepto
		  'MAS INT PAGO MES',;              // Descripci¢n
		  0,;                               // N£mero de la factura
		  nVlrCre,;                         // Credito
		  nVlrDeb,;                         // Debito
		  nSaldos,;                         // Saldos
		  0000,;                            // nCodCmv
		  lShared,;                         // lShared
		  .T.,;                             // lInsReg
		  cNomUsr)
     *À+INT PAGO MES

       nVlrCre := nTotNoP
       nVlrDeb := 0
       nSaldos += ABS(nVlrCre - nVlrDeb)

       lSaveCausa(SPACE(02),;                       // C¢digo del Estudiante
		  SPACE(02),;                       // C¢digo del Grupo
		  nMesIni,;                         // Mes Inicial
		  0,0,0,;                           // Mes Inicial y Final
		  CTOD('00/00/00'),;                // Fecha Facturaci¢n
		  SPACE(02),;                       // Concepto
		  'MAS INTxCobMes',;                // Descripci¢n
		  0,;                               // N£mero de la factura.
		  nVlrCre,;                         // Credito
		  nVlrDeb,;                         // Debito
		  nSaldos,;                         // Saldos
		  0000,;                            // nCodCmv
		  lShared,;                         // lShared
		  .T.,;                             // lInsReg
		  cNomUsr)
     *À+INTxCobMes

       nVlrCre := nTotCau
       nVlrDeb := 0
*      nSaldos se toma el que viene

       lSaveCausa(SPACE(02),;                           // C¢digo del Estudiante
		  SPACE(02),;                           // C¢digo del Grupo
		  nMesIni,;                             // Mes Inicial
		  0,0,0,;                               // Mes Inicial y Final
		  CTOD('00/00/00'),;                    // Fecha Facturaci¢n
		  SPACE(02),;                           // Concepto
		  'CAUSACION MES DE '+cMes(nMesIni,3),; // Descripci¢n
		  0,;                                   // N£mero de la Factura.
		  nVlrCre,;                             // Credito
		  nVlrDeb,;                             // Debito
		  nSaldos,;                             // Saldos
		  0000,;                                // nCodCmv
		  lShared,;                             // lShared
		  .T.,;                                 // lInsReg
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

*>>>>ORDENACION DE LOS PAGOS
/*     aVlrPag,{nAnoPag,;      // 1. A¤o
		nMesPag,;      // 2. Mes
		0,;            // 3. Recibos.        Tipo = 1
		0,;            // 4. Abonos          Tipo = 2
		0,;            // 5. Inscripciones   Tipo = 3
		0,;            // 6. Pagos Parciales Tipo = 4
		cCodBan}       // 7. C¢digo del Banco */


       FOR i := 1 TO LEN(aVlrPag)

	 cNroMes := STR(aVlrPag[i,2],2)
	 lCorrecion(@cNroMes)

	 aVlrPag[i,7] := STR(aVlrPag[i,1],4)+cNroMes

       ENDFOR
     *ÀReemplazo del cCodBan para poder ordenar

       aVlrPag := ASORT(aVlrPag,,,{|x,y|x[7] < y[7] })
*>>>>FIN ORDENACION DE LOS PAGOS

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

	   nVlrCre := 0
	   nVlrDeb := aVlrPag[i][3]
	   nSaldos -= ABS(nVlrCre - nVlrDeb)


	   lSaveCausa(SPACE(02),;                       // C¢digo del Estudiante
		      SPACE(02),;                       // C¢digo del Grupo
		      nMesIni,;                         // Mes Inicial
		      0,0,0,;                             // Mes Inicial y Final
		      CTOD('00/00/00'),;                // Fecha Facturaci¢n
		      SPACE(02),;                       // Concepto
		      cDescri,;                         // Descripci¢n
		      0,;                               // N£mero de la factura.
		      nVlrCre,;                         // Credito
		      nVlrDeb,;                         // Debito
		      nSaldos,;                         // Saldos
		      0000,;                            // nCodCmv
		      lShared,;                         // lShared
		      .T.,;                             // lInsReg
		      cNomUsr)


       ENDFOR
*>>>>FIN GRABACION LAS CONSIGNACIONES

*>>>>GRABACION DE LAS INCONSISTENCIAS
       FOR i := 1 TO LEN(aDifRec)


	   cDescri := aDifRec[i,6]


	   nVlrCre := aDifRec[i,7]
	   nVlrDeb := aDifRec[i,8]

	   IF nVlrCre > 0
	      nSaldos += ABS(nVlrCre - nVlrDeb)
	   ENDIF

	   IF nVlrDeb > 0
	      nSaldos -= ABS(nVlrCre - nVlrDeb)
	   ENDIF

	   lSaveCausa(aDifRec[i,1],;                    // C¢digo del Estudiante
		      aDifRec[i,2],;		        // C¢digo del Grupo
		      aDifRec[i,3],;                    // Mes de Facturaci¢n
		      aDifRec[i,4],;                    // Mes Inicial
		      aDifRec[i,5],;                    // Mes Final
		      0,;                               // Mes Final Movimiento
		      CTOD('00/00/00'),;                // Fecha Facturaci¢n
		      SPACE(02),;                       // Concepto
		      cDescri,;                         // Descripci¢n
		      0,;                               // N£mero de la factura.
		      nVlrCre,;                         // Credito
		      nVlrDeb,;                         // Debito
		      nSaldos,;                         // Saldos
		      0000,;                            // nCodCmv
		      lShared,;                         // lShared
		      .T.,;                             // lInsReg
		      cNomUsr)

       ENDFOR
*>>>>FIN GRABACION DE LAS INCONSISTENCIAS

*>>>>GRABACION DE LOS ABONOS
       FOR i := 1 TO LEN(aVlrAbo)

	   cDescri := 'ABONOS DE '+;
		      cMes(nMesIni,3)+' '+;
		      'PAGADO EN'+' '+;
		      cMes(aVlrAbo[i][2],3)+' '+;
		      STR(aVlrAbo[i][1],4)

	   nVlrCre := 0
	   nVlrDeb := aVlrAbo[i][5]
	   nSaldos -= ABS(nVlrCre - nVlrDeb)


	   lSaveCausa(SPACE(02),;                       // C¢digo del Estudiante
		      SPACE(02),;                       // C¢digo del Grupo
		      nMesIni,;                         // Mes Inicial
		      0,0,0,;                             // Mes Inicial y Final
		      CTOD('00/00/00'),;                // Fecha Facturaci¢n
		      SPACE(02),;                       // Concepto
		      cDescri,;                         // Descripci¢n
		      0,;                               // N£mero de la factura.
		      nVlrCre,;                         // Credito
		      nVlrDeb,;                         // Debito
		      nSaldos,;                         // Saldos
		      0000,;                            // nCodCmv
		      lShared,;                         // lShared
		      .T.,;                             // lInsReg
		      cNomUsr)


       ENDFOR
       RETURN NIL
*>>>>FIN GRABACION DE LOS ABONOS


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
		    nFinMes,dFecFac,cCodCon,cDescri,nNroFac,;
		    nCredit,nDebito,nSaldos,nCodCmv,lShared,;
		    lInsReg,cNomUsr)

*>>>>DESCRIPCION DE PARAMETROS
/*     cCodEst                              // C¢digo del Estudiante
       cCodGru                              // C¢dogp del Grupo
       nMesIni                              // Mes Inicial
       nMesFin                              // Mes Final
       nFinMes                              // Mes Final del Movimiento
       dFecFac                              // Fecha de Facturaci¢n
       cCodCon                              // C¢digo del Concepto
       cDescri                              // Descripci¢n
       nNroFac                              // N£mero de la Factura
       nCredit                              // Cr‚dito
       nDebito                              // Debito
       nSaldos                              // Saldos
       nCodCmv                              // Codigo de Concepto del Movimiento
       lShared                              // .T. Sistema Compartido
       lInsReg                              // .T. Insertar Registros
       cNomUsr                              // Nombre del usuario */
*>>>>FIN DESCRIPCION DE PARAMETROS

*>>>>DECLARACION DE VARIABLES
       LOCAL cNroFac := ''                  // N£mero de la Factura.
*>>>>FIN DECLARACION DE VARIABLES

*>>>>NUMERO DE LA FACTURA
       cNroFac := STR(nNroFac,12)
       lCorrecion(@cNroFac)
       cNroFac := SUBS(cNroFac,2,LEN(cNroFac))
*>>>>FIN NUMERO DE LA FACTURA

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
	  REPL MVT->nMesFinMvt WITH nFinMes
	  REPL MVT->dFecFacPag WITH dFecFac
	  REPL MVT->cCodigoCon WITH cCodCon
	  REPL MVT->cDescriMvt WITH cDescri
	  REPL MVT->nCreditMvt WITH nCredit
	  REPL MVT->nNroFacCaA WITH VAL(cNroFac)
	  REPL MVT->nDebitoMvt WITH nDebito
	  REPL MVT->nSaldosMvt WITH nSaldos
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
		    nCodCmv,cObserv,lShared,lInsReg,cNomUsr,;
		    aVlrDif)

*>>>>DESCRIPCION DE PARAMETROS
/*     nNroMes                              // N£mero del Mes
       cCodRef                              // C¢digo de la Referencia
       cCodEst                              // C¢digo del Estudiante
       nVlrTra                              // Valor de la transaci¢n
       dFecTra                              // Fecha de la transaci¢n
       nCodCmv                              // Codigo de Concepto del Movimiento
       cObserv                              // Observaci¢n
       aVlrDif                              // @Valor Diferencia */
*>>>>FIN DESCRIPCION DE PARAMETROS

*>>>>DECLARACION DE VARIABLES
       LOCAL nVlrDif := 0                   // Valor de la diferencia
       LOCAL aFecTra := {}                  // Fecha de la Transaci¢n
*>>>>FIN DECLARACION DE VARIABLES

*>>>>GRABACION DEL REGISTRO
       aFecTra := aFecha(dFecTra)
       lInsReg := IF(lInsReg == NIL,.T.,lInsReg)
       IF MVT->(lRegLock(lShared,lInsReg))

	  IF lInsReg
	     REPL MVT->nIdeCodMvt WITH MVT->(RECNO())
	     REPL MVT->nNroMesMvt WITH nNroMes
	  ENDIF

	  IF nVlrTra # 0
	     REPL MVT->cCodigoCon WITH '--'
	  ENDIF
	  REPL MVT->nCreditMvt WITH 0
	  REPL MVT->nDebitoMvt WITH nVlrTra

	  REPL MVT->cCodRefTra  WITH cCodRef
	  REPL MVT->cCodEstTra  WITH cCodEst
	  REPL MVT->nValorTra   WITH nVlrTra
	  REPL MVT->dFechaTra   WITH dFecTra


	  nVlrDif := ABS(nVlrTra - (MVT->nVlrPagPag+MVT->nIntMesPag))

	  REPL MVT->nVlrDifMvt  WITH nVlrDif

	  REPL MVT->nCodigoCmv  WITH nCodCmv
	  REPL MVT->cObservMvt  WITH cObserv

	  REPL MVT->cNomUsrMvt WITH cNomUsr
	  REPL MVT->dFecUsrMvt WITH DATE()
	  REPL MVT->cHorUsrMvt WITH TIME()
	  MVT->(DBCOMMIT())

	  IF nVlrDif # 0

	     DO CASE
	     CASE nVlrTra == 0

		  AADD(aVlrDif,{MVT->cCodigoEst,;      // 1.
				MVT->cCodigoGru,;      // 2.
				MVT->nNroMesMvt,;      // 3.
				MVT->nMesIniPag,;      // 4.
				MVT->nMesFinPag,;      // 5.
				MVT->cCodigoEst+'-'+;
				MVT->cCodigoGru+' '+;
				'NO FIGURA EL PAGO',;  // 6. Descripci¢n
				0 ,;                   // 7. Cr‚dito
				nVlrDif})              // 8. D‚bito

	     CASE nVlrTra > (MVT->nVlrPagPag+MVT->nIntMesPag)

		  AADD(aVlrDif,{MVT->cCodigoEst,;      // 1.
				MVT->cCodigoGru,;      // 2.
				MVT->nNroMesMvt,;      // 3.
				MVT->nMesIniPag,;      // 4.
				MVT->nMesFinPag,;      // 5.
				MVT->cCodigoEst+'-'+;
				MVT->cCodigoGru+' '+;
				'MAYOR VALOR PAGADO '+;
				cMes(VAL(aFecTra[1]),3),; // 6. Descripci¢n
				nVlrDif,;                 // 7. Cr‚dito
				0})                       // 8. D‚bito

	     CASE nVlrTra < (MVT->nVlrPagPag+MVT->nIntMesPag)

		  AADD(aVlrDif,{MVT->cCodigoEst,;      // 1.
				MVT->cCodigoGru,;      // 2.
				MVT->nNroMesMvt,;      // 3.
				MVT->nMesIniPag,;      // 4.
				MVT->nMesFinPag,;      // 5.
				MVT->cCodigoEst+'-'+;
				MVT->cCodigoGru+' '+;
				'MENOR VALOR PAGADO '+;   // 6. Descripci¢n
				cMes(VAL(aFecTra[1]),3),; // 6. Descripci¢n
				0,;                       // 7. Cr‚dito
				nVlrDif})                 // 8. D‚bito
	     ENDCASE

	  ENDIF



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


/*************************************************************************
* TITULO..: GENERACION DEL ARCHIVO PLANO CONTABLE                        *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: DIC 04/2013 MIE A
       Colombia, Bucaramanga        INICIO:  3:35 PM   DIC 04/2013 MIE

OBJETIVOS:

1- Genera el archivo plano con los movimientos contables

2- Retorna NIL

SINTAXIS:

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION OtrMvt013(lShared,nModCry,cNomSis,cCodEmp,cNitEmp,cEmpPal,;
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
       #INCLUDE "ARC-FACT.PRG"              // Archivos del Sistema

       LOCAL cSavPan := ''                  // Salvar Pantalla
       LOCAL cAnoSis := SUBS(cAnoUsr,3,2)   // A¤o del sistema
       LOCAL lHayErr := .F.                 // .T. Hay Error

       LOCAL nNroArc := 0                   // N£mero del Archivo
       LOCAL cRegTxt := ''                  // Texto del registro
       LOCAL nByeWri := 0                   // Bytes Escritos
       LOCAL lGraReg := .F.                 // Grabar el Registro
       LOCAL Getlist := {}                  // Variable del sistema
     *ÀVariables espec¡ficas 
*>>>>FIN DECLARACION DE VARIABLES

*>>>>VALIDACION DE CONTENIDOS DE ARCHIVOS
       lHayErr := .T.
       DO CASE
       CASE MVT->(RECCOUNT()) == 0
	    cError('NO SE HAN CREADO LOS REGISTROS CONTABLES')

       CASE SCO->nEmpMvtCon == 0
	    cError('NO SE HA DEFINIDO EL CODIGO DE LA EMPRESA PARA GENERAR MOVIMIENTOS')

       CASE SCO->nEmpMvtCon > 1
	    cError('EMPRESA NO VALIDA PARA GENERAR MOVIMIENTOS')

       CASE EMPTY(SCO->nEmpMvtCon)
	    cError('NO SE HA DEFINIDO EL CODIGO PARA EL COLEGIO')

       CASE EMPTY(SCO->cCenCosCon)
	    cError('NO SE HA DEFINIDO EL CENTRO DE COSTOS')

       CASE EMPTY(SCO->cSubCenCon)
	    cError('NO SE HA DEFINIDO EL SUB CENTRO DE COSTOS')



       OTHERWISE
	    lHayErr :=.F.
       ENDCASE
       IF lHayErr
	  RETURN NIL
       ENDIF
*>>>>FIN VALIDACION DE CONTENIDOS DE ARCHIVOS

*>>>>ANALISIS DE DECISION
       IF !lPregunta('SE VAN A GENERAR LOS MOVIMIENTOS PARA EL SIIGO. '+;
		     'DESEA CONTINUAR? No Si')
	  cError('SE ABANDONA EL PROCESO')
	  RETURN NIL
       ENDIF
*>>>>FIN ANALISIS DE DECISION

*>>>>ANALISIS DE DECISION
       DO CASE
       CASE SCO->nEmpMvtCon == 1 // SIIGO

	    SiigoTxt(lShared,nModCry,cNomSis,cCodEmp,cNitEmp,cEmpPal,;
		     cNomEmp,cNomSec,cNomUsr,cAnoUsr,aArchvo,lPrnArc,;
		     cOpcPrn,nCodPrn,lModReg,lDelReg,lInsReg,lHaySql,;
		     oBrowse,cPatSis,cMaeAlu,nMesIni)
	  *ÀGeneraci¢n del archivo plano. Siigo

       ENDCASE
       RETURN NIL
*>>>>FIN ANALISIS DE DECISION


/*************************************************************************
* TITULO..: SIIGO - GENERACION DEL ARCHIVO PLANO CONTABLE                *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: DIC 04/2013 MIE A
       Colombia, Bucaramanga        INICIO:  3:35 PM   DIC 04/2013 MIE

OBJETIVOS:

1- Genera el archivo plano con los movimientos contables para el SIIGO

2- Retorna NIL

SINTAXIS:

1. jean.ospina@strategy-e.com Cel:3123043605

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION SiigoTxt(lShared,nModCry,cNomSis,cCodEmp,cNitEmp,cEmpPal,;
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
       #INCLUDE "ARC-FACT.PRG"              // Archivos del Sistema

       LOCAL cSavPan := ''                  // Salvar Pantalla
       LOCAL cAnoSis := SUBS(cAnoUsr,3,2)   // A¤o del sistema
       LOCAL lHayErr := .F.                 // .T. Hay Error

       LOCAL nNroArc := 0                   // N£mero del Archivo
       LOCAL cRegTxt := ''                  // Texto del registro
       LOCAL nByeWri := 0                   // Bytes Escritos
       LOCAL lGraReg := .F.                 // Grabar el Registro

       LOCAL cTipCom := ''                  // Tipo de Comprobante
       LOCAL aFecha  := {}                  // Fecha de Proceso
       LOCAL cMesIni := ''                  // Mes Inicial
       LOCAL cMesFin := ''                  // Mes Final
       LOCAL cNroFac := ''                  // N£mero de la Factura.
       LOCAL cNroNit := ''                  // N£mero del Nit
       LOCAL cDescri := ''                  // Descripci¢n
       LOCAL nVlrMvt := ''                  // Valor del Movimiento
       LOCAL nVlrLen := 0                   // Valor cifra entera
       LOCAL cVlrLen := ''                  // Valor cifra entera
       LOCAL nVlrDec := 0                   // Valor de cifra decimal
       LOCAL cVlrDec := ''                  // Valor de cifra decimal
       LOCAL cYear   := ''                  // N£mero de A¤o
       LOCAL cNroMes := ''                  // N£mero del mes

       LOCAL Getlist := {}                  // Variable del sistema
     *ÀVariables espec¡ficas 
*>>>>FIN DECLARACION DE VARIABLES

*>>>>CREACION DEL ARCHIVO
       cMesIni := STR(nMesIni,2)
       lCorrecion(@cMesIni)

       FileTem := PathDoc+'\'+'Mvt'+cMesIni+'.txt'
       nNroArc := FCREATE(FileTem,0)
       IF nNroArc == -1
	  cError('NO SE PUEDE CREAR EL ARCHIVO '+FileTem)
	  RETURN NIL
       ENDIF
*>>>>FIN CREACION DEL ARCHIVO

*>>>>RECORRIDO DE LOS REGISTROS
       cSavPan := SAVESCREEN(0,0,24,79)

       SELECT MVT
       MVT->(DBGOTOP())
       DO WHILE .NOT. MVT->(EOF())


**********MOVIMIENTOS CONTABLES
	    cRegTxt := ''
	    DO CASE
	    CASE MVT->nCodigoCmv == 9901 .OR.;   // SERVICIOS EDUCATIVOS
		 MVT->nCodigoCmv == 9902 .OR.;   // ANTICIPOS
		 MVT->nCodigoCmv == 9903 .OR.;   // RECARGOS  X
		 MVT->nCodigoCmv == 9904 .OR.;   // AYUDAS
		 MVT->nCodigoCmv == 9905 .OR.;   // DESCUENTOS
		 MVT->nCodigoCmv == 9906 .OR.;   // INT PAGO MES X
		 MVT->nCodigoCmv == 9907         // INTxCOB MES


*----------------TIPO DE COMPROBANTE
		   cTipCom := 'F'                // CUASACION

		   cRegTxt :=  cTipCom
/*                  Tipo de comprobante
		    Lengitud(01). Alfan£merica
		    F = Causaci¢n R = Ingresos
		    COL:A =>  001:001 */
*----------------FIN TIPO DE COMPROBANTE

*----------------CODIGO COMPROBANTE
		   cRegTxt += SCO->cEmpMvtCon
/*                  C¢digo Comprobante
		    Longitud(03). N£merico
		    C¢digo del Colegio
		    COL:B =>  002:004 */
*----------------FIN CODIGO COMPROBANTE

*----------------NUMERO DE DOCUMENTO
		   cNroFac := STR(MVT->nNroFacCaA,11)
		   lCorrecion(@cNroFac)

		   cRegTxt += cNroFac
/*                  N£mero de documento
		    Longitud(11). N£merico
		    N£mero de la factura.
		    Se debe generar el recibo de caja para el caso del Ingreso(R).
		    COL:C =>  005:015 */
*----------------FIN NUMERO DE DOCUMENTO


*----------------SECUENCIA
		   cRegTxt += 'XXXXX'
/*                  Secuencia.
		    Longitud(05). N£merico. M ximo hasta 250
		    COL:D =>  016:020 */
*----------------FIN SECUENCIA


*----------------NIT
		   cNroNit := ALLTRIM(SCO->cNroNitCon)
		   cNroNit := SUBS(cNroNit,1,LEN(cNroNit)-1)

		   DO CASE
		   CASE LEN(cNroNit) > 13
			cNroNit := SUBS(cNroNit,1,13)
		   CASE LEN(cNroNit) < 13
			cNroNit := SPACE(13-LEN(cNroNit))+cNroNit
		   ENDCASE

		   lCorrecion(@cNroNit)
		   cRegTxt += cNroNit
/*                  Nit sin digito de verificaci¢n
		    Longitud(13). N£merico
		    COL:E =>  021:033 */
*----------------FIN NIT

*----------------SUCURSAL
		   cRegTxt += REPL('0',3)
/*                  Sucursal
		    Longitud(03). N£merico.
		    Fijo Ceros
		    COL:F =>  034:036 */
*----------------FIN SUCURSAL

*----------------CUENTA CONTABLE
		   cRegTxt += 'XXXXXXXXXX'
/*                  Cuenta Contable
		    Longitud(10). N£merico
		    Alineada a la izquierda
		    COL:G =>  037:046 */
*----------------FIN CUENTA CONTABLE

*----------------CODIGO DE PRODUCTO
		   cRegTxt += REPL('0',13)
/*                  C¢digo de producto
		    Longitud(13). N£merico
		    Fijos Ceros
		    COL:H =>  047:059 */
*----------------FIN CODIGO DE PRODUCTO

*----------------FECHA DEL DOCUMENTO XXX
		   IF cTipCom == 'F'
		      aFecha := aFecha(MVT->dFecFacPag)
		   ELSE
		      aFecha := aFecha(MVT->dFecFacPag) // OJO FECHA DE PAGO
		   ENDIF

		   cRegTxt += aFecha[3]+aFecha[1]+aFecha[2]
/*                  Fecha del documento
		    Longitud(08). AAAAMMDD
		    Fecha de Facturaci¢n.AAAAMMDD
		    COL:I =>  060:067 */
*----------------FIN FECHA DEL DOCUMENTO

*----------------CENTRO DE COSTOS
		   cRegTxt += SCO->cCenCosCon
/*                  Centro de Costos
		    Longitud(04). N£merico
		    C¢digo para cada Colegio.
		    COL:J =>  068:071 */
*----------------FIN CENTRO DE COSTOS

*----------------SUBCENTRO DE COSTO
		   cRegTxt += SUBS(SCO->cSubCenCon,2,4)
/*                  SubCentro de Costo
		    Longitud(03). N£merico
		    C¢digo para cada Colegio.
		    COL:K =>  072:074 */
*----------------FIN SUBCENTRO DE COSTO

*----------------DESCRIPCION DEL MOVIMIENTO
		   cDescri := ALLTRIM(MVT->cDescriMvt)
		   cDescri += ':'+MVT->cCodigoEst+':'+STR(MVT->(RECNO()),4)
		   cDescri := SUBS(cDescri+SPACE(50),1,50)

		   cRegTxt += cDescri
/*                  Descripci¢n del movimiento
		    Longitud(50). Alfan£merico
		    COL:L =>  075:124 */
*----------------FIN DESCRIPCION DEL MOVIMIENTO


*----------------DEBITO O CREDITO
		   IF MVT->nCreditMvt > 0
		      cRegTxt += 'C'
		      nVlrMvt := MVT->nCreditMvt
		   ENDIF
		   IF MVT->nDebitoMvt > 0
		      cRegTxt += 'D'
		      nVlrMvt := MVT->nDebitoMvt
		   ENDIF
		   IF MVT->nCreditMvt > 0 .AND. MVT->nDebitoMvt > 0
		      cRegTxt += 'X'
		      nVlrMvt := 0
		   ENDIF
/*                  Cr‚dito o D‚bito
		    Longitud(01). Alfan£merico.
		    C=Cr‚dito D=D‚bito
		    COL:M =>  125:125 */
*----------------FIN DEBITO O CREDITO

*----------------VALOR DEL MOVIMIENTO
		   IF nVlrMvt == 0
		      cVlrLen := REPL('0',13)
		      cVlrDec := REPL('0',02)
		   ELSE
		      nVlrLen := INT(nVlrMvt)
		      cVlrLen := STR(nVlrLen,13,0)
		      lCorrecion(@cVlrLen)

		      nVlrDec := nVlrMvt - nVlrLen
		      nVlrDec := nVlrDec * 100
		      cVlrDec := STR(nVlrDec,2,0)
		      lCorrecion(@cVlrDec)
		   ENDIF

		   cRegTxt += cVlrLen+cVlrDec
/*                  Valor del Movimiento
		    Longitud(15). N£merico. 13 enteros, 2 d‚cimales
		    COL:N =>  126:140 */
*----------------FIN VALOR DEL MOVIMIENTO

*----------------BASE DE RETENCION
		   cRegTxt += REPL('0',15)
/*                  Base de Retenci¢n
		    Longitud(15). N£merico. 13 enteros, 2 d‚cimales
		    Fijos Ceros
		    COL:O =>  141:155 */
*----------------FIN BASE RETENCION

*----------------CODIGO DEL VENDEDOR
		   cRegTxt += REPL('0',04)
/*                  C¢digo del vendedor
		    Longitud(04). N£merico
		    Fijos Ceros
		    COL:P =>  156:159 */
*----------------FIN CODIGO DEL VENDEDOR

*----------------CODIGO DE LA CIUDAD
		   cRegTxt += REPL('0',04)
/*                  C¢digo de la ciudad
		    Longitud(04). N£merico
		    Fijo Ceros
		    COL:Q =>  160:163 */
*----------------FIN CODIGO DE LA CIUDAD

*----------------CODIGO DE LA ZONA
		   cRegTxt += REPL('0',03)
/*                  C¢digo de la zona
		    Longitud(03). N£merico
		    Fijos Ceros
		    COL:R =>  164:166 */
*----------------FIN CODIGO DE LA ZONA

*----------------CODIGO DE LA BODEGA
		   cRegTxt += REPL('0',04)
/*                  C¢digo de la bodega
		    Longitud(04). N£merico
		    Fijos Ceros
		    COL:S =>  167:170 */
*----------------FIN CODIGO DE LA BODEGA


*----------------CODIGO DE LA UBICACION
		   cRegTxt += REPL('0',03)
/*                  C¢digo de la ubicaci¢n.
		    Longitud(03). N£merico
		    Fijos Ceros
		    COL:T =>  171:173 */
*----------------FIN CODIGO DE LA UBICACION

*----------------CANTIDAD
		   cRegTxt += REPL('0',15)
/*                  Cantidad
		    Longitud(15). N£merico. 10 enteros, 5 d‚cimales
		    Fijos Ceros
		    COL:U =>  174:188 */
*----------------FIN CANTIDAD

*----------------TIPO DE DOCUMENTO CRUCE
		   cRegTxt += 'F'
/*                  Tipo documento cruce
		    Longitud(01). Alfan£merico
		    Constante F para ambos
		    COL:V =>  189:189 */
*----------------FIN TIPO DE DOCUMENTO CRUCE

*----------------CODIGO COMPROBANTE CRUCE
		   cRegTxt += SCO->cEmpMvtCon
/*                  C¢digo Comprobante Cruce
		    Longitud(03). Alfan£merico diferentes a espacios
		    C¢digo del Colegio = Colomna B
		    COL:W =>  190:192 */
*----------------FIN CODIGO COMPROBANTE CRUCE

*----------------NUMERO DOCUMENTO CRUCE
		   cMesIni := STR(MVT->nNroMesMvt,2)
		   lCorrecion(@cMesIni)

		   cMesFin := STR(MVT->nMesFinPag,2)
		   lCorrecion(@cMesFin)

		   cRegTxt += '0'+MVT->cCodigoEst+cMesIni+cMesFin
/*                  N£mero del documento cruce
		    Longitud(11). N£merico
		    C¢digo de la Referencia
		    COL:X =>  193:203 */
*----------------FIN NUMERO DOCUMENTO CRUCE

*----------------SECUENCIA DEL DOCUMENTO CRUCE
		   cRegTxt += '001'
/*                  Secuencia del documento cruce
		    Longitud(03). N£merico. M ximo hasta 250
		    001 => Constante
		    COL:Y =>  204:206 */
*----------------FIN SECUENCIA DEL DOCUMENTO CRUCE

*----------------FECHA VENCIMIENTO DE DOCUMENTO CRUCE
		   IF MVT->nNroMesMvt == 12
		      cYear   := STR(VAL(cAnoUsr)+1,2)
		      cNroMes := '01'
		   ELSE
		      cYear   := cAnoUsr
		      cNroMes := STR(MVT->nNroMesMvt+1,2)
		      lCorrecion(@cNroMes)
		   ENDIF

		   cRegTxt += cYear+cNroMes+'01'
/*                  Fecha Vencimiento de Documento cruce
		    Longitud(08). AAAAMMDD
		    Primer d¡a del Mes Siguiente o Fecha de transaci¢n
		    COL:Z =>  207:214 */
*----------------FIN FECHA VENCIMIENTO DE DOCUMENTO CRUCE

*----------------CODIGO FORMA DE PAGO
		   cRegTxt += REPL('0',04)
/*                  C¢digo forma de pago
		    Longitud(04). N£merico.
		    Sole se utilizan 3 el primer digito debe ser cero.
		    Pendiente
		    COL:AA=>  215:218 */
*----------------FIN CODIGO FORMA DE PAGO

*----------------CODIGO DEL BANCO
		   cRegTxt += REPL('0',02)
/*                  C¢digo del Banco
		    Longitud(02). N£merico
		    COL:AB=>  219:220 */

		    cRegTxt += CHR(13)+CHR(10)
*----------------FIN CODIGO DEL BANCO

	    ENDCASE
**********FIN MOVIMIENTOS CONTABLES

**********GRABACION DE LA CABECERA DEL ARCHIVO
	    IF .NOT. EMPTY(cRegTxt)
	       nByeWri := FWRITE(nNroArc,cRegTxt,LEN(cRegTxt))
	       IF nByeWri # LEN(cRegTxt)
		   cError('GRABACION DE LA CABECERA')
		   EXIT
	       ENDIF
	    ENDIF
**********FIN GRABACION DE LA CABECERA DEL ARCHIVO

**********AVANCE DEL SIGUIENTE REGISTRO
	    SELECT MVT
	    MVT->(DBSKIP())
**********FIN AVANCE DEL SIGUIENTE REGISTRO

       ENDDO
       RETURN NIL
*>>>>FIN RECORRIDO DE LOS REGISTROS


/*************************************************************************
* TITULO..: SIIGO - GENERACION DEL ARCHIVO PLANO CONTABLE                *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: DIC 04/2013 MIE A
       Colombia, Bucaramanga        INICIO:  3:35 PM   DIC 04/2013 MIE

OBJETIVOS:

1- Separa el archivo y su path

2- Retorna NIL

SINTAXIS:

1. jean.ospina@strategy-e.com Cel:3123043605

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION fArchvo(fArchvo,PathArc)

*>>>>DESCRIPCION DE PARAMETROS
/*     fArchvo                              // @Archivo
       PathArc                              // @Path del archivo */
*>>>>FIN DESCRIPCION DE PARAMETROS

*>>>>DECLARACION DE VARIABLES
       LOCAL nNroPos := 0                   // N£mero de la Posici¢n
*>>>>FIN DECLARACION DE VARIABLES

*>>>>SEPRACION DEL ARCHIVO
       nNroPos := RAT('\',fArchvo)
       IF nNroPos # 0
	  PathArc := SUBS(fArchvo,1,nNroPos-1)
	  fArchvo := SUBS(fArchvo,nNroPos+1,LEN(fArchvo))
       ELSE
	  PathArc := ''
       ENDIF
       RETURN NIL
*>>>>FIN SEPRACION DEL ARCHIVO

/*************************************************************************
* TITULO..: IMPRESION CUENTA T                                           *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: MAR 03/2013 LUN A
       Colombia, Bucaramanga        INICIO:  2:37 PM   MAR 03/2013 LUN

OBJETIVOS:

1- Imprime los Movimientos de la Cuenta T

2- Retorna NIL

SINTAXIS:

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION OtrMvt014(lShared,nModCry,cNomSis,cCodEmp,cNitEmp,cEmpPal,;
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
	  FilePrn := 'CTAT-'+cMes(MVT->nNroMesMvt,3)
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
		   'MOVIMIENTOS CUENTA T',;
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

       AADD(aNroCol,40)
       AADD(aTitPrn,'DESCRIPCION')

       AADD(aNroCol,14)
       AADD(aTitPrn,'CREDITOS')

       AADD(aNroCol,14)
       AADD(aTitPrn,'DEBITOS')

       AADD(aNroCol,14)
       AADD(aTitPrn,'SALDO')

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
	    IF MVT->nCodigoCmv # 0
	       MVT->(DBSKIP())
	       LOOP
	    ENDIF
**********FIN ANALISIS DE DECISION

**********IMPRESION DEL REGISTRO
            aRegPrn := {}
	    AADD(aRegPrn,STR(MVT->nNroMesMvt,2,0))

	    AADD(aRegPrn,MVT->cDescriMvt)

	    AADD(aRegPrn,TRANS(MVT->nCreditMvt,"####,###,###"))
	    AADD(aRegPrn,TRANS(MVT->nDebitoMvt,"####,###,###"))
	    AADD(aRegPrn,TRANS(MVT->nSaldosMvt,"####,###,###"))

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
