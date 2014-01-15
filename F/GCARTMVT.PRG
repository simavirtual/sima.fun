/*************************************************************************
* TITULO..: CREACION DE LA ESTRUCTURA                                    *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: ENE 14/2014 MAR A
       Colombia, Bucaramanga        INICIO: 10:39 AM   ENE 14/2014 MAR

OBJETIVOS:

1- Crea la estructura del archivo

2- Retorna NIL

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION CreaDbfMvt(lShared,nModCry,PathArc,fArchvo,aStrDbf)

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
*>>>>FIN DECLARACION DE VARIABLES

*>>>>DECLARACION DE LA ESTRUCTURA
       AADD(aDbfStr,{'nIdeCodMvt','Numeric'  ,16,0}) // Ide del Registro
      *Llave Principal

       AADD(aDbfStr,{'nNroMesMvt','Numeric',2,0}) // Mes
       AADD(aDbfStr,{'cCodigoEst','Character',6,0}) // C¢digo del Estudiante
       AADD(aDbfStr,{'cCodigoGru','Character',4,0}) // C¢digo del Grupo
       AADD(aDbfStr,{'nMesIniPag','Numeric',2,0}) // Mes Inicial
       AADD(aDbfStr,{'nMesFinPag','Numeric',2,0}) // Mes Final
       AADD(aDbfStr,{'nMesFinMvt','Numeric',2,0}) // Mes Final
       AADD(aDbfStr,{'cCodigoCon','Character',2,0}) // Concepto
       AADD(aDbfStr,{'cDescriMvt','Character',40,0}) // Descripci¢n
       AADD(aDbfStr,{'nCreditMvt','Numeric',14,2}) // CREDITOS
       AADD(aDbfStr,{'nDebitoMvt','Numeric',14,2}) // DEBITOS
       AADD(aDbfStr,{'nSaldosMvt','Numeric',14,2}) // SALDOS
       AADD(aDbfStr,{'nTotCauPag','Numeric',14,2}) // CAUSACION
       AADD(aDbfStr,{'nSdoAntPag','Numeric',14,2}) // SDOANT
       AADD(aDbfStr,{'nMorAntPag','Numeric',14,2}) // MORANT
       AADD(aDbfStr,{'nVlrMesPag','Numeric',14,2}) // VLRMES
       AADD(aDbfStr,{'nVlrPagPag','Numeric',14,2}) // VLRPAG
       AADD(aDbfStr,{'nIntMesPag','Numeric',14,2}) // INTMES
       AADD(aDbfStr,{'cEstadoPag','Character',1,0}) // Estado
       AADD(aDbfStr,{'dFecPagPag','Date',8,0}) // Fecha de Pago
       AADD(aDbfStr,{'nNroFacCaA','Numeric',11,0}) // NROFAC
       AADD(aDbfStr,{'dFecFacPag','Date',8,0}) // Fecha de Facturaci¢n
       AADD(aDbfStr,{'cCodigoBan','Character',2,0}) // Banco
       AADD(aDbfStr,{'cCodRefTra','Character',12,0}) // Referencia
       AADD(aDbfStr,{'cCodEstTra','Character',6,0}) // C¢digo del Estudiante
       AADD(aDbfStr,{'nValorTra','Numeric',14,2}) // VLRTRA
       AADD(aDbfStr,{'dFechaTra','Date',8,0}) // Fecha de Transaci¢n
       AADD(aDbfStr,{'nVlrDifMvt','Numeric',14,2}) // VLRDIF
       AADD(aDbfStr,{'nCodigoCmv','Numeric',4,0}) // Concepto Movimiento
       AADD(aDbfStr,{'cObservMvt','Character',40,0}) // Observaci¢n

       AADD(aDbfStr,{'cNomUsrMvt','Character',10,0}) // Nombre del Usuario
       AADD(aDbfStr,{'dFecUsrMvt','Date'     ,08,0}) // Fecha del Usuario
       AADD(aDbfStr,{'cHorUsrMvt','Character',10,0}) // Hora del Usuario
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
       RETURN NIL
*>>>>FIN CREACION DE LA ESTRUCTURA

/*************************************************************************
* TITULO..: RECUPERACION DE LA ESTRUCTURA                                *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: ENE 14/2014 MAR A
       Colombia, Bucaramanga        INICIO: 10:39 AM   ENE 14/2014 MAR

OBJETIVOS:

1- Recupera la estructura del archivo

2- Retorna NIL

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION RecuDbfMvt(lShared,nModCry,PathArc,fArchvo)

*>>>>DESCRIPCION DE PARAMETROS
/*     lShared                        // .T. Sistema Compartido
       nModCry                        // Modo de Protecci¢n
       PathArc			      // Path del Archivo
       fArchvo			      // Nombre del Archivo */
*>>>>FIN DESCRIPCION DE PARAMETROS

