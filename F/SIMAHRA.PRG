/*                       SIMA - CONTABILIDAD ACADEMICA
		 BIBLIOTECAS DE FUNCIONES PARA EL ARCHIVO HORAS

REQUERIMIENTOS:

- Compilar: clipper FuncsHra /w/m/b

OBJETIVOS:

- Funciones aplicadas para el archivo de Horas

FUNCIONES:


***************************************************************************
*-------------------- DECLARACION DE LAS FUNCIONES -----------------------*
**************************************************************************/

/*************************************************************************
* TITULO..: CREACION DE LA ESTRUCTURA                                    *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: FEB 02/2000 MIE A
       Colombia, Bucaramanga        INICIO: 12:30 AM   FEB 02/2000 MIE

OBJETIVOS:

1- Crea la estructura del archivo

2- Retorna NIL

SINTAXIS:

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION CreaDbfHra(lShared,nModCry,PathArc,fArchvo,aStrDbf)

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
       AADD(aDbfStr,{'cCodigoHra','Character',02,0}) // C¢digo de la Hora
       AADD(aDbfStr,{'cNombreHra','Character',20,0}) // Descripci¢n de la Hora
       AADD(aDbfStr,{'cHorIniHra','Character',08,0}) // Hora Inicial
       AADD(aDbfStr,{'cHorFinHra','Character',08,0}) // Hora Final
       AADD(aDbfStr,{'lHraClaHra','Logical'  ,01,0}) // .T. Hora de Clase
*>>>>FIN DECLARACION DE LA ESTRUCTURA

*>>>>RETORNO DE LA ESTRUCTURA
       IF !EMPTY(aStrDbf)
	  aStrDbf := aDbfStr
	  RETURN NIL
       ENDIF
*>>>>FIN RETORNO DE LA ESTRUCTURA

*>>>>CREACION DE LA ESTRUCTURA
       PathAct := cPathAct()
       DO CASE
       CASE DIRCHANGE(PathArc) == 0
	    DBCREATE(fArchvo,aDbfStr,"DBFNTX")

       CASE DIRCHANGE(PathArc) == -3
	    cError('NO EXISTE EL DIRECTORIO: '+PathArc)

       CASE DIRCHANGE(PathArc) == -5
	    cError('NO TIENE DERECHOS EN: '+PathArc)
       ENDCASE
       DIRCHANGE(PathAct)
       RETURN NIL
*>>>>FIN CREACION DE LA ESTRUCTURA

/*************************************************************************
* TITULO..: RECUPERACION DE LA ESTRUCTURA                                *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: FEB 02/2000 MIE A
       Colombia, Bucaramanga        INICIO: 12:30 AM   FEB 02/2000 MIE

OBJETIVOS:

1- Recupera la estructura del archivo

2- Retorna NIL

SINTAXIS:


*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION RecuDbfHra(lShared,nModCry,PathArc,fArchvo)

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
       CreaDbfHra(lShared,nModCry,PathArc,fArchvo)
       RESTORE SCREEN
       RETURN NIL
*>>>>FIN RECUPERA LA ESTRUCTURA DEL ARCHIVO

/*************************************************************************
* TITULO..: ACTUALIZACION DE LA ESTRUCTURA                               *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: NOV 04/99 JUE A
       Colombia, Bucaramanga        INICIO: 03:00 PM   NOV 04/99 JUE

OBJETIVOS:

1)- Actualiza la Estructura del Archivo

2)- Retorna el N£mero de Error:
    0 => No hay Error
	 Estructura Actualizada
	 Estructura Sin problemas
    1 => Estructura No Actualizada

SINTAXIS:


*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION nActStrHra(lShared,nModCry,PathArc,cNomArc)

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
       CreaDbfHra(lShared,nModCry,PathArc,cNomArc,@aStrNew)
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
			 {||CreaDbfHra(lShared,nModCry,PathArc,FileTem)})
	     cError('NO SE ACTUALIZO LA ESTRUCTURA DEL ARCHIVO')
	     nNroErr := 1
	  ENDIF
	  RESTSCREEN(0,0,24,79,cSavPan)
       ENDIF
       RETURN nNroErr
*>>>>FIN ACTUALIZACION DE LA ESTRUCTURA

/*************************************************************************
* TITULO..: MANTENIMIENTO DEL ARCHIVO          	                         *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: FEB 02/2000 MIE A
       Colombia, Bucaramanga        INICIO: 12:30 AM   FEB 02/2000 MIE

OBJETIVOS:

1- Permite el mantenimiento del archivo

2- Se debe pasar el directorio completo de archivo

3- Retorn NIL

SINTAXIS:


*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION MantenHra(lShared,nModCry,cNomSis,cEmpPal,cNitEmp,cNomEmp,;
		   cNomSec,nFilInf,nColInf,nFilPal,cNomUsr,cAnoUsr,;
		   cPatSis,cMaeAlu,cMaeAct,cJorTxt,lModReg,cPatCon)

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
       cPatSis                              // Path del sistema
       cMaeAlu                              // Maestros habilitados
       cMaeAct                              // Maestro Activo
       cJorTxt                              // Jornada escogida
       lModReg                              // .T. Modificar el Registro
       cPatCon                              // Path de la Contabilidad */
