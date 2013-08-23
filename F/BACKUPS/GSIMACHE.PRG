/*************************************************************************
* TITULO..: CREACION DE LA ESTRUCTURA                                    *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: NOV  3/2004 MIE A
       Colombia, Bucaramanga        INICIO:  6:17 PM   NOV  3/2004 MIE

OBJETIVOS:

1- Crea la estructura del archivo

2- Retorna NIL

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION CreaDbfChe(lShared,nModCry,PathArc,fArchvo,aStrDbf)

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
       AADD(aDbfStr,{'nNumeroChe','Numeric',9,0}) // N£mero del Cheque
       AADD(aDbfStr,{'cNroCuCChe','Character',20,0}) // N£mero de la Cuenta Corriente
       AADD(aDbfStr,{'nNroCpBChe','Numeric',9,0}) // N£mero del Comprobante
       AADD(aDbfStr,{'dFecCheChe','Date',8,0}) // Fecha del Cheque
       AADD(aDbfStr,{'nVlrCheChe','Numeric',12,2}) // Valor del Cheque
       AADD(aDbfStr,{'cDocNitChe','Character',16,0}) // Documento del Beneficiario
       AADD(aDbfStr,{'cTipNitChe','Character',1,0}) // Tipo del Documento del Beneficiario
       AADD(aDbfStr,{'nEstadoChe','Numeric',1,0}) // Estado del Cheque. 0=>Original 1=>Duplicado 2=>Anulado 3=>No
       AADD(aDbfStr,{'cCodTraChe','Character',4,0}) // C¢digo de la Transacci¢n
       AADD(aDbfStr,{'dFecTraChe','Date',8,0}) // Fecha de la Transacci¢n
       AADD(aDbfStr,{'nVlrTraChe','Numeric',12,2}) // Valor de la Transacci¢n

       AADD(aDbfStr,{'nCodigoChe','Numeric'  ,16,0}) // C¢digo del Registro
       AADD(aDbfStr,{'cNomUsrChe','Character',10,0}) // Nombre del Usuario
       AADD(aDbfStr,{'dFecUsrChe','Date'     ,08,0}) // Fecha del Usuario
       AADD(aDbfStr,{'cHorUsrChe','Character',10,0}) // Hora del Usuario
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

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: NOV  3/2004 MIE A
       Colombia, Bucaramanga        INICIO:  6:17 PM   NOV  3/2004 MIE

OBJETIVOS:

1- Recupera la estructura del archivo

2- Retorna NIL

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION RecuDbfChe(lShared,nModCry,PathArc,fArchvo)

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
       CreaDbfChe(lShared,nModCry,PathArc,fArchvo)
       RESTORE SCREEN
       RETURN NIL
*>>>>FIN RECUPERA LA ESTRUCTURA DEL ARCHIVO

/*************************************************************************
* TITULO..: ACTUALIZACION DE LA ESTRUCTURA                               *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: NOV  3/2004 MIE A
       Colombia, Bucaramanga        INICIO:  6:17 PM   NOV  3/2004 MIE

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

FUNCTION nActStrChe(lShared,nModCry,PathArc,cNomArc)

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
       CreaDbfChe(lShared,nModCry,PathArc,cNomArc,@aStrNew)
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
                         {||CreaDbfChe(lShared,nModCry,PathArc,FileTem)})
             cError('NO SE ACTUALIZO LA ESTRUCTURA DEL ARCHIVO')
             nNroErr := 1
          ENDIF
          RESTSCREEN(0,0,24,79,cSavPan)
       ENDIF
       RETURN nNroErr
*>>>>FIN ACTUALIZACION DE LA ESTRUCTURA

/*************************************************************************
* TITULO..: MANTENIMIENTO DEL ARCHIVO                                    *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: NOV  3/2004 MIE A
       Colombia, Bucaramanga        INICIO:  6:17 PM   NOV  3/2004 MIE

OBJETIVOS:

1- Permite el mantenimiento del archivo

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION MantenChe(lShared,nModCry,cNomSis,cCodEmp,cNitEmp,cEmpPal,;
		   cNomEmp,cNomSec,cNomUsr,cAnoUsr,PathArc,fArchvo,;
		   aArcNtx,lPrnArc,cOpcPrn,lModReg,lDelReg,lInsReg,;
		   lHaySql)

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
       PathArc                              // Path del Archivo
       fArchvo                              // Archivo de Usuarios
       aArcNtx                              // Archivos Indice
       lPrnArc                              // .T. Imprimir a Archivo
       cOpcPrn                              // Opciones de Impresi¢n
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

       LOCAL aUseDbf := {}                  // Archivos en Uso
       LOCAL fNtxArc := ''                  // Archivo Indice
       LOCAL oBrowse := NIL                 // Browse
*>>>>FIN DECLARACION DE VARIABLES

*>>>>AREAS DE TRABAJO
       fNtxArc := IF(aArcNtx==NIL,NIL,PathArc+'\'+aArcNtx[1])

       aUseDbf := {}
       AADD(aUseDbf,{.T.,PathArc+'\'+fArchvo,'CHE',fNtxArc,lShared,nModCry})
*>>>>FIN AREAS DE TRABAJO

*>>>>SELECION DE LAS AREAS DE TRABAJO
       IF !lUseDbfs(aUseDbf)
          cError('ABRIENDO EL ARCHIVO')
          CloseDbf('CHE')
          RETURN NIL
       ENDIF
*>>>>FIN SELECION DE LAS AREAS DE TRABAJO

*>>>>PARAMETROS POR DEFECTO
       lModReg := IF(EMPTY(lModReg),.F.,lModReg)
       lModReg := IF(lModReg .AND. CHE->(RECCOUNT())==0,.F.,lModReg)

       lDelReg := IF(lDelReg==NIL,.F.,lDelReg)

       lInsReg := IF(lInsReg==NIL,.F.,lInsReg)

       lHaySql := IF(lHaySql==NIL,.F.,lHaySql)
*>>>>FIN PARAMETROS POR DEFECTO

*>>>>MANTENIMIENTO DEL ARCHIVO
       oBrowse := oBrwDbfChe(lShared,cNomUsr,cAnoUsr,03,00,22,79,;
                             lModReg,lDelReg,lInsReg,lHaySql)

       SETKEY(K_F2,{||lManRegChe(lShared,cNomUsr,3)})
     *ÀConsulta

       IF lModReg
          SETKEY(K_F4,{||lManRegChe(lShared,cNomUsr,2,oBrowse,;
                                    CHE->nNumeroChe)})
       ENDIF
     *ÀActualizar

       SETKEY(K_F5,{||BuscarChe(oBrowse)})

       SETKEY(K_F9,{||MenuOtrChe(lShared,nModCry,cNomSis,cCodEmp,cNitEmp,;
                                 cEmpPal,cNomEmp,cNomSec,cNomUsr,cAnoUsr,;
                                 PathArc,fArchvo,aArcNtx,lPrnArc,cOpcPrn,;
                                 lModReg,lDelReg,lInsReg,lHaySql,oBrowse)})

       CHE->(CtrlBrw(lShared,oBrowse))

       SETKEY(K_F2,NIL)
       SETKEY(K_F4,NIL)
       SETKEY(K_F5,NIL)
       SETKEY(K_F9,NIL)
       CloseDbf('CHE')
       RETURN NIL
*>>>>FIN MANTENIMIENTO DEL ARCHIVO

/*************************************************************************
* TITULO..: DEFINICION DEL OBJETO BROWSE                                 *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: NOV  3/2004 MIE A
       Colombia, Bucaramanga        INICIO:  6:17 PM   NOV  3/2004 MIE

OBJETIVOS:

1- Define el objeto Browse del archivo

SINTAXIS:

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION oBrwDbfChe(lShared,cNomUsr,cAnoUsr,nFilSup,nColSup,nFilInf,nColInf,;
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

       cTitSup := '<< CHEQUES >>'
       cTitInf := '<F2>Consultar <F5>Buscar'+;
                   IF(lModReg,' <F4>Actualizar','')+' <F9>Otros'+;
                   IF(lDelReg,' <DEL>Borrar','')+;
                   IF(lInsReg,' <INS>Incluir','')

       IF lInsReg
          oBrowse:Cargo := {cTitSup,cTitInf,{||lManRegChe(lShared,cNomUsr)}}
       ELSE
          oBrowse:Cargo := {cTitSup,cTitInf}
       ENDIF
     *ÀDefinici¢n de cabeceras y l¡neas de cabeceras

       SELECT CHE
       oColumn := TBCOLUMNNEW('NUMERO;CHEQUE',{||CHE->nNumeroChe})
       oColumn:Cargo := {{'MODI',.F.},{'ALIAS','CHE'},;
			 {'FIELD','nNumeroChe'},{'PICTURE','999999999'}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn := TBCOLUMNNEW('CUENTA;CORRIENTE',{||CHE->cNroCuCChe})
       oColumn:Cargo := {{'MODI',.F.},{'ALIAS','CHE'},;
			 {'FIELD','cNroCuCChe'},{'PICTURE','@!X'}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn := TBCOLUMNNEW('NUMERO;COMPROBANTE',{||CHE->nNroCpBChe})
       oColumn:Cargo := {{'MODI',lModReg},{'ALIAS','CHE'},;
			 {'FIELD','nNroCpBChe'},{'PICTURE','999999999'}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn := TBCOLUMNNEW('FECHA;CHEQUE',{||CHE->dFecCheChe})
       oColumn:Cargo := {{'MODI',lModReg},{'ALIAS','CHE'},;
			 {'FIELD','dFecCheChe'},{'PICTURE','@!D'}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn := TBCOLUMNNEW('VALOR;CHEQUE',{||CHE->nVlrCheChe})
       oColumn:Cargo := {{'MODI',lModReg},{'ALIAS','CHE'},;
			 {'FIELD','nVlrCheChe'},{'PICTURE','999999999.99'}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn := TBCOLUMNNEW('DOCUMENTO;BENEICIARIO',{||CHE->cDocNitChe})
       oColumn:Cargo := {{'MODI',lModReg},{'ALIAS','CHE'},;
			 {'FIELD','cDocNitChe'},{'PICTURE','9999999999999999'}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn := TBCOLUMNNEW('TIPO DOCUMENTO;BENEICIARIO',{||CHE->cTipNitChe})
       oColumn:Cargo := {{'MODI',lModReg},{'ALIAS','CHE'},;
			 {'FIELD','cTipNitChe'},{'PICTURE','9'}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn := TBCOLUMNNEW('ESTADO',{||CHE->nEstadoChe})
       oColumn:Cargo := {{'MODI',lModReg},{'ALIAS','CHE'},;
			 {'FIELD','nEstadoChe'},{'PICTURE','9'}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn := TBCOLUMNNEW('CODIGO;TRANSACCION',{||CHE->cCodTraChe})
       oColumn:Cargo := {{'MODI',lModReg},{'ALIAS','CHE'},;
			 {'FIELD','cCodTraChe'},{'PICTURE','9'}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn := TBCOLUMNNEW('FECHA;TRANSACCION',{||CHE->dFecTraChe})
       oColumn:Cargo := {{'MODI',lModReg},{'ALIAS','CHE'},;
			 {'FIELD','dFecTraChe'},{'PICTURE','@!'}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn := TBCOLUMNNEW('VALOR;TRANSACCION',{||CHE->nVlrTraChe})
       oColumn:Cargo := {{'MODI',lModReg},{'ALIAS','CHE'},;
			 {'FIELD','nVlrTraChe'},{'PICTURE','999999999.99'}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn	     := TBCOLUMNNEW('NOMBRE;DEL USUARIO',{||CHE->cNomUsrChe})
       oColumn:Cargo := {{'MODI',.F.}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn	     := TBCOLUMNNEW('FECHA DE;PROCESO',;
				    {||cFecha(CHE->dFecUsrChe)})
       oColumn:Cargo := {{'MODI',.F.}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn	     := TBCOLUMNNEW('HORA DE;PROCESO',;
				    {||cHoraSys(CHE->cHorUsrChe)})
       oColumn:Cargo := {{'MODI',.F.}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn	     := TBCOLUMNNEW('CODIGO',{||CHE->nCodigoChe})
       oColumn:Cargo := {{'MODI',.F.}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn	     := TBCOLUMNNEW('No.',{||CHE->(RECNO())})
       oColumn:Cargo := {{'MODI',.F.}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       RETURN oBrowse
*>>>>FIN DEFINICION DEL OBJETO BROWSE

/*************************************************************************
* TITULO..: MANTENIMIENTO DEL REGISTRO                                   *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: NOV  3/2004 MIE A
       Colombia, Bucaramanga        INICIO:  6:17 PM   NOV  3/2004 MIE

OBJETIVOS:

1- Permite inclusi¢n,modificaci¢n y consulta del registro

2- Puede invocarse en la lectura a trav‚s de la clausula VALID

2- Returna .T.

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION lManRegChe(lShared,cNomUsr,nTipMod,oBrowse,nNumero,nNroOpc)

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

       LOCAL cNroCuC := ''                  // N£mero de la Cuenta Corriente                               
       LOCAL nNroCpB := 0                   // N£mero del Comprobante                                      
       LOCAL dFecChe := CTOD('00/00/00')      // Fecha del Cheque                                            
       LOCAL nVlrChe := 0                   // Valor del Cheque                                            
       LOCAL cDocNit := ''                  // Documento del Beneficiario                                  
       LOCAL cTipNit := ''                  // Tipo del Documento del Beneficiario                         
       LOCAL nEstado := 0                   // Estado del Cheque. 0=>Original 1=>Duplicado 2=>Anulado 3=>No
       LOCAL cCodTra := ''                  // C¢digo de la Transacci¢n                                    
       LOCAL dFecTra := CTOD('00/00/00')      // Fecha de la Transacci¢n                                     
       LOCAL nVlrTra := 0                   // Valor de la Transacci¢n                                     

       LOCAL GetList := {}                 // Variable del sistema
*>>>>FIN DECLARACION DE VARIABLES

*>>>>DECLARACION DEL MENU
       nTipMod := IF(nTipMod==NIL,1,nTipMod)

       cSavPan := SAVESCREEN(0,0,24,79)
       nNroOpc := 1
       IF EMPTY(nNroOpc)

          AADD(aMenus,'1<INFORMACION BASICA>')

          AADD(aAyuda,IF(nTipMod==3,'Consulta','Actualiza')+' '+;
                      'la Informaci¢n B sica de la Empresa')

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
            cTxtTem := 'CHEQUES .POR FAVOR INGRESE LOS DATOS'
            CHE->(DBGOBOTTOM())
            CHE->(DBSKIP())
            nTipCur := SETCURSOR(1)

       CASE nTipMod == 2
            cTxtTem := 'CHEQUES .POR FAVOR ACTUALICE LOS DATOS'
            nTipCur := SETCURSOR(1)

       CASE nTipMod == 3
            cTxtTem := 'CONSULTA. CHEQUES'
       ENDCASE
       nFilIni := nMarco(03,cTxtTem,22,'°')
*>>>>FIN MARCO DEL MANTENIMIENTO

*>>>>MANTENIMIENTO DEL REGISTRO
       SELECT CHE
       DO WHILE .T.

**********INICIALIZACION DE LAS VARIABLES
            IF lGrabar

               IF EMPTY(nNumero)
                  nNumero := CHE->nNumeroChe
               ENDIF

               cNroCuC := CHE->cNroCuCChe
               nNroCpB := CHE->nNroCpBChe
               dFecChe := CHE->dFecCheChe
               nVlrChe := CHE->nVlrCheChe
               cDocNit := CHE->cDocNitChe
               cTipNit := CHE->cTipNitChe
               nEstado := CHE->nEstadoChe
               cCodTra := CHE->cCodTraChe
               dFecTra := CHE->dFecTraChe
               nVlrTra := CHE->nVlrTraChe
            ENDIF
**********FIN INICIALIZACION DE LAS VARIABLES

**********LECTURA DE CAMPO
            nNroFil := nFilIni
            cTxtTem := 'NUMERO DEL CHEQUE          :'

            IF nTipMod == 2 .OR. nTipMod == 3 .OR. !EMPTY(nNumero)
               @ nNroFil,nNroCol SAY cTxtTem
               @ nNroFil,nNroCol+LEN(cTxtTem)+1 SAY nNumero COLOR('I')
            ELSE
               @ nNroFil,nNroCol SAY cTxtTem;
                                 GET nNumero PICT '999999999';
                                 VALID !EMPTY(nNumero) .AND.;
                                       !lValCodChe(nNumero)
            ENDIF
**********FIN LECTURA DE CAMPO

**********LECTURA DE CAMPO
            nColTem := nNroCol
            cTxtTem := 'CUENTA CORRIENTE           :'

            IF nTipMod == 3
               @ nNroFil+1,nColTem SAY cTxtTem
               @ nNroFil+1,nColTem+LEN(cTxtTem)+1 SAY cNroCuC COLOR('I')
            ELSE
               @ nNroFil+1,nColTem SAY cTxtTem;
                                   GET cNroCuC PICT '@!X';
                                   VALID !EMPTY(cNroCuC);
                                   WHEN {||HelpRead('FAVOR INGRESE EL NUMERO DE LA CUENTA CORRIENTE')}
            ENDIF
**********FIN LECTURA DE CAMPO

**********LECTURA DE CAMPO
            nColTem := nNroCol
            cTxtTem := 'NUMERO COMPROBANTE         :'

            IF nTipMod == 3
               @ nNroFil+2,nColTem SAY cTxtTem
               @ nNroFil+2,nColTem+LEN(cTxtTem)+1 SAY nNroCpB COLOR('I')
            ELSE
               @ nNroFil+2,nColTem SAY cTxtTem;
                                   GET nNroCpB PICT '999999999';
                                   WHEN {||HelpRead('FAVOR INGRESE EL NUMERO DEL COMPROBANTE')}
            ENDIF
**********FIN LECTURA DE CAMPO

**********LECTURA DE CAMPO
            nColTem := nNroCol
            cTxtTem := 'FECHA DEL CHEQUE           :'

            IF nTipMod == 3
               @ nNroFil+3,nColTem SAY cTxtTem
               @ nNroFil+3,nColTem+LEN(cTxtTem)+1 SAY dFecChe COLOR('I')
            ELSE
               @ nNroFil+3,nColTem SAY cTxtTem;
                                   GET dFecChe PICT '@!D';
                                   VALID !EMPTY(dFecChe);
                                   WHEN {||HelpRead('FAVOR INGRESE LA FECHA DEL CHEQUE')}
            ENDIF
**********FIN LECTURA DE CAMPO

**********LECTURA DE CAMPO
            nColTem := nNroCol
            cTxtTem := 'VALOR DEL CHEQUE           :'

            IF nTipMod == 3
               @ nNroFil+4,nColTem SAY cTxtTem
               @ nNroFil+4,nColTem+LEN(cTxtTem)+1 SAY nVlrChe COLOR('I')
            ELSE
               @ nNroFil+4,nColTem SAY cTxtTem;
                                   GET nVlrChe PICT '999999999.99';
                                   VALID !EMPTY(nVlrChe);
                                   WHEN {||HelpRead('FAVOR INGRESE EL VALOR DEL CHEQUE')}
            ENDIF
**********FIN LECTURA DE CAMPO

**********LECTURA DE CAMPO
            nColTem := nNroCol
            cTxtTem := 'DOCUMENTO BENEFICIARIO     :'

            IF nTipMod == 3
               @ nNroFil+5,nColTem SAY cTxtTem
               @ nNroFil+5,nColTem+LEN(cTxtTem)+1 SAY cDocNit COLOR('I')
            ELSE
               @ nNroFil+5,nColTem SAY cTxtTem;
                                   GET cDocNit PICT '9999999999999999';
                                   VALID !EMPTY(cDocNit);
                                   WHEN {||HelpRead('FAVOR INGRESE EL DOCUMENTO DEL BENEFICIARIO')}
            ENDIF
**********FIN LECTURA DE CAMPO

**********LECTURA DE CAMPO
            nColTem := nNroCol
            cTxtTem := 'TIPO DOCUMENTO BENEFICIARIO:'

            IF nTipMod == 3
               @ nNroFil+6,nColTem SAY cTxtTem
               @ nNroFil+6,nColTem+LEN(cTxtTem)+1 SAY cTipNit COLOR('I')
            ELSE
               @ nNroFil+6,nColTem SAY cTxtTem;
                                   GET cTipNit PICT '9';
                                   VALID !EMPTY(cTipNit);
                                   WHEN {||HelpRead('FAVOR INGRESE EL TIPO DEL DOCUMENTO DEL BENEFICIARIO')}
            ENDIF
**********FIN LECTURA DE CAMPO

**********LECTURA DE CAMPO
            nColTem := nNroCol
            cTxtTem := 'ESTADO DEL CHEQUE          :'

            IF nTipMod == 3
               @ nNroFil+7,nColTem SAY cTxtTem
               @ nNroFil+7,nColTem+LEN(cTxtTem)+1 SAY nEstado COLOR('I')
            ELSE
               @ nNroFil+7,nColTem SAY cTxtTem;
                                   GET nEstado PICT '9';
                                   VALID !EMPTY(nEstado);
                                   WHEN {||HelpRead('FAVOR INGRESE EL ESTADO DEL CHEQUE')}
            ENDIF
**********FIN LECTURA DE CAMPO

**********LECTURA DE CAMPO
            nColTem := nNroCol
            cTxtTem := 'CODIGO TRANSACION          :'

            IF nTipMod == 3
               @ nNroFil+8,nColTem SAY cTxtTem
               @ nNroFil+8,nColTem+LEN(cTxtTem)+1 SAY cCodTra COLOR('I')
            ELSE
               @ nNroFil+8,nColTem SAY cTxtTem;
                                   GET cCodTra PICT '9';
                                   VALID !EMPTY(cCodTra);
                                   WHEN {||HelpRead('FAVOR INGRESE EL CODIGO DE LA TRANSACCION')}
            ENDIF
**********FIN LECTURA DE CAMPO

**********LECTURA DE CAMPO
            nColTem := nNroCol
            cTxtTem := 'FECHA TRANSACION           :'

            IF nTipMod == 3
               @ nNroFil+9,nColTem SAY cTxtTem
               @ nNroFil+9,nColTem+LEN(cTxtTem)+1 SAY dFecTra COLOR('I')
            ELSE
               @ nNroFil+9,nColTem SAY cTxtTem;
                                   GET dFecTra PICT '@!';
                                   VALID !EMPTY(dFecTra);
                                   WHEN {||HelpRead('FAVOR INGRESE LA FECHA DE LA TRANSACCION')}
            ENDIF
**********FIN LECTURA DE CAMPO

**********LECTURA DE CAMPO
            nColTem := nNroCol
            cTxtTem := 'VALOR TRANSACCION          :'

            IF nTipMod == 3
               @ nNroFil+10,nColTem SAY cTxtTem
               @ nNroFil+10,nColTem+LEN(cTxtTem)+1 SAY nVlrTra COLOR('I')
            ELSE
               @ nNroFil+10,nColTem SAY cTxtTem;
                                   GET nVlrTra PICT '999999999.99';
                                   VALID !EMPTY(nVlrTra);
                                   WHEN {||HelpRead('FAVOR INGRESE EL VALOR DE LA TRANSACCION')}
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
       SELECT CHE
       IF nTipMod # 3 .AND. lGrabar

          lInsReg := IF(nTipMod == 1,.T.,.F.)
          IF CHE->(lRegLock(lShared,lInsReg))

             IF lInsReg
                REPL CHE->nCodigoChe WITH CHE->(RECNO())
                REPL CHE->nNumeroChe WITH nNumero
             ENDIF

             REPL CHE->cNroCuCChe WITH cNroCuC
             REPL CHE->nNroCpBChe WITH nNroCpB
             REPL CHE->dFecCheChe WITH dFecChe
             REPL CHE->nVlrCheChe WITH nVlrChe
             REPL CHE->cDocNitChe WITH cDocNit
             REPL CHE->cTipNitChe WITH cTipNit
             REPL CHE->nEstadoChe WITH nEstado
             REPL CHE->cCodTraChe WITH cCodTra
             REPL CHE->dFecTraChe WITH dFecTra
             REPL CHE->nVlrTraChe WITH nVlrTra

             REPL CHE->cNomUsrChe WITH cNomUsr
             REPL CHE->dFecUsrChe WITH DATE()
             REPL CHE->cHorUsrChe WITH TIME()
             CHE->(DBCOMMIT())
          ENDIF

          IF lShared
             CHE->(DBUNLOCK())
          ENDIF

       ENDIF
       RESTSCREEN(0,0,24,79,cSavPan)
       SETCURSOR(nTipCur)
*>>>>FIN GRABACION DEL CAMPO

*>>>>REFRESCAR EL BROWSE
       IF nTipMod == 2
          nNroReg := CHE->(RECNO())
          CHE->(DBGOTOP())
          oBrowse:GOTOP()
          CHE->(DBGOTO(nNroReg))
          oBrowse:FORCESTABLE()
       ENDIF
       RETURN .T.
*>>>>FIN REFRESCAR EL BROWSE

/*************************************************************************
* TITULO..: VALIDACION DE EXISTENCIA DEL CODIGO                          *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: NOV  3/2004 MIE A
       Colombia, Bucaramanga        INICIO:  6:17 PM   NOV  3/2004 MIE

OBJETIVOS:

1- Debe estar en uso el archivo.

2- Realiza la validaci¢n de existencia del C¢digo.

3- Retorna .T. si hay problemas

SINTAXIS:

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION lValCodChe(cCodigo)

*>>>>DESCRIPCION DE PARAMETROS
/*     cCodigo                              // C¢digo a Validar */
*>>>>FIN DESCRIPCION DE PARAMETROS

