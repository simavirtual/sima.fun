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
		   cPatSis,cMaeAlu)

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
       cMaeAlu                              // Maestros Habilitados */
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
				 cMaeAlu)})

       MVT->(CtrlBrw(lShared,oBrowse))

       SETKEY(K_F2,NIL)
       SETKEY(K_F4,NIL)
       SETKEY(K_F5,NIL)
       SETKEY(K_F9,NIL)
       CloseAll()
       RETURN NIL
*>>>>FIN MANTENIMIENTO DEL ARCHIVO


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
		    oBrowse,cPatSis,cMaeAlu)

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
       cMaeAlu                              // Maestros Habilitados */
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
		      oBrowse,cPatSis,cMaeAlu)
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

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: OCT 15/2013 MAR A
       Colombia, Bucaramanga        INICIO:  4:22 PM   OCT 15/2013 MAR

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
          FilePrn := 'Mvt'
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
       AADD(aTitPrn,'MESINI')

       AADD(aNroCol,6)
       AADD(aTitPrn,'MESFIN')

       AADD(aNroCol,40)
       AADD(aTitPrn,'CODIGO')

       AADD(aNroCol,10)
       AADD(aTitPrn,'DEBITOS')

       AADD(aNroCol,10)
       AADD(aTitPrn,'CREDITOS')

       AADD(aNroCol,10)
       AADD(aTitPrn,'SALDOS')

       AADD(aNroCol,8)
       AADD(aTitPrn,'CONCEPTO')

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

**********IMPRESION DEL REGISTRO
            aRegPrn := {}
            AADD(aRegPrn,STR(MVT->nNroMesMvt,2,0))
            AADD(aRegPrn,MVT->cCodigoEst)
            AADD(aRegPrn,STR(MVT->nMesIniPag,2,0))
            AADD(aRegPrn,STR(MVT->nMesFinPag,2,0))
            AADD(aRegPrn,MVT->cDescriMvt)
            AADD(aRegPrn,STR(MVT->nDebitoMvt,10,2))
            AADD(aRegPrn,STR(MVT->nCreditMvt,10,2))
            AADD(aRegPrn,STR(MVT->nSaldosMvt,10,2))
            AADD(aRegPrn,STR(MVT->nCodigoCmv,4,0))

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
		   oBrowse,cPatSis,cMaeAlu)

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
       cMaeAlu                              // Maestros Habilitados */
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

       LOCAL nMesIni := 0                   // Mes Inicial del pago
       LOCAL cNroMes := ''                  // N£mero del Mes
       LOCAL cGruFin := ''                  // Grupo Final
       LOCAL lHayAlu := .F.                 // .T. Hay Alumno
       LOCAL cNalias := ''                  // Alias del Maestro
       LOCAL lHayPag := .F.                 // .T. Hay pago
       LOCAL nMesRet := 0                   // Mes del ultimo recibo

       LOCAL nVlrDes := 0                   // Valor del Descuento
       LOCAL nVlrRec := 0                   // Valor del Recargo
       LOCAL nVlrBec := 0                   // Valor de la Beca
       LOCAL nTotDes := 0                   // Total de Descuentos
       LOCAL nTotRec := 0                   // Total de Recargos
       LOCAL nTotBec := 0                   // Total de Becas

       LOCAL nVlrMes := 0                   // Valor de lo facturado
       LOCAL nVlrInt := 0                   // Valor de los intereses
       LOCAL nIntNoP := 0                   // Valor de los intereses no pago
       LOCAL aRegEst := {}                  // Valor del Estudiante
       LOCAL aDeuAnt := {}                  // Codigos deuda Anterior

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

       LOCAL cDescri := ''                  // Descripci¢n del Movimiento
       LOCAL nTotCau := 0                   // Total de Causaci¢n.


       LOCAL cCodigoTes := ''               // C¢digo del Estudiante
       LOCAL cNombreTes := ''               // Nombre del Estudiante
       LOCAL lRetadoTes := .T.              // .T. Estudiante retirado

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

       OTHERWISE
	    lHayErr :=.F.
       ENDCASE
       IF lHayErr
	  RETURN NIL
       ENDIF
*>>>>FIN VALIDACION DE CONTENIDOS DE ARCHIVOS

*>>>>SELECCION DEL MES
       cSavPan := SAVESCREEN(0,0,24,79)
       nMesIni := nMesano(10,15,'Mes de los Movimientos',.T.)
       RESTSCREEN(0,0,24,79,cSavPan)

       IF nMesIni == 0
	  RETURN NIL
       ENDIF
       cNroMes := STR(nMesIni,2)
       lCorrecion(@cNroMes)

       AFILL(aAntici,0)
