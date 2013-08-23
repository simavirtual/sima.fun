/*************************************************************************
* TITULO..: CREACION DE LA ESTRUCTURA                                    *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: NOV  3/2004 MIE A
       Colombia, Bucaramanga        INICIO:  3:22 PM   NOV  3/2004 MIE

OBJETIVOS:

1- Crea la estructura del archivo

2- Retorna NIL

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION CreaDbfCuC(lShared,nModCry,PathArc,fArchvo,aStrDbf)

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
       AADD(aDbfStr,{'cCodigoCuC','Character',4,0}) // C¢digo de la Cuenta
       AADD(aDbfStr,{'cCodBanCuC','Character',2,0}) // C¢digo del Banco
       AADD(aDbfStr,{'cNumeroCuC','Character',20,0}) // N£mero de la Cuenta
       AADD(aDbfStr,{'nNroCheCuC','Numeric',9,0}) // N£mero del Cheque
       AADD(aDbfStr,{'cCodPucCuC','Character',20,0}) // C¢digo del Puc
       AADD(aDbfStr,{'nCodRefCuC','Numeric',3,0}) // Posici¢n de la Referencia
       AADD(aDbfStr,{'nLenRefCuC','Numeric',3,0}) // Longitud de la Referencia
       AADD(aDbfStr,{'nTipMovCuC','Numeric',3,0}) // Posici¢n Tipo de Movimiento
       AADD(aDbfStr,{'nLenTipCuC','Numeric',3,0}) // Longitud Tipo de Movimiento
       AADD(aDbfStr,{'nIntMovCuC','Numeric',3,0}) // P¢sici¢n Cifra entera del Movimiento
       AADD(aDbfStr,{'nLenIntCuC','Numeric',3,0}) // Longitud Cifra entera del Movimiento
       AADD(aDbfStr,{'nDecMovCuC','Numeric',3,0}) // Posici¢n Cifra decimal del Movimiento
       AADD(aDbfStr,{'nLenDecCuC','Numeric',3,0}) // Longitud Cifra decimal del Movimiento
       AADD(aDbfStr,{'nAnoMovCuC','Numeric',3,0}) // Posici¢n A¤o del Movimiento
       AADD(aDbfStr,{'nLenAnoCuC','Numeric',3,0}) // Longitud A¤o del Movimiento
       AADD(aDbfStr,{'nMesMovCuC','Numeric',3,0}) // Posici¢n Mes del Movimiento
       AADD(aDbfStr,{'nDiaMovCuC','Numeric',3,0}) // Posici¢n Dia del Movimiento
       AADD(aDbfStr,{'nDigVerCuC','Numeric',3,0}) // Digito de Chequeo

       AADD(aDbfStr,{'nCodigoCuC','Numeric'  ,16,0}) // C¢digo del Registro
       AADD(aDbfStr,{'cNomUsrCuC','Character',10,0}) // Nombre del Usuario
       AADD(aDbfStr,{'dFecUsrCuC','Date'     ,08,0}) // Fecha del Usuario
       AADD(aDbfStr,{'cHorUsrCuC','Character',10,0}) // Hora del Usuario
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
       Colombia, Bucaramanga        INICIO:  3:22 PM   NOV  3/2004 MIE

OBJETIVOS:

1- Recupera la estructura del archivo

2- Retorna NIL

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION RecuDbfCuC(lShared,nModCry,PathArc,fArchvo)

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
       CreaDbfCuC(lShared,nModCry,PathArc,fArchvo)
       RESTORE SCREEN
       RETURN NIL
*>>>>FIN RECUPERA LA ESTRUCTURA DEL ARCHIVO

/*************************************************************************
* TITULO..: ACTUALIZACION DE LA ESTRUCTURA                               *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: NOV  3/2004 MIE A
       Colombia, Bucaramanga        INICIO:  3:22 PM   NOV  3/2004 MIE

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

FUNCTION nActStrCuC(lShared,nModCry,PathArc,cNomArc)

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
       CreaDbfCuC(lShared,nModCry,PathArc,cNomArc,@aStrNew)
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
                         {||CreaDbfCuC(lShared,nModCry,PathArc,FileTem)})
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
       Colombia, Bucaramanga        INICIO:  3:22 PM   NOV  3/2004 MIE

OBJETIVOS:

1- Permite el mantenimiento del archivo

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION MantenCuC(lShared,nModCry,cNomSis,cCodEmp,cNitEmp,cEmpPal,;
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
       AADD(aUseDbf,{.T.,PathArc+'\'+fArchvo,'CUC',fNtxArc,lShared,nModCry})
*>>>>FIN AREAS DE TRABAJO

*>>>>SELECION DE LAS AREAS DE TRABAJO
       IF !lUseDbfs(aUseDbf)
          cError('ABRIENDO EL ARCHIVO')
          CloseDbf('CUC')
          RETURN NIL
       ENDIF
*>>>>FIN SELECION DE LAS AREAS DE TRABAJO

*>>>>PARAMETROS POR DEFECTO
       lModReg := IF(EMPTY(lModReg),.F.,lModReg)
       lModReg := IF(lModReg .AND. CUC->(RECCOUNT())==0,.F.,lModReg)

       lDelReg := IF(lDelReg==NIL,.F.,lDelReg)

       lInsReg := IF(lInsReg==NIL,.F.,lInsReg)

       lHaySql := IF(lHaySql==NIL,.F.,lHaySql)
*>>>>FIN PARAMETROS POR DEFECTO

*>>>>MANTENIMIENTO DEL ARCHIVO
       oBrowse := oBrwDbfCuC(lShared,cNomUsr,cAnoUsr,03,00,22,79,;
                             lModReg,lDelReg,lInsReg,lHaySql)

       SETKEY(K_F2,{||lManRegCuC(lShared,cNomUsr,3)})
     *ÀConsulta

       IF lModReg
          SETKEY(K_F4,{||lManRegCuC(lShared,cNomUsr,2,oBrowse,;
                                    CUC->cCodigoCuC)})
       ENDIF
     *ÀActualizar

       SETKEY(K_F5,{||BuscarCuC(oBrowse)})

       SETKEY(K_F9,{||MenuOtrCuC(lShared,nModCry,cNomSis,cCodEmp,cNitEmp,;
                                 cEmpPal,cNomEmp,cNomSec,cNomUsr,cAnoUsr,;
                                 PathArc,fArchvo,aArcNtx,lPrnArc,cOpcPrn,;
                                 lModReg,lDelReg,lInsReg,lHaySql,oBrowse)})

       CUC->(CtrlBrw(lShared,oBrowse))

       SETKEY(K_F2,NIL)
       SETKEY(K_F4,NIL)
       SETKEY(K_F5,NIL)
       SETKEY(K_F9,NIL)
       CloseDbf('CUC')
       RETURN NIL
*>>>>FIN MANTENIMIENTO DEL ARCHIVO

/*************************************************************************
* TITULO..: DEFINICION DEL OBJETO BROWSE                                 *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: NOV  3/2004 MIE A
       Colombia, Bucaramanga        INICIO:  3:22 PM   NOV  3/2004 MIE

OBJETIVOS:

1- Define el objeto Browse del archivo

SINTAXIS:

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION oBrwDbfCuC(lShared,cNomUsr,cAnoUsr,nFilSup,nColSup,nFilInf,nColInf,;
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

       cTitSup := '<< CUENTAS CORRIENTES >>'
       cTitInf := '<F2>Consultar <F5>Buscar'+;
                   IF(lModReg,' <F4>Actualizar','')+' <F9>Otros'+;
                   IF(lDelReg,' <DEL>Borrar','')+;
                   IF(lInsReg,' <INS>Incluir','')

       IF lInsReg
          oBrowse:Cargo := {cTitSup,cTitInf,{||lManRegCuC(lShared,cNomUsr)}}
       ELSE
          oBrowse:Cargo := {cTitSup,cTitInf}
       ENDIF
     *ÀDefinici¢n de cabeceras y l¡neas de cabeceras

       SELECT CUC
       oColumn := TBCOLUMNNEW('CODIGO;CUENTA',{||CUC->cCodigoCuC})
       oColumn:Cargo := {{'MODI',.F.},{'ALIAS','CUC'},;
			 {'FIELD','cCodigoCuC'},{'PICTURE','@!X'}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn := TBCOLUMNNEW('BANCO',{||CUC->cCodBanCuC})
       oColumn:Cargo := {{'MODI',lModReg},{'ALIAS','CUC'},;
			 {'FIELD','cCodBanCuC'},{'PICTURE','99'}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn := TBCOLUMNNEW('NUMERO;CUENTA',{||CUC->cNumeroCuC})
       oColumn:Cargo := {{'MODI',lModReg},{'ALIAS','CUC'},;
			 {'FIELD','cNumeroCuC'},{'PICTURE','@!X'}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn := TBCOLUMNNEW('NUMERO;CHEQUE',{||CUC->nNroCheCuC})
       oColumn:Cargo := {{'MODI',lModReg},{'ALIAS','CUC'},;
			 {'FIELD','nNroCheCuC'},{'PICTURE','999999999'}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn := TBCOLUMNNEW('CODIGO DEL PUC',{||CUC->cCodPucCuC})
       oColumn:Cargo := {{'MODI',lModReg},{'ALIAS','CUC'},;
			 {'FIELD','cCodPucCuC'},{'PICTURE','99999999999999999999'}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn := TBCOLUMNNEW('POSICION;REFERENCIA',{||CUC->nCodRefCuC})
       oColumn:Cargo := {{'MODI',lModReg},{'ALIAS','CUC'},;
			 {'FIELD','nCodRefCuC'},{'PICTURE','999.99'}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn := TBCOLUMNNEW('LONGITUD;REFERENCIA',{||CUC->nLenRefCuC})
       oColumn:Cargo := {{'MODI',lModReg},{'ALIAS','CUC'},;
			 {'FIELD','nLenRefCuC'},{'PICTURE','999.99'}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn := TBCOLUMNNEW('POSICION TIPO;MOVIMIENTO',{||CUC->nTipMovCuC})
       oColumn:Cargo := {{'MODI',lModReg},{'ALIAS','CUC'},;
			 {'FIELD','nTipMovCuC'},{'PICTURE','999.99'}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn := TBCOLUMNNEW('LONGITUD TIPO;MOVIMIENTO',{||CUC->nLenTipCuC})
       oColumn:Cargo := {{'MODI',lModReg},{'ALIAS','CUC'},;
			 {'FIELD','nLenTipCuC'},{'PICTURE','999.99'}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn := TBCOLUMNNEW('POSICION;CIFRA ENTERA',{||CUC->nIntMovCuC})
       oColumn:Cargo := {{'MODI',lModReg},{'ALIAS','CUC'},;
			 {'FIELD','nIntMovCuC'},{'PICTURE','999.99'}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn := TBCOLUMNNEW('LONGITUD;CIFRA ENTERA',{||CUC->nLenIntCuC})
       oColumn:Cargo := {{'MODI',lModReg},{'ALIAS','CUC'},;
			 {'FIELD','nLenIntCuC'},{'PICTURE','999.99'}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn := TBCOLUMNNEW('POSICION;CIFRA DECIMAL',{||CUC->nDecMovCuC})
       oColumn:Cargo := {{'MODI',lModReg},{'ALIAS','CUC'},;
			 {'FIELD','nDecMovCuC'},{'PICTURE','999.99'}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn := TBCOLUMNNEW('LONGITUD;CIFRA DECIMAL',{||CUC->nLenDecCuC})
       oColumn:Cargo := {{'MODI',lModReg},{'ALIAS','CUC'},;
			 {'FIELD','nLenDecCuC'},{'PICTURE','999.99'}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn := TBCOLUMNNEW('POSICION;A¥O MVTO',{||CUC->nAnoMovCuC})
       oColumn:Cargo := {{'MODI',lModReg},{'ALIAS','CUC'},;
			 {'FIELD','nAnoMovCuC'},{'PICTURE','999.99'}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn := TBCOLUMNNEW('LONGITUD;A¥O MVTO',{||CUC->nLenAnoCuC})
       oColumn:Cargo := {{'MODI',lModReg},{'ALIAS','CUC'},;
			 {'FIELD','nLenAnoCuC'},{'PICTURE','999.99'}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn := TBCOLUMNNEW('POSICION;MES MVTO',{||CUC->nMesMovCuC})
       oColumn:Cargo := {{'MODI',lModReg},{'ALIAS','CUC'},;
			 {'FIELD','nMesMovCuC'},{'PICTURE','999.99'}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn := TBCOLUMNNEW('POSICION;DIA NVTO',{||CUC->nDiaMovCuC})
       oColumn:Cargo := {{'MODI',lModReg},{'ALIAS','CUC'},;
			 {'FIELD','nDiaMovCuC'},{'PICTURE','999.99'}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn := TBCOLUMNNEW('DIGITO;CHEQUEO',{||CUC->nDigVerCuC})
       oColumn:Cargo := {{'MODI',lModReg},{'ALIAS','CUC'},;
			 {'FIELD','nDigVerCuC'},{'PICTURE','999.99'}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn	     := TBCOLUMNNEW('NOMBRE;DEL USUARIO',{||CUC->cNomUsrCuC})
       oColumn:Cargo := {{'MODI',.F.}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn	     := TBCOLUMNNEW('FECHA DE;PROCESO',;
				    {||cFecha(CUC->dFecUsrCuC)})
       oColumn:Cargo := {{'MODI',.F.}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn	     := TBCOLUMNNEW('HORA DE;PROCESO',;
				    {||cHoraSys(CUC->cHorUsrCuC)})
       oColumn:Cargo := {{'MODI',.F.}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn	     := TBCOLUMNNEW('CODIGO',{||CUC->nCodigoCuC})
       oColumn:Cargo := {{'MODI',.F.}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn	     := TBCOLUMNNEW('No.',{||CUC->(RECNO())})
       oColumn:Cargo := {{'MODI',.F.}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       RETURN oBrowse
*>>>>FIN DEFINICION DEL OBJETO BROWSE

/*************************************************************************
* TITULO..: MANTENIMIENTO DEL REGISTRO                                   *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: NOV  3/2004 MIE A
       Colombia, Bucaramanga        INICIO:  3:22 PM   NOV  3/2004 MIE

OBJETIVOS:

1- Permite inclusi¢n,modificaci¢n y consulta del registro

2- Puede invocarse en la lectura a trav‚s de la clausula VALID

2- Returna .T.

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION lManRegCuC(lShared,cNomUsr,nTipMod,oBrowse,cCodigo,nNroOpc)

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

       LOCAL cCodBan := ''                  // C¢digo del Banco                                            
       LOCAL cNumero := ''                  // N£mero de la Cuenta                                         
       LOCAL nNroChe := 0                   // N£mero del Cheque                                           
       LOCAL cCodPuc := ''                  // C¢digo del Puc                                              
       LOCAL nCodRef := 0                   // Posici¢n de la Referencia                                   
       LOCAL nLenRef := 0                   // Longitud de la Referencia                                   
       LOCAL nTipMov := 0                   // Posici¢n Tipo de Movimiento                                 
       LOCAL nLenTip := 0                   // Longitud Tipo de Movimiento                                 
       LOCAL nIntMov := 0                   // P¢sici¢n Cifra entera del Movimiento                        
       LOCAL nLenInt := 0                   // Longitud Cifra entera del Movimiento                        
       LOCAL nDecMov := 0                   // Posici¢n Cifra decimal del Movimiento                       
       LOCAL nLenDec := 0                   // Longitud Cifra decimal del Movimiento                       
       LOCAL nAnoMov := 0                   // Posici¢n A¤o del Movimiento                                 
       LOCAL nLenAno := 0                   // Longitud A¤o del Movimiento                                 
       LOCAL nMesMov := 0                   // Posici¢n Mes del Movimiento                                 
       LOCAL nDiaMov := 0                   // Posici¢n Dia del Movimiento                                 
       LOCAL nDigVer := 0                   // Digito de Chequeo                                           

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
            cTxtTem := 'CUENTAS CORRIENTES .POR FAVOR INGRESE LOS DATOS'
            CUC->(DBGOBOTTOM())
            CUC->(DBSKIP())
            nTipCur := SETCURSOR(1)

       CASE nTipMod == 2
            cTxtTem := 'CUENTAS CORRIENTES .POR FAVOR ACTUALICE LOS DATOS'
            nTipCur := SETCURSOR(1)

       CASE nTipMod == 3
            cTxtTem := 'CONSULTA. CUENTAS CORRIENTES'
       ENDCASE
       nFilIni := nMarco(03,cTxtTem,22,'°')
*>>>>FIN MARCO DEL MANTENIMIENTO

*>>>>MANTENIMIENTO DEL REGISTRO
       SELECT CUC
       DO WHILE .T.

**********INICIALIZACION DE LAS VARIABLES
            IF lGrabar

               IF EMPTY(cCodigo)
                  cCodigo := CUC->cCodigoCuC
               ENDIF

               cCodBan := CUC->cCodBanCuC
               cNumero := CUC->cNumeroCuC
               nNroChe := CUC->nNroCheCuC
               cCodPuc := CUC->cCodPucCuC
               nCodRef := CUC->nCodRefCuC
               nLenRef := CUC->nLenRefCuC
               nTipMov := CUC->nTipMovCuC
               nLenTip := CUC->nLenTipCuC
               nIntMov := CUC->nIntMovCuC
               nLenInt := CUC->nLenIntCuC
               nDecMov := CUC->nDecMovCuC
               nLenDec := CUC->nLenDecCuC
               nAnoMov := CUC->nAnoMovCuC
               nLenAno := CUC->nLenAnoCuC
               nMesMov := CUC->nMesMovCuC
               nDiaMov := CUC->nDiaMovCuC
               nDigVer := CUC->nDigVerCuC
            ENDIF
**********FIN INICIALIZACION DE LAS VARIABLES

**********LECTURA DE CAMPO
            nNroFil := nFilIni
            cTxtTem := 'CODIGO DE LA CUENTA         :'

            IF nTipMod == 2 .OR. nTipMod == 3 .OR. !EMPTY(cCodigo)
               @ nNroFil,nNroCol SAY cTxtTem
               @ nNroFil,nNroCol+LEN(cTxtTem)+1 SAY cCodigo COLOR('I')
            ELSE
               @ nNroFil,nNroCol SAY cTxtTem;
                                 GET cCodigo PICT '@!X';
                                 VALID !EMPTY(cCodigo) .AND.;
                                       !lValCodCuC(cCodigo)
            ENDIF
**********FIN LECTURA DE CAMPO

**********LECTURA DE CAMPO
            nColTem := nNroCol
            cTxtTem := 'CODIGO DEL BANCO            :'

            IF nTipMod == 3
               @ nNroFil+1,nColTem SAY cTxtTem
               @ nNroFil+1,nColTem+LEN(cTxtTem)+1 SAY cCodBan COLOR('I')
            ELSE
               @ nNroFil+1,nColTem SAY cTxtTem;
                                   GET cCodBan PICT '99';
                                   VALID !EMPTY(cCodBan);
                                   WHEN {||HelpRead('FAVOR INGRESE EL CODIGO DEL BANCO')}
            ENDIF
**********FIN LECTURA DE CAMPO

**********LECTURA DE CAMPO
            nColTem := nNroCol
            cTxtTem := 'NUMERO DE LA CUENTA         :'

            IF nTipMod == 3
               @ nNroFil+2,nColTem SAY cTxtTem
               @ nNroFil+2,nColTem+LEN(cTxtTem)+1 SAY cNumero COLOR('I')
            ELSE
               @ nNroFil+2,nColTem SAY cTxtTem;
                                   GET cNumero PICT '@!X';
                                   VALID !EMPTY(cNumero);
                                   WHEN {||HelpRead('FAVOR INGRESE EL NUMERO DE LA CUENTA')}
            ENDIF
**********FIN LECTURA DE CAMPO

**********LECTURA DE CAMPO
            nColTem := nNroCol
            cTxtTem := 'NUMERO DEL CHEQUE           :'

            IF nTipMod == 3
               @ nNroFil+3,nColTem SAY cTxtTem
               @ nNroFil+3,nColTem+LEN(cTxtTem)+1 SAY nNroChe COLOR('I')
            ELSE
               @ nNroFil+3,nColTem SAY cTxtTem;
                                   GET nNroChe PICT '999999999';
                                   WHEN {||HelpRead('FAVOR INGRESE EL NUMERO DEL CHEQUE')}
            ENDIF
**********FIN LECTURA DE CAMPO

**********LECTURA DE CAMPO
            nColTem := nNroCol
            cTxtTem := 'CODIGO DEL PUC              :'

            IF nTipMod == 3
               @ nNroFil+4,nColTem SAY cTxtTem
               @ nNroFil+4,nColTem+LEN(cTxtTem)+1 SAY cCodPuc COLOR('I')
            ELSE
               @ nNroFil+4,nColTem SAY cTxtTem;
                                   GET cCodPuc PICT '99999999999999999999';
                                   VALID !EMPTY(cCodPuc);
                                   WHEN {||HelpRead('FAVOR INGRESE EL CODIGO DEL PUC')}
            ENDIF
**********FIN LECTURA DE CAMPO

**********LECTURA DE CAMPO
            nColTem := nNroCol
            cTxtTem := 'POSICION DE LA REFERENCIA   :'

            IF nTipMod == 3
               @ nNroFil+5,nColTem SAY cTxtTem
               @ nNroFil+5,nColTem+LEN(cTxtTem)+1 SAY nCodRef COLOR('I')
            ELSE
               @ nNroFil+5,nColTem SAY cTxtTem;
                                   GET nCodRef PICT '999.99';
                                   WHEN {||HelpRead('FAVOR INGRESE LA POSICION DE LA REFERENCIA')}
            ENDIF
**********FIN LECTURA DE CAMPO

**********LECTURA DE CAMPO
            nColTem := nNroCol
            cTxtTem := 'LONGITUD DE LA REFRENCIA    :'

            IF nTipMod == 3
               @ nNroFil+6,nColTem SAY cTxtTem
               @ nNroFil+6,nColTem+LEN(cTxtTem)+1 SAY nLenRef COLOR('I')
            ELSE
               @ nNroFil+6,nColTem SAY cTxtTem;
                                   GET nLenRef PICT '999.99';
                                   WHEN {||HelpRead('FAVOR INGRESE LA LONGITUD DE LA REFERENCIA')}
            ENDIF
**********FIN LECTURA DE CAMPO

**********LECTURA DE CAMPO
            nColTem := nNroCol
            cTxtTem := 'POSICION TIPO DE MOVIEMIENTO:'

            IF nTipMod == 3
               @ nNroFil+7,nColTem SAY cTxtTem
               @ nNroFil+7,nColTem+LEN(cTxtTem)+1 SAY nTipMov COLOR('I')
            ELSE
               @ nNroFil+7,nColTem SAY cTxtTem;
                                   GET nTipMov PICT '999.99';
                                   WHEN {||HelpRead('FAVOR INGRESE LA POSICION DEL TIPO DE MOVIMIENTO')}
            ENDIF
**********FIN LECTURA DE CAMPO

**********LECTURA DE CAMPO
            nColTem := nNroCol
            cTxtTem := 'LONGITUD TIPO DE MOVIMIENTO :'

            IF nTipMod == 3
               @ nNroFil+8,nColTem SAY cTxtTem
               @ nNroFil+8,nColTem+LEN(cTxtTem)+1 SAY nLenTip COLOR('I')
            ELSE
               @ nNroFil+8,nColTem SAY cTxtTem;
                                   GET nLenTip PICT '999.99';
                                   WHEN {||HelpRead('FAVOR INGRESE LA LONGITUD DEL TIPO DE MOVIMIENTO')}
            ENDIF
**********FIN LECTURA DE CAMPO

**********LECTURA DE CAMPO
            nColTem := nNroCol
            cTxtTem := 'POSICION CIFRA ENTERA       :'

            IF nTipMod == 3
               @ nNroFil+9,nColTem SAY cTxtTem
               @ nNroFil+9,nColTem+LEN(cTxtTem)+1 SAY nIntMov COLOR('I')
            ELSE
               @ nNroFil+9,nColTem SAY cTxtTem;
                                   GET nIntMov PICT '999.99';
                                   WHEN {||HelpRead('FAVOR INGRESE LA POSICION DE LA CIFRA ENTERA')}
            ENDIF
**********FIN LECTURA DE CAMPO

**********LECTURA DE CAMPO
            nColTem := nNroCol
            cTxtTem := 'LONGITUD CIFRA ENTERA       :'

            IF nTipMod == 3
               @ nNroFil+10,nColTem SAY cTxtTem
               @ nNroFil+10,nColTem+LEN(cTxtTem)+1 SAY nLenInt COLOR('I')
            ELSE
               @ nNroFil+10,nColTem SAY cTxtTem;
                                   GET nLenInt PICT '999.99';
                                   WHEN {||HelpRead('FAVOR INGRESE LA LONGITUD DE LA CIFRA ENTERA')}
            ENDIF
**********FIN LECTURA DE CAMPO

**********LECTURA DE CAMPO
            nColTem := nNroCol
            cTxtTem := 'POSICION CIFRA DECIMAL      :'

            IF nTipMod == 3
               @ nNroFil+11,nColTem SAY cTxtTem
               @ nNroFil+11,nColTem+LEN(cTxtTem)+1 SAY nDecMov COLOR('I')
            ELSE
               @ nNroFil+11,nColTem SAY cTxtTem;
                                   GET nDecMov PICT '999.99';
                                   WHEN {||HelpRead('FAVOR INGRESE LA POSICION DE LA CIFRA DECIMAL')}
            ENDIF
**********FIN LECTURA DE CAMPO

**********LECTURA DE CAMPO
            nColTem := nNroCol
            cTxtTem := 'LONGITUD CIFRA DECIMAL      :'

            IF nTipMod == 3
               @ nNroFil+12,nColTem SAY cTxtTem
               @ nNroFil+12,nColTem+LEN(cTxtTem)+1 SAY nLenDec COLOR('I')
            ELSE
               @ nNroFil+12,nColTem SAY cTxtTem;
                                   GET nLenDec PICT '999.99';
                                   WHEN {||HelpRead('FAVOR INGRESE LA LONGITUD DE LA CIFRA DECIMAL')}
            ENDIF
**********FIN LECTURA DE CAMPO

**********LECTURA DE CAMPO
            nColTem := nNroCol
            cTxtTem := 'POSICION A¥O DEL MOVIMIENTO :'

            IF nTipMod == 3
               @ nNroFil+13,nColTem SAY cTxtTem
               @ nNroFil+13,nColTem+LEN(cTxtTem)+1 SAY nAnoMov COLOR('I')
            ELSE
               @ nNroFil+13,nColTem SAY cTxtTem;
                                   GET nAnoMov PICT '999.99';
                                   WHEN {||HelpRead('FAVOR INGRESE LA POSICION DEL A¥O DEL MOVIMIENTO')}
            ENDIF
**********FIN LECTURA DE CAMPO

**********LECTURA DE CAMPO
            nColTem := nNroCol
            cTxtTem := 'LONGITUD A¥O DEL MOVIMIENTO :'

            IF nTipMod == 3
               @ nNroFil+14,nColTem SAY cTxtTem
               @ nNroFil+14,nColTem+LEN(cTxtTem)+1 SAY nLenAno COLOR('I')
            ELSE
               @ nNroFil+14,nColTem SAY cTxtTem;
                                   GET nLenAno PICT '999.99';
                                   WHEN {||HelpRead('FAVOR INGRESE LA LONGITUD DEL A¥O DEL MOVIMIENTO')}
            ENDIF
**********FIN LECTURA DE CAMPO

**********LECTURA DE CAMPO
            nColTem := nNroCol
            cTxtTem := 'POSICION MES DEL MOVIMIENTO :'

            IF nTipMod == 3
               @ nNroFil+15,nColTem SAY cTxtTem
               @ nNroFil+15,nColTem+LEN(cTxtTem)+1 SAY nMesMov COLOR('I')
            ELSE
               @ nNroFil+15,nColTem SAY cTxtTem;
                                   GET nMesMov PICT '999.99';
                                   WHEN {||HelpRead('FAVOR INGRESE LA POSICION DEL MES DEL MOVIMIENTO')}
            ENDIF
**********FIN LECTURA DE CAMPO

**********LECTURA DE CAMPO
            nColTem := nNroCol
            cTxtTem := 'POSICION DIA DEL MOVIMIENTO :'

            IF nTipMod == 3
               @ nNroFil+16,nColTem SAY cTxtTem
               @ nNroFil+16,nColTem+LEN(cTxtTem)+1 SAY nDiaMov COLOR('I')
            ELSE
               @ nNroFil+16,nColTem SAY cTxtTem;
                                   GET nDiaMov PICT '999.99';
                                   WHEN {||HelpRead('FAVOR INGRESE LA POSICION DEL DIA DEL MOVIMIENTO')}
            ENDIF
**********FIN LECTURA DE CAMPO

**********LECTURA DE CAMPO
            nColTem := nNroCol
            cTxtTem := 'DIGITO CHEQUEO              :'

            IF nTipMod == 3
               @ nNroFil+17,nColTem SAY cTxtTem
               @ nNroFil+17,nColTem+LEN(cTxtTem)+1 SAY nDigVer COLOR('I')
            ELSE
               @ nNroFil+17,nColTem SAY cTxtTem;
                                   GET nDigVer PICT '999.99';
                                   WHEN {||HelpRead('FAVOR INGRESE EL DIGITO CHEQUEO')}
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
       SELECT CUC
       IF nTipMod # 3 .AND. lGrabar

          lInsReg := IF(nTipMod == 1,.T.,.F.)
          IF CUC->(lRegLock(lShared,lInsReg))

             IF lInsReg
                REPL CUC->nCodigoCuC WITH CUC->(RECNO())
                REPL CUC->cCodigoCuC WITH cCodigo
             ENDIF

             REPL CUC->cCodBanCuC WITH cCodBan
             REPL CUC->cNumeroCuC WITH cNumero
             REPL CUC->nNroCheCuC WITH nNroChe
             REPL CUC->cCodPucCuC WITH cCodPuc
             REPL CUC->nCodRefCuC WITH nCodRef
             REPL CUC->nLenRefCuC WITH nLenRef
             REPL CUC->nTipMovCuC WITH nTipMov
             REPL CUC->nLenTipCuC WITH nLenTip
             REPL CUC->nIntMovCuC WITH nIntMov
             REPL CUC->nLenIntCuC WITH nLenInt
             REPL CUC->nDecMovCuC WITH nDecMov
             REPL CUC->nLenDecCuC WITH nLenDec
             REPL CUC->nAnoMovCuC WITH nAnoMov
             REPL CUC->nLenAnoCuC WITH nLenAno
             REPL CUC->nMesMovCuC WITH nMesMov
             REPL CUC->nDiaMovCuC WITH nDiaMov
             REPL CUC->nDigVerCuC WITH nDigVer

             REPL CUC->cNomUsrCuC WITH cNomUsr
             REPL CUC->dFecUsrCuC WITH DATE()
             REPL CUC->cHorUsrCuC WITH TIME()
             CUC->(DBCOMMIT())
          ENDIF

          IF lShared
             CUC->(DBUNLOCK())
          ENDIF

       ENDIF
       RESTSCREEN(0,0,24,79,cSavPan)
       SETCURSOR(nTipCur)
*>>>>FIN GRABACION DEL CAMPO

*>>>>REFRESCAR EL BROWSE
       IF nTipMod == 2
          nNroReg := CUC->(RECNO())
          CUC->(DBGOTOP())
          oBrowse:GOTOP()
          CUC->(DBGOTO(nNroReg))
          oBrowse:FORCESTABLE()
       ENDIF
       RETURN .T.
*>>>>FIN REFRESCAR EL BROWSE

/*************************************************************************
* TITULO..: VALIDACION DE EXISTENCIA DEL CODIGO                          *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: NOV  3/2004 MIE A
       Colombia, Bucaramanga        INICIO:  3:22 PM   NOV  3/2004 MIE

OBJETIVOS:

1- Debe estar en uso el archivo.

2- Realiza la validaci¢n de existencia del C¢digo.

3- Retorna .T. si hay problemas

SINTAXIS:

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION lValCodCuC(cCodigo)

*>>>>DESCRIPCION DE PARAMETROS
/*     cCodigo                              // C¢digo a Validar */
*>>>>FIN DESCRIPCION DE PARAMETROS

