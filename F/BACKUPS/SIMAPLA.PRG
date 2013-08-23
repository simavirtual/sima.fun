/*                   SIMA. SISTEMA INTEGRADO MULTIUSUARIO
		BIBLIOTECAS DE FUNCIONES PARA EL PLAN ACADEMICO

***************************************************************************
*-------------------- DECLARACION DE LAS FUNCIONES -----------------------*
**************************************************************************/

*>>>>DECLARACION DE CONSTANTES GENERALES
       #INCLUDE "inkey.ch"
*>>>>FIN DECLARACION DE CONSTANTES GENERALES

/*************************************************************************
* TITULO..: NOMBRE DEL ARCHIVO DEL PLAN           	                 *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: FEB 28/2006 MIE A
       Colombia, Bucaramanga        INICIO: 04:30 PM   FEB 28/2006 MIE


OBJETIVOS:

1- Retorna el nombre del Archivo del Plan de acuerdo si el plan es por
   niveles o grupos

2- Retorna NIL

SINTAXIS:


*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION cFilePlan(cAnoUsr,cCodGru)

*>>>>DESCRIPCION DE PARAMETROS
/*     cAnoUsr				    // A¤o del Sistema
       cCodGru                              // C¢digo del Grupo */
*>>>>FIN DESCRIPCION DE PARAMETROS

*>>>>DECLARACION DE VARIABLES
       #INCLUDE "FILES.PRG"          // Archivos del Sistema

       LOCAL cAnoSis := SUBS(cAnoUsr,3,2)   // A¤o del Sistema
       LOCAL cNroNiv := ''                  // N£mero del Nivel
*>>>>FIN DECLARACION DE VARIABLES

*>>>>LOCALIZACION DEL NIVEL
       cNroNiv := SUBS(cCodGru,1,2)
       IF !lLocCodigo('cCodigoNiv','NIV',cNroNiv)
	  cError('EL NIVEL '+cNroNiv+' NO EXISTE')
	  RETURN 'PlanErr'
       ENDIF
*>>>>FIN LOCALIZACION DEL NIVEL

*>>>>ARMADO DEL ARCHIVO DEL PLAN ACADEMICO
       IF NIV->lPlaGruNiv
	  FilePla := 'PL'+cCodGru+cAnoSis+ExtFile
       ELSE
	  FilePla := 'PLAN'+cNroNiv+cAnoSis+ExtFile
       ENDIF
       RETURN FilePla
*>>>>FIN ARMADO DEL ARCHIVO DEL PLAN ACADEMICO