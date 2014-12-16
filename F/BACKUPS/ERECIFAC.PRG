/*************************************************************************
* TITULO..: MANTENIMIENTO DEL ARCHIVO                                    *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: OCT  8/2014 MIE A
       Colombia, Bucaramanga        INICIO: 10:21 AM   OCT  8/2014 MIE

OBJETIVOS:

1- Permite el mantenimiento del archivo

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION MantenRfa(lShared,nModCry,cNomSis,cCodEmp,cNitEmp,cEmpPal,;
		   cNomEmp,cNomSec,cNomUsr,cAnoUsr,aArchvo,lPrnArc,;
		   cOpcPrn,nCodPrn,lModReg,lDelReg,lInsReg,lHaySql,;
		   cMaeAlu,cMaeAct)

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
       cMaeAlu                              // Maestros Habilitados
       cMaeAct                              // Maestro Actual */
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
       lModReg := IF(lModReg .AND. RFA->(RECCOUNT())==0,.F.,lModReg)

       lDelReg := IF(lDelReg==NIL,.F.,lDelReg)

       lInsReg := IF(lInsReg==NIL,.F.,lInsReg)

       lHaySql := IF(lHaySql==NIL,.F.,lHaySql)
*>>>>FIN PARAMETROS POR DEFECTO

*>>>>MANTENIMIENTO DEL ARCHIVO
       oBrowse := oBrwDbfRfa(lShared,cNomUsr,cAnoUsr,03,00,22,79,;
                             lModReg,lDelReg,lInsReg,lHaySql)

       SETKEY(K_F2,{||lManRegRfa(lShared,cNomUsr,3,oBrowse)})
     *ÀConsulta

       IF lModReg
          SETKEY(K_F4,{||lManRegRfa(lShared,cNomUsr,2,oBrowse,;
                                    RFA->cCodigoEst)})
       ENDIF
     *ÀActualizar

       SETKEY(K_F3,{||EstadoCta(lShared,nModCry,cNomSis,cNomEmp,;
				cNomUsr,cAnoUsr,cPatSis,nFilPal,1,;
				cMaeAct,NIL,.F.,RFA->cCodigoEst,;
				cMaeAlu,'RFA')})

       SETKEY(K_F5,{||BuscarRfa(oBrowse)})

       SETKEY(K_F9,{||MenuOtrRfa(lShared,nModCry,cNomSis,cCodEmp,cNitEmp,;
                                 cEmpPal,cNomEmp,cNomSec,cNomUsr,cAnoUsr,;
                                 aArchvo,lPrnArc,cOpcPrn,nCodPrn,lModReg,;
                                 lDelReg,lInsReg,lHaySql,oBrowse)})

       RFA->(CtrlBrw(lShared,oBrowse))

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

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: OCT  8/2014 MIE A
       Colombia, Bucaramanga        INICIO: 10:21 AM   OCT  8/2014 MIE

OBJETIVOS:

1- Define el objeto Browse del archivo