*>>>>FIN DESCRIPCION DE PARAMETROS

*>>>>DECLARACION DE VARIABLES
       #INCLUDE "inkey.ch"                  // Declaraci¢n de teclas
       #INCLUDE "FILES.PRG"           // Archivos Compartidos

       LOCAL lHayErr := .F.                 // .T. Hay Error
       LOCAL oBrowse := NIL                 // Objeto para el Browse
       CloseAll()
*>>>>FIN DECLARACION DE VARIABLES

*>>>>AREAS DE TRABAJO
       aUseDbf := {}
       AADD(aUseDbf,{.T.,IF(EMPTY(cPatCon),'',cPatCon+'\')+;
			 PathSis+'\'+;
			 fSimaCo,'SCO',NIL,lShared,nModCry})

       AADD(aUseDbf,{.T.,PathSis+'\'+;
			 FilePrn,'PRN',NIL,lShared,nModCry})

       AADD(aUseDbf,{.T.,IF(EMPTY(cPatCon),'',cPatCon+'\')+;
			 cPatSis+'\'+;
			 FileHra,'HRA',NIL,lShared,nModCry})
*>>>>FIN AREAS DE TRABAJO

*>>>>SELECION DE LAS AREAS DE TRABAJO
       IF !lUseDbfs(aUseDbf)
	  cError('ABRIENDO ARCHIVOS')
	  CloseAll(aUseDbf)
	  RETURN NIL
       ENDIF
*>>>>FIN SELECION DE LAS AREAS DE TRABAJO

*>>>>VALIDACION DE CONTENIDOS DE ARCHIVOS
       lHayErr := .T.
       DO CASE
       CASE SCO->(RECCOUNT()) == 0
	    cError('NO EXISTEN CONFIGURACION GENERAL')

       CASE PRN->(RECCOUNT()) == 0
	    cError('NO EXISTEN IMPRESIORAS GRABADAS')

       OTHERWISE
	    lHayErr :=.F.
       ENDCASE

       IF lHayErr
	  CloseAll(aUseDbf)
	  RETURN NIL
       ENDIF
*>>>>FIN VALIDACION DE CONTENIDOS DE ARCHIVOS

*>>>>LOCALIZACION DE LA IMPRESORA
       IF !lLocCodigo('nCodigoPrn','PRN',SCO->nCodigoPrn)
	  cError('NO EXISTE LA IMPRESORA QUE ESTA HABILITADA')
	  CLOSE ALL
	  RETURN NIL
       ENDIF
*>>>>FIN LOCALIZACION DE LA IMPRESORA

*>>>>MANTENIMIENTO DEL ARCHIVO
       lModReg := IF(EMPTY(lModReg),.F.,lModReg)
       oBrowse := oBrwDbfHra(lShared,cAnoUsr,nFilPal+1,00,22,79,lModReg)

       SETKEY(K_F5,{||BuscarHra(oBrowse)})

       SETKEY(K_F9,{||MenuOtrHra(lShared,nModCry,cNomSis,cEmpPal,cNitEmp,;
				 cNomEmp,cNomSec,nFilInf,nColInf,nFilPal,;
				 cNomUsr,cAnoUsr,cPatSis,cMaeAlu,cMaeAct,;
				 cJorTxt,lModReg,cPatCon,oBrowse)})

       HRA->(CtrlBrw(lShared,oBrowse))
       SETKEY(K_F5,NIL)
       SETKEY(K_F9,NIL)
       CloseAll(aUseDbf)
       RETURN NIL
*>>>>FIN MANTENIMIENTO DEL ARCHIVO

/*************************************************************************
* TITULO..: DEFINICION DEL OBJETO BROWSE          	                 *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: FEB 02/2000 MIE A
       Colombia, Bucaramanga        INICIO: 12:30 AM   FEB 02/2000 MIE

OBJETIVOS:

1- Define el objeto Browse del archivo

2- Retorna NIL

SINTAXIS:


*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION oBrwDbfHra(lShared,cAnoUsr,nFilSup,nColSup,nFilInf,nColInf,lModReg)

*>>>>PARAMETROS DE LA FUNCION
/*     lShared                              // .T. Archivos Compartidos
       cAnoUsr                              // A¤o del usuario
       nFilSup	                            // Fila Superior
       nColSup	                            // Columna Superior
       nFilInf	                            // Fila Inferior
       nColInf	                            // Columna Inferior
       lModReg                              // .T. Modificar el Registro */
*>>>>FIN PARAMETROS DE LA FUNCION

*>>>>DECLARACION DE VARIABLES
       LOCAL oColumn := NIL                 // Columna del objeto
       LOCAL oBrowse := NIL		    // Browse de Grupos
*>>>>FIN DECLARACION DE VARIABLES

*>>>>DEFINICION DEL OBJETO BROWSE
       oBrowse := TBROWSEDB(nFilSup+1,nColSup+1,nFilInf-1,nColInf-1)
      *Definici¢n de Objeto y asignaci¢n de las coordenadas

       oBrowse:ColSep    := '³'
       oBrowse:HeadSep   := 'Ä'

       oBrowse:Cargo := {'<< DISTRIBUCION DE LAS HORAS >>',;
			 '<INS>Incluir <F5>Buscar  <DEL>Borrar  '+;
			 '<F9>Otros <ESC>Abandonar',{||IncluirHra(lShared)}}
     *ÀDefinici¢n de cabeceras y l¡neas de cabeceras

       lModReg := IF(EMPTY(lModReg),.F.,lModReg)
       lModReg := IF(lModReg .AND. HRA->(RECCOUNT())==0,.F.,lModReg)

       SELECT HRA
       oColumn	     := TBCOLUMNNEW('HORA',{||HRA->cCodigoHra})
       oColumn:Cargo := {{'MODI',lModReg},{'ALIAS','HRA'},;
			 {'FIELD','cCodigoHra'},{'PICTURE','99'}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn	     := TBCOLUMNNEW('DESCRIPCION',{||HRA->cNombreHra})
       oColumn:Cargo := {{'MODI',lModReg},{'ALIAS','HRA'},;
			 {'FIELD','cNombreHra'},{'PICTURE','@!'}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn	     := TBCOLUMNNEW('HORA INICIAL',{||HRA->cHorIniHra})
       oColumn:Cargo := {{'MODI',lModReg},{'ALIAS','HRA'},;
			 {'FIELD','cHorIniHra'},{'PICTURE','@!'}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn	     := TBCOLUMNNEW('HORA FINAL',{||HRA->cHorFinHra})
       oColumn:Cargo := {{'MODI',lModReg},{'ALIAS','HRA'},;
			 {'FIELD','cHorFinHra'},{'PICTURE','@!'}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn := TBCOLUMNNEW('HORA;DE CLASE',{||HRA->lHraClaHra})
       oColumn:Cargo := {{'MODI',lModReg},{'ALIAS','HRA'},;
			 {'FIELD','lHraClaHra'},{'PICTURE','@!'}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       RETURN oBrowse
*>>>>FIN DEFINICION DEL OBJETO BROWSE

/*************************************************************************
* TITULO..: INCLUCION DE UN REGISTRO          	                         *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: FEB 02/2000 MIE A
       Colombia, Bucaramanga        INICIO: 12:30 AM   FEB 02/2000 MIE

OBJETIVOS:

1- Incluye un registro al archivo

2- Retorna NIL

SINTAXIS:


*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION IncluirHra(lShared)

*>>>>PARAMETROS DE LA FUNCION
/*     lShared                              // .T. Archivos Compartidos */
*>>>>FIN PARAMETROS DE LA FUNCION

*>>>>DECLARACION DE CONSTANTES
       LOCAL nNroFil := 3                   // Fila de Lectura
       LOCAL nNroCol := 2                   // Columna de Lectura
       LOCAL lHayErr := .F.                 // .T. Hay Error
       LOCAL lGrabar := .F.                 // .T. Grabar registro
       LOCAL GetList := {}                  // Variable del sistema

       LOCAL cCodigoThr := ''               // C¢digo de la Hora
       LOCAL cNombreThr := ''               // Descripci¢n
       LOCAL cHorIniThr := ''               // Hora Inicial
       LOCAL cHorFinThr := ''               // Hora Final
*>>>>FIN DECLARACION DE CONSTANTES

*>>>>LECTURA Y CONFIRMACION DEL REGISTRO
       SET CURSOR ON
       nNroFil := nMarco(nNroFil,'POR FAVOR INGRESE'+;
			 'DE LA ORGANIZACION HORARIA',22,'°')
       DO WHILE .T.

**********INICIALIZACION DE LAS VARIABLES
	    IF !lHayErr
	       cCodigoThr := cSpaces('HRA','cCodigoHra')
	       cNombreThr := cSpaces('HRA','cNombreHra')
	       cHorIniThr := cSpaces('HRA','cHorIniHra')
	       cHorFinThr := cSpaces('HRA','cHorFinHra')
	    ENDIF
**********FIN INICIALIZACION DE LAS VARIABLES

**********LECTURA DEL REGISTRO
	    @ nNroFil+0,nNroCol SAY 'HORA        :';
				GET cCodigoThr PICT '@!'

	    @ nNroFil+1,nNroCol SAY 'DESCRIPCION :';
				GET cNombreThr PICT '@!'

	    @ nNroFil+2,nNroCol SAY 'INICIA      :';
				GET cHorIniThr PICT '@!'

	    @ nNroFil+3,nNroCol SAY 'TERMINA     :';
				GET cHorFinThr PICT '@!'
	    READ
**********FIN LECTURA DEL REGISTRO

**********VALIDACION DEL REGISTRO
	    lGrabar := .F.
	    DO CASE
	    CASE EMPTY(cCodigoThr) .OR. EMPTY(cHorIniThr) .OR.;
		 EMPTY(cHorIniThr)

		 cError('DEBE DAR LOS DATOS COMPLETOS. '+;
			'NO SE GRABA EL REGISTRO')
	    OTHERWISE
		 lGrabar := .T.
	    ENDCASE
**********FIN VALIDACION DEL REGISTRO

**********PREGUNTA DE DECISION
	    IF lGrabar
	       IF lPregunta('DESEA GRABAR EL REGISTRO? Si No')
		  EXIT
	       ENDIF
	    ELSE
	       EXIT
	    ENDIF
	    lHayErr := .T.
**********PREGUNTA DE DECISION

       ENDDO
*>>>>FIN LECTURA Y CONFIRMACION DEL REGISTRO

*>>>>GRABACION DEL REGISTRO
       SELECT HRA
       IF lGrabar
	  IF HRA->(lRegLock(lShared,.T.))
	     REPL HRA->cCodigoHra WITH cCodigoThr
	     REPL HRA->cNombreHra WITH cNombreThr
	     REPL HRA->cHorIniHra WITH cHorIniThr
	     REPL HRA->cHorFinHra WITH cHorFinThr
	     HRA->(DBCOMMIT())
	  ENDIF
       ENDIF
       IF lShared
	  HRA->(DBUNLOCK())
       ENDIF
       RETURN NIL
*>>>>FIN GRABACION DEL REGISTRO

/*************************************************************************
* TITULO..: BUSCAR EL CODIGO EN EL BROWSE                                *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: FEB 02/2000 MIE A
       Colombia, Bucaramanga        INICIO: 12:30 AM   FEB 02/2000 MIE

OBJETIVOS:

1- Localiza el c¢digo dentro del Browse

2- Retorna NIL

SINTAXIS:


*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION BuscarHra(oBrowse)

*>>>>PARAMETROS DE LA FUNCION
/*     oBrowse			            // Browse del Archivo */
*>>>>FIN PARAMETROS DE LA FUNCION

*>>>>DECLARACION DE VARIABLES
       LOCAL nNroFil := 0                   // Fila de lectura
       LOCAL nNroCol := 0                   // Columna de lectura
       LOCAL nRegHra := 0                   // N£mero del Registro
       LOCAL lBuscar := .T.                 // .T. Realizar la b£squeda
       LOCAL GetList := {}                  // Variable del sistema

       LOCAL cCodigoThr := ''               // C¢digo de Aprobaci¢n
*>>>>FIN DECLARACION DE VARIABLES

*>>>>CAPTURA DEL CODIGO
       SET CURSOR ON
       cCodigoThr := cSpaces('HRA','cCodigoHra')
       TitBuscar(2,@nNroFil,@nNroCol)
       @ nNroFil,nNroCol GET cCodigoThr PICT 'XX';
			 VALID lValCodHra(ROW(),COL()-1,@cCodigoThr)
       READ
*>>>>FIN CAPTURA DEL CODIGO

*>>>>VALIDACION DEL CODIGO
       IF EMPTY(cCodigoThr)
	  cError('PATRON DE BUSQUEDA NO ESPECIFICADO',;
		  'ADVERTENCIA')
	  lBuscar := .F.
       ENDIF
*>>>>FIN VALIDACION DEL CODIGO

*>>>>BUSQUEDA DEL CODIGO
       SELECT HRA
       IF lBuscar .AND. lLocCodigo('cCodigoHra','HRA',cCodigoThr)
	   nRegHra := RECNO()
	   GO TOP
	   oBrowse:GOTOP()
	   GO nRegHra
	   oBrowse:FORCESTABLE()
       ELSE
	  oBrowse:GOTOP()
       ENDIF
       RETURN NIL
*>>>>FIN BUSQUEDA DEL CODIGO

/*************************************************************************
* TITULO..: VALIDACION DEL CODIGO                                        *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: FEB 02/2000 MIE A
       Colombia, Bucaramanga        INICIO: 12:30 AM   FEB 02/2000 MIE

OBJETIVOS:

1- Debe estar en uso el archivo

2- Realiza la validaci¢n del c¢digo de acuerdo al nombre

3- Retorna .T. si hay problemas

SINTAXIS:


*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION lValCodHra(nNroFil,nNroCol,cCodHra)

*>>>>PARAMETROS DE LA FUNCION
/*     nNroFil                              // Fila de lectura
       nNroCol                              // Columna de lectura
       cCodHra				    // C¢digo de la Hrase */
*>>>>FIN PARAMETROS DE LA FUNCION

*>>>>DECLARACION DE VARIABLES
       LOCAL nRegHra := 0                   // N£mero del registro
*>>>>FIN DECLARACION DE VARIABLES

*>>>>VALIDACION DEL CODIGO DEL BANCO
       IF !lLocCodigo('cCodigoHra','HRA',cCodHra)
	  nRegHra := nSelCodHra(nNroFil,nNroCol)
	  IF nRegHra == 0
	     cCodHra := cSpaces('HRA','cCodigoHra')
	  ELSE
	     GO nRegHra
	     cCodHra := HRA->cCodigoHra
	  ENDIF
       ENDIF
       RETURN .T.
*>>>>FIN VALIDACION DEL CODIGO DEL BANCO

/*************************************************************************
* TITULO..: SELECCION DEL CODIGO                                         *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: FEB 02/2000 MIE A
       Colombia, Bucaramanga        INICIO: 12:30 AM   FEB 02/2000 MIE

OBJETIVOS:

1- Debe estar en uso el archivo.

2- Permite escoger el registro del archivo de acuerdo al nombre.

3- Retorna el n£mero del registro escogido

SINTAXIS:

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION nSelCodHra(nNroFil,nNroCol)

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
       LOCAL nRegHra := 0		    // Registro del Banco
*>>>>FIN DECLARACION DE VARIABLES

*>>>>VALIDACION DE CONTENIDOS DE ARCHIVOS
       IF HRA->(RECCOUNT()) == 0
	  cError('NO EXISTEN HORAS GRABADAS')
	  RETURN 0
       ENDIF
*>>>>FIN VALIDACION DE CONTENIDOS DE ARCHIVOS

*>>>>INICIALIZACION DE LAS COORDENADAS
	SELECT HRA
	nFilSup := nNroFil+1
	nColSup := nNroCol+2
	IF nFilSup+RECCOUNT() > 22
	   nFilInf := 22
	ELSE
	   nFilInf := nFilSup + RECCOUNT()
	ENDIF
	nColInf := nColSup+18
*>>>>FIN INICIALIZACION DE LAS COORDENADAS

*>>>>SELECCION DEL REGISTRO
       HRA->(DBGOTOP())
       cSavPan := SAVESCREEN(0,0,24,79)
       @ nFilSup-1,nColSup-1 TO nFilInf,nColInf+1 DOUBLE
       nRegHra := nBrowseDbf(nFilSup,nColSup,nFilInf-1,nColInf,;
			     {||HRA->cNombreHra})
       RESTSCREEN(0,0,24,79,cSavPan)
       RETURN nRegHra
*>>>>FIN SELECCION DEL REGISTRO

/*************************************************************************
* TITULO..: MENU OTROS                                                   *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: FEB 02/2000 MIE A
       Colombia, Bucaramanga        INICIO: 12:30 AM   FEB 02/2000 MIE

OBJETIVOS:

1- Menu Otros para el archivo

2- Retorna NIL

SINTAXIS:

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION MenuOtrHra(lShared,nModCry,cNomSis,cEmpPal,cNitEmp,cNomEmp,;
		    cNomSec,nFilInf,nColInf,nFilPal,cNomUsr,cAnoUsr,;
		    cPatSis,cMaeAlu,cMaeAct,cJorTxt,lModReg,cPatCon,;
		    oBrowse)

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
       cPatSis                              // Path del sistema
       cMaeAlu                              // Maestros habilitados
       cMaeAct                              // Maestro Activo
       cJorTxt                              // Jornada escogida
       lModReg                              // .T. Modificar el Registro
       cPatCon                              // Path de la Contabilidad
       oBrowse                              // Browse del Archivo */
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

*>>>>DECLARCION Y EJECUCION DEL MENU
       aMenus := {'1<HORAS ACADEMICAS>'}

       aAyuda := {'Imprime la distribuci¢n de las horas acad‚micas'}

       cSavPan := SAVESCREEN(0,0,24,79)
       nNroOpc := nMenu(aMenus,aAyuda,10,25,NIL,NIL,1,.F.)
       RESTSCREEN(0,0,24,79,cSavPan)
       IF nNroOpc == 0
	  RETURN NIL
       ENDIF
*>>>>FIN DECLARCION Y EJECUCION DEL MENU

*>>>>ANALISIS DE OPCION ESCOGIDA
       DO CASE
       CASE nNroOpc == 1
	    PrnHoras(lShared,nModCry,cNomSis,cEmpPal,cNitEmp,cNomEmp,;
		    cNomSec,nFilInf,nColInf,nFilPal,cNomUsr,cAnoUsr,;
		    cPatSis,cMaeAlu,cMaeAct,cJorTxt,lModReg,cPatCon,;
		    oBrowse)
	  *Imprime la distribuci¢n de las horas

       ENDCASE
       RETURN NIL
*>>>>FIN ANALISIS DE OPCION ESCOGIDA

/*************************************************************************
* TITULO..: IMPRESION DE LA ORGANIZACION DE LAS HORAS                    *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: FEB 02/2000 MIE A
       Colombia, Bucaramanga        INICIO: 12:30 AM   FEB 02/2000 MIE

OBJETIVOS:

1- Imprime la organizaci¢n de las Horas

2- Retorna NIL

SINTAXIS:


*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION PrnHoras(lShared,nModCry,cNomSis,cEmpPal,cNitEmp,cNomEmp,;
		  cNomSec,nFilInf,nColInf,nFilPal,cNomUsr,cAnoUsr,;
		  cPatSis,cMaeAlu,cMaeAct,cJorTxt,lModReg,cPatCon,;
		  oBrowse)

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
       cPatSis                              // Path del sistema
       cMaeAlu                              // Maestros habilitados
       cMaeAct                              // Maestro Activo
       cJorTxt                              // Jornada escogida
       lModReg                              // .T. Modificar el Registro
       cPatCon                              // Path de la Contabilidad
       oBrowse                              // Browse del Archivo */
*>>>>FIN DESCRIPCION DE PARAMETROS

*>>>>DECLARACION DE VARIABLES
       #INCLUDE "FILES.PRG"           // Archivos Compartidos
       #INCLUDE "EPSONFX.PRG"               // Impresora EPSON FX

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

*>>>>VALIDACION DEL CONTENIDO
       IF HRA->(RECCOUNT()) == 0
	  cError('NO EXISTEN HORAS GRABADAS')
	  RETURN NIL
       ENDIF
*>>>>FIN VALIDACION DEL CONTENIDO

*>>>>DEFINCION DEL ENCABEZADO
       nNroPag := 0
       lTamAnc := .F.

       nTotReg := HRA->(RECCOUNT())+nLinTot

       aCabPrn := {cNomEmp,cNomSis,;
		   'A¥O: '+cAnoUsr+' JORNADA: '+cJorTxt,;
		   'ORGANIZACION DE LAS HORAS',;
		   ''}

       aCabeza := {aCabPrn[1],aCabPrn[2],aCabPrn[3],aCabPrn[4],aCabPrn[5],;
		   nNroPag++,;
		   cTotPagina(nTotReg),lTamAnc}

       cCodIni := PCL({'DraftOn','Pica','CondenOn'})
       cCodFin := PCL({'NegraOf','DobGolOf'})
*>>>>FIN DEFINCION DEL ENCABEZADO

*>>>>ENCABEZADOS DE COLUMNA
       aNroCol := {04,06,52,16,20,22,12}
       aTitPrn := {'HORA',;
		   'INICIA',;
		   'TERMINA',;
		   'DESCRIPCION'}
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

*>>>>ANALISIS DE DECISION
       IF !lPregunta('DESEA CONTINUAR? Si No')
	  RETURN NIL
       ENDIF
*>>>>FIN ANALISIS DE DECISION

*>>>>ACTIVACION DE LA IMPRESORA
       IF SCO->lPrnArcCon
	  SET DEVICE TO PRINT
       ELSE
	  FilePrn := 'horas'
	  nOpcPrn := nPrinter_On(cNomUsr,@FilePrn,SCO->cOpcPrnCon,.F.,.T.)
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

*>>>>IMPRESION DEL PLAN ACADEMICO
       cSavPan := SAVESCREEN(0,0,24,79)
       SET DEVICE TO SCREEN
       Termometro(0,'IMPRIMIENDO')
       SET DEVICE TO PRINT

       SELECT HRA
       HRA->(DBGOTOP())
       DO WHILE .NOT. HRA->(EOF())

**********VISUALIZACION DE AVANCE
	    nAvance := INT(( HRA->(RECNO()) / HRA->(RECCOUNT()) )*100)

	    IF STR(nAvance,3) $ '25 50 75100'
	       SET DEVICE TO SCREEN
	       Termometro(nAvance)
	       SET DEVICE TO PRINT
	    ENDIF
**********FIN VISUALIZACION DE AVANCE

**********IMPRESION DEL REGISTRO
	    aRegPrn := {HRA->cCodigoHra,;
			HRA->cHorIniHra,;
			HRA->cHorFinHra,;
			HRA->cNombreHra}

	    lPrnOpc(lShared,nOpcPrn,FilePrn,nHanXml,01,nColCab,;
		    aTitPrn,aRegPrn,aNroCol,bPagina,bDerAut,bCabeza)
**********FIN IMPRESION DEL REGISTRO

**********AVANCE DEL SIGUIENTE REGISTRO
	    SELECT HRA
	    HRA->(DBSKIP())
	    IF HRA->(EOF())
	       SET DEVICE TO SCREEN
	       Termometro(100)
	       SET DEVICE TO PRINT
	    ENDIF
**********FIN AVANCE DEL SIGUIENTE REGISTRO

       ENDDO
       RESTSCREEN(0,0,24,79,cSavPan)
*>>>>FIN IMPRESION DEL PLAN ACADEMICO

*>>>>IMPRESION DERECHOS
       EVAL(bDerAut)
      *Derechos de Autor

       VerPrn(nOpcPrn,FilePrn,nHanXml)
       SET DEVICE TO SCREEN
       RETURN NIL
*>>>>FIN IMPRESION DERECHOS

/*************************************************************************
* TITULO..: LOCALIZAR DESCRIPCION DE LA HORA                             *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: AGO 02/2004 LUN A
       Colombia, Bucaramanga        INICIO: 01:30 PM   AGO 02/2004 LUN

OBJETIVOS:

1- Deben estar en uso el archivo

2- Permite encontrar el nombre

3- Si el nombre se incluye en un browse se debe pasar
   el Alias del Archivo del Browse

4- Retorna el nombre

SINTAXIS:

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION cLocNomHra(cCodigo,cNalias)

*>>>>PARAMETROS DE LA FUNCION
/*     cCodigo				      // C¢digo de b£squeda
       cNalias				      // Alias del Browse */
*>>>>FIN PARAMETROS DE LA FUNCION

*>>>>DECLARACION DE VARIABLES
       LOCAL cNombreThr := ''                 // Descripci¢n de la Hora
*>>>>FIN DECLARACION DE VARIABLES

*>>>>LOCALIZACION DEL CODIGO
       IF lLocCodigo('cCodigoHra','HRA',cCodigo)
	  cNombreThr := HRA->cNombreHra
       ELSE
	  cNombreThr := SPACE(02)
       ENDIF
       IF cNalias # NIL
	  SELECT &cNalias
       ENDIF
       RETURN cNombreThr
*>>>>FIN LOCALIZACION DEL CODIGO
