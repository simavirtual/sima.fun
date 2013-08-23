/*************************************************************************
* TITULO..: CREACION DE LA ESTRUCTURA                                    *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: OCT 31/2005 LUN A
       Colombia, Bucaramanga        INICIO:  3:47 PM   OCT 31/2005 LUN

OBJETIVOS:

1- Crea la estructura del archivo

2- Retorna NIL

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION CreaDbfReg(lShared,nModCry,PathArc,fArchvo,aStrDbf)

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
       AADD(aDbfStr,{'nIdeCodReg','Numeric'  ,16,0}) // Ide del Registro
      *Llave Principal

       AADD(aDbfStr,{'cPlacaVeh','Character',6,0}) // N£mero de Placa
       AADD(aDbfStr,{'cTipVehCat','Character',2,0}) // Tipo de Veh¡culo
       AADD(aDbfStr,{'nCodigoCaj','Numeric',2,0}) // N£mero de la Caja
       AADD(aDbfStr,{'dFecIngReg','Date',8,0}) // Fecha de Ingreso
       AADD(aDbfStr,{'dFecOutReg','Date',8,0}) // Fecha de Salida
       AADD(aDbfStr,{'cHorIngReg','Character',8,0}) // Hora de Ingreso
       AADD(aDbfStr,{'cHorOutReg','Character',8,0}) // Hora de Salida
       AADD(aDbfStr,{'cTiempoReg','Character',24,0}) // Tiempo de Duraci¢n
       AADD(aDbfStr,{'cTieCobReg','Character',20,0}) // Tiempo Cobrado
       AADD(aDbfStr,{'nVlrTotReg','Numeric',12,2}) // Valor del Servicio
       AADD(aDbfStr,{'nBasIvaReg','Numeric',12,2}) // Base del Iva
       AADD(aDbfStr,{'nPorIvaReg','Numeric',5,2}) // Porcentaje del Iva
       AADD(aDbfStr,{'nVlrIvaReg','Numeric',12,2}) // Valor del Iva
       AADD(aDbfStr,{'nNroFacReg','Numeric',9,0}) // Numero del Recibo
       AADD(aDbfStr,{'dFecRetRca','Date',8,0}) // Fecha de Retiro de Caja
       AADD(aDbfStr,{'cHorRetRca','Character',8,0}) // Hora del Retiro de caja
       AADD(aDbfStr,{'dFecDepReg','Date',8,0}) // Fecha de la Consignaci¢n
       AADD(aDbfStr,{'cNroComReg','Character',12,0}) // Comprobante de Contabilidad
       AADD(aDbfStr,{'cObservReg','Character',40,0}) // Observaci¢n

       AADD(aDbfStr,{'cNomUsrReg','Character',10,0}) // Nombre del Usuario
       AADD(aDbfStr,{'dFecUsrReg','Date'     ,08,0}) // Fecha del Usuario
       AADD(aDbfStr,{'cHorUsrReg','Character',10,0}) // Hora del Usuario
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

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: OCT 31/2005 LUN A
       Colombia, Bucaramanga        INICIO:  3:47 PM   OCT 31/2005 LUN

OBJETIVOS:

1- Recupera la estructura del archivo

2- Retorna NIL

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION RecuDbfReg(lShared,nModCry,PathArc,fArchvo)

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
       CreaDbfReg(lShared,nModCry,PathArc,fArchvo)
       RESTORE SCREEN
       RETURN NIL
*>>>>FIN RECUPERA LA ESTRUCTURA DEL ARCHIVO

/*************************************************************************
* TITULO..: ACTUALIZACION DE LA ESTRUCTURA                               *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: OCT 31/2005 LUN A
       Colombia, Bucaramanga        INICIO:  3:47 PM   OCT 31/2005 LUN

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

FUNCTION nActStrReg(lShared,nModCry,PathArc,cNomArc)

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
       CreaDbfReg(lShared,nModCry,PathArc,cNomArc,@aStrNew)
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
                         {||CreaDbfReg(lShared,nModCry,PathArc,FileTem)})
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

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: OCT 31/2005 LUN A
       Colombia, Bucaramanga        INICIO:  3:47 PM   OCT 31/2005 LUN

OBJETIVOS:

1- Permite inclusi¢n,modificaci¢n y consulta del registro

2- Puede invocarse en la lectura a trav‚s de la clausula VALID

2- Returna .T.

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION lManRegReg(lShared,cNomUsr,nTipMod,oBrowse,cPlaca,nNroOpc)

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

       LOCAL cTipVehTca := ''               // Tipo de Veh¡culo                                            
       LOCAL nCodigoTca := 0                // N£mero de la Caja                                           
       LOCAL dFecIngTre := CTOD('00/00/00')   // Fecha de Ingreso                                            
       LOCAL dFecOutTre := CTOD('00/00/00')   // Fecha de Salida                                             
       LOCAL cHorIngTre := ''               // Hora de Ingreso                                             
       LOCAL cHorOutTre := ''               // Hora de Salida                                              
       LOCAL cTiempoTre := ''               // Tiempo de Duraci¢n                                          
       LOCAL cTieCobTre := ''               // Tiempo Cobrado                                              
       LOCAL nVlrTotTre := 0                // Valor del Servicio                                          
       LOCAL nBasIvaTre := 0                // Base del Iva                                                
       LOCAL nPorIvaTre := 0                // Porcentaje del Iva                                          
       LOCAL nVlrIvaTre := 0                // Valor del Iva                                               
       LOCAL nNroFacTre := 0                // Numero del Recibo                                           
       LOCAL dFecRetTrc := CTOD('00/00/00')   // Fecha de Retiro de Caja                                     
       LOCAL cHorRetTrc := ''               // Hora del Retiro de caja                                     
       LOCAL dFecDepTrc := CTOD('00/00/00')   // Fecha de la Consignaci¢n                                    
       LOCAL cNroComTre := ''               // Comprobante de Contabilidad                                 
       LOCAL cObservTre := ''               // Observaci¢n                                                 

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
            cTxtTem := 'REGISTRO .INCLUIR. '+aMenus[nNroOpc]
            REG->(DBGOBOTTOM())
            REG->(DBSKIP())
            nTipCur := SETCURSOR(1)

       CASE nTipMod == 2
            cTxtTem := 'REGISTRO .ACTUALIZAR. '+aMenus[nNroOpc]
            nTipCur := SETCURSOR(1)

       CASE nTipMod == 3
            cTxtTem := 'REGISTRO. CONSUTA. '+aMenus[nNroOpc]
       ENDCASE
       nFilIni := nMarco(03,cTxtTem,22,'°')
*>>>>FIN MARCO DEL MANTENIMIENTO

*>>>>MANTENIMIENTO DEL REGISTRO
       SELECT REG
       DO WHILE .T.

**********INICIALIZACION DE LAS VARIABLES
            IF lGrabar

               IF EMPTY(cPlaca)
                  cPlaca := REG->cPlacaVeh
               ENDIF

               cTipVehTca := REG->cTipVehCat
               nCodigoTca := REG->nCodigoCaj
               dFecIngTre := REG->dFecIngReg
               dFecOutTre := REG->dFecOutReg
               cHorIngTre := REG->cHorIngReg
               cHorOutTre := REG->cHorOutReg
               cTiempoTre := REG->cTiempoReg
               cTieCobTre := REG->cTieCobReg
               nVlrTotTre := REG->nVlrTotReg
               nBasIvaTre := REG->nBasIvaReg
               nPorIvaTre := REG->nPorIvaReg
               nVlrIvaTre := REG->nVlrIvaReg
               nNroFacTre := REG->nNroFacReg
               dFecRetTrc := REG->dFecRetRca
               cHorRetTrc := REG->cHorRetRca
               dFecDepTrc := REG->dFecDepReg
               cNroComTre := REG->cNroComReg
               cObservTre := REG->cObservReg
            ENDIF
**********FIN INICIALIZACION DE LAS VARIABLES

**********LECTURA DE CAMPO
            IF nNroOpc == 1

               nNroFil := nFilIni
               cTxtTem := 'NUMERO DE PLACA   :'

               IF nTipMod == 2 .OR. nTipMod == 3 .OR. !EMPTY(cPlaca)
                  @ nNroFil,nNroCol SAY cTxtTem
                  @ nNroFil,nNroCol+LEN(cTxtTem)+1 SAY cPlaca COLOR('I')
               ELSE
                  @ nNroFil,nNroCol SAY cTxtTem;
                                    GET cPlaca PICT '@!';
                                    VALID !EMPTY(cPlaca) .AND.;
                                          !lValCodReg(cPlaca)
               ENDIF

	    ENDIF
**********FIN LECTURA DE CAMPO

**********LECTURA DE CAMPO
            IF nNroOpc == 1

               nNroFil++
               nColTem := nNroCol
               cTxtTem := 'TIPO DE VEHICULO  :'

               IF nTipMod == 3
                  @ nNroFil,nColTem SAY cTxtTem
                  @ nNroFil,nColTem+LEN(cTxtTem)+1 SAY cTipVehTca COLOR('I')
               ELSE
                  @ nNroFil,nColTem SAY cTxtTem;
                                    GET cTipVehTca PICT '@!';
                                    VALID !EMPTY(cTipVehTca);
                                    WHEN {||HelpRead('FAVOR INGRESE EL TIPO DE VEHICULO')}
               ENDIF

	    ENDIF
**********FIN LECTURA DE CAMPO

**********LECTURA DE CAMPO
            IF nNroOpc == 1

               nNroFil++
               nColTem := nNroCol
               cTxtTem := 'CAJA No.             :'

               IF nTipMod == 3
                  @ nNroFil,nColTem SAY cTxtTem
                  @ nNroFil,nColTem+LEN(cTxtTem)+1 SAY nCodigoTca COLOR('I')
               ELSE
                  @ nNroFil,nColTem SAY cTxtTem;
                                    GET nCodigoTca PICT '@!';
                                    VALID !EMPTY(nCodigoTca);
                                    WHEN {||HelpRead('FAVOR INGRESE EL NUMERO DE LA CAJA')}
               ENDIF

	    ENDIF
**********FIN LECTURA DE CAMPO

**********LECTURA DE CAMPO
            IF nNroOpc == 1

               nNroFil++
               nColTem := nNroCol
               cTxtTem := 'FECHA DE INGRESO     :'

               IF nTipMod == 3
                  @ nNroFil,nColTem SAY cTxtTem
                  @ nNroFil,nColTem+LEN(cTxtTem)+1 SAY dFecIngTre COLOR('I')
               ELSE
                  @ nNroFil,nColTem SAY cTxtTem;
                                    GET dFecIngTre PICT '@!D';
                                    VALID !EMPTY(dFecIngTre);
                                    WHEN {||HelpRead('FAVOR INGRESE LA FECHA DE INGRESO')}
               ENDIF

	    ENDIF
**********FIN LECTURA DE CAMPO

**********LECTURA DE CAMPO
            IF nNroOpc == 1

               nNroFil++
               nColTem := nNroCol
               cTxtTem := 'FECHA DE SALIDA      :'

               IF nTipMod == 3
                  @ nNroFil,nColTem SAY cTxtTem
                  @ nNroFil,nColTem+LEN(cTxtTem)+1 SAY dFecOutTre COLOR('I')
               ELSE
                  @ nNroFil,nColTem SAY cTxtTem;
                                    GET dFecOutTre PICT '@!D';
                                    VALID !EMPTY(dFecOutTre);
                                    WHEN {||HelpRead('FAVOR INGRESE LA FECHA DE SALIDA')}
               ENDIF

	    ENDIF
**********FIN LECTURA DE CAMPO

**********LECTURA DE CAMPO
            IF nNroOpc == 1

               nNroFil++
               nColTem := nNroCol
               cTxtTem := 'HORA DE INGRESO      :'

               IF nTipMod == 3
                  @ nNroFil,nColTem SAY cTxtTem
                  @ nNroFil,nColTem+LEN(cTxtTem)+1 SAY cHorIngTre COLOR('I')
               ELSE
                  @ nNroFil,nColTem SAY cTxtTem;
                                    GET cHorIngTre PICT '@!';
                                    VALID !EMPTY(cHorIngTre);
                                    WHEN {||HelpRead('FAVOR INGRESE LA HORA DE INGRESO')}
               ENDIF

	    ENDIF
**********FIN LECTURA DE CAMPO

**********LECTURA DE CAMPO
            IF nNroOpc == 1

               nNroFil++
               nColTem := nNroCol
               cTxtTem := 'HORA DE SALIDA       :'

               IF nTipMod == 3
                  @ nNroFil,nColTem SAY cTxtTem
                  @ nNroFil,nColTem+LEN(cTxtTem)+1 SAY cHorOutTre COLOR('I')
               ELSE
                  @ nNroFil,nColTem SAY cTxtTem;
                                    GET cHorOutTre PICT '@!';
                                    VALID !EMPTY(cHorOutTre);
                                    WHEN {||HelpRead('FAVOR INGRESE LA HORA DE SALIDA')}
               ENDIF

	    ENDIF
**********FIN LECTURA DE CAMPO

**********LECTURA DE CAMPO
            IF nNroOpc == 1

               nNroFil++
               nColTem := nNroCol
               cTxtTem := 'TIEMPO DE DURACION   :'

               IF nTipMod == 3
                  @ nNroFil,nColTem SAY cTxtTem
                  @ nNroFil,nColTem+LEN(cTxtTem)+1 SAY cTiempoTre COLOR('I')
               ELSE
                  @ nNroFil,nColTem SAY cTxtTem;
                                    GET cTiempoTre PICT '@!';
                                    VALID !EMPTY(cTiempoTre);
                                    WHEN {||HelpRead('FAVOR INGRESE EL TIEMPO DE DURACION')}
               ENDIF

	    ENDIF
**********FIN LECTURA DE CAMPO

**********LECTURA DE CAMPO
            IF nNroOpc == 1

               nNroFil++
               nColTem := nNroCol
               cTxtTem := 'TIEMPO COBRADO       :'

               IF nTipMod == 3
                  @ nNroFil,nColTem SAY cTxtTem
                  @ nNroFil,nColTem+LEN(cTxtTem)+1 SAY cTieCobTre COLOR('I')
               ELSE
                  @ nNroFil,nColTem SAY cTxtTem;
                                    GET cTieCobTre PICT '@!';
                                    VALID !EMPTY(cTieCobTre);
                                    WHEN {||HelpRead('FAVOR INGRESE EL TIEMPO COBRADO')}
               ENDIF

	    ENDIF
**********FIN LECTURA DE CAMPO

**********LECTURA DE CAMPO
            IF nNroOpc == 1

               nNroFil++
               nColTem := nNroCol
               cTxtTem := 'VALOR DEL SERVICIO   :'

               IF nTipMod == 3
                  @ nNroFil,nColTem SAY cTxtTem
                  @ nNroFil,nColTem+LEN(cTxtTem)+1 SAY nVlrTotTre COLOR('I')
               ELSE
                  @ nNroFil,nColTem SAY cTxtTem;
                                    GET nVlrTotTre PICT '999999999.99';
                                    VALID !EMPTY(nVlrTotTre);
                                    WHEN {||HelpRead('FAVOR INGRESE EL VALOR DEL SERVICIO')}
               ENDIF

	    ENDIF
**********FIN LECTURA DE CAMPO

**********LECTURA DE CAMPO
            IF nNroOpc == 1

               nNroFil++
               nColTem := nNroCol
               cTxtTem := 'BASE DEL IVA         :'

               IF nTipMod == 3
                  @ nNroFil,nColTem SAY cTxtTem
                  @ nNroFil,nColTem+LEN(cTxtTem)+1 SAY nBasIvaTre COLOR('I')
               ELSE
                  @ nNroFil,nColTem SAY cTxtTem;
                                    GET nBasIvaTre PICT '999999999.99';
                                    VALID !EMPTY(nBasIvaTre);
                                    WHEN {||HelpRead('FAVOR INGRESE LA BASE DEL IVA')}
               ENDIF

	    ENDIF
**********FIN LECTURA DE CAMPO

**********LECTURA DE CAMPO
            IF nNroOpc == 1

               nNroFil++
               nColTem := nNroCol
               cTxtTem := '%IVA                 :'

               IF nTipMod == 3
                  @ nNroFil,nColTem SAY cTxtTem
                  @ nNroFil,nColTem+LEN(cTxtTem)+1 SAY nPorIvaTre COLOR('I')
               ELSE
                  @ nNroFil,nColTem SAY cTxtTem;
                                    GET nPorIvaTre PICT '99.99';
                                    WHEN {||HelpRead('FAVOR INGRESE EL % DEL IVA')}
               ENDIF

	    ENDIF
**********FIN LECTURA DE CAMPO

**********LECTURA DE CAMPO
            IF nNroOpc == 1

               nNroFil++
               nColTem := nNroCol
               cTxtTem := 'VALOR DEL IVA        :'

               IF nTipMod == 3
                  @ nNroFil,nColTem SAY cTxtTem
                  @ nNroFil,nColTem+LEN(cTxtTem)+1 SAY nVlrIvaTre COLOR('I')
               ELSE
                  @ nNroFil,nColTem SAY cTxtTem;
                                    GET nVlrIvaTre PICT '999999999.99';
                                    VALID !EMPTY(nVlrIvaTre);
                                    WHEN {||HelpRead('FAVOR INGRESE EL VALOR DEL IVA')}
               ENDIF

	    ENDIF
**********FIN LECTURA DE CAMPO

**********LECTURA DE CAMPO
            IF nNroOpc == 1

               nNroFil++
               nColTem := nNroCol
               cTxtTem := 'RECIBO               :'

               IF nTipMod == 3
                  @ nNroFil,nColTem SAY cTxtTem
                  @ nNroFil,nColTem+LEN(cTxtTem)+1 SAY nNroFacTre COLOR('I')
               ELSE
                  @ nNroFil,nColTem SAY cTxtTem;
                                    GET nNroFacTre PICT '999999999';
                                    VALID !EMPTY(nNroFacTre);
                                    WHEN {||HelpRead('FAVOR INGRESE EL NUMERO DEL RECIBO')}
               ENDIF

	    ENDIF
**********FIN LECTURA DE CAMPO

**********LECTURA DE CAMPO
            IF nNroOpc == 1

               nNroFil++
               nColTem := nNroCol
               cTxtTem := 'FECHA DE RETIRO      :'

               IF nTipMod == 3
                  @ nNroFil,nColTem SAY cTxtTem
                  @ nNroFil,nColTem+LEN(cTxtTem)+1 SAY dFecRetTrc COLOR('I')
               ELSE
                  @ nNroFil,nColTem SAY cTxtTem;
                                    GET dFecRetTrc PICT '@!D';
                                    VALID !EMPTY(dFecRetTrc);
                                    WHEN {||HelpRead('FAVOR INGRESE LA FECHA DEL RETIRO DE CAJA')}
               ENDIF

	    ENDIF
**********FIN LECTURA DE CAMPO

**********LECTURA DE CAMPO
            IF nNroOpc == 1

               nNroFil++
               nColTem := nNroCol
               cTxtTem := 'HORA DEL RETIRO      :'

               IF nTipMod == 3
                  @ nNroFil,nColTem SAY cTxtTem
                  @ nNroFil,nColTem+LEN(cTxtTem)+1 SAY cHorRetTrc COLOR('I')
               ELSE
                  @ nNroFil,nColTem SAY cTxtTem;
                                    GET cHorRetTrc PICT '@!';
                                    VALID !EMPTY(cHorRetTrc);
                                    WHEN {||HelpRead('FAVOR INGRESE LA HORA DEL RETIRO DE CAJA')}
               ENDIF

	    ENDIF
**********FIN LECTURA DE CAMPO

**********LECTURA DE CAMPO
            IF nNroOpc == 1

               nNroFil++
               nColTem := nNroCol
               cTxtTem := 'FECHA DE CONSIGNACION:'

               IF nTipMod == 3
                  @ nNroFil,nColTem SAY cTxtTem
                  @ nNroFil,nColTem+LEN(cTxtTem)+1 SAY dFecDepTrc COLOR('I')
               ELSE
                  @ nNroFil,nColTem SAY cTxtTem;
                                    GET dFecDepTrc PICT '@!D';
                                    VALID !EMPTY(dFecDepTrc);
                                    WHEN {||HelpRead('FAVOR INGRESE LA FECHA DEL RETIRO DE CAJA')}
               ENDIF

	    ENDIF
**********FIN LECTURA DE CAMPO

**********LECTURA DE CAMPO
            IF nNroOpc == 1

               nNroFil++
               nColTem := nNroCol
               cTxtTem := 'COMPROBANTE          :'

               IF nTipMod == 3
                  @ nNroFil,nColTem SAY cTxtTem
                  @ nNroFil,nColTem+LEN(cTxtTem)+1 SAY cNroComTre COLOR('I')
               ELSE
                  @ nNroFil,nColTem SAY cTxtTem;
                                    GET cNroComTre PICT '@X';
                                    VALID !EMPTY(cNroComTre);
                                    WHEN {||HelpRead('FAVOR INGRESE EL COMPROBANTE DE CONTABILIDAD')}
               ENDIF

	    ENDIF
**********FIN LECTURA DE CAMPO

**********LECTURA DE CAMPO
            IF nNroOpc == 1

               nNroFil++
               nColTem := nNroCol
               cTxtTem := 'OBSERVACION          :'

               IF nTipMod == 3
                  @ nNroFil,nColTem SAY cTxtTem
                  @ nNroFil,nColTem+LEN(cTxtTem)+1 SAY cObservTre COLOR('I')
               ELSE
                  @ nNroFil,nColTem SAY cTxtTem;
                                    GET cObservTre PICT '@X';
                                    VALID !EMPTY(cObservTre);
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
       SELECT REG
       IF nTipMod # 3 .AND. lGrabar

          lInsReg := IF(nTipMod == 1,.T.,.F.)
          IF REG->(lRegLock(lShared,lInsReg))

             IF lInsReg
                REPL REG->nIdeCodReg WITH REG->(RECNO())
                REPL REG->cPlacaVeh WITH cPlaca
             ENDIF

             REPL REG->cTipVehCat WITH cTipVehTca
             REPL REG->nCodigoCaj WITH nCodigoTca
             REPL REG->dFecIngReg WITH dFecIngTre
             REPL REG->dFecOutReg WITH dFecOutTre
             REPL REG->cHorIngReg WITH cHorIngTre
             REPL REG->cHorOutReg WITH cHorOutTre
             REPL REG->cTiempoReg WITH cTiempoTre
             REPL REG->cTieCobReg WITH cTieCobTre
             REPL REG->nVlrTotReg WITH nVlrTotTre
             REPL REG->nBasIvaReg WITH nBasIvaTre
             REPL REG->nPorIvaReg WITH nPorIvaTre
             REPL REG->nVlrIvaReg WITH nVlrIvaTre
             REPL REG->nNroFacReg WITH nNroFacTre
             REPL REG->dFecRetRca WITH dFecRetTrc
             REPL REG->cHorRetRca WITH cHorRetTrc
             REPL REG->dFecDepReg WITH dFecDepTrc
             REPL REG->cNroComReg WITH cNroComTre
             REPL REG->cObservReg WITH cObservTre

             REPL REG->cNomUsrReg WITH cNomUsr
             REPL REG->dFecUsrReg WITH DATE()
             REPL REG->cHorUsrReg WITH TIME()
             REG->(DBCOMMIT())
          ENDIF

          IF lShared
             REG->(DBUNLOCK())
          ENDIF

       ENDIF
       RESTSCREEN(0,0,24,79,cSavPan)
       SETCURSOR(nTipCur)
*>>>>FIN GRABACION DEL REGISTRO

*>>>>REFRESCAR EL BROWSE
       IF nTipMod == 2
          nNroReg := REG->(RECNO())
          REG->(DBGOTOP())
          oBrowse:GOTOP()
          REG->(DBGOTO(nNroReg))
          oBrowse:FORCESTABLE()
       ENDIF
       RETURN .T.
*>>>>FIN REFRESCAR EL BROWSE

/*************************************************************************
* TITULO..: VALIDACION DE EXISTENCIA DEL CODIGO                          *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: OCT 31/2005 LUN A
       Colombia, Bucaramanga        INICIO:  3:47 PM   OCT 31/2005 LUN

OBJETIVOS:

1- Debe estar en uso el archivo.

2- Realiza la validaci¢n de existencia del C¢digo.

3- Retorna .T. si hay problemas

SINTAXIS:

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION lValCodReg(cCodigo)

*>>>>DESCRIPCION DE PARAMETROS
/*     cCodigo                              // C¢digo a Validar */
*>>>>FIN DESCRIPCION DE PARAMETROS

