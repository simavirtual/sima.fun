/*************************************************************************
* TITULO..: MANTENIMIENTO DEL ARCHIVO                                    *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: ABR  6/2005 MIE A
       Colombia, Bucaramanga        INICIO: 11:35 AM   ABR  6/2005 MIE

OBJETIVOS:

1- Permite el mantenimiento del archivo

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION MantenPrS(lShared,nModCry,cNomSis,cCodEmp,cNitEmp,cEmpPal,;
		   cNomEmp,cNomSec,cNomUsr,cAnoUsr,aArchvo,lPrnArc,;
		   cOpcPrn,nCodPrn,lModReg,lDelReg,lInsReg,lHaySql,;
		   nFilInf,nColInf)

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
       nFilInf                              // Fila Inferior
       nColInf                              // Columna Inferior */
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

       LOCAL nMesPrs := 0                   // Mes del Presupuesto
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
       lModReg := IF(lModReg .AND. PRS->(RECCOUNT())==0,.F.,lModReg)

       lDelReg := IF(lDelReg==NIL,.F.,lDelReg)

       lInsReg := IF(lInsReg==NIL,.F.,lInsReg)

       lHaySql := IF(lHaySql==NIL,.F.,lHaySql)
*>>>>FIN PARAMETROS POR DEFECTO

*>>>>CAPTURA DEL MES A PAGAR
       cSavPan := SAVESCREEN(0,0,24,79)
       nMesPrs := nMesano(nFilInf+7,nColInf-25,'Mes del Presupuesto',.F.)
       RESTSCREEN(0,0,24,79,cSavPan)
*>>>>FIN CAPTURA DEL MES A PAGAR

*>>>>MANTENIMIENTO DEL ARCHIVO
       oBrowse := oBrwDbfPrS(lShared,cNomUsr,cAnoUsr,03,00,22,79,;
			     lModReg,lDelReg,lInsReg,lHaySql,nMesPrs)

       SETKEY(K_F2,{||lManRegPrS(lShared,cNomUsr,3,oBrowse)})
     *ÀConsulta

       IF lModReg
          SETKEY(K_F4,{||lManRegPrS(lShared,cNomUsr,2,oBrowse,;
                                    PRS->cCodPucPrS)})
       ENDIF
     *ÀActualizar

       SETKEY(K_F5,{||BuscarPrS(oBrowse)})

       SETKEY(K_F9,{||MenuOtrPrS(lShared,nModCry,cNomSis,cCodEmp,cNitEmp,;
                                 cEmpPal,cNomEmp,cNomSec,cNomUsr,cAnoUsr,;
                                 aArchvo,lPrnArc,cOpcPrn,nCodPrn,lModReg,;
                                 lDelReg,lInsReg,lHaySql,oBrowse)})

       PRS->(CtrlBrw(lShared,oBrowse))

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

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: ABR  6/2005 MIE A
       Colombia, Bucaramanga        INICIO: 11:35 AM   ABR  6/2005 MIE

OBJETIVOS:

1- Define el objeto Browse del archivo