*>>>>RECUPERA LA ESTRUCTURA DEL ARCHIVO
       SAVE SCREEN
       cError('SE BORRO EL ARCHIVO '+PathArc+'\'+fArchvo,;
              'Error Grave. TOME NOTA',;
              'Al Presionar Cualquier tecla se crea el archivo')
       Termometro(0,'CREANDO LA ESTRUCTURA')
       Termometro(100)
       CreaDbfMvt(lShared,nModCry,PathArc,fArchvo)
       RESTORE SCREEN
       RETURN NIL
*>>>>FIN RECUPERA LA ESTRUCTURA DEL ARCHIVO

/*************************************************************************
* TITULO..: ACTUALIZACION DE LA ESTRUCTURA                               *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: ENE 14/2014 MAR A
       Colombia, Bucaramanga        INICIO: 10:39 AM   ENE 14/2014 MAR

OBJETIVOS:

1- Actualiza la Estructura del Archivo

2- Retorna el N£mero de Error:
   0 => No hay Error
	Estructura Actualizada
	Estructura Sin problemas
   1 => Estructura No Actualizada

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION nActStrMvt(lShared,nModCry,PathArc,cNomArc)

*>>>>DESCRIPCION DE PARAMETROS
/*     lShared                              // .T. Sistema Compartido
       nModCry                              // Modo de Protecci¢n
       PathArc                              // Path del Archivo
       cNomArc                              // Nombre del Archivo */
*>>>>FIN DESCRIPCION DE PARAMETROS

*>>>>DECLARACION DE VARIABLES
       LOCAL cSavPan := ''                  // Salvar Pantalla
       LOCAL nNroErr := 0                   // N£mero del Error
       LOCAL       i := 0                   // Contador
       LOCAL aStrNew := {'1'}               // Estructura Nueva
       LOCAL aStrOld := {}                  // Estructura Vieja
       LOCAL lCambio := .F.                 // .T. Cambio la Estructura
       LOCAL FileTem := ''                  // Archivo temporal
*>>>>FIN DECLARACION DE VARIABLES