*>>>>DECLARACION DE VARIABLES
       LOCAL lHayErr := .F.                 // .T. Hay Error
*>>>>FIN DECLARACION DE VARIABLES

*>>>>VALIDACION DEL CODIGO
       IF cCodigo # cSpaces('REG','cPlacaVeh')
          IF lLocCodigo('cPlacaVeh','REG',cCodigo)
             cError('ESTE CODIGO YA EXISTE')
             lHayErr := .T.
          ENDIF
       ENDIF
       RETURN lHayErr
*>>>>FIN VALIDACION DEL CODIGO

/*************************************************************************
* TITULO..: VALIDACION DEL CODIGO                                        *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: OCT 31/2005 LUN A
       Colombia, Bucaramanga        INICIO:  3:47 PM   OCT 31/2005 LUN

OBJETIVOS:

1- Debe estar en uso el archivo

2- Realiza la validaci¢n del c¢digo

3- Retorna .T. si hay problemas

SINTAXIS:

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION lValReg(nNroFil,nNroCol,cCodigo)

*>>>>DESCRIPCION DE PARAMETROS
/*     nNroFil                              // Fila de lectura
       nNroCol                              // Columna de lectura
       cCodigo                              // C¢digo a Validar */
*>>>>FIN DESCRIPCION DE PARAMETROS