SINTAXIS:

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION oBrwDbfPrS(lShared,cNomUsr,cAnoUsr,nFilSup,nColSup,nFilInf,nColInf,;
		    lModReg,lDelReg,lInsReg,lHaySql,nMesPrs)

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
       lHaySql                              // .T. Exportar a Sql
       nMesPrs                              // Mes del Presupuesto  */
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

       cTitSup := '<< PRESUPUESTO MES '+cMes(nMesPrs)+'>>'
       cTitInf := '<F2>Consultar <F5>Buscar'+;
                   IF(lModReg,' <F4>Actualizar','')+' <F9>Otros'+;
                   IF(lDelReg,' <DEL>Borrar','')+;
                   IF(lInsReg,' <INS>Incluir','')

       IF lInsReg
          oBrowse:Cargo := {cTitSup,cTitInf,{||lManRegPrS(lShared,cNomUsr)}}
       ELSE
          oBrowse:Cargo := {cTitSup,cTitInf}
       ENDIF
     *ÀDefinici¢n de cabeceras y l¡neas de cabeceras

       SELECT PRS
       oColumn := TBCOLUMNNEW('CODIGO DEL PUC',{||PRS->cCodPucPrS})
       oColumn:Cargo := {{'MODI',.F.},{'ALIAS','PRS'},;
			 {'FIELD','cCodPucPrS'},{'PICTURE','99999999999999999999'}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn := TBCOLUMNNEW('CUENTA',{||cLocNomCam('cCodigoPuc','PUC',;
						     PRS->cCodPucPrS,;
						     'cNombrePuc',;
						     'PRS')})

       oColumn:Cargo := {{'MODI',.F.}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna



       IF nMesPrs == 1
	  oColumn := TBCOLUMNNEW('PRESUPUESTO;ENERO',{||PRS->nPrsEnePrS})
	  oColumn:Cargo := {{'MODI',lModReg},{'ALIAS','PRS'},;
			    {'FIELD','nPrsEnePrS'},{'PICTURE','999999999.99'}}
	  oBrowse:ADDCOLUMN(oColumn)
	*ÀDefinici¢n Columna
       ENDIF

       IF nMesPrs == 2
	  oColumn := TBCOLUMNNEW('PRESUPUESTO;FEBRERO',{||PRS->nPrsFebPrS})
	  oColumn:Cargo := {{'MODI',lModReg},{'ALIAS','PRS'},;
			    {'FIELD','nPrsFebPrS'},{'PICTURE','999999999.99'}}
	  oBrowse:ADDCOLUMN(oColumn)
	*ÀDefinici¢n Columna
       ENDIF

       IF nMesPrs == 3
	  oColumn := TBCOLUMNNEW('PRESUPUESTO;MARZO',{||PRS->nPrsMarPrS})
	  oColumn:Cargo := {{'MODI',lModReg},{'ALIAS','PRS'},;
			    {'FIELD','nPrsMarPrS'},{'PICTURE','999999999.99'}}
	  oBrowse:ADDCOLUMN(oColumn)
	*ÀDefinici¢n Columna
       ENDIF

       IF nMesPrs == 4
	  oColumn := TBCOLUMNNEW('PRESUPUESTO;ABRIL',{||PRS->nPrsAbrPrS})
	  oColumn:Cargo := {{'MODI',lModReg},{'ALIAS','PRS'},;
			    {'FIELD','nPrsAbrPrS'},{'PICTURE','999999999.99'}}
	  oBrowse:ADDCOLUMN(oColumn)
	*ÀDefinici¢n Columna
       ENDIF

       IF nMesPrs == 5
	  oColumn := TBCOLUMNNEW('PRESUPUESTO;MAYO',{||PRS->nPrsMayPrS})
	  oColumn:Cargo := {{'MODI',lModReg},{'ALIAS','PRS'},;
			    {'FIELD','nPrsMayPrS'},{'PICTURE','999999999.99'}}
	  oBrowse:ADDCOLUMN(oColumn)
	*ÀDefinici¢n Columna
       ENDIF

       IF nMesPrs == 6
	  oColumn := TBCOLUMNNEW('PRESUPUESTO;JUNIO',{||PRS->nPrsJunPrS})
	  oColumn:Cargo := {{'MODI',lModReg},{'ALIAS','PRS'},;
			    {'FIELD','nPrsJunPrS'},{'PICTURE','999999999.99'}}
	  oBrowse:ADDCOLUMN(oColumn)
	*ÀDefinici¢n Columna
       ENDIF

       IF nMesPrs == 7
	  oColumn := TBCOLUMNNEW('PRESUPUESTO;JULIO',{||PRS->nPrsJulPrS})
	  oColumn:Cargo := {{'MODI',lModReg},{'ALIAS','PRS'},;
			    {'FIELD','nPrsJulPrS'},{'PICTURE','999999999.99'}}
	  oBrowse:ADDCOLUMN(oColumn)
	*ÀDefinici¢n Columna
       ENDIF

       IF nMesPrs == 8
	  oColumn := TBCOLUMNNEW('PRESUPUESTO;AGOSTO',{||PRS->nPrsAgoPrS})
	  oColumn:Cargo := {{'MODI',lModReg},{'ALIAS','PRS'},;
			    {'FIELD','nPrsAgoPrS'},{'PICTURE','999999999.99'}}
	  oBrowse:ADDCOLUMN(oColumn)
	*ÀDefinici¢n Columna
       ENDIF

       IF nMesPrs == 9
	  oColumn := TBCOLUMNNEW('PRESUPUESTO;SEPTIEMBRE',{||PRS->nPrsSepPrS})
	  oColumn:Cargo := {{'MODI',lModReg},{'ALIAS','PRS'},;
			    {'FIELD','nPrsSepPrS'},{'PICTURE','999999999.99'}}
	  oBrowse:ADDCOLUMN(oColumn)
	*ÀDefinici¢n Columna
       ENDIF

       IF nMesPrs == 10
	  oColumn := TBCOLUMNNEW('PRESUPUESTO;OCTUBRE',{||PRS->nPrsOctPrS})
	  oColumn:Cargo := {{'MODI',lModReg},{'ALIAS','PRS'},;
			    {'FIELD','nPrsOctPrS'},{'PICTURE','999999999.99'}}
	  oBrowse:ADDCOLUMN(oColumn)
	*ÀDefinici¢n Columna
       ENDIF

       IF nMesPrs == 11
	  oColumn := TBCOLUMNNEW('PRESUPUESTO;NOVIEMBRE',{||PRS->nPrsNovPrS})
	  oColumn:Cargo := {{'MODI',lModReg},{'ALIAS','PRS'},;
			    {'FIELD','nPrsNovPrS'},{'PICTURE','999999999.99'}}
	  oBrowse:ADDCOLUMN(oColumn)
	*ÀDefinici¢n Columna
       ENDIF

       IF nMesPrs == 12
	  oColumn := TBCOLUMNNEW('PRESUPUESTO;DICIEMBRE',{||PRS->nPrsDicPrS})
	  oColumn:Cargo := {{'MODI',lModReg},{'ALIAS','PRS'},;
			    {'FIELD','nPrsDicPrS'},{'PICTURE','999999999.99'}}
	  oBrowse:ADDCOLUMN(oColumn)
	*ÀDefinici¢n Columna
       ENDIF

       oColumn := TBCOLUMNNEW('TOTAL;PRESUPUESTO',{||PRS->nTotPrSPrS})
       oColumn:Cargo := {{'MODI',lModReg},{'ALIAS','PRS'},;
			 {'FIELD','nTotPrSPrS'},{'PICTURE','999999999.99'}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       IF nMesPrs == 1
	  oColumn := TBCOLUMNNEW('EJECUTADO;ENERO',{||PRS->nEjeEnePrS})
	  oColumn:Cargo := {{'MODI',lModReg},{'ALIAS','PRS'},;
			    {'FIELD','nEjeEnePrS'},{'PICTURE','999999999.99'}}
	  oBrowse:ADDCOLUMN(oColumn)
	*ÀDefinici¢n Columna
       ENDIF

       IF nMesPrs == 2
	  oColumn := TBCOLUMNNEW('EJECUTADO;FEBRERO',{||PRS->nEjeFebPrS})
	  oColumn:Cargo := {{'MODI',lModReg},{'ALIAS','PRS'},;
			    {'FIELD','nEjeFebPrS'},{'PICTURE','999999999.99'}}
	  oBrowse:ADDCOLUMN(oColumn)
	*ÀDefinici¢n Columna
       ENDIF

       IF nMesPrs == 3
	  oColumn := TBCOLUMNNEW('EJECUTADO;MARZO',{||PRS->nEjeMarPrS})
	  oColumn:Cargo := {{'MODI',lModReg},{'ALIAS','PRS'},;
			    {'FIELD','nEjeMarPrS'},{'PICTURE','999999999.99'}}
	  oBrowse:ADDCOLUMN(oColumn)
	*ÀDefinici¢n Columna
       ENDIF

       IF nMesPrs == 4
	  oColumn := TBCOLUMNNEW('EJECUTADO;ABRIL',{||PRS->nEjeAbrPrS})
	  oColumn:Cargo := {{'MODI',lModReg},{'ALIAS','PRS'},;
			    {'FIELD','nEjeAbrPrS'},{'PICTURE','999999999.99'}}
	  oBrowse:ADDCOLUMN(oColumn)
	*ÀDefinici¢n Columna
       ENDIF

       IF nMesPrs == 5
	  oColumn := TBCOLUMNNEW('EJECUTADO;MAYO',{||PRS->nEjeMayPrS})
	  oColumn:Cargo := {{'MODI',lModReg},{'ALIAS','PRS'},;
			    {'FIELD','nEjeMayPrS'},{'PICTURE','999999999.99'}}
	  oBrowse:ADDCOLUMN(oColumn)
	*ÀDefinici¢n Columna
       ENDIF

       IF nMesPrs == 6
	  oColumn := TBCOLUMNNEW('EJECUTADO;JUNIO',{||PRS->nEjeJunPrS})
	  oColumn:Cargo := {{'MODI',lModReg},{'ALIAS','PRS'},;
			    {'FIELD','nEjeJunPrS'},{'PICTURE','999999999.99'}}
	  oBrowse:ADDCOLUMN(oColumn)
	*ÀDefinici¢n Columna
       ENDIF

       IF nMesPrs == 7
	  oColumn := TBCOLUMNNEW('EJECUTADO;JULIO',{||PRS->nEjeJulPrS})
	  oColumn:Cargo := {{'MODI',lModReg},{'ALIAS','PRS'},;
			    {'FIELD','nEjeJulPrS'},{'PICTURE','999999999.99'}}
	  oBrowse:ADDCOLUMN(oColumn)
	*ÀDefinici¢n Columna
       ENDIF

       IF nMesPrs == 8
	  oColumn := TBCOLUMNNEW('EJECUTADO;AGOSTO',{||PRS->nEjeAgoPrS})
	  oColumn:Cargo := {{'MODI',lModReg},{'ALIAS','PRS'},;
			    {'FIELD','nEjeAgoPrS'},{'PICTURE','999999999.99'}}
	  oBrowse:ADDCOLUMN(oColumn)
	*ÀDefinici¢n Columna
       ENDIF

       IF nMesPrs == 9
	  oColumn := TBCOLUMNNEW('EJECUTADO;SEPTIEMBRE',{||PRS->nEjeSepPrS})
	  oColumn:Cargo := {{'MODI',lModReg},{'ALIAS','PRS'},;
			    {'FIELD','nEjeSepPrS'},{'PICTURE','999999999.99'}}
	  oBrowse:ADDCOLUMN(oColumn)
	*ÀDefinici¢n Columna
       ENDIF

       IF nMesPrs == 10
	  oColumn := TBCOLUMNNEW('EJECUTADO;OCTUBRE',{||PRS->nEjeOctPrS})
	  oColumn:Cargo := {{'MODI',lModReg},{'ALIAS','PRS'},;
			    {'FIELD','nEjeOctPrS'},{'PICTURE','999999999.99'}}
	  oBrowse:ADDCOLUMN(oColumn)
	*ÀDefinici¢n Columna
       ENDIF

       IF nMesPrs == 11
	  oColumn := TBCOLUMNNEW('EJECUTADO;NOVIEMBRE',{||PRS->nEjeNovPrS})
	  oColumn:Cargo := {{'MODI',lModReg},{'ALIAS','PRS'},;
			    {'FIELD','nEjeNovPrS'},{'PICTURE','999999999.99'}}
	  oBrowse:ADDCOLUMN(oColumn)
	*ÀDefinici¢n Columna
       ENDIF

       IF nMesPrs == 12
	  oColumn := TBCOLUMNNEW('EJECUTADO;DICIEMBRE',{||PRS->nEjeDicPrS})
	  oColumn:Cargo := {{'MODI',lModReg},{'ALIAS','PRS'},;
			    {'FIELD','nEjeDicPrS'},{'PICTURE','999999999.99'}}
	  oBrowse:ADDCOLUMN(oColumn)
	*ÀDefinici¢n Columna
       ENDIF

       oColumn := TBCOLUMNNEW('TOTAL;EJECUTADO',{||PRS->nTotEjePrS})
       oColumn:Cargo := {{'MODI',lModReg},{'ALIAS','PRS'},;
			 {'FIELD','nTotEjePrS'},{'PICTURE','999999999.99'}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn := TBCOLUMNNEW('TOTAL;SALDO',{||PRS->nTotSdoPrS})
       oColumn:Cargo := {{'MODI',lModReg},{'ALIAS','PRS'},;
			 {'FIELD','nTotSdoPrS'},{'PICTURE','999999999.99'}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn := TBCOLUMNNEW('POR %',{||PRS->nPorEjePrS})
       oColumn:Cargo := {{'MODI',lModReg},{'ALIAS','PRS'},;
			 {'FIELD','nPorEjePrS'},{'PICTURE','999.99'}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn := TBCOLUMNNEW('ING %',{||PRS->nPorIngPrS})
       oColumn:Cargo := {{'MODI',lModReg},{'ALIAS','PRS'},;
			 {'FIELD','nPorIngPrS'},{'PICTURE','999.99'}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn	     := TBCOLUMNNEW('NOMBRE;DEL USUARIO',{||PRS->cNomUsrPrS})
       oColumn:Cargo := {{'MODI',.F.}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn	     := TBCOLUMNNEW('FECHA DE;PROCESO',;
				    {||cFecha(PRS->dFecUsrPrS)})
       oColumn:Cargo := {{'MODI',.F.}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn	     := TBCOLUMNNEW('HORA DE;PROCESO',;
				    {||cHoraSys(PRS->cHorUsrPrS)})
       oColumn:Cargo := {{'MODI',.F.}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn	     := TBCOLUMNNEW('CODIGO',{||PRS->nIdeCodPrS})
       oColumn:Cargo := {{'MODI',.F.}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn	     := TBCOLUMNNEW('No.',{||PRS->(RECNO())})
       oColumn:Cargo := {{'MODI',.F.}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       RETURN oBrowse
*>>>>FIN DEFINICION DEL OBJETO BROWSE

/*************************************************************************
* TITULO..: MANTENIMIENTO DEL REGISTRO                                   *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: ABR  6/2005 MIE A
       Colombia, Bucaramanga        INICIO: 11:35 AM   ABR  6/2005 MIE

OBJETIVOS:

1- Permite inclusi¢n,modificaci¢n y consulta del registro

2- Puede invocarse en la lectura a trav‚s de la clausula VALID

2- Returna .T.

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION lManRegPrS(lShared,cNomUsr,nTipMod,oBrowse,cCodPuc,nNroOpc)

*>>>>DESCRIPCION DE PARAMETROS
/*     lShared                              // .T. Archivos Compartidos
       cNomUsr                              // Nombre del Usuario
       nTipMod                              // Tipo de Modificaci¢n. 1 =>Insertar, 2=>Modificar 3=>Consultar
       xCodigo                              // C¢digo a Ingresar, Actualizar
       cTipNit                              // Tipo de Documento
       nNroOpc                              // N£mero de Opci¢n
       oBrowse                              // Browse del Archivo */
*>>>>FIN DESCRIPCION DE PARAMETROS

*>>>>DECLARACION DE VARIABLES
       LOCAL cSavPan := ''                  // Salvar Pantalla

       LOCAL aMenus  := {}                  // Vector de declaracion de men£
       LOCAL aAyuda  := {}                  // Vector de ayudas para el men£

       LOCAL nTipCur := 1                   // Tipo de Cursor
       LOCAL nNroFil := 0                   // N£mero de la fila
       LOCAL nNroCol := 1                   // N£mero de la Columna
       LOCAL nColTem := 0                   // Columna Temporal
       LOCAL nFilIni := 0                   // Fila Inicial

       LOCAL nNroReg := 0                   // N£mero del Registro
       LOCAL lGrabar := .T.                 // .T. Grabar el registro
       LOCAL lInsReg := .F.                 // .T. Insertar el Registro

       LOCAL cTxtTem := ''                  // Texto temporal
       LOCAL cTxtHlp := ''                  // Texto de Ayuda

       LOCAL nPrsEne := 0                // Presupuesto                                                 
       LOCAL nPrsFeb := 0                // Presupuesto                                                 
       LOCAL nPrsMar := 0                // Presupuesto                                                 
       LOCAL nPrsAbr := 0                // Presupuesto                                                 
       LOCAL nPrsMay := 0                // Presupuesto                                                 
       LOCAL nPrsJun := 0                // Presupuesto                                                 
       LOCAL nPrsJul := 0                // Presupuesto                                                 
       LOCAL nPrsAgo := 0                // Presupuesto                                                 
       LOCAL nPrsSep := 0                // Presupuesto                                                 
       LOCAL nPrsOct := 0                // Presupuesto                                                 
       LOCAL nPrsNov := 0                // Presupuesto                                                 
       LOCAL nPrsDic := 0                // Presupuesto                                                 
       LOCAL nTotPrS := 0                // Presupuesto                                                 
       LOCAL nEjeEne := 0                // Ejecutado                                                   
       LOCAL nEjeFeb := 0                // Ejecutado                                                   
       LOCAL nEjeMar := 0                // Ejecutado                                                   
       LOCAL nEjeAbr := 0                // Ejecutado                                                   
       LOCAL nEjeMay := 0                // Ejecutado                                                   
       LOCAL nEjeJun := 0                // Ejecutado                                                   
       LOCAL nEjeJul := 0                // Ejecutado                                                   
       LOCAL nEjeAgo := 0                // Ejecutado                                                   
       LOCAL nEjeSep := 0                // Ejecutado                                                   
       LOCAL nEjeOct := 0                // Ejecutado                                                   
       LOCAL nEjeNov := 0                // Ejecutado                                                   
       LOCAL nEjeDic := 0                // Ejecutado                                                   
       LOCAL nTotEje := 0                // Ejecutado                                                   
       LOCAL nTotSdo := 0                // Saldo                                                       
       LOCAL nPorEje := 0                // Porcentaje Ejecutado                                        
       LOCAL nPorIng := 0                // Porcentaje respecto ingreso                                 

       LOCAL GetList := {}                 // Variable del sistema
*>>>>FIN DECLARACION DE VARIABLES

*>>>>DECLARACION DEL MENU
       nTipMod := IF(nTipMod==NIL,1,nTipMod)

       AADD(aMenus,'1<INFORMACION BASICA>')

       AADD(aAyuda,IF(nTipMod==3,'Consulta','Actualiza')+' '+;
                   'la Informaci¢n B sica.')

       cSavPan := SAVESCREEN(0,0,24,79)
       nNroOpc := IF(nNroOpc==NIL,1,nNroOpc)
       IF EMPTY(nNroOpc)

          cSavPan := SAVESCREEN(0,0,24,79)
          nNroOpc := 1
          nNroOpc := nMenu(aMenus,aAyuda,10,25,;
                           IF(nTipMod==3,'CONSULTAR','ACTUALIZAR'),NIL,1,.F.)
          RESTSCREEN(0,0,24,79,cSavPan)

          IF nNroOpc == 0
             RETURN NIL
          ENDIF

       ENDIF
*>>>>FIN DECLARACION DEL MENU

*>>>>VALIDACION DE LA INFORMACION BASICA
       IF nNroOpc # 1
          IF EMPTY(nNroOpc) // Ojo
             cError('PRIMERO DEBE ESTAR ACTUALIZADA LA INFORMACION BASICA')
             RETURN NIL
          ENDIF
       ENDIF
*>>>>FIN VALIDACION DE LA INFORMACION BASICA

*>>>>MARCO DEL MANTENIMIENTO
       nTipCur := SETCURSOR()
       DO CASE
       CASE nTipMod == 1
            cTxtTem := 'PRESUPUESTO .INCLUIR. '+aMenus[nNroOpc]
            PRS->(DBGOBOTTOM())
            PRS->(DBSKIP())
            nTipCur := SETCURSOR(1)

       CASE nTipMod == 2
            cTxtTem := 'PRESUPUESTO .ACTUALIZAR. '+aMenus[nNroOpc]
            nTipCur := SETCURSOR(1)

       CASE nTipMod == 3
            cTxtTem := 'PRESUPUESTO. CONSUTA. '+aMenus[nNroOpc]
       ENDCASE
       nFilIni := nMarco(03,cTxtTem,22,'°')
*>>>>FIN MARCO DEL MANTENIMIENTO

*>>>>MANTENIMIENTO DEL REGISTRO
       SELECT PRS
       DO WHILE .T.

**********INICIALIZACION DE LAS VARIABLES
            IF lGrabar

               IF EMPTY(cCodPuc)
                  cCodPuc := PRS->cCodPucPrS
               ENDIF

               nPrsEne := PRS->nPrsEnePrS
               nPrsFeb := PRS->nPrsFebPrS
               nPrsMar := PRS->nPrsMarPrS
               nPrsAbr := PRS->nPrsAbrPrS
               nPrsMay := PRS->nPrsMayPrS
               nPrsJun := PRS->nPrsJunPrS
               nPrsJul := PRS->nPrsJulPrS
               nPrsAgo := PRS->nPrsAgoPrS
               nPrsSep := PRS->nPrsSepPrS
               nPrsOct := PRS->nPrsOctPrS
               nPrsNov := PRS->nPrsNovPrS
               nPrsDic := PRS->nPrsDicPrS
               nTotPrS := PRS->nTotPrSPrS
               nEjeEne := PRS->nEjeEnePrS
               nEjeFeb := PRS->nEjeFebPrS
               nEjeMar := PRS->nEjeMarPrS
               nEjeAbr := PRS->nEjeAbrPrS
               nEjeMay := PRS->nEjeMayPrS
               nEjeJun := PRS->nEjeJunPrS
               nEjeJul := PRS->nEjeJulPrS
               nEjeAgo := PRS->nEjeAgoPrS
               nEjeSep := PRS->nEjeSepPrS
               nEjeOct := PRS->nEjeOctPrS
               nEjeNov := PRS->nEjeNovPrS
               nEjeDic := PRS->nEjeDicPrS
               nTotEje := PRS->nTotEjePrS
               nTotSdo := PRS->nTotSdoPrS
               nPorEje := PRS->nPorEjePrS
               nPorIng := PRS->nPorIngPrS
            ENDIF
**********FIN INICIALIZACION DE LAS VARIABLES

**********LECTURA DE CAMPO
            IF nNroOpc == 1

               nNroFil := nFilIni
               cTxtTem := 'CODIGO DEL PUC        :'

               IF nTipMod == 2 .OR. nTipMod == 3 .OR. !EMPTY(cCodPuc)
                  @ nNroFil,nNroCol SAY cTxtTem
                  @ nNroFil,nNroCol+LEN(cTxtTem)+1 SAY cCodPuc COLOR('I')
               ELSE
                  @ nNroFil,nNroCol SAY cTxtTem;
                                    GET cCodPuc PICT '99999999999999999999';
                                    VALID !EMPTY(cCodPuc) .AND.;
                                          !lValCodPrS(cCodPuc)
               ENDIF

	    ENDIF
**********FIN LECTURA DE CAMPO

**********LECTURA DE CAMPO
            IF nNroOpc == 1

               nNroFil++
               nColTem := nNroCol
               cTxtTem := 'PRESUPUESTO ENERO     :'

               IF nTipMod == 3
                  @ nNroFil,nColTem SAY cTxtTem
                  @ nNroFil,nColTem+LEN(cTxtTem)+1 SAY nPrsEne COLOR('I')
               ELSE
                  @ nNroFil,nColTem SAY cTxtTem;
                                    GET nPrsEne PICT '999999999.99';
                                    WHEN {||HelpRead('FAVOR INGRESE EL VALOR PRESUPUESTADO DE ENERO')}
               ENDIF

	    ENDIF
**********FIN LECTURA DE CAMPO

**********LECTURA DE CAMPO
            IF nNroOpc == 1

               nNroFil++
               nColTem := nNroCol
               cTxtTem := 'PRESUPUESTO FEBRERO   :'

               IF nTipMod == 3
                  @ nNroFil,nColTem SAY cTxtTem
                  @ nNroFil,nColTem+LEN(cTxtTem)+1 SAY nPrsFeb COLOR('I')
               ELSE
                  @ nNroFil,nColTem SAY cTxtTem;
                                    GET nPrsFeb PICT '999999999.99';
                                    WHEN {||HelpRead('FAVOR INGRESE EL VALOR PRESUPUESTADO DE FEBRERO')}
               ENDIF

	    ENDIF
**********FIN LECTURA DE CAMPO

**********LECTURA DE CAMPO
            IF nNroOpc == 1

               nNroFil++
               nColTem := nNroCol
               cTxtTem := 'PRESUPUESTO MARZO     :'

               IF nTipMod == 3
                  @ nNroFil,nColTem SAY cTxtTem
                  @ nNroFil,nColTem+LEN(cTxtTem)+1 SAY nPrsMar COLOR('I')
               ELSE
                  @ nNroFil,nColTem SAY cTxtTem;
                                    GET nPrsMar PICT '999999999.99';
                                    WHEN {||HelpRead('FAVOR INGRESE EL VALOR PRESUPUESTADO DE MARZO')}
               ENDIF

	    ENDIF
**********FIN LECTURA DE CAMPO

**********LECTURA DE CAMPO
            IF nNroOpc == 1

               nNroFil++
               nColTem := nNroCol
               cTxtTem := 'PRESUPUESTO ABRIL     :'

               IF nTipMod == 3
                  @ nNroFil,nColTem SAY cTxtTem
                  @ nNroFil,nColTem+LEN(cTxtTem)+1 SAY nPrsAbr COLOR('I')
               ELSE
                  @ nNroFil,nColTem SAY cTxtTem;
                                    GET nPrsAbr PICT '999999999.99';
                                    WHEN {||HelpRead('FAVOR INGRESE EL VALOR PRESUPUESTADO DE ABRIL')}
               ENDIF

	    ENDIF
**********FIN LECTURA DE CAMPO

**********LECTURA DE CAMPO
            IF nNroOpc == 1

               nNroFil++
               nColTem := nNroCol
               cTxtTem := 'PRESUPUESTO MAYO      :'

               IF nTipMod == 3
                  @ nNroFil,nColTem SAY cTxtTem
                  @ nNroFil,nColTem+LEN(cTxtTem)+1 SAY nPrsMay COLOR('I')
               ELSE
                  @ nNroFil,nColTem SAY cTxtTem;
                                    GET nPrsMay PICT '999999999.99';
                                    WHEN {||HelpRead('FAVOR INGRESE EL VALOR PRESUPUESTADO DE MAYO')}
               ENDIF

	    ENDIF
**********FIN LECTURA DE CAMPO

**********LECTURA DE CAMPO
            IF nNroOpc == 1

               nNroFil++
               nColTem := nNroCol
               cTxtTem := 'PRESUPUESTO JUNIO     :'

               IF nTipMod == 3
                  @ nNroFil,nColTem SAY cTxtTem
                  @ nNroFil,nColTem+LEN(cTxtTem)+1 SAY nPrsJun COLOR('I')
               ELSE
                  @ nNroFil,nColTem SAY cTxtTem;
                                    GET nPrsJun PICT '999999999.99';
                                    WHEN {||HelpRead('FAVOR INGRESE EL VALOR PRESUPUESTADO DE JUNIO')}
               ENDIF

	    ENDIF
**********FIN LECTURA DE CAMPO

**********LECTURA DE CAMPO
            IF nNroOpc == 1

               nNroFil++
               nColTem := nNroCol
               cTxtTem := 'PRESUPUESTO JULIO     :'

               IF nTipMod == 3
                  @ nNroFil,nColTem SAY cTxtTem
                  @ nNroFil,nColTem+LEN(cTxtTem)+1 SAY nPrsJul COLOR('I')
               ELSE
                  @ nNroFil,nColTem SAY cTxtTem;
                                    GET nPrsJul PICT '999999999.99';
                                    WHEN {||HelpRead('FAVOR INGRESE EL VALOR PRESUPUESTADO DE JULIO')}
               ENDIF

	    ENDIF
**********FIN LECTURA DE CAMPO

**********LECTURA DE CAMPO
            IF nNroOpc == 1

               nNroFil++
               nColTem := nNroCol
               cTxtTem := 'PRESUPUESTO AGOSTO    :'

               IF nTipMod == 3
                  @ nNroFil,nColTem SAY cTxtTem
                  @ nNroFil,nColTem+LEN(cTxtTem)+1 SAY nPrsAgo COLOR('I')
               ELSE
                  @ nNroFil,nColTem SAY cTxtTem;
                                    GET nPrsAgo PICT '999999999.99';
                                    WHEN {||HelpRead('FAVOR INGRESE EL VALOR PRESUPUESTADO DE AGOSTO')}
               ENDIF

	    ENDIF
**********FIN LECTURA DE CAMPO

**********LECTURA DE CAMPO
            IF nNroOpc == 1

               nNroFil++
               nColTem := nNroCol
               cTxtTem := 'PRESUPUESTO SEPTIEMBRE:'

               IF nTipMod == 3
                  @ nNroFil,nColTem SAY cTxtTem
                  @ nNroFil,nColTem+LEN(cTxtTem)+1 SAY nPrsSep COLOR('I')
               ELSE
                  @ nNroFil,nColTem SAY cTxtTem;
                                    GET nPrsSep PICT '999999999.99';
                                    WHEN {||HelpRead('FAVOR INGRESE EL VALOR PRESUPUESTADO DE SEPTIEMBRE')}
               ENDIF

	    ENDIF
**********FIN LECTURA DE CAMPO

**********LECTURA DE CAMPO
            IF nNroOpc == 1

               nNroFil++
               nColTem := nNroCol
               cTxtTem := 'PRESUPUESTO OCTUBRE   :'

               IF nTipMod == 3
                  @ nNroFil,nColTem SAY cTxtTem
                  @ nNroFil,nColTem+LEN(cTxtTem)+1 SAY nPrsOct COLOR('I')
               ELSE
                  @ nNroFil,nColTem SAY cTxtTem;
                                    GET nPrsOct PICT '999999999.99';
                                    WHEN {||HelpRead('FAVOR INGRESE EL VALOR PRESUPUESTADO DE OCTUBRE')}
               ENDIF

	    ENDIF
**********FIN LECTURA DE CAMPO

**********LECTURA DE CAMPO
            IF nNroOpc == 1

               nNroFil++
               nColTem := nNroCol
               cTxtTem := 'PRESUPUESTO NOVIEMBRE :'

               IF nTipMod == 3
                  @ nNroFil,nColTem SAY cTxtTem
                  @ nNroFil,nColTem+LEN(cTxtTem)+1 SAY nPrsNov COLOR('I')
               ELSE
                  @ nNroFil,nColTem SAY cTxtTem;
                                    GET nPrsNov PICT '999999999.99';
                                    WHEN {||HelpRead('FAVOR INGRESE EL VALOR PRESUPUESTADO DE NOVIEMBRE')}
               ENDIF

	    ENDIF
**********FIN LECTURA DE CAMPO

**********LECTURA DE CAMPO
            IF nNroOpc == 1

               nNroFil++
               nColTem := nNroCol
               cTxtTem := 'PRESUPUESTO DICIEMBRE :'

               IF nTipMod == 3
                  @ nNroFil,nColTem SAY cTxtTem
                  @ nNroFil,nColTem+LEN(cTxtTem)+1 SAY nPrsDic COLOR('I')
               ELSE
                  @ nNroFil,nColTem SAY cTxtTem;
                                    GET nPrsDic PICT '999999999.99';
                                    WHEN {||HelpRead('FAVOR INGRESE EL VALOR PRESUPUESTADO DE DICIEMBRE')}
               ENDIF

	    ENDIF
**********FIN LECTURA DE CAMPO

**********LECTURA DE CAMPO
            IF nNroOpc == 1

               nNroFil++
               nColTem := nNroCol
               cTxtTem := 'TOTAL PRESUPUESTO     :'

               IF nTipMod == 3
                  @ nNroFil,nColTem SAY cTxtTem
                  @ nNroFil,nColTem+LEN(cTxtTem)+1 SAY nTotPrS COLOR('I')
               ELSE
                  @ nNroFil,nColTem SAY cTxtTem;
                                    GET nTotPrS PICT '999999999.99';
                                    VALID !EMPTY(nTotPrS);
                                    WHEN {||HelpRead('FAVOR INGRESE EL VALOR TOTAL DEL PRESUPUESTO')}
               ENDIF

	    ENDIF
**********FIN LECTURA DE CAMPO

**********LECTURA DE CAMPO
            IF nNroOpc == 1

               nNroFil++
               nColTem := nNroCol
               cTxtTem := 'EJECUTADO ENERO       :'

               IF nTipMod == 3
                  @ nNroFil,nColTem SAY cTxtTem
                  @ nNroFil,nColTem+LEN(cTxtTem)+1 SAY nEjeEne COLOR('I')
               ELSE
                  @ nNroFil,nColTem SAY cTxtTem;
                                    GET nEjeEne PICT '999999999.99';
                                    WHEN {||HelpRead('FAVOR INGRESE EL VALOR EJECUTADO DE ENERO')}
               ENDIF

	    ENDIF
**********FIN LECTURA DE CAMPO

**********LECTURA DE CAMPO
            IF nNroOpc == 1

               nNroFil++
               nColTem := nNroCol
               cTxtTem := 'EJECUTADO FEBRERO     :'

               IF nTipMod == 3
                  @ nNroFil,nColTem SAY cTxtTem
                  @ nNroFil,nColTem+LEN(cTxtTem)+1 SAY nEjeFeb COLOR('I')
               ELSE
                  @ nNroFil,nColTem SAY cTxtTem;
                                    GET nEjeFeb PICT '999999999.99';
                                    WHEN {||HelpRead('FAVOR INGRESE EL VALOR EJECUTADO DE FEBRERO')}
               ENDIF

	    ENDIF
**********FIN LECTURA DE CAMPO

**********LECTURA DE CAMPO
            IF nNroOpc == 1

               nNroFil++
               nColTem := nNroCol
               cTxtTem := 'EJECUTADO MARZO       :'

               IF nTipMod == 3
                  @ nNroFil,nColTem SAY cTxtTem
                  @ nNroFil,nColTem+LEN(cTxtTem)+1 SAY nEjeMar COLOR('I')
               ELSE
                  @ nNroFil,nColTem SAY cTxtTem;
                                    GET nEjeMar PICT '999999999.99';
                                    WHEN {||HelpRead('FAVOR INGRESE EL VALOR EJECUTADO DE MARZO')}
               ENDIF

	    ENDIF
**********FIN LECTURA DE CAMPO

**********LECTURA DE CAMPO
            IF nNroOpc == 1

               nNroFil++
               nColTem := nNroCol
               cTxtTem := 'EJECUTADO ABRIL       :'

               IF nTipMod == 3
                  @ nNroFil,nColTem SAY cTxtTem
                  @ nNroFil,nColTem+LEN(cTxtTem)+1 SAY nEjeAbr COLOR('I')
               ELSE
                  @ nNroFil,nColTem SAY cTxtTem;
                                    GET nEjeAbr PICT '999999999.99';
                                    WHEN {||HelpRead('FAVOR INGRESE EL VALOR EJECUTADO DE ABRIL')}
               ENDIF

	    ENDIF
**********FIN LECTURA DE CAMPO

**********LECTURA DE CAMPO
            IF nNroOpc == 1

               nNroFil++
               nColTem := nNroCol
               cTxtTem := 'EJECUTADO MAYO        :'

               IF nTipMod == 3
                  @ nNroFil,nColTem SAY cTxtTem
                  @ nNroFil,nColTem+LEN(cTxtTem)+1 SAY nEjeMay COLOR('I')
               ELSE
                  @ nNroFil,nColTem SAY cTxtTem;
                                    GET nEjeMay PICT '999999999.99';
                                    WHEN {||HelpRead('FAVOR INGRESE EL VALOR EJECUTADO DE MAYO')}
               ENDIF

	    ENDIF
**********FIN LECTURA DE CAMPO

**********LECTURA DE CAMPO
            IF nNroOpc == 1

               nNroFil++
               nColTem := nNroCol
               cTxtTem := 'EJECUTADO JUNIO       :'

               IF nTipMod == 3
                  @ nNroFil,nColTem SAY cTxtTem
                  @ nNroFil,nColTem+LEN(cTxtTem)+1 SAY nEjeJun COLOR('I')
               ELSE
                  @ nNroFil,nColTem SAY cTxtTem;
                                    GET nEjeJun PICT '999999999.99';
                                    WHEN {||HelpRead('FAVOR INGRESE EL VALOR EJECUTADO DE JUNIO')}
               ENDIF

	    ENDIF
**********FIN LECTURA DE CAMPO

**********LECTURA DE CAMPO
            IF nNroOpc == 1

               nNroFil++
               nColTem := nNroCol
               cTxtTem := 'EJECUTADO JULIO       :'

               IF nTipMod == 3
                  @ nNroFil,nColTem SAY cTxtTem
                  @ nNroFil,nColTem+LEN(cTxtTem)+1 SAY nEjeJul COLOR('I')
               ELSE
                  @ nNroFil,nColTem SAY cTxtTem;
                                    GET nEjeJul PICT '999999999.99';
                                    WHEN {||HelpRead('FAVOR INGRESE EL VALOR EJECUTADO DE JULIO')}
               ENDIF

	    ENDIF
**********FIN LECTURA DE CAMPO

**********LECTURA DE CAMPO
            IF nNroOpc == 1

               nNroFil++
               nColTem := nNroCol
               cTxtTem := 'EJECUTADO AGOSTO      :'

               IF nTipMod == 3
                  @ nNroFil,nColTem SAY cTxtTem
                  @ nNroFil,nColTem+LEN(cTxtTem)+1 SAY nEjeAgo COLOR('I')
               ELSE
                  @ nNroFil,nColTem SAY cTxtTem;
                                    GET nEjeAgo PICT '999999999.99';
                                    WHEN {||HelpRead('FAVOR INGRESE EL VALOR EJECUTADO DE AGOSTO')}
               ENDIF

	    ENDIF
**********FIN LECTURA DE CAMPO

**********LECTURA DE CAMPO
            IF nNroOpc == 1

               nNroFil++
               nColTem := nNroCol
               cTxtTem := 'EJECUTADO SEPTIEMBRE  :'

               IF nTipMod == 3
                  @ nNroFil,nColTem SAY cTxtTem
                  @ nNroFil,nColTem+LEN(cTxtTem)+1 SAY nEjeSep COLOR('I')
               ELSE
                  @ nNroFil,nColTem SAY cTxtTem;
                                    GET nEjeSep PICT '999999999.99';
                                    WHEN {||HelpRead('FAVOR INGRESE EL VALOR EJECUTADO DE SEPTIEMBRE')}
               ENDIF

	    ENDIF
**********FIN LECTURA DE CAMPO

**********LECTURA DE CAMPO
            IF nNroOpc == 1

               nNroFil++
               nColTem := nNroCol
               cTxtTem := 'EJECUTADO OCTUBRE     :'

               IF nTipMod == 3
                  @ nNroFil,nColTem SAY cTxtTem
                  @ nNroFil,nColTem+LEN(cTxtTem)+1 SAY nEjeOct COLOR('I')
               ELSE
                  @ nNroFil,nColTem SAY cTxtTem;
                                    GET nEjeOct PICT '999999999.99';
                                    WHEN {||HelpRead('FAVOR INGRESE EL VALOR EJECUTADO DE OCTUBRE')}
               ENDIF

	    ENDIF
**********FIN LECTURA DE CAMPO

**********LECTURA DE CAMPO
            IF nNroOpc == 1

               nNroFil++
               nColTem := nNroCol
               cTxtTem := 'EJECUTADO NOVIEMBRE   :'

               IF nTipMod == 3
                  @ nNroFil,nColTem SAY cTxtTem
                  @ nNroFil,nColTem+LEN(cTxtTem)+1 SAY nEjeNov COLOR('I')
               ELSE
                  @ nNroFil,nColTem SAY cTxtTem;
                                    GET nEjeNov PICT '999999999.99';
                                    WHEN {||HelpRead('FAVOR INGRESE EL VALOR EJECUTADO DE NOVIEMBRE')}
               ENDIF

	    ENDIF
**********FIN LECTURA DE CAMPO

**********LECTURA DE CAMPO
            IF nNroOpc == 1

               nNroFil++
               nColTem := nNroCol
               cTxtTem := 'EJECUTADO DICIEMBRE   :'

               IF nTipMod == 3
                  @ nNroFil,nColTem SAY cTxtTem
                  @ nNroFil,nColTem+LEN(cTxtTem)+1 SAY nEjeDic COLOR('I')
               ELSE
                  @ nNroFil,nColTem SAY cTxtTem;
                                    GET nEjeDic PICT '999999999.99';
                                    WHEN {||HelpRead('FAVOR INGRESE EL VALOR EJECUTADO DE DICIEMBRE')}
               ENDIF

	    ENDIF
**********FIN LECTURA DE CAMPO

**********LECTURA DE CAMPO
            IF nNroOpc == 1

               nNroFil++
               nColTem := nNroCol
               cTxtTem := 'TOTAL EJECUTADO       :'

               IF nTipMod == 3
                  @ nNroFil,nColTem SAY cTxtTem
                  @ nNroFil,nColTem+LEN(cTxtTem)+1 SAY nTotEje COLOR('I')
               ELSE
                  @ nNroFil,nColTem SAY cTxtTem;
                                    GET nTotEje PICT '999999999.99';
                                    VALID !EMPTY(nTotEje);
                                    WHEN {||HelpRead('FAVOR INGRESE EL VALOR TOTAL EJECUTADO')}
               ENDIF

	    ENDIF
**********FIN LECTURA DE CAMPO

**********LECTURA DE CAMPO
            IF nNroOpc == 1

               nNroFil++
               nColTem := nNroCol
               cTxtTem := 'TOTAL SALDO           :'

               IF nTipMod == 3
                  @ nNroFil,nColTem SAY cTxtTem
                  @ nNroFil,nColTem+LEN(cTxtTem)+1 SAY nTotSdo COLOR('I')
               ELSE
                  @ nNroFil,nColTem SAY cTxtTem;
                                    GET nTotSdo PICT '999999999.99';
                                    VALID !EMPTY(nTotSdo);
                                    WHEN {||HelpRead('FAVOR INGRESE EL VALOR TOTAL DEL SALDO')}
               ENDIF

	    ENDIF
**********FIN LECTURA DE CAMPO

**********LECTURA DE CAMPO
            IF nNroOpc == 1

               nNroFil++
               nColTem := nNroCol
               cTxtTem := 'POR %                 :'

               IF nTipMod == 3
                  @ nNroFil,nColTem SAY cTxtTem
                  @ nNroFil,nColTem+LEN(cTxtTem)+1 SAY nPorEje COLOR('I')
               ELSE
                  @ nNroFil,nColTem SAY cTxtTem;
                                    GET nPorEje PICT '999.99';
                                    VALID !EMPTY(nPorEje);
                                    WHEN {||HelpRead('FAVOR INGRESE EL PORCENTAJE EJECUTADO')}
               ENDIF

	    ENDIF
**********FIN LECTURA DE CAMPO

**********LECTURA DE CAMPO
            IF nNroOpc == 1

               nNroFil++
               nColTem := nNroCol
               cTxtTem := 'ING %                 :'

               IF nTipMod == 3
                  @ nNroFil,nColTem SAY cTxtTem
                  @ nNroFil,nColTem+LEN(cTxtTem)+1 SAY nPorIng COLOR('I')
               ELSE
                  @ nNroFil,nColTem SAY cTxtTem;
                                    GET nPorIng PICT '999.99';
                                    WHEN {||HelpRead('FAVOR INGRESE EL PORCENTAJE RESPECTO EL INGRESO')}
               ENDIF

	    ENDIF
**********FIN LECTURA DE CAMPO

**********LECTURA DE LOS CAMPOS
            IF nTipMod == 3
               cPausa()
               EXIT
            ELSE
               READ
            ENDIF
**********FIN LECTURA DE LOS CAMPOS

**********PREGUNTA DE DECISION
            DO CASE
            CASE LASTKEY() # K_ESC .AND. nTipMod # 3
                 IF !lPregunta('DESEA GRABAR? Si No')
                    lGrabar := .F.
                    LOOP
                 ELSE
                    lGrabar := .T.
                    EXIT
                 ENDIF

            CASE LASTKEY() == K_ESC
                 lGrabar := .F.
                 IF !lPregunta('DESEA ABANDONAR? Si No')
                    LOOP
                 ENDIF
                 EXIT
            ENDCASE
**********FIN PREGUNTA DE DECISION

       ENDDO
*>>>>FIN MANTENIMIENTO DEL REGISTRO

*>>>>GRABACION DEL REGISTRO
       SELECT PRS
       IF nTipMod # 3 .AND. lGrabar

          lInsReg := IF(nTipMod == 1,.T.,.F.)
          IF PRS->(lRegLock(lShared,lInsReg))

             IF lInsReg
                REPL PRS->nIdeCodPrS WITH PRS->(RECNO())
                REPL PRS->cCodPucPrS WITH cCodPuc
             ENDIF

             REPL PRS->nPrsEnePrS WITH nPrsEne
             REPL PRS->nPrsFebPrS WITH nPrsFeb
             REPL PRS->nPrsMarPrS WITH nPrsMar
             REPL PRS->nPrsAbrPrS WITH nPrsAbr
             REPL PRS->nPrsMayPrS WITH nPrsMay
             REPL PRS->nPrsJunPrS WITH nPrsJun
             REPL PRS->nPrsJulPrS WITH nPrsJul
             REPL PRS->nPrsAgoPrS WITH nPrsAgo
             REPL PRS->nPrsSepPrS WITH nPrsSep
             REPL PRS->nPrsOctPrS WITH nPrsOct
             REPL PRS->nPrsNovPrS WITH nPrsNov
             REPL PRS->nPrsDicPrS WITH nPrsDic
             REPL PRS->nTotPrSPrS WITH nTotPrS
             REPL PRS->nEjeEnePrS WITH nEjeEne
             REPL PRS->nEjeFebPrS WITH nEjeFeb
             REPL PRS->nEjeMarPrS WITH nEjeMar
             REPL PRS->nEjeAbrPrS WITH nEjeAbr
             REPL PRS->nEjeMayPrS WITH nEjeMay
             REPL PRS->nEjeJunPrS WITH nEjeJun
             REPL PRS->nEjeJulPrS WITH nEjeJul
             REPL PRS->nEjeAgoPrS WITH nEjeAgo
             REPL PRS->nEjeSepPrS WITH nEjeSep
             REPL PRS->nEjeOctPrS WITH nEjeOct
             REPL PRS->nEjeNovPrS WITH nEjeNov
             REPL PRS->nEjeDicPrS WITH nEjeDic
             REPL PRS->nTotEjePrS WITH nTotEje
             REPL PRS->nTotSdoPrS WITH nTotSdo
             REPL PRS->nPorEjePrS WITH nPorEje
             REPL PRS->nPorIngPrS WITH nPorIng

             REPL PRS->cNomUsrPrS WITH cNomUsr
             REPL PRS->dFecUsrPrS WITH DATE()
             REPL PRS->cHorUsrPrS WITH TIME()
             PRS->(DBCOMMIT())
          ENDIF

          IF lShared
             PRS->(DBUNLOCK())
          ENDIF

       ENDIF
       RESTSCREEN(0,0,24,79,cSavPan)
       SETCURSOR(nTipCur)
*>>>>FIN GRABACION DEL REGISTRO

*>>>>REFRESCAR EL BROWSE
       IF nTipMod == 2
          nNroReg := PRS->(RECNO())
          PRS->(DBGOTOP())
          oBrowse:GOTOP()
          PRS->(DBGOTO(nNroReg))
          oBrowse:FORCESTABLE()
       ENDIF
       RETURN .T.
*>>>>FIN REFRESCAR EL BROWSE

/*************************************************************************
* TITULO..: MENU DE OTROS PARA EL ARCHIVO                                *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: ABR  6/2005 MIE A
       Colombia, Bucaramanga        INICIO: 11:35 AM   ABR  6/2005 MIE

OBJETIVOS:

1- Menu de Otros para el archivo

2- Retorna NIL

SINTAXIS:

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION MenuOtrPrS(lShared,nModCry,cNomSis,cCodEmp,cNitEmp,cEmpPal,;
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
       aArchvo                              // Archivo en Uso
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
       AADD(aMenus,'1<PRESUPUESTO>')

       aAyuda := {}
       AADD(aAyuda,'Imprime los Detalles del Archivo')

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
            OtrPrS011(lShared,nModCry,cNomSis,cCodEmp,cNitEmp,cEmpPal,;
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

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: ABR  6/2005 MIE A
       Colombia, Bucaramanga        INICIO: 11:35 AM   ABR  6/2005 MIE

OBJETIVOS:

1- Imprime los campos del archivo de mantenimiento

2- Retorna NIL

SINTAXIS:

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION OtrPrS011(lShared,nModCry,cNomSis,cCodEmp,cNitEmp,cEmpPal,;
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
       LOCAL cSavPan := ''                  // Salvar Pantalla
     *ÀVariables generales

       LOCAL FilePrn := ''                  // Archivo de impresion
       LOCAL nRegPrn := 0                   // Registro de Impresi¢n
       LOCAL nHanXml := 0                   // Manejador del Archivo
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
          FilePrn := 'PrS'
          nOpcPrn := nPrinter_On(cNomUsr,@FilePrn,cOpcPrn,.F.,.T.)
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
                   'PRESUPUESTO',;
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

       AADD(aNroCol,20)
       AADD(aTitPrn,'CUENTA')

       AADD(aNroCol,14)
       AADD(aTitPrn,'P ENERO')

       AADD(aNroCol,14)
       AADD(aTitPrn,'P FEBRERO')

       AADD(aNroCol,14)
       AADD(aTitPrn,'P MARZO')

       AADD(aNroCol,14)
       AADD(aTitPrn,'P ABRIL')

       AADD(aNroCol,14)
       AADD(aTitPrn,'P MAYO')

       AADD(aNroCol,14)
       AADD(aTitPrn,'P JUNIO')

       AADD(aNroCol,14)
       AADD(aTitPrn,'P JULIO')

       AADD(aNroCol,14)
       AADD(aTitPrn,'P AGOSTO')

       AADD(aNroCol,14)
       AADD(aTitPrn,'P SEPTIEMBRE')

       AADD(aNroCol,14)
       AADD(aTitPrn,'P OCTUBRE')

       AADD(aNroCol,14)
       AADD(aTitPrn,'P NOVIEMBRE')

       AADD(aNroCol,14)
       AADD(aTitPrn,'P DICIEMBRE')

       AADD(aNroCol,14)
       AADD(aTitPrn,'PRESUPUESTO')

       AADD(aNroCol,14)
       AADD(aTitPrn,'E ENERO')

       AADD(aNroCol,14)
       AADD(aTitPrn,'E FEBRERO')

       AADD(aNroCol,14)
       AADD(aTitPrn,'E MARZO')

       AADD(aNroCol,14)
       AADD(aTitPrn,'E ABRIL')

       AADD(aNroCol,14)
       AADD(aTitPrn,'E MAYO')

       AADD(aNroCol,14)
       AADD(aTitPrn,'E JUNIO')

       AADD(aNroCol,14)
       AADD(aTitPrn,'E JULIO')

       AADD(aNroCol,14)
       AADD(aTitPrn,'E AGOSTO')

       AADD(aNroCol,14)
       AADD(aTitPrn,'E SEPTIEMBRE')

       AADD(aNroCol,14)
       AADD(aTitPrn,'E OCTUBRE')

       AADD(aNroCol,14)
       AADD(aTitPrn,'E NOVIEMBRE')

       AADD(aNroCol,14)
       AADD(aTitPrn,'E DICIEMBRE')

       AADD(aNroCol,14)
       AADD(aTitPrn,'EJECUTADO')

       AADD(aNroCol,14)
       AADD(aTitPrn,'TOTAL SALDO')

       AADD(aNroCol,14)
       AADD(aTitPrn,'POR %')

       AADD(aNroCol,14)
       AADD(aTitPrn,'ING %')

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

       SELECT PRS
       PRS->(DBGOTOP())
       DO WHILE .NOT. PRS->(EOF())

**********VISUALIZACION DE AVANCE
            nAvance := INT(( PRS->(RECNO()) / PRS->(RECCOUNT()) )*100)

            IF STR(nAvance,3) $ '25 50 75100'
               SET DEVICE TO SCREEN
               Termometro(nAvance)
               SET DEVICE TO PRINT
            ENDIF
**********FIN VISUALIZACION DE AVANCE

**********IMPRESION DEL REGISTRO
            aRegPrn := {}
            AADD(aRegPrn,PRS->cCodPucPrS)
            AADD(aRegPrn,TRANS(PRS->nPrsEnePrS,'###,###,###.99'))
            AADD(aRegPrn,TRANS(PRS->nPrsFebPrS,'###,###,###.99'))
            AADD(aRegPrn,TRANS(PRS->nPrsMarPrS,'###,###,###.99'))
            AADD(aRegPrn,TRANS(PRS->nPrsAbrPrS,'###,###,###.99'))
            AADD(aRegPrn,TRANS(PRS->nPrsMayPrS,'###,###,###.99'))
            AADD(aRegPrn,TRANS(PRS->nPrsJunPrS,'###,###,###.99'))
            AADD(aRegPrn,TRANS(PRS->nPrsJulPrS,'###,###,###.99'))
            AADD(aRegPrn,TRANS(PRS->nPrsAgoPrS,'###,###,###.99'))
            AADD(aRegPrn,TRANS(PRS->nPrsSepPrS,'###,###,###.99'))
            AADD(aRegPrn,TRANS(PRS->nPrsOctPrS,'###,###,###.99'))
            AADD(aRegPrn,TRANS(PRS->nPrsNovPrS,'###,###,###.99'))
            AADD(aRegPrn,TRANS(PRS->nPrsDicPrS,'###,###,###.99'))
            AADD(aRegPrn,TRANS(PRS->nTotPrSPrS,'###,###,###.99'))
            AADD(aRegPrn,TRANS(PRS->nEjeEnePrS,'###,###,###.99'))
            AADD(aRegPrn,TRANS(PRS->nEjeFebPrS,'###,###,###.99'))
            AADD(aRegPrn,TRANS(PRS->nEjeMarPrS,'###,###,###.99'))
            AADD(aRegPrn,TRANS(PRS->nEjeAbrPrS,'###,###,###.99'))
            AADD(aRegPrn,TRANS(PRS->nEjeMayPrS,'###,###,###.99'))
            AADD(aRegPrn,TRANS(PRS->nEjeJunPrS,'###,###,###.99'))
            AADD(aRegPrn,TRANS(PRS->nEjeJulPrS,'###,###,###.99'))
            AADD(aRegPrn,TRANS(PRS->nEjeAgoPrS,'###,###,###.99'))
            AADD(aRegPrn,TRANS(PRS->nEjeSepPrS,'###,###,###.99'))
            AADD(aRegPrn,TRANS(PRS->nEjeOctPrS,'###,###,###.99'))
            AADD(aRegPrn,TRANS(PRS->nEjeNovPrS,'###,###,###.99'))
            AADD(aRegPrn,TRANS(PRS->nEjeDicPrS,'###,###,###.99'))
            AADD(aRegPrn,TRANS(PRS->nTotEjePrS,'###,###,###.99'))
            AADD(aRegPrn,TRANS(PRS->nTotSdoPrS,'###,###,###.99'))
            AADD(aRegPrn,TRANS(PRS->nPorEjePrS,'###,###,###.99'))
            AADD(aRegPrn,TRANS(PRS->nPorIngPrS,'###,###,###.99'))

            lPrnOpc(lShared,nOpcPrn,FilePrn,nHanXml,01,nColCab,;
                    aTitPrn,aRegPrn,aNroCol,bPagina,bDerAut,bCabeza)
**********FIN IMPRESION DEL REGISTRO

**********AVANCE DEL SIGUIENTE REGISTRO
	    SELECT PRS
	    PRS->(DBSKIP())
	    IF PRS->(EOF())
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