/*                   SIMA. SISTEMA INTEGRADO MULTIUSUARIO
	 BIBLIOTECA DE FUNCIONES PARA EL ARCHIVO DE CONTRATANTES

/*************************************************************************
* TITULO..: CREACION DE LA ESTRUCTURA                                    *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: SEP 22/2004 MIE A
       Colombia, Bucaramanga        INICIO: 10:30 PM   SEP 22/2004 MIE

OBJETIVOS:

1- Crea la estructura del archivo

2- Retorna NIL

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION CreaDbfCnt(lShared,nModCry,PathArc,fArchvo,aStrDbf)

*>>>>PARAMETROS DE LA FUNCION
/*     lShared                              // .T. Sistema Compartido
       nModCry                              // Modo de Protecci¢n
       PathArc				    // Path del Archivo
       fArchvo				    // Nombre del Archivo
       aStrDbf                              // Estructura del Archivo */
*>>>>FIN PARAMETROS DE LA FUNCION

*>>>>DECLARACION DE VARIABLES
       LOCAL PathAct := ''                  // Path Actual

       LOCAL aDbfStr := {}                  // Estructura del Archivo
*>>>>FIN DECLARACION DE VARIABLES

*>>>>DECLARACION DE LA ESTRUCTURA
       AADD(aDbfStr,{"cCodigoEst","Character",06,0}) // C¢digo del Estudiante
       AADD(aDbfStr,{"cDocNitPer","Character",16,0}) // Documento de Identidad
       AADD(aDbfStr,{"cTipNitPer","Character",01,0}) // Tipo de Documento. 1=>Cedula, 2=>Nits Empresariales, 3=>Nits de Extranjeria, 4=>Cedula de Estranjeria, 5=>NUIP: N£mero £nico de identificaci¢n personal
       AADD(aDbfStr,{"nNumeroCnt","Numerci"  ,01,0}) // N£mero del Contratante
       AADD(aDbfStr,{"cAnoCntCnt","Character",04,0}) // A¤o del Contratante
       AADD(aDbfStr,{"lNoRepoCnt","Logical"  ,01,0}) // .T. No Reportar .F. Si Reportar
       AADD(aDbfStr,{"dFecMatEst","Date"     ,08,0}) // Fecha de matricula
       AADD(aDbfStr,{"cHorMatEst","Character",08,0}) // Hora de matricula
*>>>>DECLARACION DE LA ESTRUCTURA

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
	    DBCREATE(fArchvo,aDbfStr,"DBFNTX")

       CASE DIRCHANGE(PathArc) == -3
	    cError('NO EXISTE EL DIRECTORIO: '+PathArc)

       CASE DIRCHANGE(PathArc) == -5
	    cError('NO TIENE DERECHOS EN: '+PathArc)
       ENDCASE
       nCd(PathAct)
       RETURN NIL
*>>>>FIN CREACION DE LA ESTRUCTURA

/*************************************************************************
* TITULO..: RECUPERACION DE LA ESTRUCTURA                                *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: SEP 22/2004 MIE A
       Colombia, Bucaramanga        INICIO: 10:35 PM   SEP 22/2004 MIE

OBJETIVOS:

1- Recupera la estructura del archivo

2- Retorna NIL


*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION RecuDbfCnt(lShared,nModCry,PathArc,fArchvo)

*>>>>PARAMETROS DE LA FUNCION
/*     lShared                        // .T. Sistema Compartido
       nModCry                        // Modo de Protecci¢n
       PathArc			      // Path del Archivo
       fArchvo			      // Nombre del Archivo */
*>>>>FIN PARAMETROS DE LA FUNCION

*>>>>RECUPERA LA ESTRUCTURA DEL ARCHIVO
       SAVE SCREEN
       cError("SE BORRO EL ARCHIVO "+PathArc+'\'+fArchvo,;
	      "Error Grave. TOME NOTA",;
	      "Al Presionar Cualquier tecla se crea el archivo")
       Termometro(0,"CREANDO LA ESTRUCTURA")
       Termometro(100)
       CreaDbfCnt(lShared,nModCry,PathArc,fArchvo)
       RESTORE SCREEN
       RETURN NIL
*>>>>FIN RECUPERA LA ESTRUCTURA DEL ARCHIVO

/*************************************************************************
* TITULO..: ACTUALIZACION DE LA ESTRUCTURA                               *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: SEP 22/2004 MIE A
       Colombia, Bucaramanga        INICIO: 10:40 PM   SEP 22/2004 MIE

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

FUNCTION nActStrCnt(lShared,nModCry,PathArc,cNomArc)

*>>>>PARAMETROS DE LA FUNCION
/*     lShared                              // .T. Sistema Compartido
       nModCry                              // Modo de Protecci¢n
       PathArc				    // Path del Archivo
       cNomArc				    // Nombre del Archivo */
*>>>>FIN PARAMETROS DE LA FUNCION

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
       CreaDbfCnt(lShared,nModCry,PathArc,cNomArc,@aStrNew)
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
*>>>>FIN VALIDACION DE LAS STRUCTURAS

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
			 {||CreaDbfCnt(lShared,nModCry,PathArc,FileTem)})
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

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: SEP 22/2004 MIE A
       Colombia, Bucaramanga        INICIO: 10:45 PM   SEP 22/2004 MIE

OBJETIVOS:

1- Permite el mantenimiento del archivo

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/


FUNCTION MantenCnt(lShared,nModCry,cNomSis,cEmpPal,cNitEmp,;
		   cNomEmp,cNomSec,nFilInf,nColInf,nFilPal,;
		   cNomUsr,cAnoUsr,PathArc,cMaeAlu,cMaeAct,;
		   cJorTxt,lPrnArc,cOpcPrn,lModReg,lDelReg,;
		   lInsReg,cAnoAnt,cUnoAnt)


*>>>>DESCRIPCION DE PARAMETROS
/*     lShared                              // .T. Sistema Compartido
       nModCry                              // Modo de Protecci¢n
       cNomSis                              // Nombre del Sistema
       cEmpPal                              // Nombre de la Empresa principal
       cNitEmp                              // Nit de la Empresa
       cNomEmp                              // Nombre de la Empresa
       cNomSec                              // Nombre de la Empresa Secundario
       nFilInf                              // Fila Inferior del SubMen£
       nColInf                              // Columna Inferior del SubMen£
       nFilPal                              // Fila Inferior Men£ principal
       cNomUsr                              // Nombre del Usuario
       cAnoUsr                              // A¤o del usuario
       PathArc			            // Path del Archivo
       cMaeAlu                              // Maestros habilitados
       cMaeAct                              // Maestro Activo
       cJorTxt                              // Jornada escogida
       lPrnArc                              // .T. Imprimir a Archivo
       cOpcPrn                              // Opciones de Impresi¢n
       lModReg                              // .T. Modificar el Registro
       lDelReg                              // .T. Borrar Registros
       lInsReg                              // .T. Insertar el Registro
       cAnoAnt                              // A¤o Anterior
       cUnoAnt                              // Path Integraci¢n Uno a¤o anterior */
