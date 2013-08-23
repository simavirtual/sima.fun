/*************************************************************************
* TITULO..: AREAS Y MATERIAS DEL ESTUDIANTE                              *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: SEP 10/2008 MIE A
       Bucaramanga, Colombia	    INICIO: 01:30 PM   SEP 10/2008 MIE

OBJETIVOS:

1- Crea dos vectores con los detalles de las areas y asignaturas
   que ve el estudiante de acuerdo al grado.

2- Debe estar en uso los archivos de materias, plan, notas

4- Retorna NIL

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION AreMatEst(aAreas,aMaters,nNroPer)

*>>>>PARAMETROS DE LA FUNCION
/*     aAreas			      // @Detalles de las areas
       aMaters			      // @Detalles de las materias
       nNroPer			      // N£mero del Periodo */
*>>>>FIN PARAMETROS DE LA FUNCION

*>>>>DECLARACION DE VARIABLES
       LOCAL     i,k := 0                   // Contador
       LOCAL aStrNot := {}                  // Vector con la estructura
       LOCAL cMatBol := ''                  // Nombre materia para boletin
       LOCAL cMatCer := ''                  // Nombre materia para certificado
       LOCAL lNoPrnM := .F.                 // .T. No Imprimir .F. Imprimir Materia en Boletin

       LOCAL aDetNot  := {}		    // Notas de las Areas o Materias

       LOCAL aDbfMat := {}                  // Campos de Materias
       LOCAL aDbfPla := {}                  // Campos del Plan Academico
       LOCAL aDbfNot := {}                  // Campos de Notas

       LOCAL cMatVar := {}                  // Materia Variable
       LOCAL aMatSel := {}                  // Materias Selectivas
       LOCAL aDbfSel := {}                  // Campos de Estudiantes con Materias Selectivas
       LOCAL aDbfVar := {}                  // Materias Variables
       LOCAL aMatVar := {}                  // Campos de Materias
     *ÀMaterias Selectivas

       LOCAL cCodigoTma := ''               // C¢digo de la materia
*>>>>FIN DECLARACION DE VARIABLES

*>>>>LOCALIZACION DE LAS AREAS Y MATERIAS
       SELECT NOT
       aStrNot := DBSTRUCT()
       FOR i := 1 TO LEN(aStrNot)

***********LOCALIZACION DEL AREA
	     IF SUBS(aStrNot[i][1],2,3) == 'ARE' .AND.;
		SUBS(aStrNot[i][1],8,3) # 'REC'

*---------------LOCALIZACION AREA PARA EL BOLETIN
		  cCodigoTma := SUBS(aStrNot[i][1],6,2)+'00'
		  IF !lLocCodigo('cCodigoMat','MAT',cCodigoTma,;
					'DEL AREA Campo No.'+str(i,3))
		     cError('EL CODIGO '+cCodigoTma+' NO EXISTE',;
			    aStrNot[i][1])
		     RETURN NIL
		  ENDIF
		  cMatBol := MAT->cNombreMat
*---------------FIN LOCALIZACION AREA PARA EL BOLETIN

*---------------LOCALIZACION DEL AREA EN PLAN ACADEMICO
		  IF !lLocCodigo('cCodigoMat','PLA',cCodigoTma,;
				 'DE LA MATERIA EN PLAN ACADEMICO')
		     RETURN NIL
		  ENDIF
*---------------FIN LOCALIZACION DEL AREA EN PLAN ACADEMICO

*---------------LOCALIZACION AREA PARA EL CERTIFICADO
		  cMatCer := ''
		  IF !EMPTY(PLA->cMatCerPla)
		     IF !lLocCodigo('cCodigoMat','MAT',PLA->cMatCerPla,;
					   'DEL AREA')
			RETURN NIL
		     ENDIF
		     cMatCer := MAT->cNombreMat
		  ENDIF
*---------------FIN LOCALIZACION AREA PARA EL CERTIFICADO