*>>>>DECLARACION DE VARIABLES
       LOCAL lHayErr := .F.                 // .T. Hay Error
*>>>>FIN DECLARACION DE VARIABLES

*>>>>VALIDACION DEL CODIGO
       IF cCodigo # cSpaces('CUC','cCodigoCuC')
          IF lLocCodigo('cCodigoCuC','CUC',cCodigo)
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
       Colombia, Bucaramanga        INICIO:  3:22 PM   NOV  3/2004 MIE

OBJETIVOS:

1- Permite localizar un c¢digo dentro del archivo.

2- Retorna NIL

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION BuscarCuC(oBrowse)

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
       cCodigo := cSpaces('CUC','cCodigoCuC')
       TitBuscar(LEN(cCodigo),@nNroFil,@nNroCol)
       @ nNroFil,nNroCol GET cCodigo PICT '@!';
			 VALID lValCuC(ROW(),COL()-3,@cCodigo)
       READ
*>>>>FIN CAPTURA DEL CODIGO

*>>>>VALIDACION DEL CODIGO
       IF cCodigo == cSpaces('CUC','cCodigoCuC')
          cError('PATRON DE BUSQUEDA NO ESPECIFICADO',;
                 'ADVERTENCIA')
          lBuscar := .F.
       ENDIF
