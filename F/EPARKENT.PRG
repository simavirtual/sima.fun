/*************************************************************************
* TITULO..: MENU DE OTROS PARA EL ARCHIVO                                *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: JUN 29/2005 MIE A
       Colombia, Bucaramanga        INICIO:  5:17 PM   JUN 29/2005 MIE

OBJETIVOS:

1- Menu de Otros para el archivo

2- Retorna NIL

SINTAXIS:

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION MenuOtrEnt(lShared,nModCry,cNomSis,cCodEmp,cNitEmp,cEmpPal,;
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
       #DEFINE ANO 1                        // A¤os
       #DEFINE MES 2                        // Meses
       #DEFINE DIA 3                        // Dias
       #DEFINE HOD 4                        // Horas Diurnas
       #DEFINE HON 5                        // Horas Nocturnas
       #DEFINE MIN 6                        // Minutos
       #DEFINE SEG 7                        // Segundos

       LOCAL cSavPan := ''                  // Salvar Pantalla
       LOCAL cAnoSis := SUBS(cAnoUsr,3,2)   // A¤o del sistema
       LOCAL lHayErr := .F.                 // .T. Hay Error

       LOCAL aMenus  := {}                  // Vector de declaracion de men£
       LOCAL aAyuda  := {}                  // Vector de ayudas para el men£
       LOCAL nNroOpc := 1                   // Numero de la opcion
       LOCAL aTimPar := {}                  // Tiempo de Parqueo

       LOCAL GetList := {}                  // Variable del Sistema
*>>>>FIN DECLARACION DE VARIABLES

*>>>>DECLARCION Y EJECUCION DEL MENU
       aMenus := {}
       AADD(aMenus,'1<TOTAL DEL DIA    >')
       AADD(aMenus,'2<ENTRADAS         >')
       AADD(aMenus,'3<TIEMPO DE PARQUEO>')

       aAyuda := {}
       AADD(aAyuda,'Imprime el Total del Ingreso del D¡a')
       AADD(aAyuda,'Imprime los Detalles del Archivo')
       AADD(aAyuda,'Calcula el Tiempo de Parqueo')

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
	    OtrEnt012(lShared,nModCry,cNomSis,cCodEmp,cNitEmp,cEmpPal,;
		      cNomEmp,cNomSec,cNomUsr,cAnoUsr,aArchvo,lPrnArc,;
		      cOpcPrn,nCodPrn,lModReg,lDelReg,lInsReg,lHaySql,;
		      oBrowse)
	   *Impresi¢n del total del d¡a

       CASE nNroOpc == 2
	    OtrEnt011(lShared,nModCry,cNomSis,cCodEmp,cNitEmp,cEmpPal,;
		      cNomEmp,cNomSec,cNomUsr,cAnoUsr,aArchvo,lPrnArc,;
		      cOpcPrn,nCodPrn,lModReg,lDelReg,lInsReg,lHaySql,;
		      oBrowse)
	   *Impresi¢n de los campos del Archivo

       CASE nNroOpc == 3

	    aTimPar := aHoraDias(ENT->dFecIngEnt,ENT->dFecOutEnt,;
				 ENT->cHorIngEnt,ENT->cHorOutEnt,;
				 PAR->cIniDiaPak,PAR->cFinDiaPak,;
				 PAR->cIniNocPak,PAR->cFinNocPak,;
				 PAR->nMinFraPak)

	    cError('AA:MM:DD:HD:HN:MM:SS='+;
		    ALLTRIM(STR(aTimPar[ANO],3))+':'+;
		    ALLTRIM(STR(aTimPar[MES],3))+':'+;
		    ALLTRIM(STR(aTimPar[DIA],3))+':'+;
		    ALLTRIM(STR(aTimPar[HOD],2))+':'+;
		    ALLTRIM(STR(aTimPar[HON],2))+':'+;
		    ALLTRIM(STR(aTimPar[MIN],2))+':'+;
		    ALLTRIM(STR(aTimPar[SEG],2)))

       ENDCASE
       RETURN NIL
*>>>>FIN ANALISIS DE OPCION ESCOGIDA

/*************************************************************************
* TITULO..: TOTAL DEL DIA                                                *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: JUN 29/2005 MIE A
       Colombia, Bucaramanga        INICIO:  5:17 PM   JUN 29/2005 MIE

OBJETIVOS:

1- Totaliza el total del d¡a

2- Retorna NIL

SINTAXIS:

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION OtrEnt012(lShared,nModCry,cNomSis,cCodEmp,cNitEmp,cEmpPal,;
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

       LOCAL nNroFil := 0                   // N£mero de la Fila
       LOCAL nNroCol := 0                   // N£mero de la Columna
       LOCAL dFecPrn := CTOD('00/00/00')    // Fecha de Corte

       LOCAL nFacIni := 0                   // Factura Inicial
       LOCAL nFacFin := 0                   // Factura Final
       LOCAL nNroFac := 0                   // Total de Facturas
       LOCAL nFacPag := 0                   // N£mero de Pagos
       LOCAL nFacNpa := 0                   // N£mero de no pagados
       LOCAL nBasIva := 0                   // Base del Iva
       LOCAL nVlrIva := 0                   // Valor del Iva
       LOCAL nTotSer := 0                   // Total del Servicio

       LOCAL nAvance := 0                   // Avance de registros
       LOCAL Getlist := {}                  // Variable del sistema
     *ÀVariables espec¡ficas
*>>>>FIN DECLARACION DE VARIABLES

*>>>>LECTURA FECHA DE CORTE
       cSavPan := SAVESCREEN(0,0,24,79)
       SETCURSOR(1)
       dFecPrn := DATE()
       TitBuscar(14,@nNroFil,@nNroCol,'MM/DD/AAAA','FECHA DE CORTE:',)
       @ nNroFil,nNroCol GET dFecPrn PICT '@D'
       READ
       SETCURSOR(0)
       RESTSCREEN(0,0,24,79,cSavPan)

       IF EMPTY(dFecPrn)
	  RETURN NIL
       ENDIF
*>>>>FIN LECTURA FECHA DE CORTE

*>>>>FILTRACION DEL ARCHIVO
       SELECT ENT
       SET FILTER TO ENT->dFecIngEnt == dFecPrn .OR.;
		     ENT->dFecOutEnt == dFecPrn

       ENT->(DBGOTOP())
       IF ENT->(EOF())
	  SET FILTER TO
	  cError('NO EXISTEN REGISTROS PARA '+cFecha(dFecPrn))
	  RETURN NIL
       ENDIF
*>>>>FIN FILTRACION DEL ARCHIVO

*>>>>ACTIVACION DE LA IMPRESORA
       IF PAR->lPrnArcPak
	  SET DEVICE TO PRINT
       ELSE
	  FilePrn := 'totdia'
	  nOpcPrn := nPrinter_On(cNomUsr,@FilePrn,PAR->cOpcRecPak,.F.,.T.)
	  IF EMPTY(nOpcPrn)
	     RETURN NIL
	  ENDIF
       ENDIF
       SET DEVICE TO SCREEN
*>>>>FIN ACTIVACION DE LA IMPRESORA

*>>>>RECORRIDOS POR REGISTROS
       SELECT ENT
       ENT->(DBGOTOP())
       nFacIni := ENT->nNroFacEnt
       DO WHILE .NOT. ENT->(EOF())

**********IMPRESION DE LA LINEA DE ESTADO
	    nNroFac++
	    LineaEstados('REGISTRO No: '+ENT->(STR(RECNO(),4))+'/'+;
			  ENT->(STR(RECCOUNT(),4))+':'+;
			  STR(nNroFac,4),cNomSis)
**********FIN IMPRESION DE LA LINEA DE ESTADO

**********TOTALES DEL DIA
	    nFacFin := ENT->nNroFacEnt
	    IF EMPTY(ENT->dFecOutEnt)
	       nFacNpa++
	    ELSE
	       nFacPag++
	    ENDIF

	    nTotSer += ENT->nVlrTotEnt
	    nBasIva += ENT->nBasIvaEnt
	    nVlrIva += ENT->nVlrIvaEnt
**********FIN TOTALES DEL DIA

	  ENT->(DBSKIP())

       ENDDO
*>>>>FIN RECORRIDOS POR REGISTROS

*>>>>ACTIVACION DE LA IMPRESORA
       SET DEVICE TO PRINT
       SendCodes(PCL('Reset'))

       SendCodes(PCL({'Pica','CondenOn'}))
       SETPRC(0,0)
*>>>>FIN ACTIVACION DE LA IMPRESORA

*>>>>IMPRESION DEL TOTAL DEL DIA
       @ PROW()+1,00 SAY REPL('=',20)

       @ PROW()+1,00 SAY 'FECHA.:'+cFecha(dFecPrn)
       @ PROW()+1,00 SAY 'HORA..:'+TIME()
       @ PROW()+1,00 SAY 'FACTURA INICIAL...:'+ALLTRIM(STR(nFacIni,9))
       @ PROW()+1,00 SAY 'FACTURA FINAL.....:'+ALLTRIM(STR(nFacFin,9))
       @ PROW()+1,00 SAY 'TOTAL FACTURAS....:'+ALLTRIM(STR(nNroFac,9))
       @ PROW()+1,00 SAY 'FACTURAS PAGADAS..:'+ALLTRIM(STR(nFacPag,9))
       @ PROW()+1,00 SAY 'FACT NO CANCELADAS:'+ALLTRIM(STR(nFacNpa,9))

       @ PROW()+2,00 SAY 'BASE DEL IVA......$'+ALLTRIM(TRANS(nBasIva,"####,###,###"))
       @ PROW()+1,00 SAY 'VALOR DEL IVA.....$'+ALLTRIM(TRANS(nVlrIva,"####,###,###"))
       @ PROW()+1,00 SAY 'TOTAL.............$'+ALLTRIM(TRANS(nTotSer,"####,###,###"))

       SET DEVICE TO SCREEN
       VerPrn(nOpcPrn,FilePrn,nHanXml)

       ENT->(DBGOTOP())
       oBrowse:GOTOP()
       oBrowse:FORCESTABLE()
       RETURN NIL
*>>>>FIN IMPRESION DEL TOTAL DEL DIA