/*                   SIMA. SISTEMA INTEGRADO MULTIUSUARIO
		 BIBLIOTECAS DE FUNCIONES GENERALES DE PROFESORES

OBJETIVOS:

- Definici¢n de funciones generales para el SIMA

***************************************************************************
*-------------------- DECLARACION DE LAS FUNCIONES -----------------------*
**************************************************************************/

*>>>>DECLARACION DE CONSTANTES GENERALES
       #INCLUDE "inkey.ch"
*>>>>FIN DECLARACION DE CONSTANTES GENERALES

/*************************************************************************
* TITULO DEL PROGRAMA..: ENCONTRAR EL NOMBRE DEL PROFESOR                *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: MAY 09/95 MAR A
       Colombia, Bucaramanga        INICIO: 12:50 AM   MAY 09/95 MAR

OBJETIVOS:

1- Deben estar en uso el archivo de profesores

2- Permite encontrar el nombre del profesor

3- Si el nombre del profesor se incluye en un browse de debe pasar
   el Alias del Archivo del Browse

4- Retorna el nombre del profesor

SINTAXIS:

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION cSekNomPro(cCodigo,cAlias)

*>>>>PARAMETROS DE LA FUNCION
/*     cCodigo				      // C¢digo de b£squeda
       cAlias                                 // Alias diferente al maestro*/
*>>>>FIN PARAMETROS DE LA FUNCION

*>>>>DECLARACION DE VARIABLES
       LOCAL cNalias := ''                    // Alias del maestro

       LOCAL cNombreTpr := ''                 // Nombre del profesor
*>>>>FIN DECLARACION DE VARIABLES

*>>>>BUSQUEDA DEL CODIGO
       IF lLocCodigo('cCodigoPro','PRO',cCodigo)

	  cNombreTpr := RTRIM(PRO->cApelliPro)+' '+;
			RTRIM(PRO->cNombrePro)
	  IF PRO->lRetiroPro
	     cNombreTpr := cNombreTpr +'. RETIRADO'
	  ENDIF

       ELSE
	  IF EMPTY(cCodigo)
	     cNombreTpr := 'POR DEFINIR'
	  ELSE
	     cNombreTpr := 'PROFESOR NO EXISTE'
	  ENDIF
       ENDIF
       IF cAlias # NIL
	  SELECT &cAlias
       ENDIF
       RETURN cNombreTpr+SPACE(50-LEN(cNombreTpr))
*>>>>FIN BUSQUEDA DEL CODIGO