*>>>>FIN VALIDACION DEL CODIGO

*>>>>BUSQUEDA DEL CODIGO
       SELECT CUC
       IF lBuscar .AND. lLocCodigo('cCodigoCuC','CUC',cCodigo)
          nNroReg := CUC->(RECNO())
          CUC->(DBGOTOP())
          oBrowse:GOTOP()
          CUC->(DBGOTO(nNroReg))
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
       Colombia, Bucaramanga        INICIO:  3:22 PM   NOV  3/2004 MIE

OBJETIVOS:

1- Debe estar en uso el archivo

2- Realiza la validaci¢n del c¢digo

3- Retorna .T. si hay problemas

SINTAXIS:

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION lValCuC(nNroFil,nNroCol,cCodigo)

*>>>>DESCRIPCION DE PARAMETROS
/*     nNroFil                              // Fila de lectura
       nNroCol                              // Columna de lectura
       cCodigo                              // C¢digo a Validar */
*>>>>FIN DESCRIPCION DE PARAMETROS

*>>>>DECLARACION DE VARIABLES
       LOCAL nNroReg := 0                   // N£mero del Registro
*>>>>FIN DECLARACION DE VARIABLES

*>>>>VALIDACION DEL CODIGO
       IF !lLocCodigo('cCodigoCuC','CUC',cCodigo)
          nNroReg := nSelCuC(nNroFil,nNroCol)
          IF nNroReg == 0
             cCodigo := cSpaces('CUC','cCodigoCuC')
          ELSE
             CUC->(DBGOTO(nNroReg))
             cCodigo := CUC->cCodigoCuC
          ENDIF
       ENDIF
       RETURN .T.