*>>>>DECLARACION DE VARIABLES
       LOCAL lHayErr := .F.                 // .T. Hay Error
*>>>>FIN DECLARACION DE VARIABLES

*>>>>VALIDACION DEL CODIGO
       IF cCodigo # cSpaces('CHE','nNumeroChe')
          IF lLocCodigo('nNumeroChe','CHE',cCodigo)
             cError('ESTE CODIGO YA EXISTE')
             lHayErr := .T.
          ENDIF
       ENDIF
       RETURN lHayErr
*>>>>FIN VALIDACION DEL CODIGO

/*************************************************************************
* TITULO..: BUSQUEDA DEL CODIGO                                          *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: NOV  3/2004 MIE A
       Colombia, Bucaramanga        INICIO:  6:17 PM   NOV  3/2004 MIE

OBJETIVOS:

1- Permite localizar un c¢digo dentro del archivo.

2- Retorna NIL

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION BuscarChe(oBrowse)

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
       cCodigo := cSpaces('CHE','nNumeroChe')
       TitBuscar(LEN(cCodigo),@nNroFil,@nNroCol)
       @ nNroFil,nNroCol GET cCodigo PICT '@!';
			 VALID lValChe(ROW(),COL()-3,@cCodigo)
       READ
*>>>>FIN CAPTURA DEL CODIGO

*>>>>VALIDACION DEL CODIGO
       IF cCodigo == cSpaces('CHE','nNumeroChe')
          cError('PATRON DE BUSQUEDA NO ESPECIFICADO',;
                 'ADVERTENCIA')
          lBuscar := .F.
       ENDIF
*>>>>FIN VALIDACION DEL CODIGO

*>>>>BUSQUEDA DEL CODIGO
       SELECT CHE
       IF lBuscar .AND. lLocCodigo('nNumeroChe','CHE',cCodigo)
          nNroReg := CHE->(RECNO())
          CHE->(DBGOTOP())
          oBrowse:GOTOP()
          CHE->(DBGOTO(nNroReg))
          oBrowse:FORCESTABLE()
       ELSE
          oBrowse:GOTOP()
       ENDIF
       RETURN NIL
*>>>>FIN BUSQUEDA DEL CODIGO

/*************************************************************************
* TITULO..: VALIDACION DEL CODIGO                                        *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: NOV  3/2004 MIE A
       Colombia, Bucaramanga        INICIO:  6:17 PM   NOV  3/2004 MIE

OBJETIVOS:

1- Debe estar en uso el archivo

2- Realiza la validaci¢n del c¢digo

3- Retorna .T. si hay problemas

SINTAXIS:

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION lValChe(nNroFil,nNroCol,cCodigo)

*>>>>DESCRIPCION DE PARAMETROS
/*     nNroFil                              // Fila de lectura
       nNroCol                              // Columna de lectura
       cCodigo                              // C¢digo a Validar */
