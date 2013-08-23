/*************************************************************************
* TITULO..: LOCALIZACION DE LA OBSERVACION                               *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: AGO 10/2006 MAR A
       Colombia, Bucaramanga        INICIO: 01:30 AM   AGO 10/2006 MAR

OBJETIVOS:

1- Permite localizar la observaci¢n del estudiante para una prueba
   especifica.

2- Retorna NIL

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION lLocCodObs(cCodTob,cCodEst)

*>>>>DESCRIPCION DE PARAMETROS
/*     cCodTob				    // C¢digo a localizar
       cCodEst                              // C¢digo del estudiante */
*>>>>FIN DESCRIPCION DE PARAMETROS

*>>>>DECLARACION DE VARIABLES
       LOCAL lExiste := .T.                 // .T. Existe el c¢digo
*>>>>FIN DECLARACION DE VARIABLES

*>>>>LOCALIZACION DEL CODIGO
       SELECT OBS
       OBS->(DBGOTOP())
       LOCATE FOR OBS->cCodigoTob == cCodTob .AND.;
		  OBS->cCodEstObs == cCodEst

       IF .NOT. OBS->(FOUND())
	  lExiste := .F.
       ENDIF
       RETURN lExiste
*>>>>FIN LOCALIZACION DEL CODIGO

/*************************************************************************
* TITULO..: CONSULTA DE LAS OBSERVACIONES                                *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: AGO 14/2006 MAR A
       Colombia, Bucaramanga        INICIO: 07:45 AM   AGO 14/2006 MAR

OBJETIVOS:

1- Permite consultar las observaciones de los estudiantes.

2- Retorna NIL

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION InfoObs(nFilInf,nColInf,cNomEmp,cNomSis,cNalias,oBrowse)

*>>>>DESCRIPCION DE PARAMETROS
/*     nFilInf                              // Fila de Impresi¢n
       nColInf                              // Columna de Impresi¢n
       cNomEmp                              // Nombre de la Empresa
       cNomSis                              // Nombre del sistema
       cNalias                              // Alias del Archivo del Browse
       oBrowse                              // Browse del Archivo */
*>>>>FIN DESCRIPCION DE PARAMETROS

*>>>>DECLARACION DE VARIABLES
       LOCAL cSavPan := ''                  // Salvar Pantalla

       LOCAL lModTxt := .F.                 // Modificar el texto
       LOCAL cTexto  := ''                  // Contenido del texto
       LOCAL cTxtHlp := ''                  // Texto de Ayuda
       LOCAL cTitHlp := ''                  // T¡tulo para la Ayuda
*>>>>FIN DECLARACION DE VARIABLES

*>>>>SELECCION DEL TIPO DE OBSERVACION
       cSavPan := SAVESCREEN(0,0,24,79)
       IF EMPTY(nSelTob(nFilInf,nColInf))
	  RESTSCREEN(0,0,24,79,cSavPan)
	  SELECT &cNalias
	  oBrowse:FORCESTABLE()
	  RETURN NIL
       ENDIF
*>>>>FIN SELECCION DEL TIPO DE OBSERVACION

*>>>>LINEA DE ESTADO
       LineaEstado('LICENCIA DE USO A FAVOR DE: '+cNomEmp,cNomSis)
*>>>>FIN LINEA DE ESTADO

*>>>>CONSULTA DE LA OBSERVACION
       IF lLocCodObs(TOB->cCodigoTob,ADM->cCodigoEst)

	    cTexto := OBS->mObservObs

	    EditarMemo(cNomSis,cTexto,;
		       RTRIM(SUBS(RTRIM(ADM->cNombreEst)+;
			     ' '+ADM->cApelliEst,1,30))+':'+;
		       ALLTRIM(TOB->cNombreTob),;
		       cTxtHlp,cTitHlp,lModTxt)

       ELSE
	  cError('NO EXISTE OBSERVACION PARA '+ALLTRIM(TOB->cNombreTob))
       ENDIF
       RESTSCREEN(0,0,24,79,cSavPan)
       SELECT &cNalias
       oBrowse:FORCESTABLE()
       RETURN NIL
*>>>>FIN CONSULTA DE LA OBSERVACION

