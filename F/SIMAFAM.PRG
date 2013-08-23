/*                  SISTEMA CONTABILIDAD ACADEMICA
	     BIBLIOTECAS DE FUNCIONES PARA EL ARCHIVO FAMILIAS

***************************************************************************
*-------------------- DECLARACION DE LAS FUNCIONES -----------------------*
**************************************************************************/

/*************************************************************************
* TITULO..: RECUPERACION DE LA ESTRUCTURA                                *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: MAY 05/2003 LUN A
       Colombia, Bucaramanga        INICIO: 10:30 AM   MAY 05/2003 LUN

OBJETIVOS:

1- Recupera la estructura del archivo

2- Retorna NIL

SINTAXIS:


*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION RecuDbfFam(lShared,nModCry,PathArc,fArchvo,fNtxArc)

*>>>>PARAMETROS DE LA FUNCION
/*     lShared                        // .T. Sistema Compartido
       nModCry                        // Modo de Protecci¢n
       PathArc			      // Path del Archivo
       fArchvo			      // Nombre del Archivo
       fNtxArc			      // Archivo de Indice */
*>>>>FIN PARAMETROS DE LA FUNCION

*>>>>RECUPERA LA ESTRUCTURA DEL ARCHIVO
       SAVE SCREEN
       cError("SE BORRO EL ARCHIVO "+PathArc+'\'+fArchvo,;
	      "Error Grave. TOME NOTA",;
	      "Al Presionar Cualquier tecla se crea el archivo")
       Termometro(0,"CREANDO LA ESTRUCTURA")
       Termometro(100)
       CreaDbfFam(lShared,nModCry,PathArc,fArchvo,fNtxArc)
       RESTORE SCREEN
       RETURN NIL
*>>>>FIN RECUPERA LA ESTRUCTURA DEL ARCHIVO

/*************************************************************************
* TITULO..: ACTUALIZACION DE LA ESTRUCTURA                               *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: MAY 05/2003 LUN A
       Colombia, Bucaramanga        INICIO: 10:45 AM   MAY 05/2003 LUN

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

FUNCTION nActDbfFam(lShared,nModCry,PathArc,cNomArc)

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
       IF !lUseDbf(.T.,PathArc+'\'+cNomArc,'FAM',NIL,lShared,nModCry)
	  cError('ABRIENDO EL ARCHIVO DE CORRECIONES')
	  CloseDbf('FAM')
	  RETURN nNroErr := 1
       ENDIF
       aStrOld := FAM->(DBSTRUCT())
       CloseDbf('FAM')
       CreaDbfFam(lShared,nModCry,PathArc,cNomArc,,@aStrNew)
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
	  cError('El Archivo CORRECIONES su Estructura Esta DesActualizada.',;
		 'ATENCION',;
		 'Para Actualizarla NO Debe Haber Ning£n Usuario en la Red.')
	  lCambio := lPregunta('DESEA ACTUALIZAR LA ESTRUCTURA? No Si')
	  IF !lCambio
	     nNroErr := 1
	  ENDIF
       ENDIF
*>>>>FIN CONFIRMACION DE LA ACTUALIZACION

*>>>>ACTUALIZACION DE LA STRUCTURA
       IF lCambio
	  FileTem := SUBS(cNomArc,1,AT('.',cNomArc))+'STR'
	  cSavPan := SAVESCREEN(0,0,24,79)
	  IF !lStrucFile(lShared,;
			 PathArc+'\'+cNomArc,;
			 PathArc+'\'+FileTem,;
			 {||CreaDbfFam(lShared,nModCry,PathArc,FileTem)})
	     cError('NO SE ACTUALIZO LA ESTRUCTURA DEL ARCHIVO')
	     nNroErr := 1
	  ENDIF
	  RESTSCREEN(0,0,24,79,cSavPan)
       ENDIF
       RETURN nNroErr
*>>>>FIN ACTUALIZACION DE LA STRUCTURA

/*************************************************************************
* TITULO..: INCLUCION DE UN REGISTRO                                     *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: MAY 05/2003 LUN A
       Colombia, Bucaramanga        INICIO: 11:30 AM   MAY 05/2003 LUN

OBJETIVOS:

2- Incluye un registro al archivo

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION IncluirFam(lShared)

*>>>>PARAMETROS DE LA FUNCION
/*     lShared                              // .T. Archivos Compartidos */
*>>>>FIN PARAMETROS DE LA FUNCION

cError('PENDIENTE')
RETURN NIL