*>>>>FIN DESCRIPCION DE PARAMETROS

*>>>>DECLARACION DE VARIABLES
       LOCAL nNroReg := 0                   // N£mero del Registro
*>>>>FIN DECLARACION DE VARIABLES

*>>>>VALIDACION DEL CODIGO
       IF !lLocCodigo('nNumeroChe','CHE',cCodigo)
          nNroReg := nSelChe(nNroFil,nNroCol)
          IF nNroReg == 0
             cCodigo := cSpaces('CHE','nNumeroChe')
          ELSE
             CHE->(DBGOTO(nNroReg))
             cCodigo := CHE->nNumeroChe
          ENDIF
       ENDIF
       RETURN .T.
*>>>>FIN VALIDACION DEL CODIGO

/*************************************************************************
* TITULO..: SELECCION DEL CODIGO                                         *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: NOV  3/2004 MIE A
       Colombia, Bucaramanga        INICIO:  6:17 PM   NOV  3/2004 MIE

OBJETIVOS:

1- Debe estar en uso el archivo

2- Permite escoger el registro de acuerdo al c¢digo o descripci¢n

3- Retorna el n£mero del registro escogido

SINTAXIS:

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION nSelChe(nNroFil,nNroCol)

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
       IF CHE->(RECCOUNT()) == 0
          cError('NO EXISTEN REGISTROS GRABADOS')
          RETURN 0
       ENDIF
*>>>>FIN VALIDACION DE CONTENIDOS DE ARCHIVOS

*>>>>INICIALIZACION DE LAS COORDENADAS
       SELECT CHE
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
       CHE->(DBGOTOP())
       cSavPan := SAVESCREEN(0,0,24,79)
       @ nFilSup-1,nColSup-1 TO nFilInf,nColInf+1 DOUBLE
       nNroReg := nBrowseDbf(nFilSup,nColSup,nFilInf-1,nColInf,;
			     {||CHE->nNumeroChe})
       RESTSCREEN(0,0,24,79,cSavPan)
       RETURN nNroReg
*>>>>FIN SELECCION DEL CODIGO

/*************************************************************************
* TITULO..: MENU DE OTROS PARA EL ARCHIVO                                *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: NOV  3/2004 MIE A
       Colombia, Bucaramanga        INICIO:  6:17 PM   NOV  3/2004 MIE

OBJETIVOS:

1- Menu de Otros para el archivo

2- Retorna NIL

SINTAXIS:

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION MenuOtrChe(lShared,nModCry,cNomSis,cCodEmp,cNitEmp,cEmpPal,;
                    cNomEmp,cNomSec,cNomUsr,cAnoUsr,PathArc,fArchvo,;
                    aArcNtx,lPrnArc,cOpcPrn,lModReg,lDelReg,lInsReg,;
                    lHaySql,oBrowse)

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
       PathArc                              // Path del Archivo
       fArchvo                              // Archivo de Usuarios
       aArcNtx                              // Archivos Indice
       lPrnArc                              // .T. Imprimir a Archivo
       cOpcPrn                              // Opciones de Impresi¢n
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
       AADD(aMenus,'1<CHEQUES>')

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
            OtrChe011(lShared,nModCry,cNomSis,cCodEmp,cNitEmp,cEmpPal,;
                      cNomEmp,cNomSec,cNomUsr,cAnoUsr,PathArc,fArchvo,;
                      aArcNtx,lPrnArc,cOpcPrn,lModReg,lDelReg,lInsReg,;
                      lHaySql,oBrowse)
           *Impresi¢n de los campos del Archivo

       ENDCASE
       RETURN NIL
*>>>>FIN ANALISIS DE OPCION ESCOGIDA

/*************************************************************************
* TITULO..: IMPRESION CAMPOS DEL MANTENIMIENTO                           *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: NOV  3/2004 MIE A
       Colombia, Bucaramanga        INICIO:  6:17 PM   NOV  3/2004 MIE

OBJETIVOS:

1- Imprime los campos del archivo de mantenimiento

2- Retorna NIL

SINTAXIS:

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION OtrChe011(lShared,nModCry,cNomSis,cCodEmp,cNitEmp,cEmpPal,;
		   cNomEmp,cNomSec,cNomUsr,cAnoUsr,PathArc,fArchvo,;
		   aArcNtx,lPrnArc,cOpcPrn,lModReg,lDelReg,lInsReg,;
		   lHaySql,oBrowse)

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
       PathArc                              // Path del Archivo
       fArchvo                              // Archivo de Usuarios
       aArcNtx                              // Archivos Indice
       lPrnArc                              // .T. Imprimir a Archivo
       cOpcPrn                              // Opciones de Impresi¢n
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

*>>>>DEFINCION DEL ENCABEZADO
       nNroPag := 0
       lTamAnc := .F.

       nTotReg := 0

       aCabPrn := {cNomEmp,cNomSis,;
                   'CHEQUES',;
                   '',;
                   ''}

       aCabeza := {aCabPrn[1],aCabPrn[2],aCabPrn[3],aCabPrn[4],aCabPrn[5],;
                   nNroPag++,;
                   cTotPagina(nTotReg),lTamAnc}

       cCodIni := PCL({'DraftOn','Elite','CondenOn'})
       cCodFin := PCL({'NegraOf','DobGolOf'})
*>>>>FIN DEFINCION DEL ENCABEZADO

*>>>>ENCABEZADOS DE COLUMNA
       aNroCol := {}
       aTitPrn := {}

       AADD(aNroCol,10)
       AADD(aTitPrn,'CHEQUE')

       AADD(aNroCol,20)
       AADD(aTitPrn,'CUENTA CORRIENTE')

       AADD(aNroCol,12)
       AADD(aTitPrn,'COMPROBANTE')

       AADD(aNroCol,8)
       AADD(aTitPrn,'FECHA')

       AADD(aNroCol,14)
       AADD(aTitPrn,'VLR CHEQUE')

       AADD(aNroCol,16)
       AADD(aTitPrn,'DOCUMENTO')

       AADD(aNroCol,4)
       AADD(aTitPrn,'TIPO')

       AADD(aNroCol,6)
       AADD(aTitPrn,'ESTADO')

       AADD(aNroCol,6)
       AADD(aTitPrn,'TRANS')

       AADD(aNroCol,8)
       AADD(aTitPrn,'F. TRANS')

       AADD(aNroCol,14)
       AADD(aTitPrn,'VLR TRANS')

       cCabCol := cRegPrint(aTitPrn,aNroCol)
*>>>>FIN ENCABEZADOS DE COLUMNA

*>>>>ANALISIS PARA CENTRAR EL INFORME
       nLenPrn := PCL('n17Stan')
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

*>>>>ACTIVACION DE LA IMPRESORA
       IF lPrnArc
          SET DEVICE TO PRINT
       ELSE
          FilePrn := 'Che'
          nOpcPrn := nPrinter_On(cNomUsr,@FilePrn,cOpcPrn,.F.,.T.)
          IF EMPTY(nOpcPrn)
             RETURN NIL
          ENDIF
       ENDIF
       SendCodes(PCL('Reset'))

       EVAL(bCabeza)
      *Impresi¢n del Encabezado

       AADD(aCabPrn,cFecPrn)
       AADD(aCabPrn,cHorPrn)
       AADD(aCabPrn,cDiaPrn)

       nHanXml := CreaFrmPrn(lShared,FilePrn,aNroCol,nOpcPrn,aCabPrn,aTitPrn)
*>>>>FIN ACTIVACION DE LA IMPRESORA

*>>>>RECORRIDO DE LOS REGISTROS
       cSavPan := SAVESCREEN(0,0,24,79)
       SET DEVICE TO SCREEN
       Termometro(0,'IMPRIMIENDO')
       SET DEVICE TO PRINT

       SELECT CHE
       CHE->(DBGOTOP())
       DO WHILE .NOT. CHE->(EOF())

**********VISUALIZACION DE AVANCE
            nAvance := INT(( CHE->(RECNO()) / CHE->(RECCOUNT()) )*100)

            IF STR(nAvance,3) $ '25 50 75100'
               SET DEVICE TO SCREEN
               Termometro(nAvance)
               SET DEVICE TO PRINT
            ENDIF
**********FIN VISUALIZACION DE AVANCE

**********IMPRESION DEL REGISTRO
            aRegPrn := {}
            AADD(aRegPrn,STR(CHE->nNumeroChe,9,0))
            AADD(aRegPrn,CHE->cNroCuCChe)
            AADD(aRegPrn,STR(CHE->nNroCpBChe,9,0))
            AADD(aRegPrn,cFecha(CHE->dFecCheChe))
            AADD(aRegPrn,TRANS(CHE->nVlrCheChe,'###,###,###.99'))
            AADD(aRegPrn,CHE->cDocNitChe)
            AADD(aRegPrn,CHE->cTipNitChe)
            AADD(aRegPrn,STR(CHE->nEstadoChe,1,0))
            AADD(aRegPrn,CHE->cCodTraChe)
            AADD(aRegPrn,cFecha(CHE->dFecTraChe))
            AADD(aRegPrn,TRANS(CHE->nVlrTraChe,'###,###,###.99'))

            lPrnOpc(lShared,nOpcPrn,FilePrn,nHanXml,01,nColCab,;
                    aTitPrn,aRegPrn,aNroCol,bPagina,bDerAut,bCabeza)
**********FIN IMPRESION DEL REGISTRO

**********AVANCE DEL SIGUIENTE REGISTRO
	    SELECT CHE
	    CHE->(DBSKIP())
	    IF CHE->(EOF())
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
       SET DEVICE TO SCREEN
       RETURN NIL
*>>>>FIN IMPRESION DERECHOS