*---------------CAMPOS DE ARCHIVOS
		  aDbfMat := aArrStrMat()
		*ÀMaterias

		  aDbfPla := aArrStrPla()
		*ÀPlan Academico

		  aDbfNot := {}
		  AADD(aDbfNot,{'cCodMat',cCodigoTma})
		  AADD(aDbfNot,{'cIndica1','NOT->cJ1'+cCodigoTma+'Not'})
		  AADD(aDbfNot,{'cIndica2','NOT->cJ2'+cCodigoTma+'Not'})
		  AADD(aDbfNot,{'cIndica3','NOT->cJ3'+cCodigoTma+'Not'})
		  AADD(aDbfNot,{'cIndica4','NOT->cJ4'+cCodigoTma+'Not'})
		  AADD(aDbfNot,{'cIndica5','NOT->cJ5'+cCodigoTma+'Not'})
		*ÀIndicadores

		  AADD(aDbfNot,{'cNotInd1','NOT->cN1'+cCodigoTma+'Not'})
		  AADD(aDbfNot,{'cNotInd2','NOT->cN2'+cCodigoTma+'Not'})
		  AADD(aDbfNot,{'cNotInd3','NOT->cN3'+cCodigoTma+'Not'})
		  AADD(aDbfNot,{'cNotInd4','NOT->cN4'+cCodigoTma+'Not'})
		  AADD(aDbfNot,{'cNotInd5','NOT->cN5'+cCodigoTma+'Not'})
		*ÀNotas de los Indicadores.

		  AADD(aDbfNot,{'cNotas','NOT->'+aStrNot[i][1]})
		*ÀNotas definitivas

		  AADD(aDbfNot,{'cFallas' ,'NOT->cFa'+cCodigoTma+'Not'})
		*ÀAusencias

		  AADD(aDbfNot,{'cAcumul' ,''})
		*ÀNotas Acumuladas
*---------------FIN CAMPOS DE ARCHIVOS

*---------------DETALLES DEL AREA
		  lNoPrnM := IF(SUBS(PLA->cPrnBolPla,nNroPer,1)='1',.T.,.F.)

		  aDetNot := {}
		  AADD(aDetNot,{'nNroOrd',PLA->nNroOrdPla})
		*ÀOrden en el Boletin

		  AADD(aDetNot,{'cCodAre',SUBS(cCodigoTma,1,2)})
		*ÀC¢digo del Area

		  AADD(aDetNot,{'cMatBol',cMatBol})
		*ÀMateria para el Boletin. lDetAreEst => Reemplaza materia variable o selectiva

		  AADD(aDetNot,{'cMatCer',IF(EMPTY(PLA->cMatCerPla),;
					     cMatBol,cMatCer)})
		*ÀMateria para el Certificado

		  AADD(aDetNot,{'lNoPrnM',lNoPrnM})
		*À.T. No Imprimir .F. Imprimir Materia en Boletin

		  AADD(aDetNot,{'cMatSel',''})
		*ÀlDetAreEst => Materias Selectivas

		  AADD(aDetNot,{'aDbfMat',aDbfMat})
		  AADD(aDetNot,{'aDbfPla',aDbfPla})
		  AADD(aDetNot,{'aDbfNot',aDbfNot})
		*ÀCampos de Archivos

		  aMatSel := {}
		  AADD(aDetNot,{'aMatSel',aMatSel})
		*ÀMaterias Selectivas
*---------------FIN DETALLES DEL AREA

*---------------ACUMULACION DE LAS AREAS
		  AADD(aAreas,{PLA->nNroOrdPla,;       // No.01 Orden en el Boletin
			       SUBS(cCodigoTma,1,2),;  // No.02 C¢digo del Area
			       aDetNot,;               // No.03 Detalles de la Materia
			       cCodigoTma})            // No.04 Codigo del Area
*---------------FIN ACUMULACION DE LAS AREAS

	      ENDIF
***********FIN LOCALIZACION DEL AREA

***********LOCALIZACION DE LA MATERIA
	     IF SUBS(aStrNot[i][1],2,2) == 'NT' .AND.;
		SUBS(aStrNot[i][1],8,3) # 'REC'

*---------------LOCALIZACION MATERIA PARA EL BOLETIN
		  cCodigoTma := SUBS(aStrNot[i][1],4,4)

		  IF !lLocCodigo('cCodigoMat','MAT',cCodigoTma,;
					'DE LA MATERIA Campo No.'+str(i,3))
		     cError('EL CODIGO: '+cCodigoTma+' NO EXISTE')
		     RETURN NIL
		  ENDIF
		  cMatBol := MAT->cNombreMat
*---------------FIN LOCALIZACION MATERIA PARA EL BOLETIN

*---------------LOCALIZACION DE LA MATERIA EN PLAN ACADEMICO
		  IF !lLocCodigo('cCodigoMat','PLA',cCodigoTma,;
				 'DE LA MATERIA EN PLAN ACADEMICO')
		     RETURN NIL
		  ENDIF
