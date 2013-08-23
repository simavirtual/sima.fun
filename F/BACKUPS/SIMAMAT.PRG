/*                   SIMA. SISTEMA INTEGRADO MULTIUSUARIO
		 BIBLIOTECAS DE FUNCIONES GENERALES DE MATERIAS

OBJETIVOS:

- Definici¢n de funciones generales para el SIMA

***************************************************************************
*-------------------- DECLARACION DE LAS FUNCIONES -----------------------*
**************************************************************************/

*>>>>DECLARACION DE CONSTANTES GENERALES
       #INCLUDE "inkey.ch"
*>>>>FIN DECLARACION DE CONSTANTES GENERALES

/*************************************************************************
* TITULO DE LA FUNCION..: VALIDACION DE LA MATERIA                       *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: MAY 10/95 MIE A
       Colombia, Bucaramanga        INICIO: 11:04 AM   MAY 10/95 MIE

OBJETIVOS:

1- Debe estar en uso el archivo

2- Realiza la validaci¢n del c¢digo

3- Retorna .T. si hay problemas

SINTAXIS:


*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION lValMateria(nNroFil,nNroCol,cCodigo,nNroReg)

*>>>>PARAMETROS DE LA FUNCION
/*     nNroFil                              // Fila de lectura
       nNroCol                              // Columna de lectura
       cCodigo			            // @Codigo a validar
       nNroReg			            // @N£mero del Registro */
*>>>>FIN PARAMETROS DE LA FUNCION

*>>>>VALIDACION DEL CODIGO DEL CONCEPTO
       IF !lLocCodigo('cCodigoMat','MAT',cCodigo)
	  lSelMateria(nNroFil,nNroCol,@nNroReg)
	  IF nNroReg == 0
	     cCodigo := cSpaField('MAT','cCodigoMat')
	  ELSE
	     GO nNroReg
	     cCodigo := MAT->cCodigoMat
	  ENDIF
       ELSE
	  nNroReg := RECNO()
       ENDIF
       RETURN .T.
*>>>>FIN VALIDACION DEL CODIGO DEL CONCEPTO

/*************************************************************************
* TITULO DEL PROGRAMA..: SELECCION DE LA MATERIA                         *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: MAY 10/95 MIE A
       Colombia, Bucaramanga        INICIO: 12:05 AM   MAY 10/95 MIE

OBJETIVOS:

1- Debe estar en uso el archivo

2- Retorna por referencia los param‚tros de la funci¢n marcados con @

3- Permite escoger una materia determinada

4- Retorna .T. si escogio la materia

SINTAXIS:

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION lSelMateria(nNroFil,nNroCol,nNroReg,cTitulo)

*>>>>PARAMETROS DE LA FUNCION
/*     nNroFil                              // N£mero de la fila
       nNroCol                              // N£mero de la Columna
       nNroReg		                    // @N£mero del registro escogido
       cTitulo                              // T¡tulo de lectura */
*>>>>FIN PARAMETROS DE LA FUNCION

*>>>>DECLARACION DE VARIABLES
       LOCAL nFilSup := 0                   // Fila superior
       LOCAL nColSup := 0                   // Colunma superior
       LOCAL nFilInf := 0                   // Fila inferior
       LOCAL nColInf := 0                   // Columna inferior
*>>>>FIN DECLARACION DE VARIABLES

*>>>>IMPRESION DE ENCABEZADOS
       cTitulo := IF(cTitulo == NIL,'',cTitulo)
       @ nNroFil,nNroCol SAY cTitulo
*>>>>FIN IMPRESION DE ENCABEZADOS

*>>>>SELECCION DEL REGISTRO
	SELECT MAT
	nNroCol = nNroCol + LEN(cTitulo)
	nFilSup := nNroFil
	nColSup := nNroCol
	IF nFilSup+RECCOUNT() > 22
	   nFilInf := 21
	ELSE
	   nFilInf := nFilSup + RECCOUNT() - 1
	ENDIF
	nColInf := nColSup+73+LEN(MAT->cCodigoMat)

	MAT->(DBGOTOP())
	nNroReg := nBrowseDbf(nFilSup,nColSup,nFilInf,nColInf,;
			      {||MAT->cCodigoMat+' '+MAT->cNombreMat})
	IF nNroReg == 0
	   RETURN .F.
	ENDIF
	MAT->(DBGOTO(nNroReg))
	@ nFilSup,nColSup SAY MAT->cCodigoMat
	RETURN .T.
*>>>>FIN SELECCION DEL REGISTRO

/*************************************************************************
* TITULO DEL PROGRAMA..: ENCONTRAR EL NOMBRE DE LA MATERIA               *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: MAY 12/95 VIE A
       Colombia, Bucaramanga        INICIO: 11:45 AM   MAY 12/95 VIE

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

FUNCTION cSekNomMat(cCodigo,cNalias)

*>>>>PARAMETROS DE LA FUNCION
/*     cCodigo				      // C¢digo de b£squeda
       cNalias				      // Alias del Browse */
*>>>>FIN PARAMETROS DE LA FUNCION

*>>>>DECLARACION DE VARIABLES
       LOCAL cNombreTma := ''                 // Nombre de la materia
*>>>>FIN DECLARACION DE VARIABLES

*>>>>BUSQUEDA DEL CODIGO
       IF lLocCodigo('cCodigoMat','MAT',cCodigo)
	  cNombreTma := MAT->cNombreMat
	  DO CASE
	  CASE MAT->nMatVarMat == 1
	     cNombreTma := 'Niv '+cNombreTma
	  CASE MAT->nMatVarMat == 2
	     cNombreTma := 'Gru '+cNombreTma
	  ENDCASE
       ELSE
	  cNombreTma := 'MATERIA NO EXISTE'
       ENDIF
       IF cNalias # NIL
	  SELECT &cNalias
       ENDIF
       RETURN cNombreTma
*>>>>FIN BUSQUEDA DEL CODIGO