*>>>>SELECCION DE LAS AREAS DE TRABAJO
       IF !lUseDbf(.T.,PathArc+'\'+cNomArc,'ACT',NIL,lShared,nModCry)
          cError('ABRIENDO EL ARCHIVO')
          CloseDbf('ACT')
          RETURN nNroErr := 1
       ENDIF
       aStrOld := ACT->(DBSTRUCT())
       CloseDbf('ACT')
       CreaDbfMvt(lShared,nModCry,PathArc,cNomArc,@aStrNew)
*>>>>FIN SELECCION DE LAS AREAS DE TRABAJO

*>>>>VALIDACION DE LA ESTRUCTURA
       lCambio := .T.
       IF LEN(aStrNew) == LEN(aStrOld)
          lCambio := .F.
          nNroErr := 1
       ENDIF

       IF !lCambio
          FOR i := 1 TO LEN(aStrNew)
              IF UPPER(aStrNew[i,1]) # UPPER(aStrOld[i,1]) .OR.;
                 UPPER(SUBS(aStrNew[i,2],1,1)) # UPPER(SUBS(aStrOld[i,2],1,1)) .OR.;
                 aStrNew[i,3] # aStrOld[i,3] .OR.;
                 aStrNew[i,4] # aStrOld[i,4]
                 lCambio := .T.
                 EXIT
              ENDIF
          ENDFOR
       ENDIF
*>>>>FIN VALIDACION DE LA ESTRUCTURA

*>>>>CONFIRMACION DE LA ACTUALIZACION
       IF lCambio .AND. lShared
          cError('El Archivo '+cNomArc+' su Estructura Esta DesActualizada.',;
          'ATENCION',;
          'Para Actualizarla NO Debe Haber Ning£n Usuario en la Red.')
          lCambio := lPregunta('DESEA ACTUALIZAR LA ESTRUCTURA? No Si')
          IF !lCambio
             nNroErr := 1
          ENDIF
       ENDIF
*>>>>FIN CONFIRMACION DE LA ACTUALIZACION

*>>>>ACTUALIZACION DE LA ESTRUCTURA
       IF lCambio
          FileTem := SUBS(cNomArc,1,AT('.',cNomArc))+'STR'
          cSavPan := SAVESCREEN(0,0,24,79)
          IF !lStrucFile(lShared,;
                         PathArc+'\'+cNomArc,;
                         PathArc+'\'+FileTem,;
                         {||CreaDbfMvt(lShared,nModCry,PathArc,FileTem)})
             cError('NO SE ACTUALIZO LA ESTRUCTURA DEL ARCHIVO')
             nNroErr := 1
          ENDIF
          RESTSCREEN(0,0,24,79,cSavPan)
       ENDIF
       RETURN nNroErr
*>>>>FIN ACTUALIZACION DE LA ESTRUCTURA

/*************************************************************************
* TITULO..: MANTENIMIENTO DEL REGISTRO                                   *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: ENE 14/2014 MAR A
       Colombia, Bucaramanga        INICIO: 10:39 AM   ENE 14/2014 MAR

OBJETIVOS:

1- Permite inclusi¢n,modificaci¢n y consulta del registro

2- Puede invocarse en la lectura a trav‚s de la clausula VALID

2- Returna .T.

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION lManRegMvt(lShared,cNomUsr,nTipMod,oBrowse,nNroMes,nNroOpc)

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
       #INCLUDE 'inkey.ch'                  // Declaraci¢n de teclas

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

       LOCAL cCodigoTes := ''               // C¢digo del Estudiante                                       
       LOCAL cCodigoTgr := ''               // C¢digo del Grupo                                            
       LOCAL nMesIniTpa := 0                // Mes Inicial                                                 
       LOCAL nMesFinTpa := 0                // Mes Final                                                   
       LOCAL nMesFinTmv := 0                // Mes Final                                                   
       LOCAL cCodigoTco := ''               // Concepto                                                    
       LOCAL cDescriTmv := ''               // Descripci¢n                                                 
       LOCAL nCreditTmv := 0                // CREDITOS                                                    
       LOCAL nDebitoTmv := 0                // DEBITOS                                                     
       LOCAL nSaldosTmv := 0                // SALDOS                                                      
       LOCAL nTotCauTmv := 0                // CAUSACION                                                   
       LOCAL nSdoAntTpa := 0                // SDOANT                                                      
       LOCAL nMorAntTpa := 0                // MORANT                                                      
       LOCAL nVlrMesTpa := 0                // VLRMES                                                      
       LOCAL nVlrPagTpa := 0                // VLRPAG                                                      
       LOCAL nIntMesTpa := 0                // INTMES                                                      
       LOCAL cEstadoTpa := ''               // Estado                                                      
       LOCAL dFecPagTpa := CTOD('00/00/00')   // Fecha de Pago                                               
       LOCAL nNroFacTca := 0                // NROFAC                                                      
       LOCAL dFecFacTpa := CTOD('00/00/00')   // Fecha de Facturaci¢n                                        
       LOCAL cCodigoTba := ''               // Banco                                                       
       LOCAL cCodRefTtr := ''               // Referencia                                                  
       LOCAL cCodEstTtr := ''               // C¢digo del Estudiante                                       
       LOCAL nValorTtr := 0                // VLRTRA                                                      
       LOCAL dFechaTtr := CTOD('00/00/00')   // Fecha de Transaci¢n                                         
       LOCAL nVlrDifTmv := 0                // VLRDIF                                                      
       LOCAL nCodigoTmv := 0                // Concepto Movimiento                                         
       LOCAL cObservTmv := ''               // Observaci¢n                                                 

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
            cTxtTem := 'MOVIMIENTOS .INCLUIR. '+aMenus[nNroOpc]
            MVT->(DBGOBOTTOM())
            MVT->(DBSKIP())
            nTipCur := SETCURSOR(1)

       CASE nTipMod == 2
            cTxtTem := 'MOVIMIENTOS .ACTUALIZAR. '+aMenus[nNroOpc]
            nTipCur := SETCURSOR(1)

       CASE nTipMod == 3
            cTxtTem := 'MOVIMIENTOS. CONSUTA. '+aMenus[nNroOpc]
       ENDCASE
       nFilIni := nMarco(03,cTxtTem,22,'°')
*>>>>FIN MARCO DEL MANTENIMIENTO

*>>>>MANTENIMIENTO DEL REGISTRO
       SELECT MVT
       DO WHILE .T.

**********INICIALIZACION DE LAS VARIABLES
            IF lGrabar

               IF EMPTY(nNroMes)
                  nNroMes := MVT->nNroMesMvt
               ENDIF

               cCodigoTes := MVT->cCodigoEst
               cCodigoTgr := MVT->cCodigoGru
               nMesIniTpa := MVT->nMesIniPag
               nMesFinTpa := MVT->nMesFinPag
               nMesFinTmv := MVT->nMesFinMvt
               cCodigoTco := MVT->cCodigoCon
               cDescriTmv := MVT->cDescriMvt
               nCreditTmv := MVT->nCreditMvt
               nDebitoTmv := MVT->nDebitoMvt
               nSaldosTmv := MVT->nSaldosMvt
               nTotCauTmv := MVT->nTotCauPag
               nSdoAntTpa := MVT->nSdoAntPag
               nMorAntTpa := MVT->nMorAntPag
               nVlrMesTpa := MVT->nVlrMesPag
               nVlrPagTpa := MVT->nVlrPagPag
               nIntMesTpa := MVT->nIntMesPag
               cEstadoTpa := MVT->cEstadoPag
               dFecPagTpa := MVT->dFecPagPag
               nNroFacTca := MVT->nNroFacCaA
               dFecFacTpa := MVT->dFecFacPag
               cCodigoTba := MVT->cCodigoBan
               cCodRefTtr := MVT->cCodRefTra
               cCodEstTtr := MVT->cCodEstTra
               nValorTtr := MVT->nValorTra
               dFechaTtr := MVT->dFechaTra
               nVlrDifTmv := MVT->nVlrDifMvt
               nCodigoTmv := MVT->nCodigoCmv
               cObservTmv := MVT->cObservMvt
            ENDIF
**********FIN INICIALIZACION DE LAS VARIABLES

**********LECTURA DE CAMPO
            IF nNroOpc == 1

               nNroFil := nFilIni
               cTxtTem := 'MES                         :'

               IF nTipMod == 2 .OR. nTipMod == 3 .OR. !EMPTY(nNroMes)
                  @ nNroFil,nNroCol SAY cTxtTem
                  @ nNroFil,nNroCol+LEN(cTxtTem)+1 SAY nNroMes COLOR('I')
               ELSE
                  @ nNroFil,nNroCol SAY cTxtTem;
                                    GET nNroMes PICT '99';
                                    VALID !EMPTY(nNroMes) .AND.;
                                          !lValCodMvt(nNroMes)
               ENDIF

	    ENDIF
**********FIN LECTURA DE CAMPO

**********LECTURA DE CAMPO
            IF nNroOpc == 1

               nNroFil++
               nColTem := nNroCol
               cTxtTem := 'CODIGO DEL ESTUDIANTE :'

               IF nTipMod == 3
                  @ nNroFil,nColTem SAY cTxtTem
                  @ nNroFil,nColTem+LEN(cTxtTem)+1 SAY cCodigoTes COLOR('I')
               ELSE
                  @ nNroFil,nColTem SAY cTxtTem;
                                    GET cCodigoTes PICT '999999';
                                    VALID !EMPTY(cCodigoTes);
                                    WHEN {||HelpRead('FAVOR INGRESE EL CODIGO DEL ESTUDIANTE')}
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
                  @ nNroFil,nColTem+LEN(cTxtTem)+1 SAY cCodigoTgr COLOR('I')
               ELSE
                  @ nNroFil,nColTem SAY cTxtTem;
                                    GET cCodigoTgr PICT '9999';
                                    VALID !EMPTY(cCodigoTgr);
                                    WHEN {||HelpRead('FAVOR INGRESE EL CODIGO DEL GRUPO')}
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
                  @ nNroFil,nColTem+LEN(cTxtTem)+1 SAY nMesIniTpa COLOR('I')
               ELSE
                  @ nNroFil,nColTem SAY cTxtTem;
                                    GET nMesIniTpa PICT '99';
                                    VALID !EMPTY(nMesIniTpa);
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
                  @ nNroFil,nColTem+LEN(cTxtTem)+1 SAY nMesFinTpa COLOR('I')
               ELSE
                  @ nNroFil,nColTem SAY cTxtTem;
                                    GET nMesFinTpa PICT '99';
                                    VALID !EMPTY(nMesFinTpa);
                                    WHEN {||HelpRead('FAVOR INGRESE EL MES FINAL')}
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
                  @ nNroFil,nColTem+LEN(cTxtTem)+1 SAY nMesFinTmv COLOR('I')
               ELSE
                  @ nNroFil,nColTem SAY cTxtTem;
                                    GET nMesFinTmv PICT '99';
                                    VALID !EMPTY(nMesFinTmv);
                                    WHEN {||HelpRead('FAVOR INGRESE EL MES FINAL')}
               ENDIF

	    ENDIF
**********FIN LECTURA DE CAMPO

**********LECTURA DE CAMPO
            IF nNroOpc == 1

               nNroFil++
               nColTem := nNroCol
               cTxtTem := 'CONCEPTO              :'

               IF nTipMod == 3
                  @ nNroFil,nColTem SAY cTxtTem
                  @ nNroFil,nColTem+LEN(cTxtTem)+1 SAY cCodigoTco COLOR('I')
               ELSE
                  @ nNroFil,nColTem SAY cTxtTem;
                                    GET cCodigoTco PICT '@!';
                                    VALID !EMPTY(cCodigoTco);
                                    WHEN {||HelpRead('FAVOR INGRESE EL CODIGO DE CONCEPTO')}
               ENDIF

	    ENDIF
**********FIN LECTURA DE CAMPO

**********LECTURA DE CAMPO
            IF nNroOpc == 1

               nNroFil++
               nColTem := nNroCol
               cTxtTem := 'DESCRIPCION           :'

               IF nTipMod == 3
                  @ nNroFil,nColTem SAY cTxtTem
                  @ nNroFil,nColTem+LEN(cTxtTem)+1 SAY cDescriTmv COLOR('I')
               ELSE
                  @ nNroFil,nColTem SAY cTxtTem;
                                    GET cDescriTmv PICT '@!';
                                    VALID !EMPTY(cDescriTmv);
                                    WHEN {||HelpRead('FAVOR INGRESE LA DECRIPCION')}
               ENDIF

	    ENDIF
**********FIN LECTURA DE CAMPO

**********LECTURA DE CAMPO
            IF nNroOpc == 1

               nNroFil++
               nColTem := nNroCol
               cTxtTem := 'CREDITOS                    :'

               IF nTipMod == 3
                  @ nNroFil,nColTem SAY cTxtTem
                  @ nNroFil,nColTem+LEN(cTxtTem)+1 SAY nCreditTmv COLOR('I')
               ELSE
                  @ nNroFil,nColTem SAY cTxtTem;
                                    GET nCreditTmv PICT '9999999999.99';
                                    VALID !EMPTY(nCreditTmv);
                                    WHEN {||HelpRead('FAVOR INGRESE LOS CREDITOS')}
               ENDIF

	    ENDIF
**********FIN LECTURA DE CAMPO

**********LECTURA DE CAMPO
            IF nNroOpc == 1

               nNroFil++
               nColTem := nNroCol
               cTxtTem := 'DEBITOS                     :'

               IF nTipMod == 3
                  @ nNroFil,nColTem SAY cTxtTem
                  @ nNroFil,nColTem+LEN(cTxtTem)+1 SAY nDebitoTmv COLOR('I')
               ELSE
                  @ nNroFil,nColTem SAY cTxtTem;
                                    GET nDebitoTmv PICT '9999999999.99';
                                    VALID !EMPTY(nDebitoTmv);
                                    WHEN {||HelpRead('FAVOR INGRESE LOS DEBITOS')}
               ENDIF

	    ENDIF
**********FIN LECTURA DE CAMPO

**********LECTURA DE CAMPO
            IF nNroOpc == 1

               nNroFil++
               nColTem := nNroCol
               cTxtTem := 'SALDOS                      :'

               IF nTipMod == 3
                  @ nNroFil,nColTem SAY cTxtTem
                  @ nNroFil,nColTem+LEN(cTxtTem)+1 SAY nSaldosTmv COLOR('I')
               ELSE
                  @ nNroFil,nColTem SAY cTxtTem;
                                    GET nSaldosTmv PICT '9999999999.99';
                                    VALID !EMPTY(nSaldosTmv);
                                    WHEN {||HelpRead('FAVOR INGRESE LOS SALDOS')}
               ENDIF

	    ENDIF
**********FIN LECTURA DE CAMPO

**********LECTURA DE CAMPO
            IF nNroOpc == 1

               nNroFil++
               nColTem := nNroCol
               cTxtTem := 'CAUSACION                   :'

               IF nTipMod == 3
                  @ nNroFil,nColTem SAY cTxtTem
                  @ nNroFil,nColTem+LEN(cTxtTem)+1 SAY nTotCauTmv COLOR('I')
               ELSE
                  @ nNroFil,nColTem SAY cTxtTem;
                                    GET nTotCauTmv PICT '9999999999.99';
                                    VALID !EMPTY(nTotCauTmv);
                                    WHEN {||HelpRead('FAVOR INGRESE EL TOTAL CAUSACION')}
               ENDIF

	    ENDIF
**********FIN LECTURA DE CAMPO

**********LECTURA DE CAMPO
            IF nNroOpc == 1

               nNroFil++
               nColTem := nNroCol
               cTxtTem := 'SDOANT                      :'

               IF nTipMod == 3
                  @ nNroFil,nColTem SAY cTxtTem
                  @ nNroFil,nColTem+LEN(cTxtTem)+1 SAY nSdoAntTpa COLOR('I')
               ELSE
                  @ nNroFil,nColTem SAY cTxtTem;
                                    GET nSdoAntTpa PICT '9999999999.99';
                                    VALID !EMPTY(nSdoAntTpa);
                                    WHEN {||HelpRead('FAVOR INGRESE EL SALDO ANTERIOR')}
               ENDIF

	    ENDIF
**********FIN LECTURA DE CAMPO

**********LECTURA DE CAMPO
            IF nNroOpc == 1

               nNroFil++
               nColTem := nNroCol
               cTxtTem := 'MORANT                      :'

               IF nTipMod == 3
                  @ nNroFil,nColTem SAY cTxtTem
                  @ nNroFil,nColTem+LEN(cTxtTem)+1 SAY nMorAntTpa COLOR('I')
               ELSE
                  @ nNroFil,nColTem SAY cTxtTem;
                                    GET nMorAntTpa PICT '9999999999.99';
                                    VALID !EMPTY(nMorAntTpa);
                                    WHEN {||HelpRead('FAVOR INGRESE EL MORA ANTERIOR')}
               ENDIF

	    ENDIF
**********FIN LECTURA DE CAMPO

**********LECTURA DE CAMPO
            IF nNroOpc == 1

               nNroFil++
               nColTem := nNroCol
               cTxtTem := 'VLRMES                      :'

               IF nTipMod == 3
                  @ nNroFil,nColTem SAY cTxtTem
                  @ nNroFil,nColTem+LEN(cTxtTem)+1 SAY nVlrMesTpa COLOR('I')
               ELSE
                  @ nNroFil,nColTem SAY cTxtTem;
                                    GET nVlrMesTpa PICT '9999999999.99';
                                    VALID !EMPTY(nVlrMesTpa);
                                    WHEN {||HelpRead('FAVOR INGRESE EL VALOR DEL MES')}
               ENDIF

	    ENDIF
**********FIN LECTURA DE CAMPO

**********LECTURA DE CAMPO
            IF nNroOpc == 1

               nNroFil++
               nColTem := nNroCol
               cTxtTem := 'VLRPAG                      :'

               IF nTipMod == 3
                  @ nNroFil,nColTem SAY cTxtTem
                  @ nNroFil,nColTem+LEN(cTxtTem)+1 SAY nVlrPagTpa COLOR('I')
               ELSE
                  @ nNroFil,nColTem SAY cTxtTem;
                                    GET nVlrPagTpa PICT '9999999999.99';
                                    VALID !EMPTY(nVlrPagTpa);
                                    WHEN {||HelpRead('FAVOR INGRESE EL VALOR A PAGAR')}
               ENDIF

	    ENDIF
**********FIN LECTURA DE CAMPO

**********LECTURA DE CAMPO
            IF nNroOpc == 1

               nNroFil++
               nColTem := nNroCol
               cTxtTem := 'INTMES                      :'

               IF nTipMod == 3
                  @ nNroFil,nColTem SAY cTxtTem
                  @ nNroFil,nColTem+LEN(cTxtTem)+1 SAY nIntMesTpa COLOR('I')
               ELSE
                  @ nNroFil,nColTem SAY cTxtTem;
                                    GET nIntMesTpa PICT '9999999999.99';
                                    VALID !EMPTY(nIntMesTpa);
                                    WHEN {||HelpRead('FAVOR INGRESE LOS INT DEL MES')}
               ENDIF

	    ENDIF
**********FIN LECTURA DE CAMPO

**********LECTURA DE CAMPO
            IF nNroOpc == 1

               nNroFil++
               nColTem := nNroCol
               cTxtTem := 'ESTADO                :'

               IF nTipMod == 3
                  @ nNroFil,nColTem SAY cTxtTem
                  @ nNroFil,nColTem+LEN(cTxtTem)+1 SAY cEstadoTpa COLOR('I')
               ELSE
                  @ nNroFil,nColTem SAY cTxtTem;
                                    GET cEstadoTpa PICT '@!';
                                    VALID !EMPTY(cEstadoTpa);
                                    WHEN {||HelpRead('FAVOR INGRESE EL ESTADO DEL PAGO')}
               ENDIF

	    ENDIF
**********FIN LECTURA DE CAMPO

**********LECTURA DE CAMPO
            IF nNroOpc == 1

               nNroFil++
               nColTem := nNroCol
               cTxtTem := 'FECHA DE PAGO         :'

               IF nTipMod == 3
                  @ nNroFil,nColTem SAY cTxtTem
                  @ nNroFil,nColTem+LEN(cTxtTem)+1 SAY dFecPagTpa COLOR('I')
               ELSE
                  @ nNroFil,nColTem SAY cTxtTem;
                                    GET dFecPagTpa PICT '@!D';
                                    VALID !EMPTY(dFecPagTpa);
                                    WHEN {||HelpRead('FAVOR INGRESE LA FECHA DE PAGO')}
               ENDIF

	    ENDIF
**********FIN LECTURA DE CAMPO

**********LECTURA DE CAMPO
            IF nNroOpc == 1

               nNroFil++
               nColTem := nNroCol
               cTxtTem := 'NROFAC                      :'

               IF nTipMod == 3
                  @ nNroFil,nColTem SAY cTxtTem
                  @ nNroFil,nColTem+LEN(cTxtTem)+1 SAY nNroFacTca COLOR('I')
               ELSE
                  @ nNroFil,nColTem SAY cTxtTem;
                                    GET nNroFacTca PICT '999999999999';
                                    VALID !EMPTY(nNroFacTca);
                                    WHEN {||HelpRead('FAVOR INGRESE EL NUMERO FACTURA')}
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
                  @ nNroFil,nColTem+LEN(cTxtTem)+1 SAY dFecFacTpa COLOR('I')
               ELSE
                  @ nNroFil,nColTem SAY cTxtTem;
                                    GET dFecFacTpa PICT '@!D';
                                    VALID !EMPTY(dFecFacTpa);
                                    WHEN {||HelpRead('FAVOR INGRESE LA FECHA DE FACTURACION')}
               ENDIF

	    ENDIF
**********FIN LECTURA DE CAMPO

**********LECTURA DE CAMPO
            IF nNroOpc == 1

               nNroFil++
               nColTem := nNroCol
               cTxtTem := 'BANCO                 :'

               IF nTipMod == 3
                  @ nNroFil,nColTem SAY cTxtTem
                  @ nNroFil,nColTem+LEN(cTxtTem)+1 SAY cCodigoTba COLOR('I')
               ELSE
                  @ nNroFil,nColTem SAY cTxtTem;
                                    GET cCodigoTba PICT '@!';
                                    VALID !EMPTY(cCodigoTba);
                                    WHEN {||HelpRead('FAVOR INGRESE EL CODIGO DEL BANCO')}
               ENDIF

	    ENDIF
**********FIN LECTURA DE CAMPO

**********LECTURA DE CAMPO
            IF nNroOpc == 1

               nNroFil++
               nColTem := nNroCol
               cTxtTem := 'REFERENCIA            :'

               IF nTipMod == 3
                  @ nNroFil,nColTem SAY cTxtTem
                  @ nNroFil,nColTem+LEN(cTxtTem)+1 SAY cCodRefTtr COLOR('I')
               ELSE
                  @ nNroFil,nColTem SAY cTxtTem;
                                    GET cCodRefTtr PICT '@!';
                                    VALID !EMPTY(cCodRefTtr);
                                    WHEN {||HelpRead('FAVOR INGRESE LA REFERENCIA')}
               ENDIF

	    ENDIF
**********FIN LECTURA DE CAMPO

**********LECTURA DE CAMPO
            IF nNroOpc == 1

               nNroFil++
               nColTem := nNroCol
               cTxtTem := 'CODIGO DEL ESTUDIANTE :'

               IF nTipMod == 3
                  @ nNroFil,nColTem SAY cTxtTem
                  @ nNroFil,nColTem+LEN(cTxtTem)+1 SAY cCodEstTtr COLOR('I')
               ELSE
                  @ nNroFil,nColTem SAY cTxtTem;
                                    GET cCodEstTtr PICT '999999';
                                    VALID !EMPTY(cCodEstTtr);
                                    WHEN {||HelpRead('FAVOR INGRESE EL CODIGO DEL ESTUDIANTE')}
               ENDIF

	    ENDIF
**********FIN LECTURA DE CAMPO

**********LECTURA DE CAMPO
            IF nNroOpc == 1

               nNroFil++
               nColTem := nNroCol
               cTxtTem := 'VLRTRA                      :'

               IF nTipMod == 3
                  @ nNroFil,nColTem SAY cTxtTem
                  @ nNroFil,nColTem+LEN(cTxtTem)+1 SAY nValorTtr COLOR('I')
               ELSE
                  @ nNroFil,nColTem SAY cTxtTem;
                                    GET nValorTtr PICT '9999999999.99';
                                    VALID !EMPTY(nValorTtr);
                                    WHEN {||HelpRead('FAVOR INGRESE EL VALOR A CONSIGNADO')}
               ENDIF

	    ENDIF
**********FIN LECTURA DE CAMPO

**********LECTURA DE CAMPO
            IF nNroOpc == 1

               nNroFil++
               nColTem := nNroCol
               cTxtTem := 'FECHA TRANSACION      :'

               IF nTipMod == 3
                  @ nNroFil,nColTem SAY cTxtTem
                  @ nNroFil,nColTem+LEN(cTxtTem)+1 SAY dFechaTtr COLOR('I')
               ELSE
                  @ nNroFil,nColTem SAY cTxtTem;
                                    GET dFechaTtr PICT '@!D';
                                    VALID !EMPTY(dFechaTtr);
                                    WHEN {||HelpRead('FAVOR INGRESE LA FECHA TRANSACION')}
               ENDIF

	    ENDIF
**********FIN LECTURA DE CAMPO

**********LECTURA DE CAMPO
            IF nNroOpc == 1

               nNroFil++
               nColTem := nNroCol
               cTxtTem := 'VLRDIF                      :'

               IF nTipMod == 3
                  @ nNroFil,nColTem SAY cTxtTem
                  @ nNroFil,nColTem+LEN(cTxtTem)+1 SAY nVlrDifTmv COLOR('I')
               ELSE
                  @ nNroFil,nColTem SAY cTxtTem;
                                    GET nVlrDifTmv PICT '9999999999.99';
                                    VALID !EMPTY(nVlrDifTmv);
                                    WHEN {||HelpRead('FAVOR INGRESE EL VALOR DIFERENCIA')}
               ENDIF

	    ENDIF
**********FIN LECTURA DE CAMPO

**********LECTURA DE CAMPO
            IF nNroOpc == 1

               nNroFil++
               nColTem := nNroCol
               cTxtTem := 'CONCEPTO                    :'

               IF nTipMod == 3
                  @ nNroFil,nColTem SAY cTxtTem
                  @ nNroFil,nColTem+LEN(cTxtTem)+1 SAY nCodigoTmv COLOR('I')
               ELSE
                  @ nNroFil,nColTem SAY cTxtTem;
                                    GET nCodigoTmv PICT '9999';
                                    VALID !EMPTY(nCodigoTmv);
                                    WHEN {||HelpRead('FAVOR INGRESE EL CONCEPTO')}
               ENDIF

	    ENDIF
**********FIN LECTURA DE CAMPO

**********LECTURA DE CAMPO
            IF nNroOpc == 1

               nNroFil++
               nColTem := nNroCol
               cTxtTem := 'OBSERVACION           :'

               IF nTipMod == 3
                  @ nNroFil,nColTem SAY cTxtTem
                  @ nNroFil,nColTem+LEN(cTxtTem)+1 SAY cObservTmv COLOR('I')
               ELSE
                  @ nNroFil,nColTem SAY cTxtTem;
                                    GET cObservTmv PICT '@!';
                                    VALID !EMPTY(cObservTmv);
                                    WHEN {||HelpRead('FAVOR INGRESE LA OBSERVACION')}
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
       SELECT MVT
       IF nTipMod # 3 .AND. lGrabar

          lInsReg := IF(nTipMod == 1,.T.,.F.)
          IF MVT->(lRegLock(lShared,lInsReg))

             IF lInsReg
                REPL MVT->nIdeCodMvt WITH MVT->(RECNO())
                REPL MVT->nNroMesMvt WITH nNroMes
             ENDIF

             REPL MVT->cCodigoEst WITH cCodigoTes
             REPL MVT->cCodigoGru WITH cCodigoTgr
             REPL MVT->nMesIniPag WITH nMesIniTpa
             REPL MVT->nMesFinPag WITH nMesFinTpa
             REPL MVT->nMesFinMvt WITH nMesFinTmv
             REPL MVT->cCodigoCon WITH cCodigoTco
             REPL MVT->cDescriMvt WITH cDescriTmv
             REPL MVT->nCreditMvt WITH nCreditTmv
             REPL MVT->nDebitoMvt WITH nDebitoTmv
             REPL MVT->nSaldosMvt WITH nSaldosTmv
             REPL MVT->nTotCauPag WITH nTotCauTmv
             REPL MVT->nSdoAntPag WITH nSdoAntTpa
             REPL MVT->nMorAntPag WITH nMorAntTpa
             REPL MVT->nVlrMesPag WITH nVlrMesTpa
             REPL MVT->nVlrPagPag WITH nVlrPagTpa
             REPL MVT->nIntMesPag WITH nIntMesTpa
             REPL MVT->cEstadoPag WITH cEstadoTpa
             REPL MVT->dFecPagPag WITH dFecPagTpa
             REPL MVT->nNroFacCaA WITH nNroFacTca
             REPL MVT->dFecFacPag WITH dFecFacTpa
             REPL MVT->cCodigoBan WITH cCodigoTba
             REPL MVT->cCodRefTra WITH cCodRefTtr
             REPL MVT->cCodEstTra WITH cCodEstTtr
             REPL MVT->nValorTra WITH nValorTtr
             REPL MVT->dFechaTra WITH dFechaTtr
             REPL MVT->nVlrDifMvt WITH nVlrDifTmv
             REPL MVT->nCodigoCmv WITH nCodigoTmv
             REPL MVT->cObservMvt WITH cObservTmv

             REPL MVT->cNomUsrMvt WITH cNomUsr
             REPL MVT->dFecUsrMvt WITH DATE()
             REPL MVT->cHorUsrMvt WITH TIME()
             MVT->(DBCOMMIT())
          ENDIF

          IF lShared
             MVT->(DBUNLOCK())
          ENDIF

       ENDIF
       RESTSCREEN(0,0,24,79,cSavPan)
       SETCURSOR(nTipCur)
*>>>>FIN GRABACION DEL REGISTRO

*>>>>REFRESCAR EL BROWSE
       IF nTipMod == 2
          nNroReg := MVT->(RECNO())
          MVT->(DBGOTOP())
          oBrowse:GOTOP()
          MVT->(DBGOTO(nNroReg))
          oBrowse:FORCESTABLE()
       ENDIF
       RETURN .T.
*>>>>FIN REFRESCAR EL BROWSE

/*************************************************************************
* TITULO..: VALIDACION DE EXISTENCIA DEL CODIGO                          *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: ENE 14/2014 MAR A
       Colombia, Bucaramanga        INICIO: 10:39 AM   ENE 14/2014 MAR

OBJETIVOS:

1- Debe estar en uso el archivo.

2- Realiza la validaci¢n de existencia del C¢digo.

3- Retorna .T. si hay problemas

SINTAXIS:

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION lValCodMvt(cCodigo)

*>>>>DESCRIPCION DE PARAMETROS
/*     cCodigo                              // C¢digo a Validar */
*>>>>FIN DESCRIPCION DE PARAMETROS

*>>>>DECLARACION DE VARIABLES
       LOCAL lHayErr := .F.                 // .T. Hay Error
*>>>>FIN DECLARACION DE VARIABLES

*>>>>VALIDACION DEL CODIGO
       IF cCodigo # cSpaces('MVT','nNroMesMvt')
          IF lLocCodigo('nNroMesMvt','MVT',cCodigo)
             cError('ESTE CODIGO YA EXISTE')
             lHayErr := .T.
          ENDIF
       ENDIF
       RETURN lHayErr
*>>>>FIN VALIDACION DEL CODIGO