*>>>>FIN SELECCION DEL MES

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
*lLocCodigo('cCodigoGru','GRU','1501')  // ojo
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
*GO 16  // ojo
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

*==============INICIALIZACION DE ACUMULADORES
		 aRegEst := {0,; // Deuda Anterior
			     0,; // Mora Anterior
			     0}  // Valor del Mes
*==============FIN INICIALIZACION DE ACUMULADORES

*==============ANALISIS SI ESTUDIANTE ESTA RETIRADO
		 lRetadoTes := .F.
		 lHayAlu := lSekCodMae(CLI->cCodigoEst,;
				       cMaeAlu,@cNalias,.F.)
		 IF lHayAlu
		    cCodigoTes := &cNalias->cCodigoEst
		    IF &cNalias->lRetiroEst
		       lRetadoTes := .T.
		    ENDIF
		    cNombreTes := RTRIM(&cNalias->cApelliEst)+' '+;
				  &cNalias->cNombreEst
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
			       nTotCau := nTotCau-nVlrTar
			    ELSE
			       nTotCau := nTotCau+nVlrTar
			    ENDIF
			    InsRegMvt(CLI->cCodigoEst,nMesIni,;
				      PAG->nMesIniPag,;
				      PAG->nMesIniPag,;
				      cDescri,;
				      IF(CON->lDesEfeDes,0,nVlrTar),;   // Debito
				      IF(CON->lDesEfeDes,nVlrTar,0),;   // Credito
				      0,;                               // Saldo
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

				nTotCau := nTotCau+aAntEst[k]
				InsRegMvt(CLI->cCodigoEst,nMesIni,;
					  PAG->nMesIniPag+1,;
					  PAG->nMesFinPag,;
					  cDescri,;
					  IF(CON->lDesEfeDes,0,aAntEst[k]),;        // Debito
					  IF(CON->lDesEfeDes,ABS(aAntEst[k]),0),;   // Credito
					  0,;                                       // Saldo
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
			    cDescri := 'RECARGO'+' '+;
				       cMes(PAG->nMesIniPag,3)+' '+;
				       ALLTRIM(DES->cDescriDes)
			 ELSE
			    cDescri := 'recardo'+' '+;
				       cMes(PAG->nMesIniPag,3)
			 ENDIF


			 nTotCau := nTotCau+nVlrRec
			 InsRegMvt(CLI->cCodigoEst,nMesIni,;
				   PAG->nMesIniPag,;
				   PAG->nMesIniPag,;
				   cDescri,;
				   nVlrRec,;                 // Debito
				   0,;                       // Credito
				   0,;                       // Saldo
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

			 nTotCau := nTotCau-nVlrBec
			 InsRegMvt(CLI->cCodigoEst,nMesIni,;
				   PAG->nMesIniPag,;
				   PAG->nMesIniPag,;
				   cDescri,;
				   nVlrBec,;                 // Debito
				   0,;                       // Credito
				   0,;                       // Saldo
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
			 ELSE
			    cDescri := 'descuentos'+' '+;
				       cMes(PAG->nMesIniPag,3)
			 ENDIF

			 nTotCau := nTotCau-nVlrDes
			 InsRegMvt(CLI->cCodigoEst,nMesIni,;
				   PAG->nMesIniPag,;
				   PAG->nMesIniPag,;
				   cDescri,;
				   nVlrDes,;                 // Debito
				   0,;                       // Credito
				   0,;                       // Saldo
				   9905,;                    // nCodCmv
				   lShared,;                 // lShared
				   .T.,;                     // lInsReg
				   cNomUsr)

		      ENDIF
*-------------------FIN DESCUENTOS

*-------------------CALCULO DE LOS INTERESES ACTUALES
		      nVlrMes := PAG->nVlrMesPag

		      nVlrInt := nIntMesPag(CAA->lIntPenCaA,;
					    aRegEst[nDEUANT],;
					    nVlrMes,;
					    PAG->nMesIniPag,;
					    CAA->nMesAmnCaA)

		      nIntNoP := nIntMesNoP(CAA->lIntPenCaA,;
					    aRegEst[nDEUANT],;
					    nVlrMes,;
					    PAG->nMesIniPag,;
					    CAA->nMesAmnCaA)
*-------------------FIN CALCULO DE LOS INTERESES ACTUALES

*-------------------INTERESES PAGOS DEL MES
		      IF PAG->cEstadoPag == 'A' .AND. nVlrInt > 0

			 cDescri := 'INT PAGO MES'+' '+;
				    cMes(PAG->nMesIniPag,3)


			 nTotCau := nTotCau+nVlrInt
			 InsRegMvt(CLI->cCodigoEst,nMesIni,;
				   PAG->nMesIniPag,;
				   PAG->nMesIniPag,;
				   cDescri,;
				   nVlrInt,;                 // Debito
				   0,;                       // Credito
				   0,;                       // Saldo
				   9906,;                    // nCodCmv
				   lShared,;                 // lShared
				   .T.,;                     // lInsReg
				   cNomUsr)


		      ENDIF
*-------------------FIN INTERESES PAGOS DEL MES

*-------------------LOCALIZACION DEL ABONO
		      nDeuInt := 0
		      nAboDes := 0
		      SELECT DES
		      GO TOP
		      LOCATE FOR DES->cCodigoEst == CLI->cCodigoEst .AND.;
				 DES->nTipDesDes == 3

		      IF DES->(FOUND())

*                        TOTALIZACION DE LOS ABONOS
			   nAboEst := 0
			   nAboEst += nVlrAbo(CLI->cCodigoEst,cAnoUsr,;
					      PAG->nMesIniPag,@nDeuInt,;
					      @nAboOtr,@nAboDes,;
					      @nAboFin,@nOtrFin,@nDesFin,;
					      lPrnFec,dFecPrn,aRegEst)
			   nAboMes += nAboEst
			   nDesMes += nAboDes
*                        FIN TOTALIZACION DE LOS ABONOS




*                        DEUDA ANTERIOR
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
*                        FIN DEUDA ANTERIOR

		      ELSE

*                        DEUDA ANTERIOR
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
*                        FIN DEUDA ANTERIOR


		      ENDIF
*-------------------FIN LOCALIZACION DEL ABONO


*-------------------INTERESES POR COBRAR DEL MES
		      nIntCob := nIntNoP(nDeuInt)
		      IF PAG->cEstadoPag == 'D' .AND. nIntCob > 0

			 cDescri := 'INT X COBRAR MES'+' '+;
				    cMes(PAG->nMesIniPag,3)

			 nTotCau := nTotCau+nIntCob
			 InsRegMvt(CLI->cCodigoEst,nMesIni,;
				   PAG->nMesIniPag,;
				   PAG->nMesIniPag,;
				   cDescri,;
				   nIntCob,;                 // Debito
				   0,;                       // Credito
				   0,;                       // Saldo
				   9907,;                    // nCodCmv
				   lShared,;                 // lShared
				   .T.,;                     // lInsReg
				   cNomUsr)

		      ENDIF
*-------------------FIN INTERESES POR COBRAR DEL MES

*-------------------ABONOS DESCUENTOS
		      IF nAboDes > 0

			 cDescri := 'ABONOS DESCUENTOS MES'+' '+;
				    cMes(PAG->nMesIniPag,3)

			 InsRegMvt(CLI->cCodigoEst,nMesIni,;
				   PAG->nMesIniPag,;
				   PAG->nMesIniPag,;
				   cDescri,;
				   0,;                       // Debito
				   nAboDes,;                 // Credito
				   0,;                       // Saldo
				   9900,;                    // nCodCmv
				   lShared,;                 // lShared
				   .T.,;                     // lInsReg
				   cNomUsr)

		      ENDIF
*-------------------FIN ABONOS DESCUENTOS

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
wait nTotCau
       RETURN NIL
*>>>>FIN RECORRIDO POR GRUPOS

/*************************************************************************
* TITULO..: GRABACION DEL REGISTRO                                       *
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

FUNCTION InsRegMvt(cCodEst,nNroMes,nMesIni,nMesFin,cDescri,;
		   nDebito,nCredit,nSaldos,nCodCmv,lShared,;
		   lInsReg,cNomUsr)

*>>>>DESCRIPCION DE PARAMETROS
/*     cCodEst                              // C¢digo del Estudiante
       nMesIni                              // Mes Inicial
       nMesFin                              // Mes Final
       cDescri                              // Descripci¢n
       nDebito                              // Debito
       nCredit                              // Cr‚dito
       nSaldos                              // Saldo
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
	  REPL MVT->nMesIniPag WITH nMesIni
	  REPL MVT->nMesFinPag WITH nMesFin
	  REPL MVT->cDescriMvt WITH cDescri
	  REPL MVT->nDebitoMvt WITH nDebito
	  REPL MVT->nCreditMvt WITH nCredit
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