*---------------FIN LOCALIZACION DE LA MATERIA EN PLAN ACADEMICO

*---------------LOCALIZACION AREA PARA EL CERTIFICADO
		  cMatCer := ''
		  IF !EMPTY(PLA->cMatCerPla)
		     IF !lLocCodigo('cCodigoMat','MAT',PLA->cMatCerPla,;
					   'DEL AREA')
			RETURN NIL
		     ENDIF
		     cMatCer := MAT->cNombreMat
		  ENDIF
*---------------FIN LOCALIZACION AREA PARA EL CERTIFICADO

*---------------CAMPOS DE ARCHIVOS
		  aDbfMat := aArrStrMat()
		*ÀMaterias

		  aDbfPla := aArrStrPla()
		*ÀPlan Academico

		  aDbfNot := {}
		  AADD(aDbfNot,{'cCodMat',cCodigoTma})
		  AADD(aDbfNot,{'cIndica1','NOT->cJ1'+cCodigoTma+'Not'})
		  AADD(aDbfNot,{'cIndica2','NOT->cJ2'+cCodigoTma+'Not'})
		  AADD(aDbfNot,{'cIndica3','NOT->cJ3'+cCodigoTma+'Not'})
		  AADD(aDbfNot,{'cIndica4','NOT->cJ4'+cCodigoTma+'Not'})
		  AADD(aDbfNot,{'cIndica5','NOT->cJ5'+cCodigoTma+'Not'})
		*ÀIndicadores

		  AADD(aDbfNot,{'cNotInd1','NOT->cN1'+cCodigoTma+'Not'})
		  AADD(aDbfNot,{'cNotInd2','NOT->cN2'+cCodigoTma+'Not'})
		  AADD(aDbfNot,{'cNotInd3','NOT->cN3'+cCodigoTma+'Not'})
		  AADD(aDbfNot,{'cNotInd4','NOT->cN4'+cCodigoTma+'Not'})
		  AADD(aDbfNot,{'cNotInd5','NOT->cN5'+cCodigoTma+'Not'})
		*ÀNotas de los Indicadores.

		  AADD(aDbfNot,{'cNotas'  ,'NOT->'+aStrNot[i][1]})
		*ÀNotas definitivas

		  AADD(aDbfNot,{'cFallas' ,'NOT->cFa'+cCodigoTma+'Not'})
		*ÀAusencias

		  AADD(aDbfNot,{'cAcumul' ,'NOT->cAc'+cCodigoTma+'Not'})
		*ÀNotas Acumuladas
*---------------FIN CAMPOS DE ARCHIVOS

*---------------MATERIAS SELECTIVAS
		  aMatSel := {}
		  IF xPrm(aDbfMat,'nMatVar') # 0

*::::::::::::::::::::LOCALIZACION DE LA MATERIA SELECTIVA
		       SELECT SEL
		       LOCATE FOR SEL->cCodigoEst == NOT->cCodigoEst .AND.;
				  SEL->cCodAreSel == SUBS(cCodigoTma,1,2)

		       aDbfSel := {}
		       aMatVar := {}
		       aDbfVar := {}

		       IF .NOT. SEL->(EOF())

			  aDbfSel := aArrStrSel()
			  FOR k := 1 TO TCO->nTotPerTbl

			      cMatVar := SUBS(cCodigoTma,1,2)+;
					 SUBS(SEL->cSecMatSel,k*2-1,2)

			      aDbfVar := {}
			      IF lLocCodigo('cCodigoMat','MAT',cMatVar)
				 aDbfVar := aArrStrMat()
			      ENDIF

			      AADD(aMatVar,{STR(k,1),k})
			    *ÀN£mero del periodo materia selecionada

			      AADD(aMatVar,{'aDbfVa'+STR(k,1),aDbfVar})
			    *ÀMaterias Variables Selecionadas

			  ENDFOR

		       ELSE

			  FOR k := 1 TO TCO->nTotPerTbl
			     AADD(aMatVar,{'aDbfVa'+STR(k,1),aDbfVar})
			  ENDFOR
			*ÀMaterias Variables Selecionadas ninguna

		       ENDIF
*::::::::::::::::::::FIN LOCALIZACION DE LA MATERIA SELECTIVA

		     AADD(aMatSel,{'aDbfSel',aDbfSel})
		     AADD(aMatSel,{'aMatVar',aMatVar})
		   *ÀMateria Selectiva del Estudiante

		  ENDIF
