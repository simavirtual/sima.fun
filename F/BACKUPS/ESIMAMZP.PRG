/*************************************************************************
* TITULO..: CREACION DE LA ESTRUCTURA                                    *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: NOV  1/2011 MAR A
       Colombia, Bucaramanga        INICIO:  3:48 PM   NOV  1/2011 MAR

OBJETIVOS:

1- Crea la estructura del archivo

2- Retorna NIL

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION CreaDbfMzp(lShared,nModCry,PathArc,fArchvo,aStrDbf)

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
       AADD(aDbfStr,{'nIdeCodMzp','Numeric'  ,16,0}) // Ide del Registro
      *Llave Principal

       AADD(aDbfStr,{'nRecNroMzp','Numeric',2,0}) // N£mero del Recibo
       AADD(aDbfStr,{'cCamposMzp','Character',6,0}) // Campo
       AADD(aDbfStr,{'cParte1Mzp','Character',60,0}) // Parte1
       AADD(aDbfStr,{'cParte2Mzp','Character',60,0}) // Parte2
       AADD(aDbfStr,{'cParte3Mzp','Character',60,0}) // Parte3
       AADD(aDbfStr,{'cParte4Mzp','Character',60,0}) // Parte4
       AADD(aDbfStr,{'cParte5Mzp','Character',60,0}) // Parte5
       AADD(aDbfStr,{'cParte6Mzp','Character',60,0}) // Parte6

       AADD(aDbfStr,{'cNomUsrMzp','Character',10,0}) // Nombre del Usuario
       AADD(aDbfStr,{'dFecUsrMzp','Date'     ,08,0}) // Fecha del Usuario
       AADD(aDbfStr,{'cHorUsrMzp','Character',10,0}) // Hora del Usuario
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

*>>>>REGISTROS POR DEFECTO
       aRegIni := {}
       AADD(aRegIni,{01,'NomEmp',  '7.0,3.4;' ,  '7.0,12.0;' ,  '7.0,20.5;'})
       AADD(aRegIni,{01,'NroFac', '17.0,3.7;' , '17.0,12.3;' , '17.0,20.8;'})
       AADD(aRegIni,{01,'Banco' ,  '4.0,4.2;' ,  '4.0,12.8;' ,  '2.5,22.6;'})
       AADD(aRegIni,{01,'CtaBan', '14.0,4.2;' , '14.0,12.8;' ,  '2.5,23.2;'})
       AADD(aRegIni,{01,'NomEst',  '4.0,4.6;' ,  '4.0,13.2;' ,  '4.0,21.7;'})
       AADD(aRegIni,{01,'CodFac',  '0.5,5.4;' ,  '0.5,14.0;' ,  '2.5,24.1;'})
       AADD(aRegIni,{01,'Curso' ,  '5.7,5.4;' ,  '5.7,14.0;' ,  '2.5,24.6;'})
       AADD(aRegIni,{01,'FecExp', '10.7,5.4;' , '10.7,14.0;' ,  '3.9,21.3;'})
       AADD(aRegIni,{01,'Meses' , '15.7,5.4;' , '15.7,14.0;' , '17.5,21.3;'})
       AADD(aRegIni,{01,'FecOpo',  '6.5,9.5;' ,  '6.5,18.1;' , '10.5,22.1;'})
       AADD(aRegIni,{01,'FecExt',  '6.5,9.9;' ,  '6.5,18.7;' , '10.5,24.5;'})
       AADD(aRegIni,{01,'VlrOpo', '18.5,9.5;' , '18.5,18.1;' , '18.5,22.1;'})
       AADD(aRegIni,{01,'VlrExt', '18.5,9.9;' , '18.5,18.7;' , '18.5,24.5;'})
       AADD(aRegIni,{01,'BarOpo', ''          , ''           ,  '8.5,24.2;8.5,26.7;'})
       AADD(aRegIni,{01,'BarExt', ''          ,''            ,  '8.5,24.2;8.5,26.7;'})
*>>>>FIN REGISTROS POR DEFECTO

*>>>>GRABACION DE LOS PARAMETROS POR DEFECTO
       FOR i := 1 TO LEN(aRegIni)

	 IF ARC->(lRegLock(lShared,.T.))

	    REPL ARC->nRecNroMzp WITH aRegIni[i,1]
	    REPL ARC->cCamposMzp WITH aRegIni[i,2]
	    REPL ARC->cParte1Mzp WITH aRegIni[i,3]
	    REPL ARC->cParte2Mzp WITH aRegIni[i,4]
	    REPL ARC->cParte3Mzp WITH aRegIni[i,5]


	    REPL ARC->nIdeCodMzp WITH ARC->(RECNO())
	    REPL ARC->cNomUsrMzp WITH 'system'
	    REPL ARC->dFecUsrMzp WITH DATE()
	    REPL ARC->cHorUsrMzp WITH TIME()
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
* TITULO..: IMPRESION CAMPOS DEL MANTENIMIENTO                           *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: NOV  2/2011 MIE A
       Colombia, Bucaramanga        INICIO: 10:27 AM   NOV  2/2011 MIE

OBJETIVOS:

1- Imprime los campos del archivo de mantenimiento

2- Retorna NIL

SINTAXIS:

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION OtrMzp011(lShared,nModCry,cNomSis,cCodEmp,cNitEmp,cEmpPal,;
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
          FilePrn := 'Mzp'
          nOpcPrn := nPrinter_On(cNomUsr,@FilePrn,cOpcPrn,.F.,.T.)
          IF EMPTY(nOpcPrn)
             RETURN NIL
          ENDIF
       ENDIF
*>>>>FIN ACTIVACION DE LA IMPRESORA

*>>>>PAGINA DE REFERENCIA
       Post('!R! RES; UNIT C; STM 2; SLM 2;')
       Post('SFNT ²Swiss742SWC-RomanCondensed²;')
       Post('MZP 0, 0; BOX 40, 40; SPD .2;')
       Post('MZP 0, 0; CIR .1; TEXT, L; TEXT " MZP 0, 0;";')
       Post('MZP 6, 0; CIR .1; TEXT, L; TEXT " MZP 6, 0;";')
       Post('MZP 0, 2; CIR .1; TEXT, L; TEXT " MZP 0, 2;";')
       Post('MZP 6, 2; CIR .1; TEXT, L; TEXT " MZP 6, 2;";')
       Post('PAGE;')
       Post('EXIT;')

       VerPrn(nOpcPrn,FilePrn,nHanXml)
       PRN->(DBGOTO(nRegPrn))

       SET DEVICE TO SCREEN
       RETURN NIL
*>>>>FIN PAGINA DE REFERENCIA


/*************************************************************************
* TITULO..: COLUMNAS Y FILAS PARA LA IMPRESION DE LOS RECIBOS            *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: NOV  2/2011 MIE A
       Colombia, Bucaramanga        INICIO: 02:30 AM   NOV  2/2011 MIE

OBJETIVOS:

1- Crea un vector con las columnas y filas para la impresi[on de los recibos

2- Retorna el vector.


*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION aColFilMzp(nNroRec)

*>>>>DESCRIPCION DE PARAMETROS
/*     nNroRec                              // N£mero del Recibo */
*>>>>FIN DESCRIPCION DE PARAMETROS

*>>>>DECLARACION DE VARIABLES
       LOCAL aColFil := {}                  // Columnas y filas
*>>>>FIN DECLARACION DE VARIABLES

*>>>>RECORRIDO DE LOS REGISTROS
       SELECT MZP
       MZP->(DBGOTOP())
       DO WHILE .NOT. MZP->(EOF())

**********COLUMNAS Y FILAS
	    IF MZP->nRecNroMzp == nNroRec
	       AADD(aColFil,{ALLTRIM(MZP->cCamposMzp),;
			     ALLTRIM(MZP->cParte1Mzp)+;
			     ALLTRIM(MZP->cParte2Mzp)+;
			     ALLTRIM(MZP->cParte3Mzp)+;
			     ALLTRIM(MZP->cParte4Mzp)+;
			     ALLTRIM(MZP->cParte5Mzp)+;
			     ALLTRIM(MZP->cParte6Mzp)})
	    ENDIF
**********FIN COLUMNAS Y FILAS

	  MZP->(DBSKIP())

       ENDDO
       RETURN aColFil
*>>>>FIN RECORRIDO DE LOS REGISTROS