*>>>>FIN DESCRIPCION DE PARAMETROS

*>>>>DECLARACION DE VARIABLES
       #INCLUDE "inkey.ch"                   // Declaraci¢n de teclas
       #INCLUDE "FILES.PRG"           // Archivos Compartidos

       LOCAL cSavPan := ''                  // Salvar Pantalla
       LOCAL cAnoSis := SUBS(cAnoUsr,3,2)   // A¤o del sistema
       LOCAL lHayErr := .F.                 // .T. Hay Error
       LOCAL PathUno := ''                  // Path de Integraci¢n Uno
       LOCAL PathDos := ''                  // Path de integraci¢n dos
       LOCAL PathTre := ''                  // Path de integraci¢n tres
       LOCAL PathCua := ''                  // Path de integraci¢n cuatro

       LOCAL oBrowse := NIL                 // Browse
*>>>>FIN DECLARACION DE VARIABLES

*>>>>AREAS DE TRABAJO
       aUseDbf := {}
       AADD(aUseDbf,{.T.,PathArc+'\'+FileCnt,'CNT',NIL,lShared,nModCry})
*>>>>FIN AREAS DE TRABAJO

*>>>>SELECION DE LAS AREAS DE TRABAJO
       IF !lUseDbfs(aUseDbf)
	  cError('ABRIENDO EL ARCHIVO CONTRANTES')
	  CloseDbf('CNT')
	  RETURN NIL
       ENDIF
*>>>>FIN SELECION DE LAS AREAS DE TRABAJO

*>>>>MANTENIMIENTO DEL ARCHIVO
       oBrowse := oBrwDbfCnt(lShared,cAnoUsr,nFilPal+1,00,22,79,;
			     lModReg,lDelReg,lInsReg)

       SETKEY(K_F5,{||BuscarCnt(oBrowse)})

       SETKEY(K_F9,{||MenuOtrCnt(lShared,nModCry,cNomSis,cEmpPal,cNitEmp,;
				 cNomEmp,cNomSec,nFilInf,nColInf,nFilPal,;
				 cNomUsr,cAnoUsr,PathArc,cMaeAlu,cMaeAct,;
				 cJorTxt,lPrnArc,cOpcPrn,oBrowse,cAnoAnt,;
				 cUnoAnt)})

       CNT->(CtrlBrw(lShared,oBrowse))
       SETKEY(K_F9,NIL)
       CloseDbf('CNT')
       RETURN NIL
*>>>>FIN MANTENIMIENTO DEL ARCHIVO

/*************************************************************************
* TITULO..: DEFINICION DEL OBJETO BROWSE                                 *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: SEP 22/2004 MIE A
       Colombia, Bucaramanga        INICIO: 10:50 PM   SEP 22/2004 MIE

OBJETIVOS:

1- Define el objeto Browse del archivo

SINTAXIS:


*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION oBrwDbfCnt(lShared,cAnoUsr,nFilSup,nColSup,nFilInf,nColInf,;
		    lModReg,lDelReg,lInsReg)

*>>>>PARAMETROS DE LA FUNCION
/*     lShared                              // .T. Archivos Compartidos
       cAnoUsr                              // A¤o del usuario
       nFilSup	                            // Fila Superior
       nColSup	                            // Columna Superior
       nFilInf	                            // Fila Inferior
       nColInf	                            // Columna Inferior
       lModReg                              // .T. Modificar el Registro
       lDelReg                              // .T. Borrar Registros
       lInsReg                              // .T. Insertar Registros */
*>>>>FIN PARAMETROS DE LA FUNCION

*>>>>DECLARACION DE VARIABLES
       LOCAL oColumn := NIL                 // Objeto Columna
       LOCAL oBrowse := NIL	            // Browse de Clientes
*>>>>FIN DECLARACION DE VARIABLES

*>>>>DEFINICION DEL OBJETO BROWSE
       oBrowse := TBROWSEDB(nFilSup+1,nColSup+1,nFilInf-1,nColInf-1)
      *Definici¢n de Objeto y asignaci¢n de las coordenadas

       oBrowse:ColSep    := '³'
       oBrowse:HeadSep   := 'Ä'

       lDelReg := IF(lDelReg==NIL,.F.,lDelReg)
       lInsReg := IF(lInsReg==NIL,.F.,lInsReg)

       IF lInsReg
	  oBrowse:Cargo := {'<< MANTENIMIENTO DE CONTRATANTES >>',;
			    '<ENTER>Modificar <F5>Buscar <INS>Incluir'+;
			    IF(lDelReg,' <DEL>Borrar','')+;
			    ' <F9>Otros <ESC>Abandonar',;
			    {||IncluirCnt(lShared)}}
       ELSE
	  oBrowse:Cargo := {'<< MANTENIMIENTO DE CONTRATANTES >>',;
			    '<ENTER>Modificar <F5>Buscar '+;
			    IF(lDelReg,' <DEL>Borrar','')+;
			    ' <F9>Otros <ESC>Abandonar'}
       ENDIF
     *ÀDefinici¢n de cabeceras y l¡neas de cabeceras

       lModReg := IF(EMPTY(lModReg),.F.,lModReg)
       lModReg := IF(lModReg .AND. CNT->(RECCOUNT())==0,.F.,lModReg)

       SELECT CNT
       oColumn	:= TBCOLUMNNEW('CODIGO;ESTUDIANTE',{||CNT->cCodigoEst})
       oColumn:Cargo := {{'MODI',.F.},{'ALIAS','CNT'},;
			 {'FIELD','cCodigoEst'},{'PICTURE','@!'}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn	     := TBCOLUMNNEW('DOCUMENTO;DEL CONTRATANTE',{||CNT->cDocNitPer})
       oColumn:Cargo := {{'MODI',lModReg},{'ALIAS','CNT'},;
			 {'FIELD','cDocNitPer'},{'PICTURE','@!'}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn	     := TBCOLUMNNEW('TIPO DE DOCUMENTO;DEL CONTRATANTE',{||CNT->cTipNitPer})
       oColumn:Cargo := {{'MODI',lModReg},{'ALIAS','CNT'},;
			 {'FIELD','cTipNitPer'},{'PICTURE','@!'}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn	     := TBCOLUMNNEW('NUMERO DEL;CONTRANTE',{||CNT->nNumeroCnt})
       oColumn:Cargo := {{'MODI',lModReg},{'ALIAS','CNT'},;
			 {'FIELD','nNumeroCnt'},{'PICTURE','9'}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn	:= TBCOLUMNNEW('A¥O DEL;CONTRATO',{||CNT->cAnoCntCnt})
       oColumn:Cargo := {{'MODI',lModReg},{'ALIAS','CNT'},;
			 {'FIELD','cAnoCntCnt'},{'PICTURE','@!'}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn	:= TBCOLUMNNEW('NO REPORTAR',{||CNT->lNoRepoCnt})
       oColumn:Cargo := {{'MODI',lModReg},{'ALIAS','CNT'},;
			 {'FIELD','lNoRepoCnt'},{'PICTURE','@!'}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn	:= TBCOLUMNNEW('FECHA DE;MATRICULA',{||CNT->dFecMatEst})
       oColumn:Cargo := {{'MODI',.F.},{'ALIAS','CNT'},;
			 {'FIELD','cCodigoEst'},{'PICTURE','@!'}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn	:= TBCOLUMNNEW('HORA DE;MATRICULA',{||CNT->cHorMatEst})
       oColumn:Cargo := {{'MODI',.F.},{'ALIAS','CNT'},;
			 {'FIELD','cHorMatEst'},{'PICTURE','@!'}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       RETURN oBrowse
*>>>>FIN DEFINICION DEL OBJETO BROWSE

/*************************************************************************
* TITULO..: INCLUSION DE REGISTROS                                       *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: SEP 22/2004 MIE A
       Colombia, Bucaramanga        INICIO: 10:55 PM   SEP 22/2004 MIE

OBJETIVOS:

1- Permite la inclusion de registros

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION IncluirCnt(lShared)

*>>>>PARAMETROS DE LA FUNCION
/*     lShared                              // .T. Archivos Compartidos */
*>>>>FIN PARAMETROS DE LA FUNCION

*>>>>DECLARACION DE CONSTANTES
       LOCAL       i := 0                   // Contador
       LOCAL nNroFil := 3                   // Fila de Lectura
       LOCAL nNroCol := 2                   // Columna de Lectura
       LOCAL lHayErr := .F.                 // .T. Hay Error
       LOCAL lGrabar := .F.                 // .T. Grabar
       LOCAL GetList := {}                  // Variable del sistema

       LOCAL cCodigoTes := ''               // C¢digo de Retenci¢n
       LOCAL cDocNitTpe := 0                // Valor Base de la Retefuente
       LOCAL cTipNitTpe := 0                // Porcentaje de Retenci¢n
       LOCAL nNumeroTcn := ''               // Nombre del Concepto
       LOCAL cAnoCntTcn := ''               // A¤o del Contrato
       LOCAL lNoRepoTcn := ''               // .T. No Reportar .F. Si Reportar
*>>>>FIN DECLARACION DE CONSTANTES

*>>>>LECTURA Y CONFIRMACION DEL REGISTRO
       SET CURSOR ON
       nNroFil := nMarco(nNroFil,'POR FAVOR INGRESE LOS '+;
				 'DATOS DEL CONTRATANTE',22,'°')

       DO WHILE .T.

**********INICIALIZACION DE LAS VARIABLES
	    IF !lHayErr
	       cCodigoTes := cSpaces('CNT','cCodigoEst')
	       cDocNitTpe := cSpaces('CNT','cDocNitPer')
	       cTipNitTpe := cSpaces('CNT','cTipNitPer')
	       nNumeroTcn := 0
	       cAnoCntTcn := cSpaces('CNT','cAnoCntCnt')
	       lNoRepoTcn := .F.
	    ENDIF
**********FIN INICIALIZACION DE LAS VARIABLES

**********LECTURA DEL REGISTRO
	    @ nNroFil,nNroCol   SAY 'CODIGO DEL ESTUDIANTE   :';
				GET cCodigoTes PICT '@!';
				VALID !EMPTY(cCodigoTes)

	    @ nNroFil+1,nNroCol SAY 'DOCUMENTO DE IDENTIFICACION :';
				GET cDocNitTpe PICT '@S40!';
				VALID !EMPTY(cDocNitTpe)

	    @ nNroFil+2,nNroCol SAY 'TIPO DE IDENTIFICACION:';
				GET cTipNitTpe  PICT '@!'

	    @ nNroFil+3,nNroCol SAY 'NUMERO DEL CONTRATANTE:';
				GET nNumeroTcn  PICT '9'

	    @ nNroFil+3,nNroCol SAY 'A¥O DEL CONTRATO:';
				GET cAnoCntTcn  PICT '9'

	    @ nNroFil+3,nNroCol SAY 'NO REPORTAR:';
				GET cAnoCntTcn  PICT '@!'

	    READ
**********FIN LECTURA DEL REGISTRO

**********VALIDACION DEL REGISTRO
	    IF cCodigoTes # cSpaces('CNT','cCodigoEst') .AND.;
	       nNumeroTcn # cSpaces('CNT','cNombreCnt') .AND.;
	       cDocNitTpe # 0 .AND. nNumeroTcn # 0
	       lGrabar := .T.
	    ELSE
	       lGrabar := .F.
	       cError('DEBE DAR LOS DATOS COMPLETOS. NO SE GRABA EL REGISTRO')
	    ENDIF
**********FIN VALIDACION DEL REGISTRO

**********PREGUNTA DE DECISION
	    IF lGrabar
	       IF lPregunta('DESEA GRABAR EL REGISTRO? Si No')
		  EXIT
	       ENDIF
	    ELSE
	       EXIT
	    ENDIF
**********PREGUNTA DE DECISION

       ENDDO
*>>>>FIN LECTURA Y CONFIRMACION DEL REGISTRO

*>>>>GRABACION DEL REGISTRO
       SELECT CNT
       IF lGrabar
	  IF CNT->(lRegLock(lShared,.T.))
	     REPL CNT->cCodigoEst WITH cCodigoTes
	     REPL CNT->cNombreCnt WITH nNumeroTcn
	     REPL CNT->nVlrBasCnt WITH cDocNitTpe
	     REPL CNT->nPorcenCnt WITH nNumeroTcn
	     CNT->(DBCOMMIT())
	  ENDIF
       ENDIF
       IF lShared
	  CNT->(DBUNLOCK())
       ENDIF
       RETURN NIL
*>>>>FIN GRABACION DEL CAMPO

/*************************************************************************
* TITULO..: VALIDACION DE EXISTENCIA DEL CODIGO                          *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: SEP 22/2004 MIE A
       Colombia, Bucaramanga        INICIO: 11:00 PM   SEP 22/2004 MIE

OBJETIVOS:

1- Debe estar en uso el archivo.

2- Realiza la validaci¢n de existencia del C¢digo.

3- Retorna .T. si hay problemas

SINTAXIS:


*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION lValCodCnt(cCodigo)

*>>>>PARAMETROS DE LA FUNCION
/*     cCodigo			            // C¢digo a Validar */
*>>>>FIN PARAMETROS DE LA FUNCION

*>>>>DECLARACION DE VARIABLES
       LOCAL lHayErr := .F.                 // .T. Hay Error
*>>>>FIN DECLARACION DE VARIABLES

*>>>>VALIDACION DEL CODIGO DEL BANCO
       IF cCodigo # cSpaces('CNT','cCodigoEst')
	  IF lLocCodigo('cCodigoEst','CNT',cCodigo)
	     cError('ESTE CODIGO YA EXISTE')
	     lHayErr := .T.
	  ENDIF
       ENDIF
       RETURN lHayErr
*>>>>FIN VALIDACION DEL CODIGO DEL BANCO

/*************************************************************************
* TITULO..: BUSQUEDA DEL CODIGO                                          *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: SEP 22/2004 MIE A
       Colombia, Bucaramanga        INICIO: 11:05 PM   SEP 22/2004 MIE

OBJETIVOS:

1- Permite localizar un c¢digo dentro del archivo.

2- Retorna NIL

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION BuscarCnt(oBrowse)

*>>>>PARAMETROS DE LA FUNCION
/*     oBrowse			            // Browse del Archivo */
*>>>>FIN PARAMETROS DE LA FUNCION

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
       cCodigo := cSpaces('CNT','cCodigoEst')
       TitBuscar(LEN(cCodigo),@nNroFil,@nNroCol)
       @ nNroFil,nNroCol GET cCodigo PICT '@!';
			 VALID lValCnt(ROW(),COL()-3,@cCodigo)
       READ
*>>>>FIN CAPTURA DEL CODIGO

*>>>>VALIDACION DEL CODIGO
       IF cCodigo == cSpaces('CNT','cCodigoEst')
	  cError('PATRON DE BUSQUEDA NO ESPECIFICADO',;
		  'ADVERTENCIA')
	  lBuscar := .F.
       ENDIF
*>>>>FIN VALIDACION DEL CODIGO

*>>>>BUSQUEDA DEL CODIGO
       SELECT CNT
       IF lBuscar .AND. lLocCodigo('cCodigoEst','CNT',cCodigo)
	  nNroReg := RECNO()
	  GO TOP
	  oBrowse:GOTOP()
	  GO nNroReg
	  oBrowse:FORCESTABLE()
       ELSE
	  oBrowse:GOTOP()
       ENDIF
       RETURN NIL
*>>>>FIN BUSQUEDA DEL CODIGO

/*************************************************************************
* TITULO..: VALIDACION DEL CODIGO                                        *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: SEP 22/2004 MIE A
       Colombia, Bucaramanga        INICIO: 11:10 PM   SEP 22/2004 MIE

OBJETIVOS:

1- Debe estar en uso el archivo

2- Realiza la validaci¢n del c¢digo

3- Retorna .T. si hay problemas

SINTAXIS:


*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION lValCnt(nNroFil,nNroCol,cCodigo)

*>>>>PARAMETROS DE LA FUNCION
/*     nNroFil                              // Fila de lectura
       nNroCol                              // Columna de lectura
       cCodigo			            // C¢digo a Validar */
*>>>>FIN PARAMETROS DE LA FUNCION

*>>>>DECLARACION DE VARIABLES
       LOCAL nNroReg := 0                   // N£mero del Registro
*>>>>FIN DECLARACION DE VARIABLES

*>>>>VALIDACION DEL CODIGO
       IF !lLocCodigo('cCodigoEst','CNT',cCodigo)
	  nNroReg := nSelCnt(nNroFil,nNroCol)
	  IF nNroReg == 0
	     cCodigo := cSpaces('CNT','cCodigoEst')
	  ELSE
	     GO nNroReg
	     cCodigo := CNT->cCodigoEst
	  ENDIF
       ENDIF
       RETURN .T.
*>>>>FIN VALIDACION DEL CODIGO

/*************************************************************************
* TITULO..: SELECCION DEL CODIGO                                         *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: SEP 22/2004 MIE A
       Colombia, Bucaramanga        INICIO: 11:15 PM   SEP 22/2004 MIE

OBJETIVOS:

1- Debe estar en uso el archivo

2- Permite escoger el registro de acuerdo al c¢digo o descripci¢n

3- Retorna el n£mero del registro escogido

SINTAXIS:

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION nSelCnt(nNroFil,nNroCol)

*>>>>PARAMETROS DE LA FUNCION
/*     nNroFil                              // N£mero de la fila
       nNroCol                              // N£mero de la Columna */
*>>>>FIN PARAMETROS DE LA FUNCION

*>>>>DECLARACION DE VARIABLES
       LOCAL cSavPan := ''                  // Salvar Pantalla
       LOCAL nFilSup := 0                   // Fila superior
       LOCAL nColSup := 0                   // Colunma superior
       LOCAL nFilInf := 0                   // Fila inferior
       LOCAL nColInf := 0                   // Columna inferior
       LOCAL nNroReg := 0		    // Registro del Banco
*>>>>FIN DECLARACION DE VARIABLES

*>>>>VALIDACION DE CONTENIDOS DE ARCHIVOS
       IF CNT->(RECCOUNT()) == 0
	  cError('NO EXISTEN CONTRATANTES GRABADOS')
	  RETURN 0
       ENDIF
*>>>>FIN VALIDACION DE CONTENIDOS DE ARCHIVOS

*>>>>INICIALIZACION DE LAS COORDENADAS
	SELECT CNT
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
       CNT->(DBGOTOP())
       cSavPan := SAVESCREEN(0,0,24,79)
       @ nFilSup-1,nColSup-1 TO nFilInf,nColInf+1 DOUBLE
       nNroReg := nBrowseDbf(nFilSup,nColSup,nFilInf-1,nColInf,;
			     {||CNT->cDocNitPer})
       RESTSCREEN(0,0,24,79,cSavPan)
       RETURN nNroReg
*>>>>FIN SELECCION DEL CODIGO

/*************************************************************************
* TITULO..: MENU DE OTROS PARA EL ARCHIVO                                *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: SEP 22/2004 MIE A
       Colombia, Bucaramanga        INICIO: 11:20 PM   SEP 22/2004 MIE

OBJETIVOS:

1- Menu de Otros para el archivo

2- Retorna NIL

SINTAXIS:

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION MenuOtrCnt(lShared,nModCry,cNomSis,cEmpPal,cNitEmp,;
		    cNomEmp,cNomSec,nFilInf,nColInf,nFilPal,;
		    cNomUsr,cAnoUsr,PathArc,cMaeAlu,cMaeAct,;
		    cJorTxt,lPrnArc,cOpcPrn,oBrowse,cAnoAnt,;
		    cUnoAnt)

*>>>>DESCRIPCION DE PARAMETROS
/*     lShared                              // .T. Sistema Compartido
       nModCry                              // Modo de Protecci¢n
       cNomSis                              // Nombre del Sistema
       cEmpPal                              // Nombre de la Empresa principal
       cNitEmp                              // Nit de la Empresa
       cNomEmp                              // Nombre de la Empresa
       cNomSec                              // Nombre de la Empresa Secundario
       nFilInf                              // Fila Inferior del SubMen£
       nColInf                              // Columna Inferior del SubMen£
       nFilPal                              // Fila Inferior Men£ principal
       cNomUsr                              // Nombre del Usuario
       cAnoUsr                              // A¤o del usuario
       PathArc			            // Path del Archivo
       cMaeAlu                              // Maestros habilitados
       cMaeAct                              // Maestro Activo
       cJorTxt                              // Jornada escogida
       lPrnArc                              // .T. Imprimir a Archivo
       cOpcPrn                              // Opciones de Impresi¢n
       oBrowse                              // Browse del Archivo
       cAnoAnt                              // A¤o Anterior
       cUnoAnt                              // Path Integraci¢n Uno a¤o anterior */
*>>>>FIN DESCRIPCION DE PARAMETROS

*>>>>DECLARACION DE VARIABLES
       LOCAL cSavPan := ''                  // Salvar Pantalla
       LOCAL cAnoSis := SUBS(cAnoUsr,3,2)   // A¤o del sistema
       LOCAL lHayErr := .F.                 // .T. Hay Error
       LOCAL cIntUno := ''                  // Path de integraci¢n uno
       LOCAL cIntDos := ''                  // Path de integraci¢n dos
       LOCAL cIntTre := ''                  // Path de integraci¢n tres
       LOCAL cIntCua := ''                  // Path de integraci¢n cuatro

       LOCAL aMenus  := {}                  // Vector de declaracion de men£
       LOCAL aAyuda  := {}                  // Vector de ayudas para el men£
       LOCAL nNroOpc := 1                   // Numero de la opcion

       LOCAL GetList := {}                  // Variable del Sistema
*>>>>FIN DECLARACION DE VARIABLES

*>>>>DECLARACION Y EJECUCION DEL MENU
       AADD(aMenus,'1<INFORME DE CONTRATANTES>')
       IF MTR->lModCntMtr
	  AADD(aMenus,'2<GRABAR CONTRATATES     >')
       ENDIF

       AADD(aAyuda,'Imprime la relaci¢n de Contratantes')
       IF MTR->lModCntMtr
	  AADD(aAyuda,'Permite grabar los mismos contrantes del a¤o anterior')
       ENDIF
*>>>>FIN DECLARACION Y EJECUCION DEL MENU

*>>>>EJECUCION DEL MENU
       cSavPan := SAVESCREEN(0,0,24,79)
       nNroOpc := nMenu(aMenus,aAyuda,10,25,NIL,NIL,1,.F.)
       RESTSCREEN(0,0,24,79,cSavPan)
       IF nNroOpc == 0
	  RETURN NIL
       ENDIF
*>>>>FIN EJECUCION DEL MENU

*>>>>ANALISIS DE OPCION ESCOGIDA
       DO CASE
       CASE nNroOpc == 1
	    OtrCnt011(lShared,nModCry,cNomSis,cEmpPal,cNitEmp,;
		      cNomEmp,cNomSec,nFilInf,nColInf,nFilPal,;
		      cNomUsr,cAnoUsr,PathArc,cMaeAlu,cMaeAct,;
		      cJorTxt,lPrnArc,cOpcPrn,oBrowse)
	   *Impresi¢n de los Contratantes

       CASE nNroOpc == 2
	    OtrCnt012(lShared,nModCry,cNomSis,cEmpPal,cNitEmp,;
		      cNomEmp,cNomSec,nFilInf,nColInf,nFilPal,;
		      cNomUsr,cAnoUsr,PathArc,cMaeAlu,cMaeAct,;
		      cJorTxt,lPrnArc,cOpcPrn,oBrowse,cAnoAnt,;
		      cUnoAnt)
	   *Grabar contratantes a¤o anterior

       ENDCASE
       RETURN NIL
*>>>>FIN ANALISIS DE OPCION ESCOGIDA

/*************************************************************************
* TITULO..: IMPRESION CAMPOS DEL MANTENIMIENTO                           *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: SEP 22/2004 MIE A
       Colombia, Bucaramanga        INICIO: 11:25 PM   SEP 22/2004 MIE

OBJETIVOS:

1- Imprime los campos del archivo de mantenimiento

2- Retorna NIL

SINTAXIS:


*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION OtrCnt011(lShared,nModCry,cNomSis,cEmpPal,cNitEmp,;
		    cNomEmp,cNomSec,nFilInf,nColInf,nFilPal,;
		    cNomUsr,cAnoUsr,PathArc,cMaeAlu,cMaeAct,;
		    cJorTxt,lPrnArc,cOpcPrn,oBrowse)

*>>>>DESCRIPCION DE PARAMETROS
/*     lShared                              // .T. Sistema Compartido
       nModCry                              // Modo de Protecci¢n
       cNomSis                              // Nombre del Sistema
       cEmpPal                              // Nombre de la Empresa principal
       cNitEmp                              // Nit de la Empresa
       cNomEmp                              // Nombre de la Empresa
       cNomSec                              // Nombre de la Empresa Secundario
       nFilInf                              // Fila Inferior del SubMen£
       nColInf                              // Columna Inferior del SubMen£
       nFilPal                              // Fila Inferior Men£ principal
       cNomUsr                              // Nombre del Usuario
       cAnoUsr                              // A¤o del usuario
       PathArc			            // Path del Archivo
       cMaeAlu                              // Maestros habilitados
       cMaeAct                              // Maestro Activo
       cJorTxt                              // Jornada escogida
       lPrnArc                              // .T. Imprimir a Archivo
       cOpcPrn                              // Opciones de Impresi¢n
       oBrowse                              // Browse del Archivo */
*>>>>FIN DESCRIPCION DE PARAMETROS

*>>>>DECLARACION DE VARIABLES
       #INCLUDE "FILES.PRG"           // Archivos Compartidos

       LOCAL lHayErr := .F.                 // .T. Hay Error
       LOCAL cSavPan := ''                  // Salvar Pantalla
     *ÀVariables generales

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

*>>>>VALIDACION DE CONTENIDOS DE ARCHIVOS
       lHayErr := .T.
       DO CASE
       CASE CNT->(RECCOUNT()) == 0
	    cError('NO EXISTEN CONTRATANTES GRABADOS')

       OTHERWISE
	    lHayErr :=.F.
       ENDCASE
       IF lHayErr
	  RETURN NIL
       ENDIF
*>>>>FIN VALIDACION DE CONTENIDOS DE ARCHIVOS

*>>>>DEFINCION DEL ENCABEZADO
       nNroPag := 0
       lTamAnc := .F.

       nTotReg := 0

       aCabPrn := {cNomEmp,cNomSis,;
		   'A¥O: '+cAnoUsr+' JORNADA: '+cJorTxt,;
		   'CONTRANTES DE LOS ESTUDIANTES',;
		   ''}

       aCabeza := {aCabPrn[1],aCabPrn[2],aCabPrn[3],aCabPrn[4],aCabPrn[5],;
		   nNroPag++,;
		   cTotPagina(nTotReg),lTamAnc}

       cCodIni := PCL({'DraftOn','Elite','CondenOn'})
       cCodFin := PCL({'NegraOf','DobGolOf'})
*>>>>FIN DEFINCION DEL ENCABEZADO


*>>>>ENCABEZADOS DE COLUMNA
       aNroCol := {06,16,04,04}
       aTitPrn := {'CODIGO','DOCUMENTO','TIPO','NRO'}
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
	  FilePrn := 'Cnt'
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

       SELECT CNT
       CNT->(DBGOTOP())
       DO WHILE .NOT. CNT->(EOF())

**********VISUALIZACION DE AVANCE
	    nAvance := INT(( CNT->(RECNO()) / CNT->(RECCOUNT()) )*100)

	    IF STR(nAvance,3) $ '25 50 75100'
	       SET DEVICE TO SCREEN
	       Termometro(nAvance)
	       SET DEVICE TO PRINT
	    ENDIF
**********FIN VISUALIZACION DE AVANCE

**********IMPRESION DEL REGISTRO
	    aRegPrn := {}
	    AADD(aRegPrn,CNT->cCodigoEst)
	    AADD(aRegPrn,CNT->cDocNitPer)
	    AADD(aRegPrn,CNT->cTipNitPer)
	    AADD(aRegPrn,STR(CNT->nNumeroCnt,1))

	    lPrnOpc(lShared,nOpcPrn,FilePrn,nHanXml,01,nColCab,;
		    aTitPrn,aRegPrn,aNroCol,bPagina,bDerAut,bCabeza)
**********FIN IMPRESION DEL REGISTRO

**********AVANCE DEL SIGUIENTE REGISTRO
	    SELECT CNT
	    CNT->(DBSKIP())
	    IF CNT->(EOF())
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

/*************************************************************************
* TITULO..: GRABACION DE LOS CONTRATANTES DEL A¥O ANTERIOR               *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: OCT 22/2005 JUE A
       Colombia, Bucaramanga        INICIO: 11:30 AM   OCT 22/2005 JUE

OBJETIVOS:

1- Graba los contratantes del a¤o anterior

2- Retorna NIL


*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION OtrCnt012(lShared,nModCry,cNomSis,cEmpPal,cNitEmp,;
		    cNomEmp,cNomSec,nFilInf,nColInf,nFilPal,;
		    cNomUsr,cAnoUsr,PathArc,cMaeAlu,cMaeAct,;
		    cJorTxt,lPrnArc,cOpcPrn,oBrowse,cAnoAnt,;
		    cUnoAnt)

*>>>>DESCRIPCION DE PARAMETROS
/*     lShared                              // .T. Sistema Compartido
       nModCry                              // Modo de Protecci¢n
       cNomSis                              // Nombre del Sistema
       cEmpPal                              // Nombre de la Empresa principal
       cNitEmp                              // Nit de la Empresa
       cNomEmp                              // Nombre de la Empresa
       cNomSec                              // Nombre de la Empresa Secundario
       nFilInf                              // Fila Inferior del SubMen£
       nColInf                              // Columna Inferior del SubMen£
       nFilPal                              // Fila Inferior Men£ principal
       cNomUsr                              // Nombre del Usuario
       cAnoUsr                              // A¤o del usuario
       PathArc			            // Path del Archivo
       cMaeAlu                              // Maestros habilitados
       cMaeAct                              // Maestro Activo
       cJorTxt                              // Jornada escogida
       lPrnArc                              // .T. Imprimir a Archivo
       cOpcPrn                              // Opciones de Impresi¢n
       oBrowse                              // Browse del Archivo
       cAnoAnt                              // A¤o Anterior
       cUnoAnt                              // Path Integraci¢n Uno a¤o anterior */
*>>>>FIN DESCRIPCION DE PARAMETROS

*>>>>DECLARACION DE VARIABLES
       LOCAL cSavPan := ''                  // Salvar Pantalla
       LOCAL lHayErr := .F.                 // .T. Hay Error

       LOCAL       i := 0                   // Contador
       LOCAL cCabeza := ''                  // Encabezado de columna
       LOCAL nNroFil := 0                   // N£mero de la fila
       LOCAL aNroCol := {}                  // Numeros de Columna

       LOCAL GetList := {}                  // Variable del Sistema

       LOCAL cCodigoTes := ''               // C¢digo del Estudiante
*>>>>FIN DECLARACION DE VARIABLES

*>>>>SELECION DE LAS AREAS DE TRABAJO
       cSavPan := SAVESCREEN(0,0,24,79)
       cMaeAct := cNivelEst(10,20,cMaeAlu)
       IF !lUseMae(lShared,cUnoAnt,cMaeAct,SUBS(cAnoAnt,3,2),.F.)
	  cError('ABRIENDO ARCHIVOS')
	  CloseDbf(cMaeAct)
	  RETURN NIL
       ENDIF
*>>>>FIN SELECION DE LAS AREAS DE TRABAJO

*>>>>VALIDACION DE CONTENIDOS DE ARCHIVOS
       SELECT &cMaeAct

       lHayErr := .T.
       DO CASE
       CASE RECCOUNT() == 0
	    cError('NO EXISTEN ESTUDIANTES MATRICULADOS')

       OTHERWISE
	    lHayErr :=.F.
       ENDCASE
       IF lHayErr
	  CloseDbf(cMaeAct)
	  RETURN NIL
       ENDIF
*>>>>FIN VALIDACION DE CONTENIDOS DE ARCHIVOS

*>>>>IMPRESION DE LOS ENCABEZADOS
       nNroFil := nMarco(3,NIL,NIL,'°')
       cCabeza := cRegPrint({'CODIGO',;
			     'GRUPO',;
			     'CONTRATANTE',;
			     'DOCUMENTO',;
			     'OBSERVACION'},;
			    {06,06,12,16,12},@aNroCol)
       @ nNroFil-2,01 SAY cCabeza
*>>>>FIN IMPRESION DE LOS ENCABEZADOS

*>>>>RECORRIDOS POR ESTUDIANTES
       SELECT &cMaeAct
       DBGOTOP()
       DO WHILE .NOT. EOF()

**********GRABACION DE LOS CONTRATANTES
	    SELECT &cMaeAct
	    FOR i := 1 TO 4

*===============NUMERO DEL CONTRATANTE
		  @ nNroFil,aNroCol[1] SAY &cMaeAct->cCodigoEst
		  @ nNroFil,aNroCol[2] SAY &cMaeAct->cCodigoGru
		  @ nNroFil,aNroCol[3] SAY 'No. '+STR(i,1)
*===============FIN NUMERO DEL CONTRATANTE

*===============CONTRATANTE NO DEFINIDO
		  IF EMPTY(&(cMaeAct+'->cNitCo'+STR(i,1)+'Est'))
		     @ nNroFil,aNroCol[5] SAY 'NO DEFINIDO'
		  ENDIF
*===============FIN CONTRATANTE NO DEFINIDO

*===============GRABACION DEL CONTRATANTE
		  IF !EMPTY(&(cMaeAct+'->cNitCo'+STR(i,1)+'Est'))

*:::::::::::::::::::::LOCALIZACION DEL CONTRATANTE
			cCodigoTes := &cMaeAct->cCodigoEst
			SELECT CNT
			CNT->(DBGOTOP())
			LOCATE FOR CNT->cCodigoEst == cCodigoTes .AND.;
				   CNT->nNumeroCnt == i
			IF .NOT. FOUND()

			   IF CNT->(lRegLock(lShared,.T.))

			      REPL CNT->cCodigoEst WITH cCodigoTes
			      REPL CNT->cDocNitPer WITH &(cMaeAct+'->cNitCo'+STR(i,1)+'Est')
			      REPL CNT->cTipNitPer WITH &(cMaeAct+'->cTipCo'+STR(i,1)+'Est')
			      REPL CNT->nNumeroCnt WITH i
			      REPL CNT->cAnoCntCnt WITH STR(VAL(cAnoAnt)+1,4)

			      CNT->(DBCOMMIT())
			      @ nNroFil,aNroCol[4] SAY CNT->cDocNitPer COLOR('I')
			      @ nNroFil,aNroCol[5] SAY 'GRABADO' COLOR('I')
			   ELSE
			      cError('NO SE GRABA NIVEL')
			   ENDIF

			   IF lShared
			      CNT->(DBUNLOCK())
			   ENDIF

			ELSE
			   @ nNroFil,aNroCol[4] SAY CNT->cDocNitPer
			   @ nNroFil,aNroCol[5] SAY 'YA DEFINIDO'
			ENDIF
*:::::::::::::::::::::FIN LOCALIZACION DEL CONTRATANTE

		  ENDIF
*===============FIN GRABACION DEL CONTRATANTE

*===============CONTROL DE LA FILA DE VISUALIZACION
		  nNroFil++
		  IF nNroFil > 20

		     nNroFil := nMarco(3,NIL,NIL,'°')
		     @ nNroFil-2,01 SAY cCabeza
		     nNroFil++

		  ENDIF
*===============FIN CONTROL DE LA FILA DE VISUALIZACION

	  ENDFOR
**********FIN GRABACION DE LOS CONTRATANTES

	  SELECT &cMaeAct
	  DBSKIP()

       ENDDO


       CloseDbf(cMaeAct)

       RESTSCREEN(0,0,24,79,cSavPan)
       SELECT CNT
       CNT->(DBGOTOP())
       oBrowse:GOTOP()
       oBrowse:FORCESTABLE()
       RETURN NIL
*>>>>FIN RECORRIDOS POR ESTUDIANTES


/*************************************************************************
* TITULO..: LOCALIZAR EL CONTRATANTE                                     *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: SEP 28/2004 MAR A
       Colombia, Bucaramanga        INICIO: 04:00 PM   SEP 28/2004 MAR

1- Localiza el registro del contratante

2- Retorna .T. si localiz¢ el registro.

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION lLocNroCnt(cCodEst,nNroCnt)

*>>>>PARAMETROS DE LA FUNCION
/*     cCodEst			            // C¢digo del Estudiante
       nNroCnt                              // N£mero del Contrante */
*>>>>FIN PARAMETROS DE LA FUNCION

*>>>>DECLARACION DE VARIABLES
       LOCAL lExiste := .T.                 // .T. Existe el c¢digo
*>>>>FIN DECLARACION DE VARIABLES

*>>>>LOCALIZACION DEL CODIGO
       SELECT CNT
       DBGOTOP()
       LOCATE FOR CNT->cCodigoEst == cCodEst .AND.;
		  CNT->nNumeroCnt == nNroCnt

       IF .NOT. FOUND()
	  lExiste := .F.
       ENDIF
       RETURN lExiste
*>>>>FIN LOCALIZACION DEL CODIGO

/*************************************************************************
* TITULO..: LOCALIZAR LOS CONTRATANTES                                   *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: SEP 16/2004 JUE A
       Colombia, Bucaramanga        INICIO: 04:00 PM   SEP 16/2004 JUE

OBJETIVOS:

1- Permite localizar todos los contratantes del estudiante.

2- Retorna un vector con los nombres de los contratantes.

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION aLocAllCnt(cMaeAct)

*>>>>DESCRIPCION DE PARAMETROS
/*     cMaeAct                              // Maestro Actual */
*>>>>FIN DESCRIPCION DE PARAMETROS

*>>>>DECLARACION DE VARIABLES
       LOCAL       i := 0                   // Contador
       LOCAL cDocNit := ''                  // Documento del Contrante
       LOCAL cTipNit := ''                  // Tipo de Documento
       LOCAL cLugDoc := ''                  // Lugar del Documento
       LOCAL cNombre := ''                  // Nombres
       LOCAL cApelli := ''                  // Apellidos
       LOCAL lHayFot := .F.                 // Hay Fotocopia

       LOCAL nTipPer := 0                   // Tipo de Persona
       LOCAL aDatCnt := {}                  // Datos del Contratante
*>>>>FIN DECLARACION DE VARIABLES

*>>>>RECORRIDO POR LOS CONTRATANTES
       FOR i := 1 TO 4

***********LOCALIZACION DEL CONTRATANTE
	     IF !lLocNroCnt(&cMaeAct->cCodigoEst,i)
		LOOP
	     ENDIF
	     cDocNit := CNT->cDocNitPer
	     cTipNit := CNT->cTipNitPer
***********FIN LOCALIZACION DEL CONTRATANTE

***********ANALISIS DEL CONTRATANTE
	     nTipPer := nTipPerMae(cDocNit,;
				   &cMaeAct->cPadNitEst,;
				   &cMaeAct->cMadNitEst)
***********FIN ANALISIS DEL CONTRATANTE

**********LECTURA DATOS DE LOS CONTRATANTES
	    DO CASE
	    CASE nTipPer == 1  // Padre

		 cNombre := ALLTRIM(&cMaeAct->cNomPadEst)
		 cApelli := ALLTRIM(&cMaeAct->cApePadEst)
		 cLugDoc := ALLTRIM(&cMaeAct->cPadLugEst)
		 lHayFot := &cMaeAct->lPadFotEst

	    CASE nTipPer == 2  // Madre

		 cNombre := ALLTRIM(&cMaeAct->cNomMadEst)
		 cApelli := ALLTRIM(&cMaeAct->cApeMadEst)
		 cLugDoc := ALLTRIM(&cMaeAct->cMadLugEst)
		 lHayFot := &cMaeAct->lMadFotEst

	    CASE nTipPer == 3  // Otra Persona

		 IF lLocNitPer(cDocNit,cTipNit)

		    cNombre := ALLTRIM(PER->cNomUnoPer)+' '+;
			       ALLTRIM(PER->cNomDosPer)

		    cApelli := ALLTRIM(PER->cApeUnoPer)+' '+;
			       ALLTRIM(PER->cApeDosPer)

		    cLugDoc := ALLTRIM(PER->cLugNitPer)

		    lHayFot := PER->lFotNitPer

		 ENDIF
	    ENDCASE
**********FIN LECTURA DATOS DE LOS CONTRATANTES

**********GRABACION DEL CONTRATANTE
	    IF !EMPTY(cDocNit)
	       cNombre := ALLTRIM(cNombre+' '+ALLTRIM(cApelli))
	       AADD(aDatCnt,{STR(i,1),;
			     ALLTRIM(cDocNit),;
			     cTipNit,;
			     cNombre,;
			     cLugDoc,;
			     lHayFot})
	    ENDIF
**********FIN GRABACION DEL CONTRATANTE

       NEXT
       RETURN aDatCnt
*>>>>FIN RECORRIDO POR LOS CONTRATANTES

/*************************************************************************
* TITULO..: LOCALIZAR LOS CONTRATANTES                                   *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: SEP 16/2004 JUE A
       Colombia, Bucaramanga        INICIO: 04:00 PM   SEP 16/2004 JUE

OBJETIVOS:

1- Permite localizar todos los contratantes del estudiante.

2- Retorna un vector con los nombres de los contratantes.

SINTAXIS:

cLocCntrt(cMaeAct,'C1DOC')  // C1DOC,C1TIP,C1NOM

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION cLocateCnt(cMaeAct,cCampo,aDatCnt,lHayFot)

*>>>>DESCRIPCION DE PARAMETROS
/*     cMaeAct                              // Maestro Habilitado
       cCampo                               // Campo del Contratante
       aDatCnt                              // Datos del Contratante
       lHayFot                              // @ .T. Hay Fotocopia */
*>>>>FIN DESCRIPCION DE PARAMETROS

*>>>>DECLARACION DE VARIABLES
       LOCAL       i := 1                   // Contador
       LOCAL cDatCnt := ''                  // Dato del Contratante
       LOCAL nNroCnt := 0                   // N£mero del Contrante
       LOCAL nNroCol := 0                   // N£mero de Columna
*>>>>FIN DECLARACION DE VARIABLES

*>>>>LOCALIZACION DE LOS DATOS DEL CONTRATANTE
       IF aDatCnt == NIL
	  aDatCnt := aLocAllCnt(cMaeAct)
	  IF EMPTY(aDatCnt)
	     RETURN ''
	  ENDIF
       ENDIF
*>>>>FIN LOCALIZACION DE LOS DATOS DEL CONTRATANTE

*>>>>ANALISIS DEL CONTRATANTE
       nNroCnt := SUBS(cCampo,2,1)
       DO CASE
       CASE 'DOC' $ cCampo
	    nNroCol := 2

       CASE 'TIP' $ cCampo
	    nNroCol := 3

       CASE 'NOM' $ cCampo
	    nNroCol := 4

       CASE 'LUG' $ cCampo
	    nNroCol := 5

       ENDCASE
*>>>>FIN ANALISIS DEL CONTRATANTE

*>>>>BUSQUEDA DEL CONTRANTE
       lHayFot := .F.
       FOR i := 1 TO LEN(aDatCnt)
	   IF aDatCnt[i,1] == nNroCnt .AND. nNroCol # 0
	      cDatCnt := aDatCnt[i,nNroCol]
	      lHayFot := aDatCnt[i,6]
	   ENDIF
       NEXT
       RETURN cDatCnt
*>>>>FIN BUSQUEDA DEL CONTRANTE