*---------------MATERIAS SELECTIVAS

*---------------DETALLES DE LA MATERIA
		  lNoPrnM := IF(SUBS(PLA->cPrnBolPla,nNroPer,1)='1',.T.,.F.)

		  aDetNot := {}
		  AADD(aDetNot,{'cCodAre',SUBS(cCodigoTma,1,2)})
		*ÀC¢digo del Area

		  AADD(aDetNot,{'cMatBol',cMatBol})
		*ÀMateria para el Boletin. lDetAreEst => Reemplaza materia variable o selectiva

		  AADD(aDetNot,{'cMatCer',IF(EMPTY(PLA->cMatCerPla),;
					     cMatBol,cMatCer)})
		*ÀMateria para el Certificado

		  AADD(aDetNot,{'cNivMat',SPACE(02)+cCodigoTma})
		*ÀlDetAreEst. SPACE(02) para el nivel+ Materia para los indicadores.

		  AADD(aDetNot,{'lNoPrnM',lNoPrnM})
		*À.T. No Imprimir .F. Imprimir Materia en Boletin

		  AADD(aDetNot,{'cMatSel',''})
		*ÀlDetAreEst => Materias Selectivas

		  AADD(aDetNot,{'aDbfMat',aDbfMat})
		  AADD(aDetNot,{'aDbfPla',aDbfPla})
		  AADD(aDetNot,{'aDbfNot',aDbfNot})
		*ÀCampos de Archivos

		  AADD(aDetNot,{'aMatSel',aMatSel})
		*ÀMaterias Selectivas
*---------------FIN DETALLES DE LA MATERIA

*---------------ACUMULACION DE LAS MATERIAS
		  AADD(aMaters,{SUBS(cCodigoTma,1,2),;   // No.01 C¢digo del Area
				aDetNot,;                // No.02 Detalles de la Materia
				cCodigoTma})             // No.03 C¢digo de la Materia
*---------------FIN ACUMULACION DE LAS MATERIAS

	     ENDIF
***********FIN LOCALIZACION DE LA MATERIA

       ENDFOR
       ASORT(aAreas,,,{|x,y| x[1] < y[1]})
      *Ordena las areas seg£n el orden especificado

       RETURN NIL
*>>>>FIN LOCALIZACION DE LAS AREAS Y MATERIAS

/*************************************************************************
* TITULO..: LOCALIZACION DE LOS DETALLES DEL AREA O MATERIA              *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: SEP 24/2008 MIE A
       Bucaramanga, Colombia	    INICIO: 04:30 PM   SEP 24/2008 MIE

OBJETIVOS:

1- Localiza los detalles del area o materia.
   que ve el estudiante de acuerdo al grado.

2- Retorna NIL

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION aLocAreMat(cCodMat,nNroPer)

*>>>>DESCRIPCION DE PARAMETROS
/*     cCodMat                              // C¢digo de la Materia
       nNroPer                              // N£mero del periodo */
*>>>>FIN DESCRIPCION DE PARAMETROS

*>>>>DECLARACION DE VARIABLES
       LOCAL       i := 0                   // Contador
       LOCAL aAreas  := {}		    // Areas
       LOCAL aMaters := {}		    // Materias

       LOCAL cMatCod := ''                  // C¢digo de la Materia
       LOCAL aDetMat := {}                  // Detalles de la Materia
*>>>>FIN DECLARACION DE VARIABLES

*>>>>LOCALIZACION EN MATERIAS
       AreMatEst(@aAreas,@aMaters,nNroPer)

       FOR i := 1 TO LEN(aMaters)

	   cMatCod := aMaters[i,3]
	 *ÀC¢digo de la Materia

	   IF cCodMat == cMatCod
	      aDetMat := aMaters[i,2]
	      EXIT
	   ENDIF

       ENDFOR
*>>>>FIN LOCALIZACION EN MATERIAS

*>>>>LOCALIZACION EN AREAS
       IF LEN(aDetMat) == 0

	  FOR i := 1 TO LEN(aAreas)

	      cMatCod := aAreas[i,4]
	    *ÀC¢digo de la Materia

	      IF SUBS(cCodMat,1,2) == SUBS(cMatCod,1,2)
		 aDetMat := aAreas[i,3]
		 EXIT
	      ENDIF

	  ENDFOR

       ENDIF
       RETURN aDetMat
*>>>>FIN LOCALIZACION EN AREAS