SINTAXIS:

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION oBrwDbfRfa(lShared,cNomUsr,cAnoUsr,nFilSup,nColSup,nFilInf,nColInf,;
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

       cTitSup := '<< RECIBOS FACTURADOS >>'
       cTitInf := '<F2>Consultar <F5>Buscar'+;
                   IF(lModReg,' <F4>Actualizar','')+' <F9>Otros'+;
                   IF(lDelReg,' <DEL>Borrar','')+;
                   IF(lInsReg,' <INS>Incluir','')

       IF lInsReg
          oBrowse:Cargo := {cTitSup,cTitInf,{||lManRegRfa(lShared,cNomUsr)}}
       ELSE
          oBrowse:Cargo := {cTitSup,cTitInf}
       ENDIF
     *ÀDefinici¢n de cabeceras y l¡neas de cabeceras

       SELECT RFA
       oColumn := TBCOLUMNNEW('CODIGO;DEL ESTUDIANTE',{||RFA->cCodigoEst})
       oColumn:Cargo := {{'MODI',.F.},{'ALIAS','RFA'},;
			 {'FIELD','cCodigoEst'},{'PICTURE','999999'}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn := TBCOLUMNNEW('CODIGO;DEL GRUPO',{||RFA->cCodigoGru})
       oColumn:Cargo := {{'MODI',lModReg},{'ALIAS','RFA'},;
			 {'FIELD','cCodigoGru'},{'PICTURE','9999'}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn := TBCOLUMNNEW('MES;INICIAL',{||RFA->nMesIniPag})
       oColumn:Cargo := {{'MODI',lModReg},{'ALIAS','RFA'},;
			 {'FIELD','nMesIniPag'},{'PICTURE','99'}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn := TBCOLUMNNEW('MES;FINAL',{||RFA->nMesFinPag})
       oColumn:Cargo := {{'MODI',lModReg},{'ALIAS','RFA'},;
			 {'FIELD','nMesFinPag'},{'PICTURE','99'}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn := TBCOLUMNNEW('VALOR;OPORTUNO',{||RFA->cVlrOpoRec})
       oColumn:Cargo := {{'MODI',lModReg},{'ALIAS','RFA'},;
			 {'FIELD','cVlrOpoRec'},{'PICTURE','@!'}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn := TBCOLUMNNEW('VALOR;EXTEMPORANEO',{||RFA->cVlrExtRec})
       oColumn:Cargo := {{'MODI',lModReg},{'ALIAS','RFA'},;
			 {'FIELD','cVlrExtRec'},{'PICTURE','@!'}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn := TBCOLUMNNEW('FECHA;PAGO OPORTUNO',{||RFA->cPagOpoPag})
       oColumn:Cargo := {{'MODI',lModReg},{'ALIAS','RFA'},;
			 {'FIELD','cPagOpoPag'},{'PICTURE','@!'}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn := TBCOLUMNNEW('FECHA;PAGO EXTEMPORANEO',{||RFA->cPagExtPag})
       oColumn:Cargo := {{'MODI',lModReg},{'ALIAS','RFA'},;
			 {'FIELD','cPagExtPag'},{'PICTURE','@!'}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn := TBCOLUMNNEW('FECHA;DE FACTURACION',{||RFA->cFecFacPag})
       oColumn:Cargo := {{'MODI',lModReg},{'ALIAS','RFA'},;
			 {'FIELD','cFecFacPag'},{'PICTURE','@!'}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn := TBCOLUMNNEW('REFERENCIA',{||RFA->cCodRefRec})
       oColumn:Cargo := {{'MODI',lModReg},{'ALIAS','RFA'},;
			 {'FIELD','cCodRefRec'},{'PICTURE','@!'}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn := TBCOLUMNNEW('PERIODO;FACTURADO',{||RFA->cPerFacRec})
       oColumn:Cargo := {{'MODI',lModReg},{'ALIAS','RFA'},;
			 {'FIELD','cPerFacRec'},{'PICTURE','@!'}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn := TBCOLUMNNEW('CONCEPTOS',{||ALLTRIM(RFA->cNomCo1Rec)+' '+;
					     ALLTRIM(RFA->cNomCo2Rec)+' '+;
					     ALLTRIM(RFA->cNomCo3Rec)+' '+;
					     ALLTRIM(RFA->cNomCo4Rec)+' '+;
					     ALLTRIM(RFA->cNomCo5Rec)+' '+;
					     ALLTRIM(RFA->cNomCo6Rec)+' '+;
					     ALLTRIM(RFA->cNomCo7Rec)+' '+;
					     ALLTRIM(RFA->cNomCo8Rec)})
       oColumn:Cargo := {{'MODI',.F.},{'ALIAS','RFA'},;
			 {'FIELD','cNomCo1Rec'},{'PICTURE','@!'}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn := TBCOLUMNNEW('NOMBRE',{||RFA->cNombreRec})
       oColumn:Cargo := {{'MODI',lModReg},{'ALIAS','RFA'},;
			 {'FIELD','cNombreRec'},{'PICTURE','@!'}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn := TBCOLUMNNEW('CODIGO SERVICIO;FACTURADO',{||RFA->cCodFacCar})
       oColumn:Cargo := {{'MODI',lModReg},{'ALIAS','RFA'},;
			 {'FIELD','cCodFacCar'},{'PICTURE','@!'}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn := TBCOLUMNNEW('CODIGO;DE LA EMPRESA',{||RFA->cCodEmpCon})
       oColumn:Cargo := {{'MODI',lModReg},{'ALIAS','RFA'},;
			 {'FIELD','cCodEmpCon'},{'PICTURE','@!'}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn := TBCOLUMNNEW('NUMERO;DEL RECIBO',{||RFA->cNroFacCaA})
       oColumn:Cargo := {{'MODI',lModReg},{'ALIAS','RFA'},;
			 {'FIELD','cNroFacCaA'},{'PICTURE','@!'}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn := TBCOLUMNNEW('NOMBRE;DE LA EMPRESA PRINCIPAL',{||RFA->cEmpPalRec})
       oColumn:Cargo := {{'MODI',lModReg},{'ALIAS','RFA'},;
			 {'FIELD','cEmpPalRec'},{'PICTURE','@!'}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn := TBCOLUMNNEW('NOMBRE;DE LA EMPRESA',{||RFA->cNomEmpRec})
       oColumn:Cargo := {{'MODI',lModReg},{'ALIAS','RFA'},;
			 {'FIELD','cNomEmpRec'},{'PICTURE','@!'}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn := TBCOLUMNNEW('NUMERO;DEL NIT',{||RFA->cNroNitRec})
       oColumn:Cargo := {{'MODI',lModReg},{'ALIAS','RFA'},;
			 {'FIELD','cNroNitRec'},{'PICTURE','@!'}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn := TBCOLUMNNEW('NOMBRE;DEL BANCO',{||RFA->cNomBanRec})
       oColumn:Cargo := {{'MODI',lModReg},{'ALIAS','RFA'},;
			 {'FIELD','cNomBanRec'},{'PICTURE','@!'}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn := TBCOLUMNNEW('CODIGO;EAN-13',{||RFA->cCodEanRec})
       oColumn:Cargo := {{'MODI',lModReg},{'ALIAS','RFA'},;
			 {'FIELD','cCodEanRec'},{'PICTURE','@!'}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn := TBCOLUMNNEW('NUMERO;DE LA CUENTA',{||RFA->cNroCtaBan})
       oColumn:Cargo := {{'MODI',lModReg},{'ALIAS','RFA'},;
			 {'FIELD','cNroCtaBan'},{'PICTURE','@!'}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn := TBCOLUMNNEW('CONCEPTO;No.1',{||RFA->cNomCo1Rec})
       oColumn:Cargo := {{'MODI',lModReg},{'ALIAS','RFA'},;
			 {'FIELD','cNomCo1Rec'},{'PICTURE','@!'}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn := TBCOLUMNNEW('VALOR EN;MORA No.1',{||RFA->cVlrMo1Rec})
       oColumn:Cargo := {{'MODI',lModReg},{'ALIAS','RFA'},;
			 {'FIELD','cVlrMo1Rec'},{'PICTURE','@!'}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn := TBCOLUMNNEW('VALOR;MES No.1',{||RFA->cVlrMe1Rec})
       oColumn:Cargo := {{'MODI',lModReg},{'ALIAS','RFA'},;
			 {'FIELD','cVlrMe1Rec'},{'PICTURE','@!'}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn := TBCOLUMNNEW('VALOR;TOTAL No.1',{||RFA->cVlrTo1Rec})
       oColumn:Cargo := {{'MODI',lModReg},{'ALIAS','RFA'},;
			 {'FIELD','cVlrTo1Rec'},{'PICTURE','@!'}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn := TBCOLUMNNEW('CONCEPTO;No.2',{||RFA->cNomCo2Rec})
       oColumn:Cargo := {{'MODI',lModReg},{'ALIAS','RFA'},;
			 {'FIELD','cNomCo2Rec'},{'PICTURE','@!'}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn := TBCOLUMNNEW('VALOR EN;MORA No.2',{||RFA->cVlrMo2Rec})
       oColumn:Cargo := {{'MODI',lModReg},{'ALIAS','RFA'},;
			 {'FIELD','cVlrMo2Rec'},{'PICTURE','@!'}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn := TBCOLUMNNEW('VALOR;MES No.2',{||RFA->cVlrMe2Rec})
       oColumn:Cargo := {{'MODI',lModReg},{'ALIAS','RFA'},;
			 {'FIELD','cVlrMe2Rec'},{'PICTURE','@!'}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn := TBCOLUMNNEW('VALOR;TOTAL No.2',{||RFA->cVlrTo2Rec})
       oColumn:Cargo := {{'MODI',lModReg},{'ALIAS','RFA'},;
			 {'FIELD','cVlrTo2Rec'},{'PICTURE','@!'}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn := TBCOLUMNNEW('CONCEPTO;No.3',{||RFA->cNomCo3Rec})
       oColumn:Cargo := {{'MODI',lModReg},{'ALIAS','RFA'},;
			 {'FIELD','cNomCo3Rec'},{'PICTURE','@!'}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn := TBCOLUMNNEW('VALOR EN;MORA No.3',{||RFA->cVlrMo3Rec})
       oColumn:Cargo := {{'MODI',lModReg},{'ALIAS','RFA'},;
			 {'FIELD','cVlrMo3Rec'},{'PICTURE','@!'}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn := TBCOLUMNNEW('VALOR;MES No.3',{||RFA->cVlrMe3Rec})
       oColumn:Cargo := {{'MODI',lModReg},{'ALIAS','RFA'},;
			 {'FIELD','cVlrMe3Rec'},{'PICTURE','@!'}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn := TBCOLUMNNEW('VALOR;TOTAL No.3',{||RFA->cVlrTo3Rec})
       oColumn:Cargo := {{'MODI',lModReg},{'ALIAS','RFA'},;
			 {'FIELD','cVlrTo3Rec'},{'PICTURE','@!'}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn := TBCOLUMNNEW('CONCEPTO;No.4',{||RFA->cNomCo4Rec})
       oColumn:Cargo := {{'MODI',lModReg},{'ALIAS','RFA'},;
			 {'FIELD','cNomCo4Rec'},{'PICTURE','@!'}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn := TBCOLUMNNEW('VALOR EN;MORA No.4',{||RFA->cVlrMo4Rec})
       oColumn:Cargo := {{'MODI',lModReg},{'ALIAS','RFA'},;
			 {'FIELD','cVlrMo4Rec'},{'PICTURE','@!'}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn := TBCOLUMNNEW('VALOR;MES No.4',{||RFA->cVlrMe4Rec})
       oColumn:Cargo := {{'MODI',lModReg},{'ALIAS','RFA'},;
			 {'FIELD','cVlrMe4Rec'},{'PICTURE','@!'}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn := TBCOLUMNNEW('VALOR;TOTAL No.4',{||RFA->cVlrTo4Rec})
       oColumn:Cargo := {{'MODI',lModReg},{'ALIAS','RFA'},;
			 {'FIELD','cVlrTo4Rec'},{'PICTURE','@!'}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn := TBCOLUMNNEW('CONCEPTO;No.5',{||RFA->cNomCo5Rec})
       oColumn:Cargo := {{'MODI',lModReg},{'ALIAS','RFA'},;
			 {'FIELD','cNomCo5Rec'},{'PICTURE','@!'}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn := TBCOLUMNNEW('VALOR EN;MORA No.5',{||RFA->cVlrMo5Rec})
       oColumn:Cargo := {{'MODI',lModReg},{'ALIAS','RFA'},;
			 {'FIELD','cVlrMo5Rec'},{'PICTURE','@!'}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn := TBCOLUMNNEW('VALOR;MES No.5',{||RFA->cVlrMe5Rec})
       oColumn:Cargo := {{'MODI',lModReg},{'ALIAS','RFA'},;
			 {'FIELD','cVlrMe5Rec'},{'PICTURE','@!'}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn := TBCOLUMNNEW('VALOR;TOTAL No.5',{||RFA->cVlrTo5Rec})
       oColumn:Cargo := {{'MODI',lModReg},{'ALIAS','RFA'},;
			 {'FIELD','cVlrTo5Rec'},{'PICTURE','@!'}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn := TBCOLUMNNEW('CONCEPTO;No.6',{||RFA->cNomCo6Rec})
       oColumn:Cargo := {{'MODI',lModReg},{'ALIAS','RFA'},;
			 {'FIELD','cNomCo6Rec'},{'PICTURE','@!'}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn := TBCOLUMNNEW('VALOR EN;MORA No.6',{||RFA->cVlrMo6Rec})
       oColumn:Cargo := {{'MODI',lModReg},{'ALIAS','RFA'},;
			 {'FIELD','cVlrMo6Rec'},{'PICTURE','@!'}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn := TBCOLUMNNEW('VALOR;MES No.6',{||RFA->cVlrMe6Rec})
       oColumn:Cargo := {{'MODI',lModReg},{'ALIAS','RFA'},;
			 {'FIELD','cVlrMe6Rec'},{'PICTURE','@!'}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn := TBCOLUMNNEW('VALOR;TOTAL No.6',{||RFA->cVlrTo6Rec})
       oColumn:Cargo := {{'MODI',lModReg},{'ALIAS','RFA'},;
			 {'FIELD','cVlrTo6Rec'},{'PICTURE','@!'}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn := TBCOLUMNNEW('CONCEPTO;No.7',{||RFA->cNomCo7Rec})
       oColumn:Cargo := {{'MODI',lModReg},{'ALIAS','RFA'},;
			 {'FIELD','cNomCo7Rec'},{'PICTURE','@!'}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn := TBCOLUMNNEW('VALOR EN;MORA No.7',{||RFA->cVlrMo7Rec})
       oColumn:Cargo := {{'MODI',lModReg},{'ALIAS','RFA'},;
			 {'FIELD','cVlrMo7Rec'},{'PICTURE','@!'}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn := TBCOLUMNNEW('VALOR;MES No.7',{||RFA->cVlrMe7Rec})
       oColumn:Cargo := {{'MODI',lModReg},{'ALIAS','RFA'},;
			 {'FIELD','cVlrMe7Rec'},{'PICTURE','@!'}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn := TBCOLUMNNEW('VALOR;TOTAL No.7',{||RFA->cVlrTo7Rec})
       oColumn:Cargo := {{'MODI',lModReg},{'ALIAS','RFA'},;
			 {'FIELD','cVlrTo7Rec'},{'PICTURE','@!'}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn := TBCOLUMNNEW('CONCEPTO;No.8',{||RFA->cNomCo8Rec})
       oColumn:Cargo := {{'MODI',lModReg},{'ALIAS','RFA'},;
			 {'FIELD','cNomCo8Rec'},{'PICTURE','@!'}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn := TBCOLUMNNEW('VALOR EN;MORA No.8',{||RFA->cVlrMo8Rec})
       oColumn:Cargo := {{'MODI',lModReg},{'ALIAS','RFA'},;
			 {'FIELD','cVlrMo8Rec'},{'PICTURE','@!'}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn := TBCOLUMNNEW('VALOR;MES No.8',{||RFA->cVlrMe8Rec})
       oColumn:Cargo := {{'MODI',lModReg},{'ALIAS','RFA'},;
			 {'FIELD','cVlrMe8Rec'},{'PICTURE','@!'}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn := TBCOLUMNNEW('VALOR;TOTAL No.8',{||RFA->cVlrTo8Rec})
       oColumn:Cargo := {{'MODI',lModReg},{'ALIAS','RFA'},;
			 {'FIELD','cVlrTo8Rec'},{'PICTURE','@!'}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn := TBCOLUMNNEW('CONCEPTO;No.9',{||RFA->cNomCo9Rec})
       oColumn:Cargo := {{'MODI',lModReg},{'ALIAS','RFA'},;
			 {'FIELD','cNomCo9Rec'},{'PICTURE','@!'}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn := TBCOLUMNNEW('VALOR EN;MORA No.9',{||RFA->cVlrMo9Rec})
       oColumn:Cargo := {{'MODI',lModReg},{'ALIAS','RFA'},;
			 {'FIELD','cVlrMo9Rec'},{'PICTURE','@!'}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn := TBCOLUMNNEW('VALOR;MES No.9',{||RFA->cVlrMe9Rec})
       oColumn:Cargo := {{'MODI',lModReg},{'ALIAS','RFA'},;
			 {'FIELD','cVlrMe9Rec'},{'PICTURE','@!'}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn := TBCOLUMNNEW('VALOR;TOTAL No.9',{||RFA->cVlrTo9Rec})
       oColumn:Cargo := {{'MODI',lModReg},{'ALIAS','RFA'},;
			 {'FIELD','cVlrTo9Rec'},{'PICTURE','@!'}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn := TBCOLUMNNEW('CODIGO BARRA;OPORTUNO',{||RFA->cBarOpoRec})
       oColumn:Cargo := {{'MODI',lModReg},{'ALIAS','RFA'},;
			 {'FIELD','cBarOpoRec'},{'PICTURE','@!'}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn := TBCOLUMNNEW('CODIGO BARRA;EXTEMPORANEO',{||RFA->cBarExtRec})
       oColumn:Cargo := {{'MODI',lModReg},{'ALIAS','RFA'},;
			 {'FIELD','cBarExtRec'},{'PICTURE','@!'}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn := TBCOLUMNNEW('TEXTO;No.1',{||RFA->cTxtUnoRec})
       oColumn:Cargo := {{'MODI',lModReg},{'ALIAS','RFA'},;
			 {'FIELD','cTxtUnoRec'},{'PICTURE','@!'}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn := TBCOLUMNNEW('TEXTO;No.2',{||RFA->cTxtDosRec})
       oColumn:Cargo := {{'MODI',lModReg},{'ALIAS','RFA'},;
			 {'FIELD','cTxtDosRec'},{'PICTURE','@!'}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn := TBCOLUMNNEW('CODE;QR',{||RFA->cCodeQrRec})
       oColumn:Cargo := {{'MODI',lModReg},{'ALIAS','RFA'},;
			 {'FIELD','cCodeQrRec'},{'PICTURE','@!'}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn := TBCOLUMNNEW('DOCUMENTO;CONTRATANTE No.1',{||RFA->cNitCn1Rec})
       oColumn:Cargo := {{'MODI',lModReg},{'ALIAS','RFA'},;
			 {'FIELD','cNitCn1Rec'},{'PICTURE','@!'}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn := TBCOLUMNNEW('NOMBRE;CONTRATANTE No.1',{||RFA->cNomCn1Rec})
       oColumn:Cargo := {{'MODI',lModReg},{'ALIAS','RFA'},;
			 {'FIELD','cNomCn1Rec'},{'PICTURE','@!'}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn := TBCOLUMNNEW('MAIL;CONTRATANTE No.1',{||RFA->cMaiCn1Rec})
       oColumn:Cargo := {{'MODI',lModReg},{'ALIAS','RFA'},;
			 {'FIELD','cMaiCn1Rec'},{'PICTURE','@!'}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn := TBCOLUMNNEW('PWD;CONTRATANTE No.1',{||RFA->cPwdCn1Rec})
       oColumn:Cargo := {{'MODI',lModReg},{'ALIAS','RFA'},;
			 {'FIELD','cPwdCn1Rec'},{'PICTURE','@!'}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn := TBCOLUMNNEW('DOCUMENTO;CONTRATANTE No.2',{||RFA->cNitCn2Rec})
       oColumn:Cargo := {{'MODI',lModReg},{'ALIAS','RFA'},;
			 {'FIELD','cNitCn2Rec'},{'PICTURE','@!'}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn := TBCOLUMNNEW('NOMBRE;CONTRATANTE No.2',{||RFA->cNomCn2Rec})
       oColumn:Cargo := {{'MODI',lModReg},{'ALIAS','RFA'},;
			 {'FIELD','cNomCn2Rec'},{'PICTURE','@!'}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn := TBCOLUMNNEW('MAIL;CONTRATANTE No.2',{||RFA->cMaiCn2Rec})
       oColumn:Cargo := {{'MODI',lModReg},{'ALIAS','RFA'},;
			 {'FIELD','cMaiCn2Rec'},{'PICTURE','@!'}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn := TBCOLUMNNEW('PWD;CONTRATANTE No.2',{||RFA->cPwdCn2Rec})
       oColumn:Cargo := {{'MODI',lModReg},{'ALIAS','RFA'},;
			 {'FIELD','cPwdCn2Rec'},{'PICTURE','@!'}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn	     := TBCOLUMNNEW('NOMBRE;DEL USUARIO',{||RFA->cNomUsrRfa})
       oColumn:Cargo := {{'MODI',.F.}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn	     := TBCOLUMNNEW('FECHA DE;PROCESO',;
				    {||cFecha(RFA->dFecUsrRfa)})
       oColumn:Cargo := {{'MODI',.F.}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn	     := TBCOLUMNNEW('HORA DE;PROCESO',;
				    {||cHoraSys(RFA->cHorUsrRfa)})
       oColumn:Cargo := {{'MODI',.F.}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn	     := TBCOLUMNNEW('CODIGO',{||RFA->nIdeCodRfa})
       oColumn:Cargo := {{'MODI',.F.}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn	     := TBCOLUMNNEW('No.',{||RFA->(RECNO())})
       oColumn:Cargo := {{'MODI',.F.}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       RETURN oBrowse
*>>>>FIN DEFINICION DEL OBJETO BROWSE

/*************************************************************************
* TITULO..: MANTENIMIENTO DEL REGISTRO                                   *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: OCT  8/2014 MIE A
       Colombia, Bucaramanga        INICIO: 10:21 AM   OCT  8/2014 MIE

OBJETIVOS:

1- Permite inclusi¢n,modificaci¢n y consulta del registro

2- Puede invocarse en la lectura a trav‚s de la clausula VALID

2- Returna .T.

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION lManRegRfa(lShared,cNomUsr,nTipMod,oBrowse,cCodigo,nNroOpc)

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

       LOCAL nMesIniTre := 0                // Mes Inicial                                                 
       LOCAL nMesFinTre := 0                // Mes Final                                                   
       LOCAL cEmpPalTre := ''               // Nombre de la Empresa Principal                              
       LOCAL cNroNitTre := ''               // N£mero del Nit                                              
       LOCAL cNomEmpTre := ''               // Nombre de la Empresa                                        
       LOCAL cCodEmpTre := ''               // C¢digo de la Empresa                                        
       LOCAL cCodFacTre := ''               // C¢digo Servicio Facturado                                   
       LOCAL cNroFacTre := ''               // N£mero del Recibo                                           
       LOCAL cNomBanTre := ''               // Nombre del Banco                                            
       LOCAL cCodEanTre := ''               // C¢digo EAN-13 del recibo                                    
       LOCAL cNroCtaTre := ''               // N£mero de la Cuenta                                         
       LOCAL cNombreTre := ''               // Nombre                                                      
       LOCAL cCodRefTre := ''               // C¢digo de la Referencia                                     
       LOCAL cCodigoTre := ''               // C¢digo del Grupo                                            
       LOCAL cFecFacTre := ''               // Fecha de Facturaci¢n                                        
       LOCAL cPagOpoTre := ''               // Fecha Pago Oportuno                                         
       LOCAL cPagExtTre := ''               // Fecha Pago Extemporaneo                                     
       LOCAL cPerFacTre := ''               // Periodo Facturado                                           
       LOCAL cNomCo1Tre := ''               // Concepto No.1                                               
       LOCAL cVlrMo1Tre := ''               // Valor Mora No.1                                             
       LOCAL cVlrMe1Tre := ''               // Valor Mes No.1                                              
       LOCAL cVlrTo1Tre := ''               // Valor Total No.1                                            
       LOCAL cNomCo2Tre := ''               // Concepto No.2                                               
       LOCAL cVlrMo2Tre := ''               // Valor Mora No.2                                             
       LOCAL cVlrMe2Tre := ''               // Valor Mes No.2                                              
       LOCAL cVlrTo2Tre := ''               // Valor Total No.2                                            
       LOCAL cNomCo3Tre := ''               // Concepto No.3                                               
       LOCAL cVlrMo3Tre := ''               // Valor Mora No.3                                             
       LOCAL cVlrMe3Tre := ''               // Valor Mes No.3                                              
       LOCAL cVlrTo3Tre := ''               // Valor Total No.3                                            
       LOCAL cNomCo4Tre := ''               // Concepto No.4                                               
       LOCAL cVlrMo4Tre := ''               // Valor Mora No.4                                             
       LOCAL cVlrMe4Tre := ''               // Valor Mes No.4                                              
       LOCAL cVlrTo4Tre := ''               // Valor Total No.4                                            
       LOCAL cNomCo5Tre := ''               // Concepto No.5                                               
       LOCAL cVlrMo5Tre := ''               // Valor Mora No.5                                             
       LOCAL cVlrMe5Tre := ''               // Valor Mes No.5                                              
       LOCAL cVlrTo5Tre := ''               // Valor Total No.5                                            
       LOCAL cNomCo6Tre := ''               // Concepto No.6                                               
       LOCAL cVlrMo6Tre := ''               // Valor Mora No.6                                             
       LOCAL cVlrMe6Tre := ''               // Valor Mes No.6                                              
       LOCAL cVlrTo6Tre := ''               // Valor Total No.6                                            
       LOCAL cNomCo7Tre := ''               // Concepto No.7                                               
       LOCAL cVlrMo7Tre := ''               // Valor Mora No.7                                             
       LOCAL cVlrMe7Tre := ''               // Valor Mes No.7                                              
       LOCAL cVlrTo7Tre := ''               // Valor Total No.7                                            
       LOCAL cNomCo8Tre := ''               // Concepto No.8                                               
       LOCAL cVlrMo8Tre := ''               // Valor Mora No.8                                             
       LOCAL cVlrMe8Tre := ''               // Valor Mes No.8                                              
       LOCAL cVlrTo8Tre := ''               // Valor Total No.8                                            
       LOCAL cNomCo9Tre := ''               // Concepto No.9                                               
       LOCAL cVlrMo9Tre := ''               // Valor Mora No.9                                             
       LOCAL cVlrMe9Tre := ''               // Valor Mes No.9                                              
       LOCAL cVlrTo9Tre := ''               // Valor Total No.9                                            
       LOCAL cVlrOpoTre := ''               // Valor Oportuno                                              
       LOCAL cVlrExtTre := ''               // Valor Extemporaneo                                          
       LOCAL cBarOpoTre := ''               // Codigo Barra Oportuno                                       
       LOCAL cBarExtTre := ''               // Codigo Barra Extemporaneo                                   
       LOCAL cTxtUnoTre := ''               // Texto1                                                      
       LOCAL cTxtDosTre := ''               // Texto2                                                      
       LOCAL cCodeQrTre := ''               // Code Qr                                                     
       LOCAL cNitCn1Tre := ''               // Documento Contratante No.1                                  
       LOCAL cNomCn1Tre := ''               // Nombre del Contratante No.1                                 
       LOCAL cMaiCn1Tre := ''               // Mail del Contratante No.1                                   
       LOCAL cPwdCn1Tre := ''               // Pwd del Contratante No.1                                    
       LOCAL cNitCn2Tre := ''               // Documento Contratante No.2                                  
       LOCAL cNomCn2Tre := ''               // Nombre del Contratante No.2                                 
       LOCAL cMaiCn2Tre := ''               // Mail del Contratante No.2                                   
       LOCAL cPwdCn2Tre := ''               // Pwd del Contratante No.2                                    

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
            cTxtTem := 'RECIBOS FACTURADOS .INCLUIR. '+aMenus[nNroOpc]
            RFA->(DBGOBOTTOM())
            RFA->(DBSKIP())
            nTipCur := SETCURSOR(1)

       CASE nTipMod == 2
            cTxtTem := 'RECIBOS FACTURADOS .ACTUALIZAR. '+aMenus[nNroOpc]
            nTipCur := SETCURSOR(1)

       CASE nTipMod == 3
            cTxtTem := 'RECIBOS FACTURADOS. CONSUTA. '+aMenus[nNroOpc]
       ENDCASE
       nFilIni := nMarco(03,cTxtTem,22,'°')
*>>>>FIN MARCO DEL MANTENIMIENTO

*>>>>MANTENIMIENTO DEL REGISTRO
       SELECT RFA
       DO WHILE .T.

**********INICIALIZACION DE LAS VARIABLES
            IF lGrabar

               IF EMPTY(cCodigo)
                  cCodigo := RFA->cCodigoEst
               ENDIF

               nMesIniTre := RFA->nMesIniPag
               nMesFinTre := RFA->nMesFinPag
               cEmpPalTre := RFA->cEmpPalRec
               cNroNitTre := RFA->cNroNitRec
               cNomEmpTre := RFA->cNomEmpRec
               cCodEmpTre := RFA->cCodEmpCon
               cCodFacTre := RFA->cCodFacCar
               cNroFacTre := RFA->cNroFacCaA
               cNomBanTre := RFA->cNomBanRec
               cCodEanTre := RFA->cCodEanRec
               cNroCtaTre := RFA->cNroCtaBan
               cNombreTre := RFA->cNombreRec
               cCodRefTre := RFA->cCodRefRec
               cCodigoTre := RFA->cCodigoGru
               cFecFacTre := RFA->cFecFacPag
               cPagOpoTre := RFA->cPagOpoPag
               cPagExtTre := RFA->cPagExtPag
               cPerFacTre := RFA->cPerFacRec
               cNomCo1Tre := RFA->cNomCo1Rec
               cVlrMo1Tre := RFA->cVlrMo1Rec
               cVlrMe1Tre := RFA->cVlrMe1Rec
               cVlrTo1Tre := RFA->cVlrTo1Rec
               cNomCo2Tre := RFA->cNomCo2Rec
               cVlrMo2Tre := RFA->cVlrMo2Rec
               cVlrMe2Tre := RFA->cVlrMe2Rec
               cVlrTo2Tre := RFA->cVlrTo2Rec
               cNomCo3Tre := RFA->cNomCo3Rec
               cVlrMo3Tre := RFA->cVlrMo3Rec
               cVlrMe3Tre := RFA->cVlrMe3Rec
               cVlrTo3Tre := RFA->cVlrTo3Rec
               cNomCo4Tre := RFA->cNomCo4Rec
               cVlrMo4Tre := RFA->cVlrMo4Rec
               cVlrMe4Tre := RFA->cVlrMe4Rec
               cVlrTo4Tre := RFA->cVlrTo4Rec
               cNomCo5Tre := RFA->cNomCo5Rec
               cVlrMo5Tre := RFA->cVlrMo5Rec
               cVlrMe5Tre := RFA->cVlrMe5Rec
               cVlrTo5Tre := RFA->cVlrTo5Rec
               cNomCo6Tre := RFA->cNomCo6Rec
               cVlrMo6Tre := RFA->cVlrMo6Rec
               cVlrMe6Tre := RFA->cVlrMe6Rec
               cVlrTo6Tre := RFA->cVlrTo6Rec
               cNomCo7Tre := RFA->cNomCo7Rec
               cVlrMo7Tre := RFA->cVlrMo7Rec
               cVlrMe7Tre := RFA->cVlrMe7Rec
               cVlrTo7Tre := RFA->cVlrTo7Rec
               cNomCo8Tre := RFA->cNomCo8Rec
               cVlrMo8Tre := RFA->cVlrMo8Rec
               cVlrMe8Tre := RFA->cVlrMe8Rec
               cVlrTo8Tre := RFA->cVlrTo8Rec
               cNomCo9Tre := RFA->cNomCo9Rec
               cVlrMo9Tre := RFA->cVlrMo9Rec
               cVlrMe9Tre := RFA->cVlrMe9Rec
               cVlrTo9Tre := RFA->cVlrTo9Rec
               cVlrOpoTre := RFA->cVlrOpoRec
               cVlrExtTre := RFA->cVlrExtRec
               cBarOpoTre := RFA->cBarOpoRec
               cBarExtTre := RFA->cBarExtRec
               cTxtUnoTre := RFA->cTxtUnoRec
               cTxtDosTre := RFA->cTxtDosRec
               cCodeQrTre := RFA->cCodeQrRec
               cNitCn1Tre := RFA->cNitCn1Rec
               cNomCn1Tre := RFA->cNomCn1Rec
               cMaiCn1Tre := RFA->cMaiCn1Rec
               cPwdCn1Tre := RFA->cPwdCn1Rec
               cNitCn2Tre := RFA->cNitCn2Rec
               cNomCn2Tre := RFA->cNomCn2Rec
               cMaiCn2Tre := RFA->cMaiCn2Rec
               cPwdCn2Tre := RFA->cPwdCn2Rec
            ENDIF
**********FIN INICIALIZACION DE LAS VARIABLES

**********LECTURA DE CAMPO
            IF nNroOpc == 1

               nNroFil := nFilIni
               cTxtTem := 'CODIGO DEL ESTUDIANTE :'

               IF nTipMod == 2 .OR. nTipMod == 3 .OR. !EMPTY(cCodigo)
                  @ nNroFil,nNroCol SAY cTxtTem
                  @ nNroFil,nNroCol+LEN(cTxtTem)+1 SAY cCodigo COLOR('I')
               ELSE
                  @ nNroFil,nNroCol SAY cTxtTem;
                                    GET cCodigo PICT '999999';
                                    VALID !EMPTY(cCodigo) .AND.;
                                          !lValCodRfa(cCodigo)
               ENDIF

	    ENDIF
**********FIN LECTURA DE CAMPO

**********LECTURA DE CAMPO
            IF nNroOpc == 1

               nNroFil++
               nColTem := nNroCol
               cTxtTem := 'MES INICIAL                 :'

               IF nTipMod == 3
                  @ nNroFil,nColTem SAY cTxtTem
                  @ nNroFil,nColTem+LEN(cTxtTem)+1 SAY nMesIniTre COLOR('I')
               ELSE
                  @ nNroFil,nColTem SAY cTxtTem;
                                    GET nMesIniTre PICT '99';
                                    VALID !EMPTY(nMesIniTre);
                                    WHEN {||HelpRead('FAVOR INGRESE EL MES INICIAL')}
               ENDIF

	    ENDIF
**********FIN LECTURA DE CAMPO

**********LECTURA DE CAMPO
            IF nNroOpc == 1

               nNroFil++
               nColTem := nNroCol
               cTxtTem := 'MES FINAL                   :'

               IF nTipMod == 3
                  @ nNroFil,nColTem SAY cTxtTem
                  @ nNroFil,nColTem+LEN(cTxtTem)+1 SAY nMesFinTre COLOR('I')
               ELSE
                  @ nNroFil,nColTem SAY cTxtTem;
                                    GET nMesFinTre PICT '99';
                                    VALID !EMPTY(nMesFinTre);
                                    WHEN {||HelpRead('FAVOR INGRESE EL MES FINAL')}
               ENDIF

	    ENDIF
**********FIN LECTURA DE CAMPO

**********LECTURA DE CAMPO
            IF nNroOpc == 1

               nNroFil++
               nColTem := nNroCol
               cTxtTem := 'NOMBRE DE LA EMPRESA P:'

               IF nTipMod == 3
                  @ nNroFil,nColTem SAY cTxtTem
                  @ nNroFil,nColTem+LEN(cTxtTem)+1 SAY cEmpPalTre COLOR('I')
               ELSE
                  @ nNroFil,nColTem SAY cTxtTem;
                                    GET cEmpPalTre PICT '@!';
                                    VALID !EMPTY(cEmpPalTre);
                                    WHEN {||HelpRead('FAVOR INGRESE EL NOMBRE DE LA EMPRESA PRINCIPAL')}
               ENDIF

	    ENDIF
**********FIN LECTURA DE CAMPO

**********LECTURA DE CAMPO
            IF nNroOpc == 1

               nNroFil++
               nColTem := nNroCol
               cTxtTem := 'NUMERO DEL NIT        :'

               IF nTipMod == 3
                  @ nNroFil,nColTem SAY cTxtTem
                  @ nNroFil,nColTem+LEN(cTxtTem)+1 SAY cNroNitTre COLOR('I')
               ELSE
                  @ nNroFil,nColTem SAY cTxtTem;
                                    GET cNroNitTre PICT '@!';
                                    VALID !EMPTY(cNroNitTre);
                                    WHEN {||HelpRead('FAVOR INGRESE EL NUMERO DEL NIT')}
               ENDIF

	    ENDIF
**********FIN LECTURA DE CAMPO

**********LECTURA DE CAMPO
            IF nNroOpc == 1

               nNroFil++
               nColTem := nNroCol
               cTxtTem := 'NOMBRE DE LA EMPRESA  :'

               IF nTipMod == 3
                  @ nNroFil,nColTem SAY cTxtTem
                  @ nNroFil,nColTem+LEN(cTxtTem)+1 SAY cNomEmpTre COLOR('I')
               ELSE
                  @ nNroFil,nColTem SAY cTxtTem;
                                    GET cNomEmpTre PICT '@!';
                                    VALID !EMPTY(cNomEmpTre);
                                    WHEN {||HelpRead('FAVOR INGRESE EL NOMBRE DE LA EMPRESA')}
               ENDIF

	    ENDIF
**********FIN LECTURA DE CAMPO

**********LECTURA DE CAMPO
            IF nNroOpc == 1

               nNroFil++
               nColTem := nNroCol
               cTxtTem := 'CODIGO DE LA EMPRESA  :'

               IF nTipMod == 3
                  @ nNroFil,nColTem SAY cTxtTem
                  @ nNroFil,nColTem+LEN(cTxtTem)+1 SAY cCodEmpTre COLOR('I')
               ELSE
                  @ nNroFil,nColTem SAY cTxtTem;
                                    GET cCodEmpTre PICT '@!';
                                    VALID !EMPTY(cCodEmpTre);
                                    WHEN {||HelpRead('FAVOR INGRESE EL CODIGO DE LA EMPRESA')}
               ENDIF

	    ENDIF
**********FIN LECTURA DE CAMPO

**********LECTURA DE CAMPO
            IF nNroOpc == 1

               nNroFil++
               nColTem := nNroCol
               cTxtTem := 'CODIGO SERVICIO FACTUR:'

               IF nTipMod == 3
                  @ nNroFil,nColTem SAY cTxtTem
                  @ nNroFil,nColTem+LEN(cTxtTem)+1 SAY cCodFacTre COLOR('I')
               ELSE
                  @ nNroFil,nColTem SAY cTxtTem;
                                    GET cCodFacTre PICT '@!';
                                    VALID !EMPTY(cCodFacTre);
                                    WHEN {||HelpRead('FAVOR INGRESE EL CODIGO DEL SERVICIO FACTURADO')}
               ENDIF

	    ENDIF
**********FIN LECTURA DE CAMPO

**********LECTURA DE CAMPO
            IF nNroOpc == 1

               nNroFil++
               nColTem := nNroCol
               cTxtTem := 'NUMERO DEL RECIBO     :'

               IF nTipMod == 3
                  @ nNroFil,nColTem SAY cTxtTem
                  @ nNroFil,nColTem+LEN(cTxtTem)+1 SAY cNroFacTre COLOR('I')
               ELSE
                  @ nNroFil,nColTem SAY cTxtTem;
                                    GET cNroFacTre PICT '@!';
                                    VALID !EMPTY(cNroFacTre);
                                    WHEN {||HelpRead('FAVOR INGRESE EL NUMERO DEL RECIBO')}
               ENDIF

	    ENDIF
**********FIN LECTURA DE CAMPO

**********LECTURA DE CAMPO
            IF nNroOpc == 1

               nNroFil++
               nColTem := nNroCol
               cTxtTem := 'NOMBRE DEL BANCO      :'

               IF nTipMod == 3
                  @ nNroFil,nColTem SAY cTxtTem
                  @ nNroFil,nColTem+LEN(cTxtTem)+1 SAY cNomBanTre COLOR('I')
               ELSE
                  @ nNroFil,nColTem SAY cTxtTem;
                                    GET cNomBanTre PICT '@!';
                                    VALID !EMPTY(cNomBanTre);
                                    WHEN {||HelpRead('FAVOR INGRESE EL NOMBRE DEL BANCO')}
               ENDIF

	    ENDIF
**********FIN LECTURA DE CAMPO

**********LECTURA DE CAMPO
            IF nNroOpc == 1

               nNroFil++
               nColTem := nNroCol
               cTxtTem := 'CODIGO EAN-13         :'

               IF nTipMod == 3
                  @ nNroFil,nColTem SAY cTxtTem
                  @ nNroFil,nColTem+LEN(cTxtTem)+1 SAY cCodEanTre COLOR('I')
               ELSE
                  @ nNroFil,nColTem SAY cTxtTem;
                                    GET cCodEanTre PICT '@!';
                                    VALID !EMPTY(cCodEanTre);
                                    WHEN {||HelpRead('FAVOR INGRESE EL CODIGO EAN-13')}
               ENDIF

	    ENDIF
**********FIN LECTURA DE CAMPO

**********LECTURA DE CAMPO
            IF nNroOpc == 1

               nNroFil++
               nColTem := nNroCol
               cTxtTem := 'NUMERO DE LA CUENTA   :'

               IF nTipMod == 3
                  @ nNroFil,nColTem SAY cTxtTem
                  @ nNroFil,nColTem+LEN(cTxtTem)+1 SAY cNroCtaTre COLOR('I')
               ELSE
                  @ nNroFil,nColTem SAY cTxtTem;
                                    GET cNroCtaTre PICT '@!';
                                    VALID !EMPTY(cNroCtaTre);
                                    WHEN {||HelpRead('FAVOR INGRESE EL NUMERO DE LA CUENTA')}
               ENDIF

	    ENDIF
**********FIN LECTURA DE CAMPO

**********LECTURA DE CAMPO
            IF nNroOpc == 1

               nNroFil++
               nColTem := nNroCol
               cTxtTem := 'NOMBRE                :'

               IF nTipMod == 3
                  @ nNroFil,nColTem SAY cTxtTem
                  @ nNroFil,nColTem+LEN(cTxtTem)+1 SAY cNombreTre COLOR('I')
               ELSE
                  @ nNroFil,nColTem SAY cTxtTem;
                                    GET cNombreTre PICT '@!';
                                    VALID !EMPTY(cNombreTre);
                                    WHEN {||HelpRead('FAVOR INGRESE EL NOMBRE')}
               ENDIF

	    ENDIF
**********FIN LECTURA DE CAMPO

**********LECTURA DE CAMPO
            IF nNroOpc == 1

               nNroFil++
               nColTem := nNroCol
               cTxtTem := 'CODIGO DE LA REFERENCI:'

               IF nTipMod == 3
                  @ nNroFil,nColTem SAY cTxtTem
                  @ nNroFil,nColTem+LEN(cTxtTem)+1 SAY cCodRefTre COLOR('I')
               ELSE
                  @ nNroFil,nColTem SAY cTxtTem;
                                    GET cCodRefTre PICT '@!';
                                    VALID !EMPTY(cCodRefTre);
                                    WHEN {||HelpRead('FAVOR INGRESE EL CODIGO DE LA REFERENCIA')}
               ENDIF

	    ENDIF
**********FIN LECTURA DE CAMPO

**********LECTURA DE CAMPO
            IF nNroOpc == 1

               nNroFil++
               nColTem := nNroCol
               cTxtTem := 'CODIGO DEL GRUPO      :'

               IF nTipMod == 3
                  @ nNroFil,nColTem SAY cTxtTem
                  @ nNroFil,nColTem+LEN(cTxtTem)+1 SAY cCodigoTre COLOR('I')
               ELSE
                  @ nNroFil,nColTem SAY cTxtTem;
                                    GET cCodigoTre PICT '9999';
                                    VALID !EMPTY(cCodigoTre);
                                    WHEN {||HelpRead('FAVOR INGRESE EL CODIGO DEL GRUPO')}
               ENDIF

	    ENDIF
**********FIN LECTURA DE CAMPO

**********LECTURA DE CAMPO
            IF nNroOpc == 1

               nNroFil++
               nColTem := nNroCol
               cTxtTem := 'FECHA DE FACTURACION  :'

               IF nTipMod == 3
                  @ nNroFil,nColTem SAY cTxtTem
                  @ nNroFil,nColTem+LEN(cTxtTem)+1 SAY cFecFacTre COLOR('I')
               ELSE
                  @ nNroFil,nColTem SAY cTxtTem;
                                    GET cFecFacTre PICT '@!';
                                    VALID !EMPTY(cFecFacTre);
                                    WHEN {||HelpRead('FAVOR INGRESE LA FECHA DE FACTURACION')}
               ENDIF

	    ENDIF
**********FIN LECTURA DE CAMPO

**********LECTURA DE CAMPO
            IF nNroOpc == 1

               nNroFil++
               nColTem := nNroCol
               cTxtTem := 'FECHA PAGO OPORTUNO   :'

               IF nTipMod == 3
                  @ nNroFil,nColTem SAY cTxtTem
                  @ nNroFil,nColTem+LEN(cTxtTem)+1 SAY cPagOpoTre COLOR('I')
               ELSE
                  @ nNroFil,nColTem SAY cTxtTem;
                                    GET cPagOpoTre PICT '@!';
                                    VALID !EMPTY(cPagOpoTre);
                                    WHEN {||HelpRead('FAVOR INGRESE LA FECHA DE PAGO OPORTUNO')}
               ENDIF

	    ENDIF
**********FIN LECTURA DE CAMPO

**********LECTURA DE CAMPO
            IF nNroOpc == 1

               nNroFil++
               nColTem := nNroCol
               cTxtTem := 'FECHA PAGO EXTEMPORANE:'

               IF nTipMod == 3
                  @ nNroFil,nColTem SAY cTxtTem
                  @ nNroFil,nColTem+LEN(cTxtTem)+1 SAY cPagExtTre COLOR('I')
               ELSE
                  @ nNroFil,nColTem SAY cTxtTem;
                                    GET cPagExtTre PICT '@!';
                                    VALID !EMPTY(cPagExtTre);
                                    WHEN {||HelpRead('FAVOR INGRESE LA FECHA DE PAGO EXTEMPORANEO')}
               ENDIF

	    ENDIF
**********FIN LECTURA DE CAMPO

**********LECTURA DE CAMPO
            IF nNroOpc == 1

               nNroFil++
               nColTem := nNroCol
               cTxtTem := 'PERIODO FACTURADO     :'

               IF nTipMod == 3
                  @ nNroFil,nColTem SAY cTxtTem
                  @ nNroFil,nColTem+LEN(cTxtTem)+1 SAY cPerFacTre COLOR('I')
               ELSE
                  @ nNroFil,nColTem SAY cTxtTem;
                                    GET cPerFacTre PICT '@!';
                                    VALID !EMPTY(cPerFacTre);
                                    WHEN {||HelpRead('FAVOR INGRESE EL PERIODO FACTURADO')}
               ENDIF

	    ENDIF
**********FIN LECTURA DE CAMPO

**********LECTURA DE CAMPO
            IF nNroOpc == 1

               nNroFil++
               nColTem := nNroCol
               cTxtTem := 'CONCEPTO No.1         :'

               IF nTipMod == 3
                  @ nNroFil,nColTem SAY cTxtTem
                  @ nNroFil,nColTem+LEN(cTxtTem)+1 SAY cNomCo1Tre COLOR('I')
               ELSE
                  @ nNroFil,nColTem SAY cTxtTem;
                                    GET cNomCo1Tre PICT '@!';
                                    VALID !EMPTY(cNomCo1Tre);
                                    WHEN {||HelpRead('FAVOR INGRESE EL CONCEPTO No.1')}
               ENDIF

	    ENDIF
**********FIN LECTURA DE CAMPO

**********LECTURA DE CAMPO
            IF nNroOpc == 1

               nNroFil++
               nColTem := nNroCol
               cTxtTem := 'VALOR MORA No.1       :'

               IF nTipMod == 3
                  @ nNroFil,nColTem SAY cTxtTem
                  @ nNroFil,nColTem+LEN(cTxtTem)+1 SAY cVlrMo1Tre COLOR('I')
               ELSE
                  @ nNroFil,nColTem SAY cTxtTem;
                                    GET cVlrMo1Tre PICT '@!';
                                    VALID !EMPTY(cVlrMo1Tre);
                                    WHEN {||HelpRead('FAVOR INGRESE EL VALOR MORA  No.1')}
               ENDIF

	    ENDIF
**********FIN LECTURA DE CAMPO

**********LECTURA DE CAMPO
            IF nNroOpc == 1

               nNroFil++
               nColTem := nNroCol
               cTxtTem := 'VALOR MES No.1        :'

               IF nTipMod == 3
                  @ nNroFil,nColTem SAY cTxtTem
                  @ nNroFil,nColTem+LEN(cTxtTem)+1 SAY cVlrMe1Tre COLOR('I')
               ELSE
                  @ nNroFil,nColTem SAY cTxtTem;
                                    GET cVlrMe1Tre PICT '@!';
                                    VALID !EMPTY(cVlrMe1Tre);
                                    WHEN {||HelpRead('FAVOR INGRESE EL VALOR MES No.1')}
               ENDIF

	    ENDIF
**********FIN LECTURA DE CAMPO

**********LECTURA DE CAMPO
            IF nNroOpc == 1

               nNroFil++
               nColTem := nNroCol
               cTxtTem := 'VALOR TOTAL No.1      :'

               IF nTipMod == 3
                  @ nNroFil,nColTem SAY cTxtTem
                  @ nNroFil,nColTem+LEN(cTxtTem)+1 SAY cVlrTo1Tre COLOR('I')
               ELSE
                  @ nNroFil,nColTem SAY cTxtTem;
                                    GET cVlrTo1Tre PICT '@!';
                                    VALID !EMPTY(cVlrTo1Tre);
                                    WHEN {||HelpRead('FAVOR INGRESE EL VALOR TOTAL No.1')}
               ENDIF

	    ENDIF
**********FIN LECTURA DE CAMPO

**********LECTURA DE CAMPO
            IF nNroOpc == 1

               nNroFil++
               nColTem := nNroCol
               cTxtTem := 'CONCEPTO No.2         :'

               IF nTipMod == 3
                  @ nNroFil,nColTem SAY cTxtTem
                  @ nNroFil,nColTem+LEN(cTxtTem)+1 SAY cNomCo2Tre COLOR('I')
               ELSE
                  @ nNroFil,nColTem SAY cTxtTem;
                                    GET cNomCo2Tre PICT '@!';
                                    VALID !EMPTY(cNomCo2Tre);
                                    WHEN {||HelpRead('FAVOR INGRESE EL CONCEPTO No.2')}
               ENDIF

	    ENDIF
**********FIN LECTURA DE CAMPO

**********LECTURA DE CAMPO
            IF nNroOpc == 1

               nNroFil++
               nColTem := nNroCol
               cTxtTem := 'VALOR MORA No.1       :'

               IF nTipMod == 3
                  @ nNroFil,nColTem SAY cTxtTem
                  @ nNroFil,nColTem+LEN(cTxtTem)+1 SAY cVlrMo2Tre COLOR('I')
               ELSE
                  @ nNroFil,nColTem SAY cTxtTem;
                                    GET cVlrMo2Tre PICT '@!';
                                    VALID !EMPTY(cVlrMo2Tre);
                                    WHEN {||HelpRead('FAVOR INGRESE EL VALOR MORA  No.2')}
               ENDIF

	    ENDIF
**********FIN LECTURA DE CAMPO

**********LECTURA DE CAMPO
            IF nNroOpc == 1

               nNroFil++
               nColTem := nNroCol
               cTxtTem := 'VALOR MES No.2        :'

               IF nTipMod == 3
                  @ nNroFil,nColTem SAY cTxtTem
                  @ nNroFil,nColTem+LEN(cTxtTem)+1 SAY cVlrMe2Tre COLOR('I')
               ELSE
                  @ nNroFil,nColTem SAY cTxtTem;
                                    GET cVlrMe2Tre PICT '@!';
                                    VALID !EMPTY(cVlrMe2Tre);
                                    WHEN {||HelpRead('FAVOR INGRESE EL VALOR MES No.2')}
               ENDIF

	    ENDIF
**********FIN LECTURA DE CAMPO

**********LECTURA DE CAMPO
            IF nNroOpc == 1

               nNroFil++
               nColTem := nNroCol
               cTxtTem := 'VALOR TOTAL No.2      :'

               IF nTipMod == 3
                  @ nNroFil,nColTem SAY cTxtTem
                  @ nNroFil,nColTem+LEN(cTxtTem)+1 SAY cVlrTo2Tre COLOR('I')
               ELSE
                  @ nNroFil,nColTem SAY cTxtTem;
                                    GET cVlrTo2Tre PICT '@!';
                                    VALID !EMPTY(cVlrTo2Tre);
                                    WHEN {||HelpRead('FAVOR INGRESE EL VALOR TOTAL No.2')}
               ENDIF

	    ENDIF
**********FIN LECTURA DE CAMPO

**********LECTURA DE CAMPO
            IF nNroOpc == 1

               nNroFil++
               nColTem := nNroCol
               cTxtTem := 'CONCEPTO No.3         :'

               IF nTipMod == 3
                  @ nNroFil,nColTem SAY cTxtTem
                  @ nNroFil,nColTem+LEN(cTxtTem)+1 SAY cNomCo3Tre COLOR('I')
               ELSE
                  @ nNroFil,nColTem SAY cTxtTem;
                                    GET cNomCo3Tre PICT '@!';
                                    VALID !EMPTY(cNomCo3Tre);
                                    WHEN {||HelpRead('FAVOR INGRESE EL CONCEPTO No.3')}
               ENDIF

	    ENDIF
**********FIN LECTURA DE CAMPO

**********LECTURA DE CAMPO
            IF nNroOpc == 1

               nNroFil++
               nColTem := nNroCol
               cTxtTem := 'VALOR MORA No.1       :'

               IF nTipMod == 3
                  @ nNroFil,nColTem SAY cTxtTem
                  @ nNroFil,nColTem+LEN(cTxtTem)+1 SAY cVlrMo3Tre COLOR('I')
               ELSE
                  @ nNroFil,nColTem SAY cTxtTem;
                                    GET cVlrMo3Tre PICT '@!';
                                    VALID !EMPTY(cVlrMo3Tre);
                                    WHEN {||HelpRead('FAVOR INGRESE EL VALOR MORA  No.3')}
               ENDIF

	    ENDIF
**********FIN LECTURA DE CAMPO

**********LECTURA DE CAMPO
            IF nNroOpc == 1

               nNroFil++
               nColTem := nNroCol
               cTxtTem := 'VALOR MES No.3        :'

               IF nTipMod == 3
                  @ nNroFil,nColTem SAY cTxtTem
                  @ nNroFil,nColTem+LEN(cTxtTem)+1 SAY cVlrMe3Tre COLOR('I')
               ELSE
                  @ nNroFil,nColTem SAY cTxtTem;
                                    GET cVlrMe3Tre PICT '@!';
                                    VALID !EMPTY(cVlrMe3Tre);
                                    WHEN {||HelpRead('FAVOR INGRESE EL VALOR MES No.3')}
               ENDIF

	    ENDIF
**********FIN LECTURA DE CAMPO

**********LECTURA DE CAMPO
            IF nNroOpc == 1

               nNroFil++
               nColTem := nNroCol
               cTxtTem := 'VALOR TOTAL No.3      :'

               IF nTipMod == 3
                  @ nNroFil,nColTem SAY cTxtTem
                  @ nNroFil,nColTem+LEN(cTxtTem)+1 SAY cVlrTo3Tre COLOR('I')
               ELSE
                  @ nNroFil,nColTem SAY cTxtTem;
                                    GET cVlrTo3Tre PICT '@!';
                                    VALID !EMPTY(cVlrTo3Tre);
                                    WHEN {||HelpRead('FAVOR INGRESE EL VALOR TOTAL No.3')}
               ENDIF

	    ENDIF
**********FIN LECTURA DE CAMPO

**********LECTURA DE CAMPO
            IF nNroOpc == 1

               nNroFil++
               nColTem := nNroCol
               cTxtTem := 'CONCEPTO No.4         :'

               IF nTipMod == 3
                  @ nNroFil,nColTem SAY cTxtTem
                  @ nNroFil,nColTem+LEN(cTxtTem)+1 SAY cNomCo4Tre COLOR('I')
               ELSE
                  @ nNroFil,nColTem SAY cTxtTem;
                                    GET cNomCo4Tre PICT '@!';
                                    VALID !EMPTY(cNomCo4Tre);
                                    WHEN {||HelpRead('FAVOR INGRESE EL CONCEPTO No.4')}
               ENDIF

	    ENDIF
**********FIN LECTURA DE CAMPO

**********LECTURA DE CAMPO
            IF nNroOpc == 1

               nNroFil++
               nColTem := nNroCol
               cTxtTem := 'VALOR MORA No.1       :'

               IF nTipMod == 3
                  @ nNroFil,nColTem SAY cTxtTem
                  @ nNroFil,nColTem+LEN(cTxtTem)+1 SAY cVlrMo4Tre COLOR('I')
               ELSE
                  @ nNroFil,nColTem SAY cTxtTem;
                                    GET cVlrMo4Tre PICT '@!';
                                    VALID !EMPTY(cVlrMo4Tre);
                                    WHEN {||HelpRead('FAVOR INGRESE EL VALOR MORA  No.4')}
               ENDIF

	    ENDIF
**********FIN LECTURA DE CAMPO

**********LECTURA DE CAMPO
            IF nNroOpc == 1

               nNroFil++
               nColTem := nNroCol
               cTxtTem := 'VALOR MES No.4        :'

               IF nTipMod == 3
                  @ nNroFil,nColTem SAY cTxtTem
                  @ nNroFil,nColTem+LEN(cTxtTem)+1 SAY cVlrMe4Tre COLOR('I')
               ELSE
                  @ nNroFil,nColTem SAY cTxtTem;
                                    GET cVlrMe4Tre PICT '@!';
                                    VALID !EMPTY(cVlrMe4Tre);
                                    WHEN {||HelpRead('FAVOR INGRESE EL VALOR MES No.4')}
               ENDIF

	    ENDIF
**********FIN LECTURA DE CAMPO

**********LECTURA DE CAMPO
            IF nNroOpc == 1

               nNroFil++
               nColTem := nNroCol
               cTxtTem := 'VALOR TOTAL No.4      :'

               IF nTipMod == 3
                  @ nNroFil,nColTem SAY cTxtTem
                  @ nNroFil,nColTem+LEN(cTxtTem)+1 SAY cVlrTo4Tre COLOR('I')
               ELSE
                  @ nNroFil,nColTem SAY cTxtTem;
                                    GET cVlrTo4Tre PICT '@!';
                                    VALID !EMPTY(cVlrTo4Tre);
                                    WHEN {||HelpRead('FAVOR INGRESE EL VALOR TOTAL No.4')}
               ENDIF

	    ENDIF
**********FIN LECTURA DE CAMPO

**********LECTURA DE CAMPO
            IF nNroOpc == 1

               nNroFil++
               nColTem := nNroCol
               cTxtTem := 'CONCEPTO No.5         :'

               IF nTipMod == 3
                  @ nNroFil,nColTem SAY cTxtTem
                  @ nNroFil,nColTem+LEN(cTxtTem)+1 SAY cNomCo5Tre COLOR('I')
               ELSE
                  @ nNroFil,nColTem SAY cTxtTem;
                                    GET cNomCo5Tre PICT '@!';
                                    VALID !EMPTY(cNomCo5Tre);
                                    WHEN {||HelpRead('FAVOR INGRESE EL CONCEPTO No.5')}
               ENDIF

	    ENDIF
**********FIN LECTURA DE CAMPO

**********LECTURA DE CAMPO
            IF nNroOpc == 1

               nNroFil++
               nColTem := nNroCol
               cTxtTem := 'VALOR MORA No.1       :'

               IF nTipMod == 3
                  @ nNroFil,nColTem SAY cTxtTem
                  @ nNroFil,nColTem+LEN(cTxtTem)+1 SAY cVlrMo5Tre COLOR('I')
               ELSE
                  @ nNroFil,nColTem SAY cTxtTem;
                                    GET cVlrMo5Tre PICT '@!';
                                    VALID !EMPTY(cVlrMo5Tre);
                                    WHEN {||HelpRead('FAVOR INGRESE EL VALOR MORA  No.5')}
               ENDIF

	    ENDIF
**********FIN LECTURA DE CAMPO

**********LECTURA DE CAMPO
            IF nNroOpc == 1

               nNroFil++
               nColTem := nNroCol
               cTxtTem := 'VALOR MES No.5        :'

               IF nTipMod == 3
                  @ nNroFil,nColTem SAY cTxtTem
                  @ nNroFil,nColTem+LEN(cTxtTem)+1 SAY cVlrMe5Tre COLOR('I')
               ELSE
                  @ nNroFil,nColTem SAY cTxtTem;
                                    GET cVlrMe5Tre PICT '@!';
                                    VALID !EMPTY(cVlrMe5Tre);
                                    WHEN {||HelpRead('FAVOR INGRESE EL VALOR MES No.5')}
               ENDIF

	    ENDIF
**********FIN LECTURA DE CAMPO

**********LECTURA DE CAMPO
            IF nNroOpc == 1

               nNroFil++
               nColTem := nNroCol
               cTxtTem := 'VALOR TOTAL No.5      :'

               IF nTipMod == 3
                  @ nNroFil,nColTem SAY cTxtTem
                  @ nNroFil,nColTem+LEN(cTxtTem)+1 SAY cVlrTo5Tre COLOR('I')
               ELSE
                  @ nNroFil,nColTem SAY cTxtTem;
                                    GET cVlrTo5Tre PICT '@!';
                                    VALID !EMPTY(cVlrTo5Tre);
                                    WHEN {||HelpRead('FAVOR INGRESE EL VALOR TOTAL No.5')}
               ENDIF

	    ENDIF
**********FIN LECTURA DE CAMPO

**********LECTURA DE CAMPO
            IF nNroOpc == 1

               nNroFil++
               nColTem := nNroCol
               cTxtTem := 'CONCEPTO No.6         :'

               IF nTipMod == 3
                  @ nNroFil,nColTem SAY cTxtTem
                  @ nNroFil,nColTem+LEN(cTxtTem)+1 SAY cNomCo6Tre COLOR('I')
               ELSE
                  @ nNroFil,nColTem SAY cTxtTem;
                                    GET cNomCo6Tre PICT '@!';
                                    VALID !EMPTY(cNomCo6Tre);
                                    WHEN {||HelpRead('FAVOR INGRESE EL CONCEPTO No.6')}
               ENDIF

	    ENDIF
**********FIN LECTURA DE CAMPO

**********LECTURA DE CAMPO
            IF nNroOpc == 1

               nNroFil++
               nColTem := nNroCol
               cTxtTem := 'VALOR MORA No.1       :'

               IF nTipMod == 3
                  @ nNroFil,nColTem SAY cTxtTem
                  @ nNroFil,nColTem+LEN(cTxtTem)+1 SAY cVlrMo6Tre COLOR('I')
               ELSE
                  @ nNroFil,nColTem SAY cTxtTem;
                                    GET cVlrMo6Tre PICT '@!';
                                    VALID !EMPTY(cVlrMo6Tre);
                                    WHEN {||HelpRead('FAVOR INGRESE EL VALOR MORA  No.6')}
               ENDIF

	    ENDIF
**********FIN LECTURA DE CAMPO

**********LECTURA DE CAMPO
            IF nNroOpc == 1

               nNroFil++
               nColTem := nNroCol
               cTxtTem := 'VALOR MES No.6        :'

               IF nTipMod == 3
                  @ nNroFil,nColTem SAY cTxtTem
                  @ nNroFil,nColTem+LEN(cTxtTem)+1 SAY cVlrMe6Tre COLOR('I')
               ELSE
                  @ nNroFil,nColTem SAY cTxtTem;
                                    GET cVlrMe6Tre PICT '@!';
                                    VALID !EMPTY(cVlrMe6Tre);
                                    WHEN {||HelpRead('FAVOR INGRESE EL VALOR MES No.6')}
               ENDIF

	    ENDIF
**********FIN LECTURA DE CAMPO

**********LECTURA DE CAMPO
            IF nNroOpc == 1

               nNroFil++
               nColTem := nNroCol
               cTxtTem := 'VALOR TOTAL No.6      :'

               IF nTipMod == 3
                  @ nNroFil,nColTem SAY cTxtTem
                  @ nNroFil,nColTem+LEN(cTxtTem)+1 SAY cVlrTo6Tre COLOR('I')
               ELSE
                  @ nNroFil,nColTem SAY cTxtTem;
                                    GET cVlrTo6Tre PICT '@!';
                                    VALID !EMPTY(cVlrTo6Tre);
                                    WHEN {||HelpRead('FAVOR INGRESE EL VALOR TOTAL No.6')}
               ENDIF

	    ENDIF
**********FIN LECTURA DE CAMPO

**********LECTURA DE CAMPO
            IF nNroOpc == 1

               nNroFil++
               nColTem := nNroCol
               cTxtTem := 'CONCEPTO No.7         :'

               IF nTipMod == 3
                  @ nNroFil,nColTem SAY cTxtTem
                  @ nNroFil,nColTem+LEN(cTxtTem)+1 SAY cNomCo7Tre COLOR('I')
               ELSE
                  @ nNroFil,nColTem SAY cTxtTem;
                                    GET cNomCo7Tre PICT '@!';
                                    VALID !EMPTY(cNomCo7Tre);
                                    WHEN {||HelpRead('FAVOR INGRESE EL CONCEPTO No.7')}
               ENDIF

	    ENDIF
**********FIN LECTURA DE CAMPO

**********LECTURA DE CAMPO
            IF nNroOpc == 1

               nNroFil++
               nColTem := nNroCol
               cTxtTem := 'VALOR MORA No.1       :'

               IF nTipMod == 3
                  @ nNroFil,nColTem SAY cTxtTem
                  @ nNroFil,nColTem+LEN(cTxtTem)+1 SAY cVlrMo7Tre COLOR('I')
               ELSE
                  @ nNroFil,nColTem SAY cTxtTem;
                                    GET cVlrMo7Tre PICT '@!';
                                    VALID !EMPTY(cVlrMo7Tre);
                                    WHEN {||HelpRead('FAVOR INGRESE EL VALOR MORA  No.7')}
               ENDIF

	    ENDIF
**********FIN LECTURA DE CAMPO

**********LECTURA DE CAMPO
            IF nNroOpc == 1

               nNroFil++
               nColTem := nNroCol
               cTxtTem := 'VALOR MES No.7        :'

               IF nTipMod == 3
                  @ nNroFil,nColTem SAY cTxtTem
                  @ nNroFil,nColTem+LEN(cTxtTem)+1 SAY cVlrMe7Tre COLOR('I')
               ELSE
                  @ nNroFil,nColTem SAY cTxtTem;
                                    GET cVlrMe7Tre PICT '@!';
                                    VALID !EMPTY(cVlrMe7Tre);
                                    WHEN {||HelpRead('FAVOR INGRESE EL VALOR MES No.7')}
               ENDIF

	    ENDIF
**********FIN LECTURA DE CAMPO

**********LECTURA DE CAMPO
            IF nNroOpc == 1

               nNroFil++
               nColTem := nNroCol
               cTxtTem := 'VALOR TOTAL No.7      :'

               IF nTipMod == 3
                  @ nNroFil,nColTem SAY cTxtTem
                  @ nNroFil,nColTem+LEN(cTxtTem)+1 SAY cVlrTo7Tre COLOR('I')
               ELSE
                  @ nNroFil,nColTem SAY cTxtTem;
                                    GET cVlrTo7Tre PICT '@!';
                                    VALID !EMPTY(cVlrTo7Tre);
                                    WHEN {||HelpRead('FAVOR INGRESE EL VALOR TOTAL No.7')}
               ENDIF

	    ENDIF
**********FIN LECTURA DE CAMPO

**********LECTURA DE CAMPO
            IF nNroOpc == 1

               nNroFil++
               nColTem := nNroCol
               cTxtTem := 'CONCEPTO No.8         :'

               IF nTipMod == 3
                  @ nNroFil,nColTem SAY cTxtTem
                  @ nNroFil,nColTem+LEN(cTxtTem)+1 SAY cNomCo8Tre COLOR('I')
               ELSE
                  @ nNroFil,nColTem SAY cTxtTem;
                                    GET cNomCo8Tre PICT '@!';
                                    VALID !EMPTY(cNomCo8Tre);
                                    WHEN {||HelpRead('FAVOR INGRESE EL CONCEPTO No.8')}
               ENDIF

	    ENDIF
**********FIN LECTURA DE CAMPO

**********LECTURA DE CAMPO
            IF nNroOpc == 1

               nNroFil++
               nColTem := nNroCol
               cTxtTem := 'VALOR MORA No.1       :'

               IF nTipMod == 3
                  @ nNroFil,nColTem SAY cTxtTem
                  @ nNroFil,nColTem+LEN(cTxtTem)+1 SAY cVlrMo8Tre COLOR('I')
               ELSE
                  @ nNroFil,nColTem SAY cTxtTem;
                                    GET cVlrMo8Tre PICT '@!';
                                    VALID !EMPTY(cVlrMo8Tre);
                                    WHEN {||HelpRead('FAVOR INGRESE EL VALOR MORA  No.8')}
               ENDIF

	    ENDIF
**********FIN LECTURA DE CAMPO

**********LECTURA DE CAMPO
            IF nNroOpc == 1

               nNroFil++
               nColTem := nNroCol
               cTxtTem := 'VALOR MES No.8        :'

               IF nTipMod == 3
                  @ nNroFil,nColTem SAY cTxtTem
                  @ nNroFil,nColTem+LEN(cTxtTem)+1 SAY cVlrMe8Tre COLOR('I')
               ELSE
                  @ nNroFil,nColTem SAY cTxtTem;
                                    GET cVlrMe8Tre PICT '@!';
                                    VALID !EMPTY(cVlrMe8Tre);
                                    WHEN {||HelpRead('FAVOR INGRESE EL VALOR MES No.8')}
               ENDIF

	    ENDIF
**********FIN LECTURA DE CAMPO

**********LECTURA DE CAMPO
            IF nNroOpc == 1

               nNroFil++
               nColTem := nNroCol
               cTxtTem := 'VALOR TOTAL No.8      :'

               IF nTipMod == 3
                  @ nNroFil,nColTem SAY cTxtTem
                  @ nNroFil,nColTem+LEN(cTxtTem)+1 SAY cVlrTo8Tre COLOR('I')
               ELSE
                  @ nNroFil,nColTem SAY cTxtTem;
                                    GET cVlrTo8Tre PICT '@!';
                                    VALID !EMPTY(cVlrTo8Tre);
                                    WHEN {||HelpRead('FAVOR INGRESE EL VALOR TOTAL No.8')}
               ENDIF

	    ENDIF
**********FIN LECTURA DE CAMPO

**********LECTURA DE CAMPO
            IF nNroOpc == 1

               nNroFil++
               nColTem := nNroCol
               cTxtTem := 'CONCEPTO No.9         :'

               IF nTipMod == 3
                  @ nNroFil,nColTem SAY cTxtTem
                  @ nNroFil,nColTem+LEN(cTxtTem)+1 SAY cNomCo9Tre COLOR('I')
               ELSE
                  @ nNroFil,nColTem SAY cTxtTem;
                                    GET cNomCo9Tre PICT '@!';
                                    VALID !EMPTY(cNomCo9Tre);
                                    WHEN {||HelpRead('FAVOR INGRESE EL CONCEPTO No.9')}
               ENDIF

	    ENDIF
**********FIN LECTURA DE CAMPO

**********LECTURA DE CAMPO
            IF nNroOpc == 1

               nNroFil++
               nColTem := nNroCol
               cTxtTem := 'VALOR MORA No.1       :'

               IF nTipMod == 3
                  @ nNroFil,nColTem SAY cTxtTem
                  @ nNroFil,nColTem+LEN(cTxtTem)+1 SAY cVlrMo9Tre COLOR('I')
               ELSE
                  @ nNroFil,nColTem SAY cTxtTem;
                                    GET cVlrMo9Tre PICT '@!';
                                    VALID !EMPTY(cVlrMo9Tre);
                                    WHEN {||HelpRead('FAVOR INGRESE EL VALOR MORA  No.9')}
               ENDIF

	    ENDIF
**********FIN LECTURA DE CAMPO

**********LECTURA DE CAMPO
            IF nNroOpc == 1

               nNroFil++
               nColTem := nNroCol
               cTxtTem := 'VALOR MES No.9        :'

               IF nTipMod == 3
                  @ nNroFil,nColTem SAY cTxtTem
                  @ nNroFil,nColTem+LEN(cTxtTem)+1 SAY cVlrMe9Tre COLOR('I')
               ELSE
                  @ nNroFil,nColTem SAY cTxtTem;
                                    GET cVlrMe9Tre PICT '@!';
                                    VALID !EMPTY(cVlrMe9Tre);
                                    WHEN {||HelpRead('FAVOR INGRESE EL VALOR MES No.9')}
               ENDIF

	    ENDIF
**********FIN LECTURA DE CAMPO

**********LECTURA DE CAMPO
            IF nNroOpc == 1

               nNroFil++
               nColTem := nNroCol
               cTxtTem := 'VALOR TOTAL No.9      :'

               IF nTipMod == 3
                  @ nNroFil,nColTem SAY cTxtTem
                  @ nNroFil,nColTem+LEN(cTxtTem)+1 SAY cVlrTo9Tre COLOR('I')
               ELSE
                  @ nNroFil,nColTem SAY cTxtTem;
                                    GET cVlrTo9Tre PICT '@!';
                                    VALID !EMPTY(cVlrTo9Tre);
                                    WHEN {||HelpRead('FAVOR INGRESE EL VALOR TOTAL No.9')}
               ENDIF

	    ENDIF
**********FIN LECTURA DE CAMPO

**********LECTURA DE CAMPO
            IF nNroOpc == 1

               nNroFil++
               nColTem := nNroCol
               cTxtTem := 'VALOR OPORTUNO        :'

               IF nTipMod == 3
                  @ nNroFil,nColTem SAY cTxtTem
                  @ nNroFil,nColTem+LEN(cTxtTem)+1 SAY cVlrOpoTre COLOR('I')
               ELSE
                  @ nNroFil,nColTem SAY cTxtTem;
                                    GET cVlrOpoTre PICT '@!';
                                    VALID !EMPTY(cVlrOpoTre);
                                    WHEN {||HelpRead('FAVOR INGRESE EL VALOR VALOR OPORTUNO')}
               ENDIF

	    ENDIF
**********FIN LECTURA DE CAMPO

**********LECTURA DE CAMPO
            IF nNroOpc == 1

               nNroFil++
               nColTem := nNroCol
               cTxtTem := 'VALOR EXTEMPORANEO    :'

               IF nTipMod == 3
                  @ nNroFil,nColTem SAY cTxtTem
                  @ nNroFil,nColTem+LEN(cTxtTem)+1 SAY cVlrExtTre COLOR('I')
               ELSE
                  @ nNroFil,nColTem SAY cTxtTem;
                                    GET cVlrExtTre PICT '@!';
                                    VALID !EMPTY(cVlrExtTre);
                                    WHEN {||HelpRead('FAVOR INGRESE EL VALOR VALOR EXTEMPORANEO')}
               ENDIF

	    ENDIF
**********FIN LECTURA DE CAMPO

**********LECTURA DE CAMPO
            IF nNroOpc == 1

               nNroFil++
               nColTem := nNroCol
               cTxtTem := 'CODIGO BARRA OPORTUNO :'

               IF nTipMod == 3
                  @ nNroFil,nColTem SAY cTxtTem
                  @ nNroFil,nColTem+LEN(cTxtTem)+1 SAY cBarOpoTre COLOR('I')
               ELSE
                  @ nNroFil,nColTem SAY cTxtTem;
                                    GET cBarOpoTre PICT '@!';
                                    VALID !EMPTY(cBarOpoTre);
                                    WHEN {||HelpRead('FAVOR INGRESE EL CODIGO BARRA OPORTUNO')}
               ENDIF

	    ENDIF
**********FIN LECTURA DE CAMPO

**********LECTURA DE CAMPO
            IF nNroOpc == 1

               nNroFil++
               nColTem := nNroCol
               cTxtTem := 'CODIGO BARRA EXTEMPORA:'

               IF nTipMod == 3
                  @ nNroFil,nColTem SAY cTxtTem
                  @ nNroFil,nColTem+LEN(cTxtTem)+1 SAY cBarExtTre COLOR('I')
               ELSE
                  @ nNroFil,nColTem SAY cTxtTem;
                                    GET cBarExtTre PICT '@!';
                                    VALID !EMPTY(cBarExtTre);
                                    WHEN {||HelpRead('FAVOR INGRESE EL CODIGO BARRA EXTEMPORANEO')}
               ENDIF

	    ENDIF
**********FIN LECTURA DE CAMPO

**********LECTURA DE CAMPO
            IF nNroOpc == 1

               nNroFil++
               nColTem := nNroCol
               cTxtTem := 'TEXTO No.1            :'

               IF nTipMod == 3
                  @ nNroFil,nColTem SAY cTxtTem
                  @ nNroFil,nColTem+LEN(cTxtTem)+1 SAY cTxtUnoTre COLOR('I')
               ELSE
                  @ nNroFil,nColTem SAY cTxtTem;
                                    GET cTxtUnoTre PICT '@!';
                                    VALID !EMPTY(cTxtUnoTre);
                                    WHEN {||HelpRead('FAVOR INGRESE EL TEXTO No.1')}
               ENDIF

	    ENDIF
**********FIN LECTURA DE CAMPO

**********LECTURA DE CAMPO
            IF nNroOpc == 1

               nNroFil++
               nColTem := nNroCol
               cTxtTem := 'TEXTO No.2            :'

               IF nTipMod == 3
                  @ nNroFil,nColTem SAY cTxtTem
                  @ nNroFil,nColTem+LEN(cTxtTem)+1 SAY cTxtDosTre COLOR('I')
               ELSE
                  @ nNroFil,nColTem SAY cTxtTem;
                                    GET cTxtDosTre PICT '@!';
                                    VALID !EMPTY(cTxtDosTre);
                                    WHEN {||HelpRead('FAVOR INGRESE EL TEXTO No.2')}
               ENDIF

	    ENDIF
**********FIN LECTURA DE CAMPO

**********LECTURA DE CAMPO
            IF nNroOpc == 1

               nNroFil++
               nColTem := nNroCol
               cTxtTem := 'CODE QR               :'

               IF nTipMod == 3
                  @ nNroFil,nColTem SAY cTxtTem
                  @ nNroFil,nColTem+LEN(cTxtTem)+1 SAY cCodeQrTre COLOR('I')
               ELSE
                  @ nNroFil,nColTem SAY cTxtTem;
                                    GET cCodeQrTre PICT '@!';
                                    VALID !EMPTY(cCodeQrTre);
                                    WHEN {||HelpRead('FAVOR INGRESE EL CODIGO QR')}
               ENDIF

	    ENDIF
**********FIN LECTURA DE CAMPO

**********LECTURA DE CAMPO
            IF nNroOpc == 1

               nNroFil++
               nColTem := nNroCol
               cTxtTem := 'DOCUMENTO CONTRATANTE :'

               IF nTipMod == 3
                  @ nNroFil,nColTem SAY cTxtTem
                  @ nNroFil,nColTem+LEN(cTxtTem)+1 SAY cNitCn1Tre COLOR('I')
               ELSE
                  @ nNroFil,nColTem SAY cTxtTem;
                                    GET cNitCn1Tre PICT '@!';
                                    VALID !EMPTY(cNitCn1Tre);
                                    WHEN {||HelpRead('FAVOR INGRESE EL DOCUMENTO CONTRATANTE No.1')}
               ENDIF

	    ENDIF
**********FIN LECTURA DE CAMPO

**********LECTURA DE CAMPO
            IF nNroOpc == 1

               nNroFil++
               nColTem := nNroCol
               cTxtTem := 'NOMBRE CONTRATANTE No.:'

               IF nTipMod == 3
                  @ nNroFil,nColTem SAY cTxtTem
                  @ nNroFil,nColTem+LEN(cTxtTem)+1 SAY cNomCn1Tre COLOR('I')
               ELSE
                  @ nNroFil,nColTem SAY cTxtTem;
                                    GET cNomCn1Tre PICT '@!';
                                    VALID !EMPTY(cNomCn1Tre);
                                    WHEN {||HelpRead('FAVOR INGRESE EL NOMBRE CONTRATANTE No.1')}
               ENDIF

	    ENDIF
**********FIN LECTURA DE CAMPO

**********LECTURA DE CAMPO
            IF nNroOpc == 1

               nNroFil++
               nColTem := nNroCol
               cTxtTem := 'MAIL CONTRATANTE No.1 :'

               IF nTipMod == 3
                  @ nNroFil,nColTem SAY cTxtTem
                  @ nNroFil,nColTem+LEN(cTxtTem)+1 SAY cMaiCn1Tre COLOR('I')
               ELSE
                  @ nNroFil,nColTem SAY cTxtTem;
                                    GET cMaiCn1Tre PICT '@!';
                                    VALID !EMPTY(cMaiCn1Tre);
                                    WHEN {||HelpRead('FAVOR INGRESE EL MAIL CONTRATANTE No.1')}
               ENDIF

	    ENDIF
**********FIN LECTURA DE CAMPO

**********LECTURA DE CAMPO
            IF nNroOpc == 1

               nNroFil++
               nColTem := nNroCol
               cTxtTem := 'PWD CONTRATANTE No.1  :'

               IF nTipMod == 3
                  @ nNroFil,nColTem SAY cTxtTem
                  @ nNroFil,nColTem+LEN(cTxtTem)+1 SAY cPwdCn1Tre COLOR('I')
               ELSE
                  @ nNroFil,nColTem SAY cTxtTem;
                                    GET cPwdCn1Tre PICT '@!';
                                    VALID !EMPTY(cPwdCn1Tre);
                                    WHEN {||HelpRead('FAVOR INGRESE EL NOMBRE CONTRATANTE No.1')}
               ENDIF

	    ENDIF
**********FIN LECTURA DE CAMPO

**********LECTURA DE CAMPO
            IF nNroOpc == 1

               nNroFil++
               nColTem := nNroCol
               cTxtTem := 'DOCUMENTO CONTRATANTE :'

               IF nTipMod == 3
                  @ nNroFil,nColTem SAY cTxtTem
                  @ nNroFil,nColTem+LEN(cTxtTem)+1 SAY cNitCn2Tre COLOR('I')
               ELSE
                  @ nNroFil,nColTem SAY cTxtTem;
                                    GET cNitCn2Tre PICT '@!';
                                    VALID !EMPTY(cNitCn2Tre);
                                    WHEN {||HelpRead('FAVOR INGRESE EL DOCUMENTO CONTRATANTE No.2')}
               ENDIF

	    ENDIF
**********FIN LECTURA DE CAMPO

**********LECTURA DE CAMPO
            IF nNroOpc == 1

               nNroFil++
               nColTem := nNroCol
               cTxtTem := 'NOMBRE CONTRATANTE No.:'

               IF nTipMod == 3
                  @ nNroFil,nColTem SAY cTxtTem
                  @ nNroFil,nColTem+LEN(cTxtTem)+1 SAY cNomCn2Tre COLOR('I')
               ELSE
                  @ nNroFil,nColTem SAY cTxtTem;
                                    GET cNomCn2Tre PICT '@!';
                                    VALID !EMPTY(cNomCn2Tre);
                                    WHEN {||HelpRead('FAVOR INGRESE EL NOMBRE CONTRATANTE No.2')}
               ENDIF

	    ENDIF
**********FIN LECTURA DE CAMPO

**********LECTURA DE CAMPO
            IF nNroOpc == 1

               nNroFil++
               nColTem := nNroCol
               cTxtTem := 'MAIL CONTRATANTE No.2 :'

               IF nTipMod == 3
                  @ nNroFil,nColTem SAY cTxtTem
                  @ nNroFil,nColTem+LEN(cTxtTem)+1 SAY cMaiCn2Tre COLOR('I')
               ELSE
                  @ nNroFil,nColTem SAY cTxtTem;
                                    GET cMaiCn2Tre PICT '@!';
                                    VALID !EMPTY(cMaiCn2Tre);
                                    WHEN {||HelpRead('FAVOR INGRESE EL MAIL CONTRATANTE No.2')}
               ENDIF

	    ENDIF
**********FIN LECTURA DE CAMPO

**********LECTURA DE CAMPO
            IF nNroOpc == 1

               nNroFil++
               nColTem := nNroCol
               cTxtTem := 'PWD CONTRATANTE No.2  :'

               IF nTipMod == 3
                  @ nNroFil,nColTem SAY cTxtTem
                  @ nNroFil,nColTem+LEN(cTxtTem)+1 SAY cPwdCn2Tre COLOR('I')
               ELSE
                  @ nNroFil,nColTem SAY cTxtTem;
                                    GET cPwdCn2Tre PICT '@!';
                                    VALID !EMPTY(cPwdCn2Tre);
                                    WHEN {||HelpRead('FAVOR INGRESE EL NOMBRE CONTRATANTE No.2')}
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
       SELECT RFA
       IF nTipMod # 3 .AND. lGrabar

          lInsReg := IF(nTipMod == 1,.T.,.F.)
          IF RFA->(lRegLock(lShared,lInsReg))

             IF lInsReg
                REPL RFA->nIdeCodRfa WITH RFA->(RECNO())
                REPL RFA->cCodigoEst WITH cCodigo
             ENDIF

             REPL RFA->nMesIniPag WITH nMesIniTre
             REPL RFA->nMesFinPag WITH nMesFinTre
             REPL RFA->cEmpPalRec WITH cEmpPalTre
             REPL RFA->cNroNitRec WITH cNroNitTre
             REPL RFA->cNomEmpRec WITH cNomEmpTre
             REPL RFA->cCodEmpCon WITH cCodEmpTre
             REPL RFA->cCodFacCar WITH cCodFacTre
             REPL RFA->cNroFacCaA WITH cNroFacTre
             REPL RFA->cNomBanRec WITH cNomBanTre
             REPL RFA->cCodEanRec WITH cCodEanTre
             REPL RFA->cNroCtaBan WITH cNroCtaTre
             REPL RFA->cNombreRec WITH cNombreTre
             REPL RFA->cCodRefRec WITH cCodRefTre
             REPL RFA->cCodigoGru WITH cCodigoTre
             REPL RFA->cFecFacPag WITH cFecFacTre
             REPL RFA->cPagOpoPag WITH cPagOpoTre
             REPL RFA->cPagExtPag WITH cPagExtTre
             REPL RFA->cPerFacRec WITH cPerFacTre
             REPL RFA->cNomCo1Rec WITH cNomCo1Tre
             REPL RFA->cVlrMo1Rec WITH cVlrMo1Tre
             REPL RFA->cVlrMe1Rec WITH cVlrMe1Tre
             REPL RFA->cVlrTo1Rec WITH cVlrTo1Tre
             REPL RFA->cNomCo2Rec WITH cNomCo2Tre
             REPL RFA->cVlrMo2Rec WITH cVlrMo2Tre
             REPL RFA->cVlrMe2Rec WITH cVlrMe2Tre
             REPL RFA->cVlrTo2Rec WITH cVlrTo2Tre
             REPL RFA->cNomCo3Rec WITH cNomCo3Tre
             REPL RFA->cVlrMo3Rec WITH cVlrMo3Tre
             REPL RFA->cVlrMe3Rec WITH cVlrMe3Tre
             REPL RFA->cVlrTo3Rec WITH cVlrTo3Tre
             REPL RFA->cNomCo4Rec WITH cNomCo4Tre
             REPL RFA->cVlrMo4Rec WITH cVlrMo4Tre
             REPL RFA->cVlrMe4Rec WITH cVlrMe4Tre
             REPL RFA->cVlrTo4Rec WITH cVlrTo4Tre
             REPL RFA->cNomCo5Rec WITH cNomCo5Tre
             REPL RFA->cVlrMo5Rec WITH cVlrMo5Tre
             REPL RFA->cVlrMe5Rec WITH cVlrMe5Tre
             REPL RFA->cVlrTo5Rec WITH cVlrTo5Tre
             REPL RFA->cNomCo6Rec WITH cNomCo6Tre
             REPL RFA->cVlrMo6Rec WITH cVlrMo6Tre
             REPL RFA->cVlrMe6Rec WITH cVlrMe6Tre
             REPL RFA->cVlrTo6Rec WITH cVlrTo6Tre
             REPL RFA->cNomCo7Rec WITH cNomCo7Tre
             REPL RFA->cVlrMo7Rec WITH cVlrMo7Tre
             REPL RFA->cVlrMe7Rec WITH cVlrMe7Tre
             REPL RFA->cVlrTo7Rec WITH cVlrTo7Tre
             REPL RFA->cNomCo8Rec WITH cNomCo8Tre
             REPL RFA->cVlrMo8Rec WITH cVlrMo8Tre
             REPL RFA->cVlrMe8Rec WITH cVlrMe8Tre
             REPL RFA->cVlrTo8Rec WITH cVlrTo8Tre
             REPL RFA->cNomCo9Rec WITH cNomCo9Tre
             REPL RFA->cVlrMo9Rec WITH cVlrMo9Tre
             REPL RFA->cVlrMe9Rec WITH cVlrMe9Tre
             REPL RFA->cVlrTo9Rec WITH cVlrTo9Tre
             REPL RFA->cVlrOpoRec WITH cVlrOpoTre
             REPL RFA->cVlrExtRec WITH cVlrExtTre
             REPL RFA->cBarOpoRec WITH cBarOpoTre
             REPL RFA->cBarExtRec WITH cBarExtTre
             REPL RFA->cTxtUnoRec WITH cTxtUnoTre
             REPL RFA->cTxtDosRec WITH cTxtDosTre
             REPL RFA->cCodeQrRec WITH cCodeQrTre
             REPL RFA->cNitCn1Rec WITH cNitCn1Tre
             REPL RFA->cNomCn1Rec WITH cNomCn1Tre
             REPL RFA->cMaiCn1Rec WITH cMaiCn1Tre
             REPL RFA->cPwdCn1Rec WITH cPwdCn1Tre
             REPL RFA->cNitCn2Rec WITH cNitCn2Tre
             REPL RFA->cNomCn2Rec WITH cNomCn2Tre
             REPL RFA->cMaiCn2Rec WITH cMaiCn2Tre
             REPL RFA->cPwdCn2Rec WITH cPwdCn2Tre

             REPL RFA->cNomUsrRfa WITH cNomUsr
             REPL RFA->dFecUsrRfa WITH DATE()
             REPL RFA->cHorUsrRfa WITH TIME()
             RFA->(DBCOMMIT())
          ENDIF

          IF lShared
             RFA->(DBUNLOCK())
          ENDIF

       ENDIF
       RESTSCREEN(0,0,24,79,cSavPan)
       SETCURSOR(nTipCur)
*>>>>FIN GRABACION DEL REGISTRO

*>>>>REFRESCAR EL BROWSE
       IF nTipMod == 2
          nNroReg := RFA->(RECNO())
          RFA->(DBGOTOP())
          oBrowse:GOTOP()
          RFA->(DBGOTO(nNroReg))
          oBrowse:FORCESTABLE()
       ENDIF
       RETURN .T.
*>>>>FIN REFRESCAR EL BROWSE

/*************************************************************************
* TITULO..: VALIDACION DE EXISTENCIA DEL CODIGO                          *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: OCT  8/2014 MIE A
       Colombia, Bucaramanga        INICIO: 10:21 AM   OCT  8/2014 MIE

OBJETIVOS:

1- Debe estar en uso el archivo.

2- Realiza la validaci¢n de existencia del C¢digo.

3- Retorna .T. si hay problemas

SINTAXIS:

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION lValCodRfa(cCodigo)

*>>>>DESCRIPCION DE PARAMETROS
/*     cCodigo                              // C¢digo a Validar */
*>>>>FIN DESCRIPCION DE PARAMETROS

*>>>>DECLARACION DE VARIABLES
       LOCAL lHayErr := .F.                 // .T. Hay Error
*>>>>FIN DECLARACION DE VARIABLES

*>>>>VALIDACION DEL CODIGO
       IF cCodigo # cSpaces('RFA','cCodigoEst')
          IF lLocCodigo('cCodigoEst','RFA',cCodigo)
             cError('ESTE CODIGO YA EXISTE')
             lHayErr := .T.
          ENDIF
       ENDIF
       RETURN lHayErr
*>>>>FIN VALIDACION DEL CODIGO

/*************************************************************************
* TITULO..: BUSQUEDA DEL CODIGO                                          *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: OCT  8/2014 MIE A
       Colombia, Bucaramanga        INICIO: 10:21 AM   OCT  8/2014 MIE

OBJETIVOS:

1- Permite localizar un c¢digo dentro del archivo.

2- Retorna NIL

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION BuscarRfa(oBrowse)

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
       cCodigo := cSpaces('RFA','cCodigoEst')
       TitBuscar(LEN(cCodigo),@nNroFil,@nNroCol)
       @ nNroFil,nNroCol GET cCodigo PICT '@!';
			 VALID lValRfa(ROW(),COL()-3,@cCodigo)
       READ
*>>>>FIN CAPTURA DEL CODIGO

*>>>>VALIDACION DEL CODIGO
       IF cCodigo == cSpaces('RFA','cCodigoEst')
          cError('PATRON DE BUSQUEDA NO ESPECIFICADO',;
                 'ADVERTENCIA')
          lBuscar := .F.
       ENDIF
*>>>>FIN VALIDACION DEL CODIGO

*>>>>BUSQUEDA DEL CODIGO
       SELECT RFA
       IF lBuscar .AND. lLocCodigo('cCodigoEst','RFA',cCodigo)
          nNroReg := RFA->(RECNO())
          RFA->(DBGOTOP())
          oBrowse:GOTOP()
          RFA->(DBGOTO(nNroReg))
          oBrowse:FORCESTABLE()
       ELSE
          oBrowse:GOTOP()
       ENDIF
       RETURN NIL
*>>>>FIN BUSQUEDA DEL CODIGO

/*************************************************************************
* TITULO..: VALIDACION DEL CODIGO                                        *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: OCT  8/2014 MIE A
       Colombia, Bucaramanga        INICIO: 10:21 AM   OCT  8/2014 MIE

OBJETIVOS:

1- Debe estar en uso el archivo

2- Realiza la validaci¢n del c¢digo

3- Retorna .T. si hay problemas

SINTAXIS:

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION lValRfa(nNroFil,nNroCol,cCodigo)

*>>>>DESCRIPCION DE PARAMETROS
/*     nNroFil                              // Fila de lectura
       nNroCol                              // Columna de lectura
       cCodigo                              // C¢digo a Validar */
*>>>>FIN DESCRIPCION DE PARAMETROS

*>>>>DECLARACION DE VARIABLES
       LOCAL nNroReg := 0                   // N£mero del Registro
*>>>>FIN DECLARACION DE VARIABLES

*>>>>VALIDACION DEL CODIGO
       IF !lLocCodigo('cCodigoEst','RFA',cCodigo)
          nNroReg := nSelRfa(nNroFil,nNroCol)
          IF nNroReg == 0
             cCodigo := cSpaces('RFA','cCodigoEst')
          ELSE
             RFA->(DBGOTO(nNroReg))
             cCodigo := RFA->cCodigoEst
          ENDIF
       ENDIF
       RETURN .T.
*>>>>FIN VALIDACION DEL CODIGO

/*************************************************************************
* TITULO..: SELECCION DEL CODIGO                                         *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: OCT  8/2014 MIE A
       Colombia, Bucaramanga        INICIO: 10:21 AM   OCT  8/2014 MIE

OBJETIVOS:

1- Debe estar en uso el archivo

2- Permite escoger el registro de acuerdo al c¢digo o descripci¢n

3- Retorna el n£mero del registro escogido

SINTAXIS:

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION nSelRfa(nNroFil,nNroCol)

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
       IF RFA->(RECCOUNT()) == 0
          cError('NO EXISTEN REGISTROS GRABADOS')
          RETURN 0
       ENDIF
*>>>>FIN VALIDACION DE CONTENIDOS DE ARCHIVOS

*>>>>INICIALIZACION DE LAS COORDENADAS
       SELECT RFA
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
       RFA->(DBGOTOP())
       cSavPan := SAVESCREEN(0,0,24,79)
       @ nFilSup-1,nColSup-1 TO nFilInf,nColInf+1 DOUBLE
       nNroReg := nBrowseDbf(nFilSup,nColSup,nFilInf-1,nColInf,;
			     {||RFA->cCodigoEst})
       RESTSCREEN(0,0,24,79,cSavPan)
       RETURN nNroReg
*>>>>FIN SELECCION DEL CODIGO

/*************************************************************************
* TITULO..: MENU DE OTROS PARA EL ARCHIVO                                *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: OCT  8/2014 MIE A
       Colombia, Bucaramanga        INICIO: 10:21 AM   OCT  8/2014 MIE

OBJETIVOS:

1- Menu de Otros para el archivo

2- Retorna NIL

SINTAXIS:

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION MenuOtrRfa(lShared,nModCry,cNomSis,cCodEmp,cNitEmp,cEmpPal,;
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
       AADD(aMenus,'1<RECIBOS FACTURADOS>')

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
            OtrRfa011(lShared,nModCry,cNomSis,cCodEmp,cNitEmp,cEmpPal,;
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

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: OCT  8/2014 MIE A
       Colombia, Bucaramanga        INICIO: 10:21 AM   OCT  8/2014 MIE

OBJETIVOS:

1- Imprime los campos del archivo de mantenimiento

2- Retorna NIL

SINTAXIS:

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION OtrRfa011(lShared,nModCry,cNomSis,cCodEmp,cNitEmp,cEmpPal,;
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
          FilePrn := 'Rfa'
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
                   'RECIBOS FACTURADOS',;
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

       AADD(aNroCol,6)
       AADD(aTitPrn,'CODIGO')

       AADD(aNroCol,6)
       AADD(aTitPrn,'MESINI')

       AADD(aNroCol,6)
       AADD(aTitPrn,'MESFIN')

       AADD(aNroCol,100)
       AADD(aTitPrn,'EMPRESA')

       AADD(aNroCol,14)
       AADD(aTitPrn,'NIT')

       AADD(aNroCol,100)
       AADD(aTitPrn,'EMPRESA')

       AADD(aNroCol,8)
       AADD(aTitPrn,'EMPRESA')

       AADD(aNroCol,10)
       AADD(aTitPrn,'CODSERFAC')

       AADD(aNroCol,12)
       AADD(aTitPrn,'RECIBO')

       AADD(aNroCol,20)
       AADD(aTitPrn,'BANCO')

       AADD(aNroCol,14)
       AADD(aTitPrn,'EAN13')

       AADD(aNroCol,20)
       AADD(aTitPrn,'CUENTA')

       AADD(aNroCol,60)
       AADD(aTitPrn,'NOMBRE')

       AADD(aNroCol,20)
       AADD(aTitPrn,'REFERENCIA')

       AADD(aNroCol,6)
       AADD(aTitPrn,'GRUPO')

       AADD(aNroCol,16)
       AADD(aTitPrn,'F.FACTURA')

       AADD(aNroCol,16)
       AADD(aTitPrn,'PAGO OPO')

       AADD(aNroCol,16)
       AADD(aTitPrn,'PAGO EXT')

       AADD(aNroCol,16)
       AADD(aTitPrn,'PERIODO FAC')

       AADD(aNroCol,16)
       AADD(aTitPrn,'CONCEPTO1')

       AADD(aNroCol,16)
       AADD(aTitPrn,'VLRMOR1')

       AADD(aNroCol,16)
       AADD(aTitPrn,'VLRMES1')

       AADD(aNroCol,16)
       AADD(aTitPrn,'VLRTOT1')

       AADD(aNroCol,16)
       AADD(aTitPrn,'CONCEPTO2')

       AADD(aNroCol,16)
       AADD(aTitPrn,'VLRMOR2')

       AADD(aNroCol,16)
       AADD(aTitPrn,'VLRMES2')

       AADD(aNroCol,16)
       AADD(aTitPrn,'VLRTOT2')

       AADD(aNroCol,16)
       AADD(aTitPrn,'CONCEPTO3')

       AADD(aNroCol,16)
       AADD(aTitPrn,'VLRMOR3')

       AADD(aNroCol,16)
       AADD(aTitPrn,'VLRMES3')

       AADD(aNroCol,16)
       AADD(aTitPrn,'VLRTOT3')

       AADD(aNroCol,16)
       AADD(aTitPrn,'CONCEPTO4')

       AADD(aNroCol,16)
       AADD(aTitPrn,'VLRMOR4')

       AADD(aNroCol,16)
       AADD(aTitPrn,'VLRMES4')

       AADD(aNroCol,16)
       AADD(aTitPrn,'VLRTOT4')

       AADD(aNroCol,16)
       AADD(aTitPrn,'CONCEPTO5')

       AADD(aNroCol,16)
       AADD(aTitPrn,'VLRMOR5')

       AADD(aNroCol,16)
       AADD(aTitPrn,'VLRMES5')

       AADD(aNroCol,16)
       AADD(aTitPrn,'VLRTOT5')

       AADD(aNroCol,16)
       AADD(aTitPrn,'CONCEPTO6')

       AADD(aNroCol,16)
       AADD(aTitPrn,'VLRMOR6')

       AADD(aNroCol,16)
       AADD(aTitPrn,'VLRMES6')

       AADD(aNroCol,16)
       AADD(aTitPrn,'VLRTOT6')

       AADD(aNroCol,16)
       AADD(aTitPrn,'CONCEPTO7')

       AADD(aNroCol,16)
       AADD(aTitPrn,'VLRMOR7')

       AADD(aNroCol,16)
       AADD(aTitPrn,'VLRMES7')

       AADD(aNroCol,16)
       AADD(aTitPrn,'VLRTOT7')

       AADD(aNroCol,16)
       AADD(aTitPrn,'CONCEPTO8')

       AADD(aNroCol,16)
       AADD(aTitPrn,'VLRMOR8')

       AADD(aNroCol,16)
       AADD(aTitPrn,'VLRMES8')

       AADD(aNroCol,16)
       AADD(aTitPrn,'VLRTOT8')

       AADD(aNroCol,16)
       AADD(aTitPrn,'CONCEPTO9')

       AADD(aNroCol,16)
       AADD(aTitPrn,'VLRMOR9')

       AADD(aNroCol,16)
       AADD(aTitPrn,'VLRMES9')

       AADD(aNroCol,16)
       AADD(aTitPrn,'VLRTOT9')

       AADD(aNroCol,16)
       AADD(aTitPrn,'VLROPO')

       AADD(aNroCol,16)
       AADD(aTitPrn,'VLREXT')

       AADD(aNroCol,100)
       AADD(aTitPrn,'BAROPO')

       AADD(aNroCol,100)
       AADD(aTitPrn,'BAREXT')

       AADD(aNroCol,400)
       AADD(aTitPrn,'TEXTO1')

       AADD(aNroCol,400)
       AADD(aTitPrn,'TEXTO2')

       AADD(aNroCol,250)
       AADD(aTitPrn,'CODEQR')

       AADD(aNroCol,16)
       AADD(aTitPrn,'DOCCO1')

       AADD(aNroCol,70)
       AADD(aTitPrn,'NOMCON1')

       AADD(aNroCol,40)
       AADD(aTitPrn,'MAICON1')

       AADD(aNroCol,20)
       AADD(aTitPrn,'PWDCON1')

       AADD(aNroCol,16)
       AADD(aTitPrn,'DOCCO2')

       AADD(aNroCol,70)
       AADD(aTitPrn,'NOMCON2')

       AADD(aNroCol,40)
       AADD(aTitPrn,'MAICON2')

       AADD(aNroCol,20)
       AADD(aTitPrn,'PWDCON2')

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

       SELECT RFA
       RFA->(DBGOTOP())
       DO WHILE .NOT. RFA->(EOF())

**********VISUALIZACION DE AVANCE
            nAvance := INT(( RFA->(RECNO()) / RFA->(RECCOUNT()) )*100)

            IF STR(nAvance,3) $ '25 50 75100'
               SET DEVICE TO SCREEN
               Termometro(nAvance)
               SET DEVICE TO PRINT
            ENDIF
**********FIN VISUALIZACION DE AVANCE

**********IMPRESION DEL REGISTRO
            aRegPrn := {}
            AADD(aRegPrn,RFA->cCodigoEst)
            AADD(aRegPrn,STR(RFA->nMesIniPag,2,0))
            AADD(aRegPrn,STR(RFA->nMesFinPag,2,0))
            AADD(aRegPrn,RFA->cEmpPalRec)
            AADD(aRegPrn,RFA->cNroNitRec)
            AADD(aRegPrn,RFA->cNomEmpRec)
            AADD(aRegPrn,RFA->cCodEmpCon)
            AADD(aRegPrn,RFA->cCodFacCar)
            AADD(aRegPrn,RFA->cNroFacCaA)
            AADD(aRegPrn,RFA->cNomBanRec)
            AADD(aRegPrn,RFA->cCodEanRec)
            AADD(aRegPrn,RFA->cNroCtaBan)
            AADD(aRegPrn,RFA->cNombreRec)
            AADD(aRegPrn,RFA->cCodRefRec)
            AADD(aRegPrn,RFA->cCodigoGru)
            AADD(aRegPrn,RFA->cFecFacPag)
            AADD(aRegPrn,RFA->cPagOpoPag)
            AADD(aRegPrn,RFA->cPagExtPag)
            AADD(aRegPrn,RFA->cPerFacRec)
            AADD(aRegPrn,RFA->cNomCo1Rec)
            AADD(aRegPrn,RFA->cVlrMo1Rec)
            AADD(aRegPrn,RFA->cVlrMe1Rec)
            AADD(aRegPrn,RFA->cVlrTo1Rec)
            AADD(aRegPrn,RFA->cNomCo2Rec)
            AADD(aRegPrn,RFA->cVlrMo2Rec)
            AADD(aRegPrn,RFA->cVlrMe2Rec)
            AADD(aRegPrn,RFA->cVlrTo2Rec)
            AADD(aRegPrn,RFA->cNomCo3Rec)
            AADD(aRegPrn,RFA->cVlrMo3Rec)
            AADD(aRegPrn,RFA->cVlrMe3Rec)
            AADD(aRegPrn,RFA->cVlrTo3Rec)
            AADD(aRegPrn,RFA->cNomCo4Rec)
            AADD(aRegPrn,RFA->cVlrMo4Rec)
            AADD(aRegPrn,RFA->cVlrMe4Rec)
            AADD(aRegPrn,RFA->cVlrTo4Rec)
            AADD(aRegPrn,RFA->cNomCo5Rec)
            AADD(aRegPrn,RFA->cVlrMo5Rec)
            AADD(aRegPrn,RFA->cVlrMe5Rec)
            AADD(aRegPrn,RFA->cVlrTo5Rec)
            AADD(aRegPrn,RFA->cNomCo6Rec)
            AADD(aRegPrn,RFA->cVlrMo6Rec)
            AADD(aRegPrn,RFA->cVlrMe6Rec)
            AADD(aRegPrn,RFA->cVlrTo6Rec)
            AADD(aRegPrn,RFA->cNomCo7Rec)
            AADD(aRegPrn,RFA->cVlrMo7Rec)
            AADD(aRegPrn,RFA->cVlrMe7Rec)
            AADD(aRegPrn,RFA->cVlrTo7Rec)
            AADD(aRegPrn,RFA->cNomCo8Rec)
            AADD(aRegPrn,RFA->cVlrMo8Rec)
            AADD(aRegPrn,RFA->cVlrMe8Rec)
            AADD(aRegPrn,RFA->cVlrTo8Rec)
            AADD(aRegPrn,RFA->cNomCo9Rec)
            AADD(aRegPrn,RFA->cVlrMo9Rec)
            AADD(aRegPrn,RFA->cVlrMe9Rec)
            AADD(aRegPrn,RFA->cVlrTo9Rec)
            AADD(aRegPrn,RFA->cVlrOpoRec)
            AADD(aRegPrn,RFA->cVlrExtRec)
            AADD(aRegPrn,RFA->cBarOpoRec)
            AADD(aRegPrn,RFA->cBarExtRec)
            AADD(aRegPrn,RFA->cTxtUnoRec)
            AADD(aRegPrn,RFA->cTxtDosRec)
            AADD(aRegPrn,RFA->cCodeQrRec)
            AADD(aRegPrn,RFA->cNitCn1Rec)
            AADD(aRegPrn,RFA->cNomCn1Rec)
            AADD(aRegPrn,RFA->cMaiCn1Rec)
            AADD(aRegPrn,RFA->cPwdCn1Rec)
            AADD(aRegPrn,RFA->cNitCn2Rec)
            AADD(aRegPrn,RFA->cNomCn2Rec)
            AADD(aRegPrn,RFA->cMaiCn2Rec)
            AADD(aRegPrn,RFA->cPwdCn2Rec)

            lPrnOpc(lShared,nOpcPrn,FilePrn,nHanXml,01,nColCab,;
                    aTitPrn,aRegPrn,aNroCol,bPagina,bDerAut,bCabeza)
**********FIN IMPRESION DEL REGISTRO

**********AVANCE DEL SIGUIENTE REGISTRO
	    SELECT RFA
	    RFA->(DBSKIP())
	    IF RFA->(EOF())
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