*>>>>DECLARACION DE VARIABLES
       LOCAL nNroReg := 0                   // N£mero del Registro
*>>>>FIN DECLARACION DE VARIABLES

*>>>>VALIDACION DEL CODIGO
       IF !lLocCodigo('cPlacaVeh','REG',cCodigo)
          nNroReg := nSelReg(nNroFil,nNroCol)
          IF nNroReg == 0
             cCodigo := cSpaces('REG','cPlacaVeh')
          ELSE
             REG->(DBGOTO(nNroReg))
             cCodigo := REG->cPlacaVeh
          ENDIF
       ENDIF
       RETURN .T.
*>>>>FIN VALIDACION DEL CODIGO

/*************************************************************************
* TITULO..: SELECCION DEL CODIGO                                         *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: OCT 31/2005 LUN A
       Colombia, Bucaramanga        INICIO:  3:47 PM   OCT 31/2005 LUN

OBJETIVOS:

1- Debe estar en uso el archivo

2- Permite escoger el registro de acuerdo al c¢digo o descripci¢n

3- Retorna el n£mero del registro escogido

SINTAXIS:

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION nSelReg(nNroFil,nNroCol)

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
       IF REG->(RECCOUNT()) == 0
          cError('NO EXISTEN REGISTROS GRABADOS')
          RETURN 0
       ENDIF
*>>>>FIN VALIDACION DE CONTENIDOS DE ARCHIVOS

*>>>>INICIALIZACION DE LAS COORDENADAS
       SELECT REG
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
       REG->(DBGOTOP())
       cSavPan := SAVESCREEN(0,0,24,79)
       @ nFilSup-1,nColSup-1 TO nFilInf,nColInf+1 DOUBLE
       nNroReg := nBrowseDbf(nFilSup,nColSup,nFilInf-1,nColInf,;
			     {||REG->cPlacaVeh})
       RESTSCREEN(0,0,24,79,cSavPan)
       RETURN nNroReg
*>>>>FIN SELECCION DEL CODIGO

/*************************************************************************
* TITULO..: IMPRESION CAMPOS DEL MANTENIMIENTO                           *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: OCT 31/2005 LUN A
       Colombia, Bucaramanga        INICIO:  3:47 PM   OCT 31/2005 LUN

OBJETIVOS:

1- Imprime los campos del archivo de mantenimiento

2- Retorna NIL

SINTAXIS:

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION OtrReg011(lShared,nModCry,cNomSis,cCodEmp,cNitEmp,cEmpPal,;
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
          FilePrn := 'Reg'
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
                   'REGISTRO',;
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
       AADD(aTitPrn,'PLACA')

       AADD(aNroCol,4)
       AADD(aTitPrn,'TIPO')

       AADD(aNroCol,4)
       AADD(aTitPrn,'CAJA')

       AADD(aNroCol,12)
       AADD(aTitPrn,'F.INGRESO')

       AADD(aNroCol,8)
       AADD(aTitPrn,'F.SALIDA')

       AADD(aNroCol,10)
       AADD(aTitPrn,'H. INGRESO')

       AADD(aNroCol,10)
       AADD(aTitPrn,'H. SALIDA')

       AADD(aNroCol,24)
       AADD(aTitPrn,'TIEMPO')

       AADD(aNroCol,20)
       AADD(aTitPrn,'TIEMPO COBRADO')

       AADD(aNroCol,14)
       AADD(aTitPrn,'VLR SERVICIO')

       AADD(aNroCol,14)
       AADD(aTitPrn,'BASE IVA')

       AADD(aNroCol,6)
       AADD(aTitPrn,'%  IVA')

       AADD(aNroCol,14)
       AADD(aTitPrn,'VALOR IVA')

       AADD(aNroCol,10)
       AADD(aTitPrn,'RECIBO')

       AADD(aNroCol,8)
       AADD(aTitPrn,'F.RETIRO')

       AADD(aNroCol,10)
       AADD(aTitPrn,'H. RETIRO')

       AADD(aNroCol,8)
       AADD(aTitPrn,'F.RETIRO')

       AADD(aNroCol,12)
       AADD(aTitPrn,'COMPROBANTE')

       AADD(aNroCol,40)
       AADD(aTitPrn,'OBSERVACION')

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

       SELECT REG
       REG->(DBGOTOP())
       DO WHILE .NOT. REG->(EOF())

**********VISUALIZACION DE AVANCE
            nAvance := INT(( REG->(RECNO()) / REG->(RECCOUNT()) )*100)

            IF STR(nAvance,3) $ '25 50 75100'
               SET DEVICE TO SCREEN
               Termometro(nAvance)
               SET DEVICE TO PRINT
            ENDIF
**********FIN VISUALIZACION DE AVANCE

**********IMPRESION DEL REGISTRO
            aRegPrn := {}
            AADD(aRegPrn,REG->cPlacaVeh)
            AADD(aRegPrn,REG->cTipVehCat)
            AADD(aRegPrn,STR(REG->nCodigoCaj,2,0))
            AADD(aRegPrn,cFecha(REG->dFecIngReg))
            AADD(aRegPrn,cFecha(REG->dFecOutReg))
            AADD(aRegPrn,REG->cHorIngReg)
            AADD(aRegPrn,REG->cHorOutReg)
            AADD(aRegPrn,REG->cTiempoReg)
            AADD(aRegPrn,REG->cTieCobReg)
            AADD(aRegPrn,TRANS(REG->nVlrTotReg,'###,###,###.99'))
            AADD(aRegPrn,TRANS(REG->nBasIvaReg,'###,###,###.99'))
            AADD(aRegPrn,STR(REG->nPorIvaReg,5,2))
            AADD(aRegPrn,TRANS(REG->nVlrIvaReg,'###,###,###.99'))
            AADD(aRegPrn,STR(REG->nNroFacReg,9,0))
            AADD(aRegPrn,cFecha(REG->dFecRetRca))
            AADD(aRegPrn,REG->cHorRetRca)
            AADD(aRegPrn,cFecha(REG->dFecDepReg))
            AADD(aRegPrn,REG->cNroComReg)
            AADD(aRegPrn,REG->cObservReg)

            lPrnOpc(lShared,nOpcPrn,FilePrn,nHanXml,01,nColCab,;
                    aTitPrn,aRegPrn,aNroCol,bPagina,bDerAut,bCabeza)
**********FIN IMPRESION DEL REGISTRO

**********AVANCE DEL SIGUIENTE REGISTRO
	    SELECT REG
	    REG->(DBSKIP())
	    IF REG->(EOF())
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