*>>>>FIN VALIDACION DEL CODIGO

/*************************************************************************
* TITULO..: SELECCION DEL CODIGO                                         *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: NOV  3/2004 MIE A
       Colombia, Bucaramanga        INICIO:  3:22 PM   NOV  3/2004 MIE

OBJETIVOS:

1- Debe estar en uso el archivo

2- Permite escoger el registro de acuerdo al c¢digo o descripci¢n

3- Retorna el n£mero del registro escogido

SINTAXIS:

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION nSelCuC(nNroFil,nNroCol)

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
       IF CUC->(RECCOUNT()) == 0
          cError('NO EXISTEN REGISTROS GRABADOS')
          RETURN 0
       ENDIF
*>>>>FIN VALIDACION DE CONTENIDOS DE ARCHIVOS

*>>>>INICIALIZACION DE LAS COORDENADAS
       SELECT CUC
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
       CUC->(DBGOTOP())
       cSavPan := SAVESCREEN(0,0,24,79)
       @ nFilSup-1,nColSup-1 TO nFilInf,nColInf+1 DOUBLE
       nNroReg := nBrowseDbf(nFilSup,nColSup,nFilInf-1,nColInf,;
			     {||CUC->cCodigoCuC})
       RESTSCREEN(0,0,24,79,cSavPan)
       RETURN nNroReg
*>>>>FIN SELECCION DEL CODIGO

/*************************************************************************
* TITULO..: MENU DE OTROS PARA EL ARCHIVO                                *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: NOV  3/2004 MIE A
       Colombia, Bucaramanga        INICIO:  3:22 PM   NOV  3/2004 MIE

OBJETIVOS:

1- Menu de Otros para el archivo

2- Retorna NIL

SINTAXIS:

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION MenuOtrCuC(lShared,nModCry,cNomSis,cCodEmp,cNitEmp,cEmpPal,;
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
       AADD(aMenus,'1<CUENTAS CORRIENTES>')

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
            OtrCuC011(lShared,nModCry,cNomSis,cCodEmp,cNitEmp,cEmpPal,;
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
       Colombia, Bucaramanga        INICIO:  3:22 PM   NOV  3/2004 MIE

OBJETIVOS:

1- Imprime los campos del archivo de mantenimiento

2- Retorna NIL

SINTAXIS:

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION OtrCuC011(lShared,nModCry,cNomSis,cCodEmp,cNitEmp,cEmpPal,;
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
                   'CUENTAS CORRIENTES',;
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

       AADD(aNroCol,6)
       AADD(aTitPrn,'CODIGO')

       AADD(aNroCol,6)
       AADD(aTitPrn,'BANCO')

       AADD(aNroCol,20)
       AADD(aTitPrn,'NUMERO DE CUENTA')

       AADD(aNroCol,10)
       AADD(aTitPrn,'CHEQUE')

       AADD(aNroCol,20)
       AADD(aTitPrn,'CODIGO')

       AADD(aNroCol,8)
       AADD(aTitPrn,'POS. REF')

       AADD(aNroCol,8)
       AADD(aTitPrn,'LEN. REF')

       AADD(aNroCol,10)
       AADD(aTitPrn,'POS. TIPO')

       AADD(aNroCol,10)
       AADD(aTitPrn,'LEN. TIPO')

       AADD(aNroCol,8)
       AADD(aTitPrn,'POS. INT')

       AADD(aNroCol,8)
       AADD(aTitPrn,'LEN. ENT')

       AADD(aNroCol,8)
       AADD(aTitPrn,'POS. DEC')

       AADD(aNroCol,8)
       AADD(aTitPrn,'LEN. DEC')

       AADD(aNroCol,8)
       AADD(aTitPrn,'POS. A¥O')

       AADD(aNroCol,8)
       AADD(aTitPrn,'LEN. A¥O')

       AADD(aNroCol,8)
       AADD(aTitPrn,'POS. MES')

       AADD(aNroCol,8)
       AADD(aTitPrn,'POS. DIA')

       AADD(aNroCol,8)
       AADD(aTitPrn,'CHEQUEO')

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
          FilePrn := 'CuC'
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

       SELECT CUC
       CUC->(DBGOTOP())
       DO WHILE .NOT. CUC->(EOF())

**********VISUALIZACION DE AVANCE
            nAvance := INT(( CUC->(RECNO()) / CUC->(RECCOUNT()) )*100)

            IF STR(nAvance,3) $ '25 50 75100'
               SET DEVICE TO SCREEN
               Termometro(nAvance)
               SET DEVICE TO PRINT
            ENDIF
**********FIN VISUALIZACION DE AVANCE

**********IMPRESION DEL REGISTRO
            aRegPrn := {}
            AADD(aRegPrn,CUC->cCodigoCuC)
            AADD(aRegPrn,CUC->cCodBanCuC)
            AADD(aRegPrn,CUC->cNumeroCuC)
            AADD(aRegPrn,STR(CUC->nNroCheCuC,9,0))
            AADD(aRegPrn,CUC->cCodPucCuC)
            AADD(aRegPrn,STR(CUC->nCodRefCuC,3,0))
            AADD(aRegPrn,STR(CUC->nLenRefCuC,3,0))
            AADD(aRegPrn,STR(CUC->nTipMovCuC,3,0))
            AADD(aRegPrn,STR(CUC->nLenTipCuC,3,0))
            AADD(aRegPrn,STR(CUC->nIntMovCuC,3,0))
            AADD(aRegPrn,STR(CUC->nLenIntCuC,3,0))
            AADD(aRegPrn,STR(CUC->nDecMovCuC,3,0))
            AADD(aRegPrn,STR(CUC->nLenDecCuC,3,0))
            AADD(aRegPrn,STR(CUC->nAnoMovCuC,3,0))
            AADD(aRegPrn,STR(CUC->nLenAnoCuC,3,0))
            AADD(aRegPrn,STR(CUC->nMesMovCuC,3,0))
            AADD(aRegPrn,STR(CUC->nDiaMovCuC,3,0))
            AADD(aRegPrn,STR(CUC->nDigVerCuC,3,0))

            lPrnOpc(lShared,nOpcPrn,FilePrn,nHanXml,01,nColCab,;
                    aTitPrn,aRegPrn,aNroCol,bPagina,bDerAut,bCabeza)
**********FIN IMPRESION DEL REGISTRO

**********AVANCE DEL SIGUIENTE REGISTRO
	    SELECT CUC
	    CUC->(DBSKIP())
	    IF CUC->(EOF())
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
