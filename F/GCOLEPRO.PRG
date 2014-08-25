/*************************************************************************
* TITULO..: CREACION DE LA ESTRUCTURA                                    *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: JUN  4/2014 MIE A
       Colombia, Bucaramanga        INICIO:  3:59 PM   JUN  4/2014 MIE

OBJETIVOS:

1- Crea la estructura del archivo

2- Retorna NIL

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION CreaDbfCol(lShared,nModCry,PathArc,fArchvo,aStrDbf)

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
       AADD(aDbfStr,{'nIdeCodCol','Numeric'  ,16,0}) // Ide del Registro
      *Llave Principal

       AADD(aDbfStr,{'cCodigoEst','Character',6,0}) // C¢digo del Estudiante
       AADD(aDbfStr,{'cCodigoGru','Character',4,0}) // C¢digo del Grupo
       AADD(aDbfStr,{'cNombreEst','Character',30,0}) // Nombre del Estudiante
       AADD(aDbfStr,{'cApelliEst','Character',30,0}) // Apellido del Estudiante
       AADD(aDbfStr,{'cYear01Col','Character',4,0}) // A¤o de Procedencia
       AADD(aDbfStr,{'cGrad01Col','Character',20,0}) // Nombre del Grado
       AADD(aDbfStr,{'cCole01Col','Character',40,0}) // Nombre del Colegio
       AADD(aDbfStr,{'cCiud01Col','Character',40,0}) // Ciudad del Colegio
       AADD(aDbfStr,{'cYear02Col','Character',4,0}) // A¤o de Procedencia
       AADD(aDbfStr,{'cGrad02Col','Character',20,0}) // Nombre del Grado
       AADD(aDbfStr,{'cCole02Col','Character',40,0}) // Nombre del Colegio
       AADD(aDbfStr,{'cCiud02Col','Character',40,0}) // Ciudad del Colegio
       AADD(aDbfStr,{'cYear03Col','Character',4,0}) // A¤o de Procedencia
       AADD(aDbfStr,{'cGrad03Col','Character',20,0}) // Nombre del Grado
       AADD(aDbfStr,{'cCole03Col','Character',40,0}) // Nombre del Colegio
       AADD(aDbfStr,{'cCiud03Col','Character',40,0}) // Ciudad del Colegio
       AADD(aDbfStr,{'cYear04Col','Character',4,0}) // A¤o de Procedencia
       AADD(aDbfStr,{'cGrad04Col','Character',20,0}) // Nombre del Grado
       AADD(aDbfStr,{'cCole04Col','Character',40,0}) // Nombre del Colegio
       AADD(aDbfStr,{'cCiud04Col','Character',40,0}) // Ciudad del Colegio
       AADD(aDbfStr,{'cYear05Col','Character',4,0}) // A¤o de Procedencia
       AADD(aDbfStr,{'cGrad05Col','Character',20,0}) // Nombre del Grado
       AADD(aDbfStr,{'cCole05Col','Character',40,0}) // Nombre del Colegio
       AADD(aDbfStr,{'cCiud05Col','Character',40,0}) // Ciudad del Colegio
       AADD(aDbfStr,{'cYear06Col','Character',4,0}) // A¤o de Procedencia
       AADD(aDbfStr,{'cGrad06Col','Character',20,0}) // Nombre del Grado
       AADD(aDbfStr,{'cCole06Col','Character',40,0}) // Nombre del Colegio
       AADD(aDbfStr,{'cCiud06Col','Character',40,0}) // Ciudad del Colegio
       AADD(aDbfStr,{'cYear07Col','Character',4,0}) // A¤o de Procedencia
       AADD(aDbfStr,{'cGrad07Col','Character',20,0}) // Nombre del Grado
       AADD(aDbfStr,{'cCole07Col','Character',40,0}) // Nombre del Colegio
       AADD(aDbfStr,{'cCiud07Col','Character',40,0}) // Ciudad del Colegio
       AADD(aDbfStr,{'cYear08Col','Character',4,0}) // A¤o de Procedencia
       AADD(aDbfStr,{'cGrad08Col','Character',20,0}) // Nombre del Grado
       AADD(aDbfStr,{'cCole08Col','Character',40,0}) // Nombre del Colegio
       AADD(aDbfStr,{'cCiud08Col','Character',40,0}) // Ciudad del Colegio
       AADD(aDbfStr,{'cYear09Col','Character',4,0}) // A¤o de Procedencia
       AADD(aDbfStr,{'cGrad09Col','Character',20,0}) // Nombre del Grado
       AADD(aDbfStr,{'cCole09Col','Character',40,0}) // Nombre del Colegio
       AADD(aDbfStr,{'cCiud09Col','Character',40,0}) // Ciudad del Colegio
       AADD(aDbfStr,{'cYear10Col','Character',4,0}) // A¤o de Procedencia
       AADD(aDbfStr,{'cGrad10Col','Character',20,0}) // Nombre del Grado
       AADD(aDbfStr,{'cCole10Col','Character',40,0}) // Nombre del Colegio
       AADD(aDbfStr,{'cCiud10Col','Character',40,0}) // Ciudad del Colegio
       AADD(aDbfStr,{'cYear11Col','Character',4,0}) // A¤o de Procedencia
       AADD(aDbfStr,{'cGrad11Col','Character',20,0}) // Nombre del Grado
       AADD(aDbfStr,{'cCole11Col','Character',40,0}) // Nombre del Colegio
       AADD(aDbfStr,{'cCiud11Col','Character',40,0}) // Ciudad del Colegio
       AADD(aDbfStr,{'cYear12Col','Character',4,0}) // A¤o de Procedencia
       AADD(aDbfStr,{'cGrad12Col','Character',20,0}) // Nombre del Grado
       AADD(aDbfStr,{'cCole12Col','Character',40,0}) // Nombre del Colegio
       AADD(aDbfStr,{'cCiud12Col','Character',40,0}) // Ciudad del Colegio
       AADD(aDbfStr,{'cYear13Col','Character',4,0}) // A¤o de Procedencia
       AADD(aDbfStr,{'cGrad13Col','Character',20,0}) // Nombre del Grado
       AADD(aDbfStr,{'cCole13Col','Character',40,0}) // Nombre del Colegio
       AADD(aDbfStr,{'cCiud13Col','Character',40,0}) // Ciudad del Colegio
       AADD(aDbfStr,{'cYear14Col','Character',4,0}) // A¤o de Procedencia
       AADD(aDbfStr,{'cGrad14Col','Character',20,0}) // Nombre del Grado
       AADD(aDbfStr,{'cCole14Col','Character',40,0}) // Nombre del Colegio
       AADD(aDbfStr,{'cCiud14Col','Character',40,0}) // Ciudad del Colegio
       AADD(aDbfStr,{'cYear15Col','Character',4,0}) // A¤o de Procedencia
       AADD(aDbfStr,{'cGrad15Col','Character',20,0}) // Nombre del Grado
       AADD(aDbfStr,{'cCole15Col','Character',40,0}) // Nombre del Colegio
       AADD(aDbfStr,{'cCiud15Col','Character',40,0}) // Ciudad del Colegio
       AADD(aDbfStr,{'cYear16Col','Character',4,0}) // A¤o de Procedencia
       AADD(aDbfStr,{'cGrad16Col','Character',20,0}) // Nombre del Grado
       AADD(aDbfStr,{'cCole16Col','Character',40,0}) // Nombre del Colegio
       AADD(aDbfStr,{'cCiud16Col','Character',40,0}) // Ciudad del Colegio
       AADD(aDbfStr,{'cYear17Col','Character',4,0}) // A¤o de Procedencia
       AADD(aDbfStr,{'cGrad17Col','Character',20,0}) // Nombre del Grado
       AADD(aDbfStr,{'cCole17Col','Character',40,0}) // Nombre del Colegio
       AADD(aDbfStr,{'cCiud17Col','Character',40,0}) // Ciudad del Colegio

       AADD(aDbfStr,{'cNomUsrCol','Character',10,0}) // Nombre del Usuario
       AADD(aDbfStr,{'dFecUsrCol','Date'     ,08,0}) // Fecha del Usuario
       AADD(aDbfStr,{'cHorUsrCol','Character',10,0}) // Hora del Usuario
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

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: JUN  4/2014 MIE A
       Colombia, Bucaramanga        INICIO:  3:59 PM   JUN  4/2014 MIE

OBJETIVOS:

1- Recupera la estructura del archivo

2- Retorna NIL

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION RecuDbfCol(lShared,nModCry,PathArc,fArchvo)

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
       CreaDbfCol(lShared,nModCry,PathArc,fArchvo)
       RESTORE SCREEN
       RETURN NIL
*>>>>FIN RECUPERA LA ESTRUCTURA DEL ARCHIVO

/*************************************************************************
* TITULO..: ACTUALIZACION DE LA ESTRUCTURA                               *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: JUN  4/2014 MIE A
       Colombia, Bucaramanga        INICIO:  3:59 PM   JUN  4/2014 MIE

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

FUNCTION nActStrCol(lShared,nModCry,PathArc,cNomArc)

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
       CreaDbfCol(lShared,nModCry,PathArc,cNomArc,@aStrNew)
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
                         {||CreaDbfCol(lShared,nModCry,PathArc,FileTem)})
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

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: JUN  4/2014 MIE A
       Colombia, Bucaramanga        INICIO:  3:59 PM   JUN  4/2014 MIE

OBJETIVOS:

1- Permite el mantenimiento del archivo

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION MantenCol(lShared,nModCry,cNomSis,cCodEmp,cNitEmp,cEmpPal,;
		   cNomEmp,cNomSec,cNomUsr,cAnoUsr,aArchvo,lPrnArc,;
		   cOpcPrn,nCodPrn,lModReg,lDelReg,lInsReg,lHaySql)

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
       aArchvo                              // Archivos en Uso
       lPrnArc                              // .T. Imprimir a Archivo
       cOpcPrn                              // Opciones de Impresi¢n
       nCodPrn                              // C¢digo de Impresi¢n 
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

       LOCAL       i := 0                   // Contador
       LOCAL lHayPrn := .F.                 // .T. Hay Archivo de Impresi¢n
       LOCAL aUseDbf := {}                  // Archivos en Uso
       LOCAL fArchvo := ''                  // Nombre del Archivo
       LOCAL fNtxArc := ''                  // Archivo Indice
       LOCAL cNalias := ''                  // Alias del Archivo
       LOCAL oBrowse := NIL                 // Browse
*>>>>FIN DECLARACION DE VARIABLES

*>>>>AREAS DE TRABAJO
       aUseDbf := {}
       FOR i := 1 TO LEN(aArchvo)
           fArchvo := aArchvo[i,1]
           fNtxArc := aArchvo[i,2]
           cNalias := aArchvo[i,3]
           AADD(aUseDbf,{.T.,fArchvo,cNalias,fNtxArc,lShared,nModCry})
           IF cNalias == 'PRN'
              lHayPrn := .T.
           ENDIF
       ENDFOR
*>>>>FIN AREAS DE TRABAJO

*>>>>SELECION DE LAS AREAS DE TRABAJO
       IF !lUseDbfs(aUseDbf)
          cError('ABRIENDO EL ARCHIVO')
          CloseAll()
          RETURN NIL
       ENDIF
*>>>>FIN SELECION DE LAS AREAS DE TRABAJO

*>>>>LOCALIZACION DE LA IMPRESORA
       IF lHayPrn
          IF !lLocCodigo('nCodigoPrn','PRN',nCodPrn)
             cError('NO EXISTE LA IMPRESORA QUE ESTA HABILITADA')
             CloseAll()
             RETURN NIL
          ENDIF
       ENDIF
*>>>>FIN LOCALIZACION DE LA IMPRESORA

*>>>>PARAMETROS POR DEFECTO
       lModReg := IF(EMPTY(lModReg),.F.,lModReg)
       lModReg := IF(lModReg .AND. COL->(RECCOUNT())==0,.F.,lModReg)

       lDelReg := IF(lDelReg==NIL,.F.,lDelReg)

       lInsReg := IF(lInsReg==NIL,.F.,lInsReg)

       lHaySql := IF(lHaySql==NIL,.F.,lHaySql)
*>>>>FIN PARAMETROS POR DEFECTO

*>>>>MANTENIMIENTO DEL ARCHIVO
       oBrowse := oBrwDbfCol(lShared,cNomUsr,cAnoUsr,03,00,22,79,;
                             lModReg,lDelReg,lInsReg,lHaySql)

       SETKEY(K_F2,{||lManRegCol(lShared,cNomUsr,3,oBrowse)})
     *ÀConsulta

       IF lModReg
          SETKEY(K_F4,{||lManRegCol(lShared,cNomUsr,2,oBrowse,;
                                    COL->cCodigoEst)})
       ENDIF
     *ÀActualizar

       SETKEY(K_F5,{||BuscarCol(oBrowse)})

       SETKEY(K_F9,{||MenuOtrCol(lShared,nModCry,cNomSis,cCodEmp,cNitEmp,;
                                 cEmpPal,cNomEmp,cNomSec,cNomUsr,cAnoUsr,;
                                 aArchvo,lPrnArc,cOpcPrn,nCodPrn,lModReg,;
                                 lDelReg,lInsReg,lHaySql,oBrowse)})

       COL->(CtrlBrw(lShared,oBrowse))

       SETKEY(K_F2,NIL)
       SETKEY(K_F4,NIL)
       SETKEY(K_F5,NIL)
       SETKEY(K_F9,NIL)
       CloseAll()
       RETURN NIL
*>>>>FIN MANTENIMIENTO DEL ARCHIVO

/*************************************************************************
* TITULO..: DEFINICION DEL OBJETO BROWSE                                 *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: JUN  4/2014 MIE A
       Colombia, Bucaramanga        INICIO:  3:59 PM   JUN  4/2014 MIE

OBJETIVOS:

1- Define el objeto Browse del archivo

SINTAXIS:

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION oBrwDbfCol(lShared,cNomUsr,cAnoUsr,nFilSup,nColSup,nFilInf,nColInf,;
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

       cTitSup := '<< COLEGIOS PROCEDENCIA >>'
       cTitInf := '<F2>Consultar <F5>Buscar'+;
                   IF(lModReg,' <F4>Actualizar','')+' <F9>Otros'+;
                   IF(lDelReg,' <DEL>Borrar','')+;
                   IF(lInsReg,' <INS>Incluir','')

       IF lInsReg
          oBrowse:Cargo := {cTitSup,cTitInf,{||lManRegCol(lShared,cNomUsr)}}
       ELSE
          oBrowse:Cargo := {cTitSup,cTitInf}
       ENDIF
     *ÀDefinici¢n de cabeceras y l¡neas de cabeceras

       SELECT COL
       oColumn := TBCOLUMNNEW('CODIGO;DEL ESTUDIANTE',{||COL->cCodigoEst})
       oColumn:Cargo := {{'MODI',.F.},{'ALIAS','COL'},;
			 {'FIELD','cCodigoEst'},{'PICTURE','999999'}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn := TBCOLUMNNEW('CODIGO;DEL GRUPO',{||COL->cCodigoGru})
       oColumn:Cargo := {{'MODI',.F.},{'ALIAS','COL'},;
			 {'FIELD','cCodigoGru'},{'PICTURE','9999'}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn := TBCOLUMNNEW('NOMBRE;DEL ESTUDIANTE',{||COL->cNombreEst})
       oColumn:Cargo := {{'MODI',.T.},{'ALIAS','COL'},;
			 {'FIELD','cNombreEst'},{'PICTURE','@!'}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn := TBCOLUMNNEW('APELLIDO;DEL ESTUDIANTE',{||COL->cApelliEst})
       oColumn:Cargo := {{'MODI',.T.},{'ALIAS','COL'},;
			 {'FIELD','cApelliEst'},{'PICTURE','@!'}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn := TBCOLUMNNEW('A¥O',{||COL->cYear01Col})
       oColumn:Cargo := {{'MODI',.T.},{'ALIAS','COL'},;
			 {'FIELD','cYear01Col'},{'PICTURE','9999'}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn := TBCOLUMNNEW('GRADO01',{||COL->cGrad01Col})
       oColumn:Cargo := {{'MODI',.T.},{'ALIAS','COL'},;
			 {'FIELD','cGrad01Col'},{'PICTURE','@!A'}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn := TBCOLUMNNEW('COLEGIO 01',{||COL->cCole01Col})
       oColumn:Cargo := {{'MODI',.T.},{'ALIAS','COL'},;
			 {'FIELD','cCole01Col'},{'PICTURE','@!A'}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn := TBCOLUMNNEW('CIUDAD 01',{||COL->cCiud01Col})
       oColumn:Cargo := {{'MODI',.T.},{'ALIAS','COL'},;
			 {'FIELD','cCiud01Col'},{'PICTURE','@!A'}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn := TBCOLUMNNEW('A¥O',{||COL->cYear02Col})
       oColumn:Cargo := {{'MODI',.T.},{'ALIAS','COL'},;
			 {'FIELD','cYear02Col'},{'PICTURE','9999'}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn := TBCOLUMNNEW('GRADO02',{||COL->cGrad02Col})
       oColumn:Cargo := {{'MODI',.T.},{'ALIAS','COL'},;
			 {'FIELD','cGrad02Col'},{'PICTURE','@!A'}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn := TBCOLUMNNEW('COLEGIO 02',{||COL->cCole02Col})
       oColumn:Cargo := {{'MODI',.T.},{'ALIAS','COL'},;
			 {'FIELD','cCole02Col'},{'PICTURE','@!A'}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn := TBCOLUMNNEW('CIUDAD 02',{||COL->cCiud02Col})
       oColumn:Cargo := {{'MODI',.T.},{'ALIAS','COL'},;
			 {'FIELD','cCiud02Col'},{'PICTURE','@!A'}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn := TBCOLUMNNEW('A¥O',{||COL->cYear03Col})
       oColumn:Cargo := {{'MODI',.T.},{'ALIAS','COL'},;
			 {'FIELD','cYear03Col'},{'PICTURE','9999'}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn := TBCOLUMNNEW('GRADO03',{||COL->cGrad03Col})
       oColumn:Cargo := {{'MODI',.T.},{'ALIAS','COL'},;
			 {'FIELD','cGrad03Col'},{'PICTURE','@!A'}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn := TBCOLUMNNEW('COLEGIO 03',{||COL->cCole03Col})
       oColumn:Cargo := {{'MODI',.T.},{'ALIAS','COL'},;
			 {'FIELD','cCole03Col'},{'PICTURE','@!A'}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn := TBCOLUMNNEW('CIUDAD 03',{||COL->cCiud03Col})
       oColumn:Cargo := {{'MODI',.T.},{'ALIAS','COL'},;
			 {'FIELD','cCiud03Col'},{'PICTURE','@!A'}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn := TBCOLUMNNEW('A¥O',{||COL->cYear04Col})
       oColumn:Cargo := {{'MODI',.T.},{'ALIAS','COL'},;
			 {'FIELD','cYear04Col'},{'PICTURE','9999'}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn := TBCOLUMNNEW('GRADO04',{||COL->cGrad04Col})
       oColumn:Cargo := {{'MODI',.T.},{'ALIAS','COL'},;
			 {'FIELD','cGrad04Col'},{'PICTURE','@!A'}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn := TBCOLUMNNEW('COLEGIO 04',{||COL->cCole04Col})
       oColumn:Cargo := {{'MODI',.T.},{'ALIAS','COL'},;
			 {'FIELD','cCole04Col'},{'PICTURE','@!A'}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn := TBCOLUMNNEW('CIUDAD 04',{||COL->cCiud04Col})
       oColumn:Cargo := {{'MODI',.T.},{'ALIAS','COL'},;
			 {'FIELD','cCiud04Col'},{'PICTURE','@!A'}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn := TBCOLUMNNEW('A¥O',{||COL->cYear05Col})
       oColumn:Cargo := {{'MODI',.T.},{'ALIAS','COL'},;
			 {'FIELD','cYear05Col'},{'PICTURE','9999'}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn := TBCOLUMNNEW('GRADO05',{||COL->cGrad05Col})
       oColumn:Cargo := {{'MODI',.T.},{'ALIAS','COL'},;
			 {'FIELD','cGrad05Col'},{'PICTURE','@!A'}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn := TBCOLUMNNEW('COLEGIO 05',{||COL->cCole05Col})
       oColumn:Cargo := {{'MODI',.T.},{'ALIAS','COL'},;
			 {'FIELD','cCole05Col'},{'PICTURE','@!A'}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn := TBCOLUMNNEW('CIUDAD 05',{||COL->cCiud05Col})
       oColumn:Cargo := {{'MODI',.T.},{'ALIAS','COL'},;
			 {'FIELD','cCiud05Col'},{'PICTURE','@!A'}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn := TBCOLUMNNEW('A¥O',{||COL->cYear06Col})
       oColumn:Cargo := {{'MODI',.T.},{'ALIAS','COL'},;
			 {'FIELD','cYear06Col'},{'PICTURE','9999'}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn := TBCOLUMNNEW('GRADO06',{||COL->cGrad06Col})
       oColumn:Cargo := {{'MODI',.T.},{'ALIAS','COL'},;
			 {'FIELD','cGrad06Col'},{'PICTURE','@!A'}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn := TBCOLUMNNEW('COLEGIO 06',{||COL->cCole06Col})
       oColumn:Cargo := {{'MODI',.T.},{'ALIAS','COL'},;
			 {'FIELD','cCole06Col'},{'PICTURE','@!A'}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn := TBCOLUMNNEW('CIUDAD 06',{||COL->cCiud06Col})
       oColumn:Cargo := {{'MODI',.T.},{'ALIAS','COL'},;
			 {'FIELD','cCiud06Col'},{'PICTURE','@!A'}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn := TBCOLUMNNEW('A¥O',{||COL->cYear07Col})
       oColumn:Cargo := {{'MODI',.T.},{'ALIAS','COL'},;
			 {'FIELD','cYear07Col'},{'PICTURE','9999'}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn := TBCOLUMNNEW('GRADO07',{||COL->cGrad07Col})
       oColumn:Cargo := {{'MODI',.T.},{'ALIAS','COL'},;
			 {'FIELD','cGrad07Col'},{'PICTURE','@!A'}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn := TBCOLUMNNEW('COLEGIO 07',{||COL->cCole07Col})
       oColumn:Cargo := {{'MODI',.T.},{'ALIAS','COL'},;
			 {'FIELD','cCole07Col'},{'PICTURE','@!A'}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn := TBCOLUMNNEW('CIUDAD 07',{||COL->cCiud07Col})
       oColumn:Cargo := {{'MODI',.T.},{'ALIAS','COL'},;
			 {'FIELD','cCiud07Col'},{'PICTURE','@!A'}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn := TBCOLUMNNEW('A¥O',{||COL->cYear08Col})
       oColumn:Cargo := {{'MODI',.T.},{'ALIAS','COL'},;
			 {'FIELD','cYear08Col'},{'PICTURE','9999'}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn := TBCOLUMNNEW('GRADO08',{||COL->cGrad08Col})
       oColumn:Cargo := {{'MODI',.T.},{'ALIAS','COL'},;
			 {'FIELD','cGrad08Col'},{'PICTURE','@!A'}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn := TBCOLUMNNEW('COLEGIO 08',{||COL->cCole08Col})
       oColumn:Cargo := {{'MODI',.T.},{'ALIAS','COL'},;
			 {'FIELD','cCole08Col'},{'PICTURE','@!A'}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn := TBCOLUMNNEW('CIUDAD 08',{||COL->cCiud08Col})
       oColumn:Cargo := {{'MODI',.T.},{'ALIAS','COL'},;
			 {'FIELD','cCiud08Col'},{'PICTURE','@!A'}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn := TBCOLUMNNEW('A¥O',{||COL->cYear09Col})
       oColumn:Cargo := {{'MODI',.T.},{'ALIAS','COL'},;
			 {'FIELD','cYear09Col'},{'PICTURE','9999'}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn := TBCOLUMNNEW('GRADO09',{||COL->cGrad09Col})
       oColumn:Cargo := {{'MODI',.T.},{'ALIAS','COL'},;
			 {'FIELD','cGrad09Col'},{'PICTURE','@!A'}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn := TBCOLUMNNEW('COLEGIO 09',{||COL->cCole09Col})
       oColumn:Cargo := {{'MODI',.T.},{'ALIAS','COL'},;
			 {'FIELD','cCole09Col'},{'PICTURE','@!A'}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn := TBCOLUMNNEW('CIUDAD 09',{||COL->cCiud09Col})
       oColumn:Cargo := {{'MODI',.T.},{'ALIAS','COL'},;
			 {'FIELD','cCiud09Col'},{'PICTURE','@!A'}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn := TBCOLUMNNEW('A¥O',{||COL->cYear10Col})
       oColumn:Cargo := {{'MODI',.T.},{'ALIAS','COL'},;
			 {'FIELD','cYear10Col'},{'PICTURE','9999'}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn := TBCOLUMNNEW('GRADO10',{||COL->cGrad10Col})
       oColumn:Cargo := {{'MODI',.T.},{'ALIAS','COL'},;
			 {'FIELD','cGrad10Col'},{'PICTURE','@!A'}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn := TBCOLUMNNEW('COLEGIO 10',{||COL->cCole10Col})
       oColumn:Cargo := {{'MODI',.T.},{'ALIAS','COL'},;
			 {'FIELD','cCole10Col'},{'PICTURE','@!A'}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn := TBCOLUMNNEW('CIUDAD 10',{||COL->cCiud10Col})
       oColumn:Cargo := {{'MODI',.T.},{'ALIAS','COL'},;
			 {'FIELD','cCiud10Col'},{'PICTURE','@!A'}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn := TBCOLUMNNEW('A¥O',{||COL->cYear11Col})
       oColumn:Cargo := {{'MODI',.T.},{'ALIAS','COL'},;
			 {'FIELD','cYear11Col'},{'PICTURE','9999'}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn := TBCOLUMNNEW('GRADO11',{||COL->cGrad11Col})
       oColumn:Cargo := {{'MODI',.T.},{'ALIAS','COL'},;
			 {'FIELD','cGrad11Col'},{'PICTURE','@!A'}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn := TBCOLUMNNEW('COLEGIO 11',{||COL->cCole11Col})
       oColumn:Cargo := {{'MODI',.T.},{'ALIAS','COL'},;
			 {'FIELD','cCole11Col'},{'PICTURE','@!A'}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn := TBCOLUMNNEW('CIUDAD 11',{||COL->cCiud11Col})
       oColumn:Cargo := {{'MODI',.T.},{'ALIAS','COL'},;
			 {'FIELD','cCiud11Col'},{'PICTURE','@!A'}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn := TBCOLUMNNEW('A¥O',{||COL->cYear12Col})
       oColumn:Cargo := {{'MODI',.T.},{'ALIAS','COL'},;
			 {'FIELD','cYear12Col'},{'PICTURE','9999'}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn := TBCOLUMNNEW('GRADO12',{||COL->cGrad12Col})
       oColumn:Cargo := {{'MODI',.T.},{'ALIAS','COL'},;
			 {'FIELD','cGrad12Col'},{'PICTURE','@!A'}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn := TBCOLUMNNEW('COLEGIO 12',{||COL->cCole12Col})
       oColumn:Cargo := {{'MODI',.T.},{'ALIAS','COL'},;
			 {'FIELD','cCole12Col'},{'PICTURE','@!A'}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn := TBCOLUMNNEW('CIUDAD 12',{||COL->cCiud12Col})
       oColumn:Cargo := {{'MODI',.T.},{'ALIAS','COL'},;
			 {'FIELD','cCiud12Col'},{'PICTURE','@!A'}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn := TBCOLUMNNEW('A¥O',{||COL->cYear13Col})
       oColumn:Cargo := {{'MODI',.T.},{'ALIAS','COL'},;
			 {'FIELD','cYear13Col'},{'PICTURE','9999'}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn := TBCOLUMNNEW('GRADO13',{||COL->cGrad13Col})
       oColumn:Cargo := {{'MODI',.T.},{'ALIAS','COL'},;
			 {'FIELD','cGrad13Col'},{'PICTURE','@!A'}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn := TBCOLUMNNEW('COLEGIO 13',{||COL->cCole13Col})
       oColumn:Cargo := {{'MODI',.T.},{'ALIAS','COL'},;
			 {'FIELD','cCole13Col'},{'PICTURE','@!A'}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn := TBCOLUMNNEW('CIUDAD 13',{||COL->cCiud13Col})
       oColumn:Cargo := {{'MODI',.T.},{'ALIAS','COL'},;
			 {'FIELD','cCiud13Col'},{'PICTURE','@!A'}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn := TBCOLUMNNEW('A¥O',{||COL->cYear14Col})
       oColumn:Cargo := {{'MODI',.T.},{'ALIAS','COL'},;
			 {'FIELD','cYear14Col'},{'PICTURE','9999'}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn := TBCOLUMNNEW('GRADO14',{||COL->cGrad14Col})
       oColumn:Cargo := {{'MODI',.T.},{'ALIAS','COL'},;
			 {'FIELD','cGrad14Col'},{'PICTURE','@!A'}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn := TBCOLUMNNEW('COLEGIO 14',{||COL->cCole14Col})
       oColumn:Cargo := {{'MODI',.T.},{'ALIAS','COL'},;
			 {'FIELD','cCole14Col'},{'PICTURE','@!A'}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn := TBCOLUMNNEW('CIUDAD 14',{||COL->cCiud14Col})
       oColumn:Cargo := {{'MODI',.T.},{'ALIAS','COL'},;
			 {'FIELD','cCiud14Col'},{'PICTURE','@!A'}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn := TBCOLUMNNEW('A¥O',{||COL->cYear15Col})
       oColumn:Cargo := {{'MODI',.T.},{'ALIAS','COL'},;
			 {'FIELD','cYear15Col'},{'PICTURE','9999'}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn := TBCOLUMNNEW('GRADO15',{||COL->cGrad15Col})
       oColumn:Cargo := {{'MODI',.T.},{'ALIAS','COL'},;
			 {'FIELD','cGrad15Col'},{'PICTURE','@!A'}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn := TBCOLUMNNEW('COLEGIO 15',{||COL->cCole15Col})
       oColumn:Cargo := {{'MODI',.T.},{'ALIAS','COL'},;
			 {'FIELD','cCole15Col'},{'PICTURE','@!A'}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn := TBCOLUMNNEW('CIUDAD 15',{||COL->cCiud15Col})
       oColumn:Cargo := {{'MODI',.T.},{'ALIAS','COL'},;
			 {'FIELD','cCiud15Col'},{'PICTURE','@!A'}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn := TBCOLUMNNEW('A¥O',{||COL->cYear16Col})
       oColumn:Cargo := {{'MODI',.T.},{'ALIAS','COL'},;
			 {'FIELD','cYear16Col'},{'PICTURE','9999'}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn := TBCOLUMNNEW('GRADO16',{||COL->cGrad16Col})
       oColumn:Cargo := {{'MODI',.T.},{'ALIAS','COL'},;
			 {'FIELD','cGrad16Col'},{'PICTURE','@!A'}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn := TBCOLUMNNEW('COLEGIO 16',{||COL->cCole16Col})
       oColumn:Cargo := {{'MODI',.T.},{'ALIAS','COL'},;
			 {'FIELD','cCole16Col'},{'PICTURE','@!A'}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn := TBCOLUMNNEW('CIUDAD 16',{||COL->cCiud16Col})
       oColumn:Cargo := {{'MODI',.T.},{'ALIAS','COL'},;
			 {'FIELD','cCiud16Col'},{'PICTURE','@!A'}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn := TBCOLUMNNEW('A¥O',{||COL->cYear17Col})
       oColumn:Cargo := {{'MODI',.T.},{'ALIAS','COL'},;
			 {'FIELD','cYear17Col'},{'PICTURE','9999'}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn := TBCOLUMNNEW('GRADO17',{||COL->cGrad17Col})
       oColumn:Cargo := {{'MODI',.T.},{'ALIAS','COL'},;
			 {'FIELD','cGrad17Col'},{'PICTURE','@!A'}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn := TBCOLUMNNEW('COLEGIO 17',{||COL->cCole17Col})
       oColumn:Cargo := {{'MODI',.T.},{'ALIAS','COL'},;
			 {'FIELD','cCole17Col'},{'PICTURE','@!A'}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn := TBCOLUMNNEW('CIUDAD 17',{||COL->cCiud17Col})
       oColumn:Cargo := {{'MODI',.T.},{'ALIAS','COL'},;
			 {'FIELD','cCiud17Col'},{'PICTURE','@!A'}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn	     := TBCOLUMNNEW('NOMBRE;DEL USUARIO',{||COL->cNomUsrCol})
       oColumn:Cargo := {{'MODI',.F.}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn	     := TBCOLUMNNEW('FECHA DE;PROCESO',;
				    {||cFecha(COL->dFecUsrCol)})
       oColumn:Cargo := {{'MODI',.F.}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn	     := TBCOLUMNNEW('HORA DE;PROCESO',;
				    {||cHoraSys(COL->cHorUsrCol)})
       oColumn:Cargo := {{'MODI',.F.}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn	     := TBCOLUMNNEW('CODIGO',{||COL->nIdeCodCol})
       oColumn:Cargo := {{'MODI',.F.}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn	     := TBCOLUMNNEW('No.',{||COL->(RECNO())})
       oColumn:Cargo := {{'MODI',.F.}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       RETURN oBrowse
*>>>>FIN DEFINICION DEL OBJETO BROWSE

/*************************************************************************
* TITULO..: MANTENIMIENTO DEL REGISTRO                                   *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: JUN  4/2014 MIE A
       Colombia, Bucaramanga        INICIO:  3:59 PM   JUN  4/2014 MIE

OBJETIVOS:

1- Permite inclusi¢n,modificaci¢n y consulta del registro

2- Puede invocarse en la lectura a trav‚s de la clausula VALID

2- Returna .T.

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION lManRegCol(lShared,cNomUsr,nTipMod,oBrowse,cCodigo,nNroOpc)

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

       LOCAL cCodigoTes := ''               // C¢digo del Grupo                                            
       LOCAL cNombreTes := ''               // Nombre del Estudiante                                       
       LOCAL cApelliTes := ''               // Apellido del Estudiante                                     
       LOCAL cYear01Tcg := ''               // A¤o de Procedencia                                          
       LOCAL cGrad01Tcg := ''               // Nombre del Grado                                            
       LOCAL cCole01Tcg := ''               // Nombre del Colegio                                          
       LOCAL cCiud01Tcg := ''               // Ciudad del Colegio                                          
       LOCAL cYear02Tcg := ''               // A¤o de Procedencia                                          
       LOCAL cGrad02Tcg := ''               // Nombre del Grado                                            
       LOCAL cCole02Tcg := ''               // Nombre del Colegio                                          
       LOCAL cCiud02Tcg := ''               // Ciudad del Colegio                                          
       LOCAL cYear03Tcg := ''               // A¤o de Procedencia                                          
       LOCAL cGrad03Tcg := ''               // Nombre del Grado                                            
       LOCAL cCole03Tcg := ''               // Nombre del Colegio                                          
       LOCAL cCiud03Tcg := ''               // Ciudad del Colegio                                          
       LOCAL cYear04Tcg := ''               // A¤o de Procedencia                                          
       LOCAL cGrad04Tcg := ''               // Nombre del Grado                                            
       LOCAL cCole04Tcg := ''               // Nombre del Colegio                                          
       LOCAL cCiud04Tcg := ''               // Ciudad del Colegio                                          
       LOCAL cYear05Tcg := ''               // A¤o de Procedencia                                          
       LOCAL cGrad05Tcg := ''               // Nombre del Grado                                            
       LOCAL cCole05Tcg := ''               // Nombre del Colegio                                          
       LOCAL cCiud05Tcg := ''               // Ciudad del Colegio                                          
       LOCAL cYear06Tcg := ''               // A¤o de Procedencia                                          
       LOCAL cGrad06Tcg := ''               // Nombre del Grado                                            
       LOCAL cCole06Tcg := ''               // Nombre del Colegio                                          
       LOCAL cCiud06Tcg := ''               // Ciudad del Colegio                                          
       LOCAL cYear07Tcg := ''               // A¤o de Procedencia                                          
       LOCAL cGrad07Tcg := ''               // Nombre del Grado                                            
       LOCAL cCole07Tcg := ''               // Nombre del Colegio                                          
       LOCAL cCiud07Tcg := ''               // Ciudad del Colegio                                          
       LOCAL cYear08Tcg := ''               // A¤o de Procedencia                                          
       LOCAL cGrad08Tcg := ''               // Nombre del Grado                                            
       LOCAL cCole08Tcg := ''               // Nombre del Colegio                                          
       LOCAL cCiud08Tcg := ''               // Ciudad del Colegio                                          
       LOCAL cYear09Tcg := ''               // A¤o de Procedencia                                          
       LOCAL cGrad09Tcg := ''               // Nombre del Grado                                            
       LOCAL cCole09Tcg := ''               // Nombre del Colegio                                          
       LOCAL cCiud09Tcg := ''               // Ciudad del Colegio                                          
       LOCAL cYear10Tcg := ''               // A¤o de Procedencia                                          
       LOCAL cGrad10Tcg := ''               // Nombre del Grado                                            
       LOCAL cCole10Tcg := ''               // Nombre del Colegio                                          
       LOCAL cCiud10Tcg := ''               // Ciudad del Colegio                                          
       LOCAL cYear11Tcg := ''               // A¤o de Procedencia                                          
       LOCAL cGrad11Tcg := ''               // Nombre del Grado                                            
       LOCAL cCole11Tcg := ''               // Nombre del Colegio                                          
       LOCAL cCiud11Tcg := ''               // Ciudad del Colegio                                          
       LOCAL cYear12Tcg := ''               // A¤o de Procedencia                                          
       LOCAL cGrad12Tcg := ''               // Nombre del Grado                                            
       LOCAL cCole12Tcg := ''               // Nombre del Colegio                                          
       LOCAL cCiud12Tcg := ''               // Ciudad del Colegio                                          
       LOCAL cYear13Tcg := ''               // A¤o de Procedencia                                          
       LOCAL cGrad13Tcg := ''               // Nombre del Grado                                            
       LOCAL cCole13Tcg := ''               // Nombre del Colegio                                          
       LOCAL cCiud13Tcg := ''               // Ciudad del Colegio                                          
       LOCAL cYear14Tcg := ''               // A¤o de Procedencia                                          
       LOCAL cGrad14Tcg := ''               // Nombre del Grado                                            
       LOCAL cCole14Tcg := ''               // Nombre del Colegio                                          
       LOCAL cCiud14Tcg := ''               // Ciudad del Colegio                                          
       LOCAL cYear15Tcg := ''               // A¤o de Procedencia                                          
       LOCAL cGrad15Tcg := ''               // Nombre del Grado                                            
       LOCAL cCole15Tcg := ''               // Nombre del Colegio                                          
       LOCAL cCiud15Tcg := ''               // Ciudad del Colegio                                          
       LOCAL cYear16Tcg := ''               // A¤o de Procedencia                                          
       LOCAL cGrad16Tcg := ''               // Nombre del Grado                                            
       LOCAL cCole16Tcg := ''               // Nombre del Colegio                                          
       LOCAL cCiud16Tcg := ''               // Ciudad del Colegio                                          
       LOCAL cYear17Tcg := ''               // A¤o de Procedencia                                          
       LOCAL cGrad17Tcg := ''               // Nombre del Grado                                            
       LOCAL cCole17Tcg := ''               // Nombre del Colegio                                          
       LOCAL cCiud17Tcg := ''               // Ciudad del Colegio                                          

       LOCAL GetList := {}                 // Variable del sistema
*>>>>FIN DECLARACION DE VARIABLES

*>>>>DECLARACION DEL MENU
       nTipMod := IF(nTipMod==NIL,1,nTipMod)

       AADD(aMenus,'1<INFORMACION BASICA>')

       AADD(aAyuda,IF(nTipMod==3,'Consulta','Actualiza')+' '+;
                   'la Informaci¢n B sica.')

       cSavPan := SAVESCREEN(0,0,24,79)
       nNroOpc := IF(nNroOpc==NIL,1,nNroOpc)
       IF EMPTY(nNroOpc)

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
            cTxtTem := 'COLEGIOS PROCEDENCIA .INCLUIR. '+aMenus[nNroOpc]
            COL->(DBGOBOTTOM())
            COL->(DBSKIP())
            nTipCur := SETCURSOR(1)

       CASE nTipMod == 2
            cTxtTem := 'COLEGIOS PROCEDENCIA .ACTUALIZAR. '+aMenus[nNroOpc]
            nTipCur := SETCURSOR(1)

       CASE nTipMod == 3
            cTxtTem := 'COLEGIOS PROCEDENCIA. CONSUTA. '+aMenus[nNroOpc]
       ENDCASE
       nFilIni := nMarco(03,cTxtTem,22,'°')
*>>>>FIN MARCO DEL MANTENIMIENTO

*>>>>MANTENIMIENTO DEL REGISTRO
       SELECT COL
       DO WHILE .T.

**********INICIALIZACION DE LAS VARIABLES
            IF lGrabar

               IF EMPTY(cCodigo)
                  cCodigo := COL->cCodigoEst
               ENDIF

               cCodigoTes := COL->cCodigoGru
               cNombreTes := COL->cNombreEst
               cApelliTes := COL->cApelliEst
               cYear01Tcg := COL->cYear01Col
               cGrad01Tcg := COL->cGrad01Col
               cCole01Tcg := COL->cCole01Col
               cCiud01Tcg := COL->cCiud01Col
               cYear02Tcg := COL->cYear02Col
               cGrad02Tcg := COL->cGrad02Col
               cCole02Tcg := COL->cCole02Col
               cCiud02Tcg := COL->cCiud02Col
               cYear03Tcg := COL->cYear03Col
               cGrad03Tcg := COL->cGrad03Col
               cCole03Tcg := COL->cCole03Col
               cCiud03Tcg := COL->cCiud03Col
               cYear04Tcg := COL->cYear04Col
               cGrad04Tcg := COL->cGrad04Col
               cCole04Tcg := COL->cCole04Col
               cCiud04Tcg := COL->cCiud04Col
               cYear05Tcg := COL->cYear05Col
               cGrad05Tcg := COL->cGrad05Col
               cCole05Tcg := COL->cCole05Col
               cCiud05Tcg := COL->cCiud05Col
               cYear06Tcg := COL->cYear06Col
               cGrad06Tcg := COL->cGrad06Col
               cCole06Tcg := COL->cCole06Col
               cCiud06Tcg := COL->cCiud06Col
               cYear07Tcg := COL->cYear07Col
               cGrad07Tcg := COL->cGrad07Col
               cCole07Tcg := COL->cCole07Col
               cCiud07Tcg := COL->cCiud07Col
               cYear08Tcg := COL->cYear08Col
               cGrad08Tcg := COL->cGrad08Col
               cCole08Tcg := COL->cCole08Col
               cCiud08Tcg := COL->cCiud08Col
               cYear09Tcg := COL->cYear09Col
               cGrad09Tcg := COL->cGrad09Col
               cCole09Tcg := COL->cCole09Col
               cCiud09Tcg := COL->cCiud09Col
               cYear10Tcg := COL->cYear10Col
               cGrad10Tcg := COL->cGrad10Col
               cCole10Tcg := COL->cCole10Col
               cCiud10Tcg := COL->cCiud10Col
               cYear11Tcg := COL->cYear11Col
               cGrad11Tcg := COL->cGrad11Col
               cCole11Tcg := COL->cCole11Col
               cCiud11Tcg := COL->cCiud11Col
               cYear12Tcg := COL->cYear12Col
               cGrad12Tcg := COL->cGrad12Col
               cCole12Tcg := COL->cCole12Col
               cCiud12Tcg := COL->cCiud12Col
               cYear13Tcg := COL->cYear13Col
               cGrad13Tcg := COL->cGrad13Col
               cCole13Tcg := COL->cCole13Col
               cCiud13Tcg := COL->cCiud13Col
               cYear14Tcg := COL->cYear14Col
               cGrad14Tcg := COL->cGrad14Col
               cCole14Tcg := COL->cCole14Col
               cCiud14Tcg := COL->cCiud14Col
               cYear15Tcg := COL->cYear15Col
               cGrad15Tcg := COL->cGrad15Col
               cCole15Tcg := COL->cCole15Col
               cCiud15Tcg := COL->cCiud15Col
               cYear16Tcg := COL->cYear16Col
               cGrad16Tcg := COL->cGrad16Col
               cCole16Tcg := COL->cCole16Col
               cCiud16Tcg := COL->cCiud16Col
               cYear17Tcg := COL->cYear17Col
               cGrad17Tcg := COL->cGrad17Col
               cCole17Tcg := COL->cCole17Col
               cCiud17Tcg := COL->cCiud17Col
            ENDIF
**********FIN INICIALIZACION DE LAS VARIABLES

**********LECTURA DE CAMPO
            IF nNroOpc == 1

               nNroFil := nFilIni
               cTxtTem := 'CODIGO DEL ESTUDIANTE :'

               IF nTipMod == 2 .OR. nTipMod == 3 .OR. !EMPTY(cCodigo)
                  @ nNroFil,nNroCol SAY cTxtTem
                  @ nNroFil,nNroCol+LEN(cTxtTem)+1 SAY cCodigo COLOR('I')
               ELSE
                  @ nNroFil,nNroCol SAY cTxtTem;
                                    GET cCodigo PICT '999999';
                                    VALID !EMPTY(cCodigo) .AND.;
                                          !lValCodCol(cCodigo)
               ENDIF

	    ENDIF
**********FIN LECTURA DE CAMPO

**********LECTURA DE CAMPO
            IF nNroOpc == 1

               nNroFil++
               nColTem := nNroCol
               cTxtTem := 'CODIGO DEL GRUPO      :'

               IF nTipMod == 3
                  @ nNroFil,nColTem SAY cTxtTem
                  @ nNroFil,nColTem+LEN(cTxtTem)+1 SAY cCodigoTes COLOR('I')
               ELSE
                  @ nNroFil,nColTem SAY cTxtTem;
                                    GET cCodigoTes PICT '9999';
                                    VALID !EMPTY(cCodigoTes);
                                    WHEN {||HelpRead('FAVOR INGRESE EL CODIGO DEL GRUPO')}
               ENDIF

	    ENDIF
**********FIN LECTURA DE CAMPO

**********LECTURA DE CAMPO
            IF nNroOpc == 1

               nNroFil++
               nColTem := nNroCol
               cTxtTem := 'NOMBRE DEL ESTUDIANTE :'

               IF nTipMod == 3
                  @ nNroFil,nColTem SAY cTxtTem
                  @ nNroFil,nColTem+LEN(cTxtTem)+1 SAY cNombreTes COLOR('I')
               ELSE
                  @ nNroFil,nColTem SAY cTxtTem;
                                    GET cNombreTes PICT '@!';
                                    VALID !EMPTY(cNombreTes);
                                    WHEN {||HelpRead('FAVOR INGRESE EL NOMBRE DEL ESTUDIANTE')}
               ENDIF

	    ENDIF
**********FIN LECTURA DE CAMPO

**********LECTURA DE CAMPO
            IF nNroOpc == 1

               nNroFil++
               nColTem := nNroCol
               cTxtTem := 'APELLIDO DEL ESTUDIANT:'

               IF nTipMod == 3
                  @ nNroFil,nColTem SAY cTxtTem
                  @ nNroFil,nColTem+LEN(cTxtTem)+1 SAY cApelliTes COLOR('I')
               ELSE
                  @ nNroFil,nColTem SAY cTxtTem;
                                    GET cApelliTes PICT '@!';
                                    VALID !EMPTY(cApelliTes);
                                    WHEN {||HelpRead('FAVOR INGRESE EL APELLIDO DEL ESTUDIANTE')}
               ENDIF

	    ENDIF
**********FIN LECTURA DE CAMPO

**********LECTURA DE CAMPO
            IF nNroOpc == 1

               nNroFil++
               nColTem := nNroCol
               cTxtTem := 'A¥O                   :'

               IF nTipMod == 3
                  @ nNroFil,nColTem SAY cTxtTem
                  @ nNroFil,nColTem+LEN(cTxtTem)+1 SAY cYear01Tcg COLOR('I')
               ELSE
                  @ nNroFil,nColTem SAY cTxtTem;
                                    GET cYear01Tcg PICT '9999';
                                    VALID !EMPTY(cYear01Tcg);
                                    WHEN {||HelpRead('FAVOR INGRESE EL A¥O 01')}
               ENDIF

	    ENDIF
**********FIN LECTURA DE CAMPO

**********LECTURA DE CAMPO
            IF nNroOpc == 1

               nNroFil++
               nColTem := nNroCol
               cTxtTem := 'GRADO01               :'

               IF nTipMod == 3
                  @ nNroFil,nColTem SAY cTxtTem
                  @ nNroFil,nColTem+LEN(cTxtTem)+1 SAY cGrad01Tcg COLOR('I')
               ELSE
                  @ nNroFil,nColTem SAY cTxtTem;
                                    GET cGrad01Tcg PICT '@!A';
                                    VALID !EMPTY(cGrad01Tcg);
                                    WHEN {||HelpRead('FAVOR INGRESE EL GRADO 01')}
               ENDIF

	    ENDIF
**********FIN LECTURA DE CAMPO

**********LECTURA DE CAMPO
            IF nNroOpc == 1

               nNroFil++
               nColTem := nNroCol
               cTxtTem := 'COLEGIO 01            :'

               IF nTipMod == 3
                  @ nNroFil,nColTem SAY cTxtTem
                  @ nNroFil,nColTem+LEN(cTxtTem)+1 SAY cCole01Tcg COLOR('I')
               ELSE
                  @ nNroFil,nColTem SAY cTxtTem;
                                    GET cCole01Tcg PICT '@!A';
                                    VALID !EMPTY(cCole01Tcg);
                                    WHEN {||HelpRead('FAVOR INGRESE EL NOMBRE DEL COLEGIO')}
               ENDIF

	    ENDIF
**********FIN LECTURA DE CAMPO

**********LECTURA DE CAMPO
            IF nNroOpc == 1

               nNroFil++
               nColTem := nNroCol
               cTxtTem := 'CIUDAD 01             :'

               IF nTipMod == 3
                  @ nNroFil,nColTem SAY cTxtTem
                  @ nNroFil,nColTem+LEN(cTxtTem)+1 SAY cCiud01Tcg COLOR('I')
               ELSE
                  @ nNroFil,nColTem SAY cTxtTem;
                                    GET cCiud01Tcg PICT '@!A';
                                    VALID !EMPTY(cCiud01Tcg);
                                    WHEN {||HelpRead('FAVOR INGRESE LA CIUDAD DEL COLEGIO 01')}
               ENDIF

	    ENDIF
**********FIN LECTURA DE CAMPO

**********LECTURA DE CAMPO
            IF nNroOpc == 1

               nNroFil++
               nColTem := nNroCol
               cTxtTem := 'A¥O                   :'

               IF nTipMod == 3
                  @ nNroFil,nColTem SAY cTxtTem
                  @ nNroFil,nColTem+LEN(cTxtTem)+1 SAY cYear02Tcg COLOR('I')
               ELSE
                  @ nNroFil,nColTem SAY cTxtTem;
                                    GET cYear02Tcg PICT '9999';
                                    VALID !EMPTY(cYear02Tcg);
                                    WHEN {||HelpRead('FAVOR INGRESE EL A¥O 02')}
               ENDIF

	    ENDIF
**********FIN LECTURA DE CAMPO

**********LECTURA DE CAMPO
            IF nNroOpc == 1

               nNroFil++
               nColTem := nNroCol
               cTxtTem := 'GRADO02               :'

               IF nTipMod == 3
                  @ nNroFil,nColTem SAY cTxtTem
                  @ nNroFil,nColTem+LEN(cTxtTem)+1 SAY cGrad02Tcg COLOR('I')
               ELSE
                  @ nNroFil,nColTem SAY cTxtTem;
                                    GET cGrad02Tcg PICT '@!A';
                                    VALID !EMPTY(cGrad02Tcg);
                                    WHEN {||HelpRead('FAVOR INGRESE EL GRADO 02')}
               ENDIF

	    ENDIF
**********FIN LECTURA DE CAMPO

**********LECTURA DE CAMPO
            IF nNroOpc == 1

               nNroFil++
               nColTem := nNroCol
               cTxtTem := 'COLEGIO 02            :'

               IF nTipMod == 3
                  @ nNroFil,nColTem SAY cTxtTem
                  @ nNroFil,nColTem+LEN(cTxtTem)+1 SAY cCole02Tcg COLOR('I')
               ELSE
                  @ nNroFil,nColTem SAY cTxtTem;
                                    GET cCole02Tcg PICT '@!A';
                                    VALID !EMPTY(cCole02Tcg);
                                    WHEN {||HelpRead('FAVOR INGRESE EL NOMBRE DEL COLEGIO')}
               ENDIF

	    ENDIF
**********FIN LECTURA DE CAMPO

**********LECTURA DE CAMPO
            IF nNroOpc == 1

               nNroFil++
               nColTem := nNroCol
               cTxtTem := 'CIUDAD 02             :'

               IF nTipMod == 3
                  @ nNroFil,nColTem SAY cTxtTem
                  @ nNroFil,nColTem+LEN(cTxtTem)+1 SAY cCiud02Tcg COLOR('I')
               ELSE
                  @ nNroFil,nColTem SAY cTxtTem;
                                    GET cCiud02Tcg PICT '@!A';
                                    VALID !EMPTY(cCiud02Tcg);
                                    WHEN {||HelpRead('FAVOR INGRESE LA CIUDAD DEL COLEGIO 02')}
               ENDIF

	    ENDIF
**********FIN LECTURA DE CAMPO

**********LECTURA DE CAMPO
            IF nNroOpc == 1

               nNroFil++
               nColTem := nNroCol
               cTxtTem := 'A¥O                   :'

               IF nTipMod == 3
                  @ nNroFil,nColTem SAY cTxtTem
                  @ nNroFil,nColTem+LEN(cTxtTem)+1 SAY cYear03Tcg COLOR('I')
               ELSE
                  @ nNroFil,nColTem SAY cTxtTem;
                                    GET cYear03Tcg PICT '9999';
                                    VALID !EMPTY(cYear03Tcg);
                                    WHEN {||HelpRead('FAVOR INGRESE EL A¥O 03')}
               ENDIF

	    ENDIF
**********FIN LECTURA DE CAMPO

**********LECTURA DE CAMPO
            IF nNroOpc == 1

               nNroFil++
               nColTem := nNroCol
               cTxtTem := 'GRADO03               :'

               IF nTipMod == 3
                  @ nNroFil,nColTem SAY cTxtTem
                  @ nNroFil,nColTem+LEN(cTxtTem)+1 SAY cGrad03Tcg COLOR('I')
               ELSE
                  @ nNroFil,nColTem SAY cTxtTem;
                                    GET cGrad03Tcg PICT '@!A';
                                    VALID !EMPTY(cGrad03Tcg);
                                    WHEN {||HelpRead('FAVOR INGRESE EL GRADO 02')}
               ENDIF

	    ENDIF
**********FIN LECTURA DE CAMPO

**********LECTURA DE CAMPO
            IF nNroOpc == 1

               nNroFil++
               nColTem := nNroCol
               cTxtTem := 'COLEGIO 03            :'

               IF nTipMod == 3
                  @ nNroFil,nColTem SAY cTxtTem
                  @ nNroFil,nColTem+LEN(cTxtTem)+1 SAY cCole03Tcg COLOR('I')
               ELSE
                  @ nNroFil,nColTem SAY cTxtTem;
                                    GET cCole03Tcg PICT '@!A';
                                    VALID !EMPTY(cCole03Tcg);
                                    WHEN {||HelpRead('FAVOR INGRESE EL NOMBRE DEL COLEGIO')}
               ENDIF

	    ENDIF
**********FIN LECTURA DE CAMPO

**********LECTURA DE CAMPO
            IF nNroOpc == 1

               nNroFil++
               nColTem := nNroCol
               cTxtTem := 'CIUDAD 03             :'

               IF nTipMod == 3
                  @ nNroFil,nColTem SAY cTxtTem
                  @ nNroFil,nColTem+LEN(cTxtTem)+1 SAY cCiud03Tcg COLOR('I')
               ELSE
                  @ nNroFil,nColTem SAY cTxtTem;
                                    GET cCiud03Tcg PICT '@!A';
                                    VALID !EMPTY(cCiud03Tcg);
                                    WHEN {||HelpRead('FAVOR INGRESE LA CIUDAD DEL COLEGIO 02')}
               ENDIF

	    ENDIF
**********FIN LECTURA DE CAMPO

**********LECTURA DE CAMPO
            IF nNroOpc == 1

               nNroFil++
               nColTem := nNroCol
               cTxtTem := 'A¥O                   :'

               IF nTipMod == 3
                  @ nNroFil,nColTem SAY cTxtTem
                  @ nNroFil,nColTem+LEN(cTxtTem)+1 SAY cYear04Tcg COLOR('I')
               ELSE
                  @ nNroFil,nColTem SAY cTxtTem;
                                    GET cYear04Tcg PICT '9999';
                                    VALID !EMPTY(cYear04Tcg);
                                    WHEN {||HelpRead('FAVOR INGRESE EL A¥O 04')}
               ENDIF

	    ENDIF
**********FIN LECTURA DE CAMPO

**********LECTURA DE CAMPO
            IF nNroOpc == 1

               nNroFil++
               nColTem := nNroCol
               cTxtTem := 'GRADO04               :'

               IF nTipMod == 3
                  @ nNroFil,nColTem SAY cTxtTem
                  @ nNroFil,nColTem+LEN(cTxtTem)+1 SAY cGrad04Tcg COLOR('I')
               ELSE
                  @ nNroFil,nColTem SAY cTxtTem;
                                    GET cGrad04Tcg PICT '@!A';
                                    VALID !EMPTY(cGrad04Tcg);
                                    WHEN {||HelpRead('FAVOR INGRESE EL GRADO 02')}
               ENDIF

	    ENDIF
**********FIN LECTURA DE CAMPO

**********LECTURA DE CAMPO
            IF nNroOpc == 1

               nNroFil++
               nColTem := nNroCol
               cTxtTem := 'COLEGIO 04            :'

               IF nTipMod == 3
                  @ nNroFil,nColTem SAY cTxtTem
                  @ nNroFil,nColTem+LEN(cTxtTem)+1 SAY cCole04Tcg COLOR('I')
               ELSE
                  @ nNroFil,nColTem SAY cTxtTem;
                                    GET cCole04Tcg PICT '@!A';
                                    VALID !EMPTY(cCole04Tcg);
                                    WHEN {||HelpRead('FAVOR INGRESE EL NOMBRE DEL COLEGIO')}
               ENDIF

	    ENDIF
**********FIN LECTURA DE CAMPO

**********LECTURA DE CAMPO
            IF nNroOpc == 1

               nNroFil++
               nColTem := nNroCol
               cTxtTem := 'CIUDAD 04             :'

               IF nTipMod == 3
                  @ nNroFil,nColTem SAY cTxtTem
                  @ nNroFil,nColTem+LEN(cTxtTem)+1 SAY cCiud04Tcg COLOR('I')
               ELSE
                  @ nNroFil,nColTem SAY cTxtTem;
                                    GET cCiud04Tcg PICT '@!A';
                                    VALID !EMPTY(cCiud04Tcg);
                                    WHEN {||HelpRead('FAVOR INGRESE LA CIUDAD DEL COLEGIO 02')}
               ENDIF

	    ENDIF
**********FIN LECTURA DE CAMPO

**********LECTURA DE CAMPO
            IF nNroOpc == 1

               nNroFil++
               nColTem := nNroCol
               cTxtTem := 'A¥O                   :'

               IF nTipMod == 3
                  @ nNroFil,nColTem SAY cTxtTem
                  @ nNroFil,nColTem+LEN(cTxtTem)+1 SAY cYear05Tcg COLOR('I')
               ELSE
                  @ nNroFil,nColTem SAY cTxtTem;
                                    GET cYear05Tcg PICT '9999';
                                    VALID !EMPTY(cYear05Tcg);
                                    WHEN {||HelpRead('FAVOR INGRESE EL A¥O 05')}
               ENDIF

	    ENDIF
**********FIN LECTURA DE CAMPO

**********LECTURA DE CAMPO
            IF nNroOpc == 1

               nNroFil++
               nColTem := nNroCol
               cTxtTem := 'GRADO05               :'

               IF nTipMod == 3
                  @ nNroFil,nColTem SAY cTxtTem
                  @ nNroFil,nColTem+LEN(cTxtTem)+1 SAY cGrad05Tcg COLOR('I')
               ELSE
                  @ nNroFil,nColTem SAY cTxtTem;
                                    GET cGrad05Tcg PICT '@!A';
                                    VALID !EMPTY(cGrad05Tcg);
                                    WHEN {||HelpRead('FAVOR INGRESE EL GRADO 02')}
               ENDIF

	    ENDIF
**********FIN LECTURA DE CAMPO

**********LECTURA DE CAMPO
            IF nNroOpc == 1

               nNroFil++
               nColTem := nNroCol
               cTxtTem := 'COLEGIO 05            :'

               IF nTipMod == 3
                  @ nNroFil,nColTem SAY cTxtTem
                  @ nNroFil,nColTem+LEN(cTxtTem)+1 SAY cCole05Tcg COLOR('I')
               ELSE
                  @ nNroFil,nColTem SAY cTxtTem;
                                    GET cCole05Tcg PICT '@!A';
                                    VALID !EMPTY(cCole05Tcg);
                                    WHEN {||HelpRead('FAVOR INGRESE EL NOMBRE DEL COLEGIO')}
               ENDIF

	    ENDIF
**********FIN LECTURA DE CAMPO

**********LECTURA DE CAMPO
            IF nNroOpc == 1

               nNroFil++
               nColTem := nNroCol
               cTxtTem := 'CIUDAD 05             :'

               IF nTipMod == 3
                  @ nNroFil,nColTem SAY cTxtTem
                  @ nNroFil,nColTem+LEN(cTxtTem)+1 SAY cCiud05Tcg COLOR('I')
               ELSE
                  @ nNroFil,nColTem SAY cTxtTem;
                                    GET cCiud05Tcg PICT '@!A';
                                    VALID !EMPTY(cCiud05Tcg);
                                    WHEN {||HelpRead('FAVOR INGRESE LA CIUDAD DEL COLEGIO 02')}
               ENDIF

	    ENDIF
**********FIN LECTURA DE CAMPO

**********LECTURA DE CAMPO
            IF nNroOpc == 1

               nNroFil++
               nColTem := nNroCol
               cTxtTem := 'A¥O                   :'

               IF nTipMod == 3
                  @ nNroFil,nColTem SAY cTxtTem
                  @ nNroFil,nColTem+LEN(cTxtTem)+1 SAY cYear06Tcg COLOR('I')
               ELSE
                  @ nNroFil,nColTem SAY cTxtTem;
                                    GET cYear06Tcg PICT '9999';
                                    VALID !EMPTY(cYear06Tcg);
                                    WHEN {||HelpRead('FAVOR INGRESE EL A¥O 06')}
               ENDIF

	    ENDIF
**********FIN LECTURA DE CAMPO

**********LECTURA DE CAMPO
            IF nNroOpc == 1

               nNroFil++
               nColTem := nNroCol
               cTxtTem := 'GRADO06               :'

               IF nTipMod == 3
                  @ nNroFil,nColTem SAY cTxtTem
                  @ nNroFil,nColTem+LEN(cTxtTem)+1 SAY cGrad06Tcg COLOR('I')
               ELSE
                  @ nNroFil,nColTem SAY cTxtTem;
                                    GET cGrad06Tcg PICT '@!A';
                                    VALID !EMPTY(cGrad06Tcg);
                                    WHEN {||HelpRead('FAVOR INGRESE EL GRADO 02')}
               ENDIF

	    ENDIF
**********FIN LECTURA DE CAMPO

**********LECTURA DE CAMPO
            IF nNroOpc == 1

               nNroFil++
               nColTem := nNroCol
               cTxtTem := 'COLEGIO 06            :'

               IF nTipMod == 3
                  @ nNroFil,nColTem SAY cTxtTem
                  @ nNroFil,nColTem+LEN(cTxtTem)+1 SAY cCole06Tcg COLOR('I')
               ELSE
                  @ nNroFil,nColTem SAY cTxtTem;
                                    GET cCole06Tcg PICT '@!A';
                                    VALID !EMPTY(cCole06Tcg);
                                    WHEN {||HelpRead('FAVOR INGRESE EL NOMBRE DEL COLEGIO')}
               ENDIF

	    ENDIF
**********FIN LECTURA DE CAMPO

**********LECTURA DE CAMPO
            IF nNroOpc == 1

               nNroFil++
               nColTem := nNroCol
               cTxtTem := 'CIUDAD 06             :'

               IF nTipMod == 3
                  @ nNroFil,nColTem SAY cTxtTem
                  @ nNroFil,nColTem+LEN(cTxtTem)+1 SAY cCiud06Tcg COLOR('I')
               ELSE
                  @ nNroFil,nColTem SAY cTxtTem;
                                    GET cCiud06Tcg PICT '@!A';
                                    VALID !EMPTY(cCiud06Tcg);
                                    WHEN {||HelpRead('FAVOR INGRESE LA CIUDAD DEL COLEGIO 02')}
               ENDIF

	    ENDIF
**********FIN LECTURA DE CAMPO

**********LECTURA DE CAMPO
            IF nNroOpc == 1

               nNroFil++
               nColTem := nNroCol
               cTxtTem := 'A¥O                   :'

               IF nTipMod == 3
                  @ nNroFil,nColTem SAY cTxtTem
                  @ nNroFil,nColTem+LEN(cTxtTem)+1 SAY cYear07Tcg COLOR('I')
               ELSE
                  @ nNroFil,nColTem SAY cTxtTem;
                                    GET cYear07Tcg PICT '9999';
                                    VALID !EMPTY(cYear07Tcg);
                                    WHEN {||HelpRead('FAVOR INGRESE EL A¥O 07')}
               ENDIF

	    ENDIF
**********FIN LECTURA DE CAMPO

**********LECTURA DE CAMPO
            IF nNroOpc == 1

               nNroFil++
               nColTem := nNroCol
               cTxtTem := 'GRADO07               :'

               IF nTipMod == 3
                  @ nNroFil,nColTem SAY cTxtTem
                  @ nNroFil,nColTem+LEN(cTxtTem)+1 SAY cGrad07Tcg COLOR('I')
               ELSE
                  @ nNroFil,nColTem SAY cTxtTem;
                                    GET cGrad07Tcg PICT '@!A';
                                    VALID !EMPTY(cGrad07Tcg);
                                    WHEN {||HelpRead('FAVOR INGRESE EL GRADO 02')}
               ENDIF

	    ENDIF
**********FIN LECTURA DE CAMPO

**********LECTURA DE CAMPO
            IF nNroOpc == 1

               nNroFil++
               nColTem := nNroCol
               cTxtTem := 'COLEGIO 07            :'

               IF nTipMod == 3
                  @ nNroFil,nColTem SAY cTxtTem
                  @ nNroFil,nColTem+LEN(cTxtTem)+1 SAY cCole07Tcg COLOR('I')
               ELSE
                  @ nNroFil,nColTem SAY cTxtTem;
                                    GET cCole07Tcg PICT '@!A';
                                    VALID !EMPTY(cCole07Tcg);
                                    WHEN {||HelpRead('FAVOR INGRESE EL NOMBRE DEL COLEGIO')}
               ENDIF

	    ENDIF
**********FIN LECTURA DE CAMPO

**********LECTURA DE CAMPO
            IF nNroOpc == 1

               nNroFil++
               nColTem := nNroCol
               cTxtTem := 'CIUDAD 07             :'

               IF nTipMod == 3
                  @ nNroFil,nColTem SAY cTxtTem
                  @ nNroFil,nColTem+LEN(cTxtTem)+1 SAY cCiud07Tcg COLOR('I')
               ELSE
                  @ nNroFil,nColTem SAY cTxtTem;
                                    GET cCiud07Tcg PICT '@!A';
                                    VALID !EMPTY(cCiud07Tcg);
                                    WHEN {||HelpRead('FAVOR INGRESE LA CIUDAD DEL COLEGIO 02')}
               ENDIF

	    ENDIF
**********FIN LECTURA DE CAMPO

**********LECTURA DE CAMPO
            IF nNroOpc == 1

               nNroFil++
               nColTem := nNroCol
               cTxtTem := 'A¥O                   :'

               IF nTipMod == 3
                  @ nNroFil,nColTem SAY cTxtTem
                  @ nNroFil,nColTem+LEN(cTxtTem)+1 SAY cYear08Tcg COLOR('I')
               ELSE
                  @ nNroFil,nColTem SAY cTxtTem;
                                    GET cYear08Tcg PICT '9999';
                                    VALID !EMPTY(cYear08Tcg);
                                    WHEN {||HelpRead('FAVOR INGRESE EL A¥O 08')}
               ENDIF

	    ENDIF
**********FIN LECTURA DE CAMPO

**********LECTURA DE CAMPO
            IF nNroOpc == 1

               nNroFil++
               nColTem := nNroCol
               cTxtTem := 'GRADO08               :'

               IF nTipMod == 3
                  @ nNroFil,nColTem SAY cTxtTem
                  @ nNroFil,nColTem+LEN(cTxtTem)+1 SAY cGrad08Tcg COLOR('I')
               ELSE
                  @ nNroFil,nColTem SAY cTxtTem;
                                    GET cGrad08Tcg PICT '@!A';
                                    VALID !EMPTY(cGrad08Tcg);
                                    WHEN {||HelpRead('FAVOR INGRESE EL GRADO 02')}
               ENDIF

	    ENDIF
**********FIN LECTURA DE CAMPO

**********LECTURA DE CAMPO
            IF nNroOpc == 1

               nNroFil++
               nColTem := nNroCol
               cTxtTem := 'COLEGIO 08            :'

               IF nTipMod == 3
                  @ nNroFil,nColTem SAY cTxtTem
                  @ nNroFil,nColTem+LEN(cTxtTem)+1 SAY cCole08Tcg COLOR('I')
               ELSE
                  @ nNroFil,nColTem SAY cTxtTem;
                                    GET cCole08Tcg PICT '@!A';
                                    VALID !EMPTY(cCole08Tcg);
                                    WHEN {||HelpRead('FAVOR INGRESE EL NOMBRE DEL COLEGIO')}
               ENDIF

	    ENDIF
**********FIN LECTURA DE CAMPO

**********LECTURA DE CAMPO
            IF nNroOpc == 1

               nNroFil++
               nColTem := nNroCol
               cTxtTem := 'CIUDAD 08             :'

               IF nTipMod == 3
                  @ nNroFil,nColTem SAY cTxtTem
                  @ nNroFil,nColTem+LEN(cTxtTem)+1 SAY cCiud08Tcg COLOR('I')
               ELSE
                  @ nNroFil,nColTem SAY cTxtTem;
                                    GET cCiud08Tcg PICT '@!A';
                                    VALID !EMPTY(cCiud08Tcg);
                                    WHEN {||HelpRead('FAVOR INGRESE LA CIUDAD DEL COLEGIO 02')}
               ENDIF

	    ENDIF
**********FIN LECTURA DE CAMPO

**********LECTURA DE CAMPO
            IF nNroOpc == 1

               nNroFil++
               nColTem := nNroCol
               cTxtTem := 'A¥O                   :'

               IF nTipMod == 3
                  @ nNroFil,nColTem SAY cTxtTem
                  @ nNroFil,nColTem+LEN(cTxtTem)+1 SAY cYear09Tcg COLOR('I')
               ELSE
                  @ nNroFil,nColTem SAY cTxtTem;
                                    GET cYear09Tcg PICT '9999';
                                    VALID !EMPTY(cYear09Tcg);
                                    WHEN {||HelpRead('FAVOR INGRESE EL A¥O 09')}
               ENDIF

	    ENDIF
**********FIN LECTURA DE CAMPO

**********LECTURA DE CAMPO
            IF nNroOpc == 1

               nNroFil++
               nColTem := nNroCol
               cTxtTem := 'GRADO09               :'

               IF nTipMod == 3
                  @ nNroFil,nColTem SAY cTxtTem
                  @ nNroFil,nColTem+LEN(cTxtTem)+1 SAY cGrad09Tcg COLOR('I')
               ELSE
                  @ nNroFil,nColTem SAY cTxtTem;
                                    GET cGrad09Tcg PICT '@!A';
                                    VALID !EMPTY(cGrad09Tcg);
                                    WHEN {||HelpRead('FAVOR INGRESE EL GRADO 02')}
               ENDIF

	    ENDIF
**********FIN LECTURA DE CAMPO

**********LECTURA DE CAMPO
            IF nNroOpc == 1

               nNroFil++
               nColTem := nNroCol
               cTxtTem := 'COLEGIO 09            :'

               IF nTipMod == 3
                  @ nNroFil,nColTem SAY cTxtTem
                  @ nNroFil,nColTem+LEN(cTxtTem)+1 SAY cCole09Tcg COLOR('I')
               ELSE
                  @ nNroFil,nColTem SAY cTxtTem;
                                    GET cCole09Tcg PICT '@!A';
                                    VALID !EMPTY(cCole09Tcg);
                                    WHEN {||HelpRead('FAVOR INGRESE EL NOMBRE DEL COLEGIO')}
               ENDIF

	    ENDIF
**********FIN LECTURA DE CAMPO

**********LECTURA DE CAMPO
            IF nNroOpc == 1

               nNroFil++
               nColTem := nNroCol
               cTxtTem := 'CIUDAD 09             :'

               IF nTipMod == 3
                  @ nNroFil,nColTem SAY cTxtTem
                  @ nNroFil,nColTem+LEN(cTxtTem)+1 SAY cCiud09Tcg COLOR('I')
               ELSE
                  @ nNroFil,nColTem SAY cTxtTem;
                                    GET cCiud09Tcg PICT '@!A';
                                    VALID !EMPTY(cCiud09Tcg);
                                    WHEN {||HelpRead('FAVOR INGRESE LA CIUDAD DEL COLEGIO 02')}
               ENDIF

	    ENDIF
**********FIN LECTURA DE CAMPO

**********LECTURA DE CAMPO
            IF nNroOpc == 1

               nNroFil++
               nColTem := nNroCol
               cTxtTem := 'A¥O                   :'

               IF nTipMod == 3
                  @ nNroFil,nColTem SAY cTxtTem
                  @ nNroFil,nColTem+LEN(cTxtTem)+1 SAY cYear10Tcg COLOR('I')
               ELSE
                  @ nNroFil,nColTem SAY cTxtTem;
                                    GET cYear10Tcg PICT '9999';
                                    VALID !EMPTY(cYear10Tcg);
                                    WHEN {||HelpRead('FAVOR INGRESE EL A¥O 10')}
               ENDIF

	    ENDIF
**********FIN LECTURA DE CAMPO

**********LECTURA DE CAMPO
            IF nNroOpc == 1

               nNroFil++
               nColTem := nNroCol
               cTxtTem := 'GRADO10               :'

               IF nTipMod == 3
                  @ nNroFil,nColTem SAY cTxtTem
                  @ nNroFil,nColTem+LEN(cTxtTem)+1 SAY cGrad10Tcg COLOR('I')
               ELSE
                  @ nNroFil,nColTem SAY cTxtTem;
                                    GET cGrad10Tcg PICT '@!A';
                                    VALID !EMPTY(cGrad10Tcg);
                                    WHEN {||HelpRead('FAVOR INGRESE EL GRADO 02')}
               ENDIF

	    ENDIF
**********FIN LECTURA DE CAMPO

**********LECTURA DE CAMPO
            IF nNroOpc == 1

               nNroFil++
               nColTem := nNroCol
               cTxtTem := 'COLEGIO 10            :'

               IF nTipMod == 3
                  @ nNroFil,nColTem SAY cTxtTem
                  @ nNroFil,nColTem+LEN(cTxtTem)+1 SAY cCole10Tcg COLOR('I')
               ELSE
                  @ nNroFil,nColTem SAY cTxtTem;
                                    GET cCole10Tcg PICT '@!A';
                                    VALID !EMPTY(cCole10Tcg);
                                    WHEN {||HelpRead('FAVOR INGRESE EL NOMBRE DEL COLEGIO')}
               ENDIF

	    ENDIF
**********FIN LECTURA DE CAMPO

**********LECTURA DE CAMPO
            IF nNroOpc == 1

               nNroFil++
               nColTem := nNroCol
               cTxtTem := 'CIUDAD 10             :'

               IF nTipMod == 3
                  @ nNroFil,nColTem SAY cTxtTem
                  @ nNroFil,nColTem+LEN(cTxtTem)+1 SAY cCiud10Tcg COLOR('I')
               ELSE
                  @ nNroFil,nColTem SAY cTxtTem;
                                    GET cCiud10Tcg PICT '@!A';
                                    VALID !EMPTY(cCiud10Tcg);
                                    WHEN {||HelpRead('FAVOR INGRESE LA CIUDAD DEL COLEGIO 02')}
               ENDIF

	    ENDIF
**********FIN LECTURA DE CAMPO

**********LECTURA DE CAMPO
            IF nNroOpc == 1

               nNroFil++
               nColTem := nNroCol
               cTxtTem := 'A¥O                   :'

               IF nTipMod == 3
                  @ nNroFil,nColTem SAY cTxtTem
                  @ nNroFil,nColTem+LEN(cTxtTem)+1 SAY cYear11Tcg COLOR('I')
               ELSE
                  @ nNroFil,nColTem SAY cTxtTem;
                                    GET cYear11Tcg PICT '9999';
                                    VALID !EMPTY(cYear11Tcg);
                                    WHEN {||HelpRead('FAVOR INGRESE EL A¥O 11')}
               ENDIF

	    ENDIF
**********FIN LECTURA DE CAMPO

**********LECTURA DE CAMPO
            IF nNroOpc == 1

               nNroFil++
               nColTem := nNroCol
               cTxtTem := 'GRADO11               :'

               IF nTipMod == 3
                  @ nNroFil,nColTem SAY cTxtTem
                  @ nNroFil,nColTem+LEN(cTxtTem)+1 SAY cGrad11Tcg COLOR('I')
               ELSE
                  @ nNroFil,nColTem SAY cTxtTem;
                                    GET cGrad11Tcg PICT '@!A';
                                    VALID !EMPTY(cGrad11Tcg);
                                    WHEN {||HelpRead('FAVOR INGRESE EL GRADO 02')}
               ENDIF

	    ENDIF
**********FIN LECTURA DE CAMPO

**********LECTURA DE CAMPO
            IF nNroOpc == 1

               nNroFil++
               nColTem := nNroCol
               cTxtTem := 'COLEGIO 11            :'

               IF nTipMod == 3
                  @ nNroFil,nColTem SAY cTxtTem
                  @ nNroFil,nColTem+LEN(cTxtTem)+1 SAY cCole11Tcg COLOR('I')
               ELSE
                  @ nNroFil,nColTem SAY cTxtTem;
                                    GET cCole11Tcg PICT '@!A';
                                    VALID !EMPTY(cCole11Tcg);
                                    WHEN {||HelpRead('FAVOR INGRESE EL NOMBRE DEL COLEGIO')}
               ENDIF

	    ENDIF
**********FIN LECTURA DE CAMPO

**********LECTURA DE CAMPO
            IF nNroOpc == 1

               nNroFil++
               nColTem := nNroCol
               cTxtTem := 'CIUDAD 11             :'

               IF nTipMod == 3
                  @ nNroFil,nColTem SAY cTxtTem
                  @ nNroFil,nColTem+LEN(cTxtTem)+1 SAY cCiud11Tcg COLOR('I')
               ELSE
                  @ nNroFil,nColTem SAY cTxtTem;
                                    GET cCiud11Tcg PICT '@!A';
                                    VALID !EMPTY(cCiud11Tcg);
                                    WHEN {||HelpRead('FAVOR INGRESE LA CIUDAD DEL COLEGIO 02')}
               ENDIF

	    ENDIF
**********FIN LECTURA DE CAMPO

**********LECTURA DE CAMPO
            IF nNroOpc == 1

               nNroFil++
               nColTem := nNroCol
               cTxtTem := 'A¥O                   :'

               IF nTipMod == 3
                  @ nNroFil,nColTem SAY cTxtTem
                  @ nNroFil,nColTem+LEN(cTxtTem)+1 SAY cYear12Tcg COLOR('I')
               ELSE
                  @ nNroFil,nColTem SAY cTxtTem;
                                    GET cYear12Tcg PICT '9999';
                                    VALID !EMPTY(cYear12Tcg);
                                    WHEN {||HelpRead('FAVOR INGRESE EL A¥O 12')}
               ENDIF

	    ENDIF
**********FIN LECTURA DE CAMPO

**********LECTURA DE CAMPO
            IF nNroOpc == 1

               nNroFil++
               nColTem := nNroCol
               cTxtTem := 'GRADO12               :'

               IF nTipMod == 3
                  @ nNroFil,nColTem SAY cTxtTem
                  @ nNroFil,nColTem+LEN(cTxtTem)+1 SAY cGrad12Tcg COLOR('I')
               ELSE
                  @ nNroFil,nColTem SAY cTxtTem;
                                    GET cGrad12Tcg PICT '@!A';
                                    VALID !EMPTY(cGrad12Tcg);
                                    WHEN {||HelpRead('FAVOR INGRESE EL GRADO 02')}
               ENDIF

	    ENDIF
**********FIN LECTURA DE CAMPO

**********LECTURA DE CAMPO
            IF nNroOpc == 1

               nNroFil++
               nColTem := nNroCol
               cTxtTem := 'COLEGIO 12            :'

               IF nTipMod == 3
                  @ nNroFil,nColTem SAY cTxtTem
                  @ nNroFil,nColTem+LEN(cTxtTem)+1 SAY cCole12Tcg COLOR('I')
               ELSE
                  @ nNroFil,nColTem SAY cTxtTem;
                                    GET cCole12Tcg PICT '@!A';
                                    VALID !EMPTY(cCole12Tcg);
                                    WHEN {||HelpRead('FAVOR INGRESE EL NOMBRE DEL COLEGIO')}
               ENDIF

	    ENDIF
**********FIN LECTURA DE CAMPO

**********LECTURA DE CAMPO
            IF nNroOpc == 1

               nNroFil++
               nColTem := nNroCol
               cTxtTem := 'CIUDAD 12             :'

               IF nTipMod == 3
                  @ nNroFil,nColTem SAY cTxtTem
                  @ nNroFil,nColTem+LEN(cTxtTem)+1 SAY cCiud12Tcg COLOR('I')
               ELSE
                  @ nNroFil,nColTem SAY cTxtTem;
                                    GET cCiud12Tcg PICT '@!A';
                                    VALID !EMPTY(cCiud12Tcg);
                                    WHEN {||HelpRead('FAVOR INGRESE LA CIUDAD DEL COLEGIO 02')}
               ENDIF

	    ENDIF
**********FIN LECTURA DE CAMPO

**********LECTURA DE CAMPO
            IF nNroOpc == 1

               nNroFil++
               nColTem := nNroCol
               cTxtTem := 'A¥O                   :'

               IF nTipMod == 3
                  @ nNroFil,nColTem SAY cTxtTem
                  @ nNroFil,nColTem+LEN(cTxtTem)+1 SAY cYear13Tcg COLOR('I')
               ELSE
                  @ nNroFil,nColTem SAY cTxtTem;
                                    GET cYear13Tcg PICT '9999';
                                    VALID !EMPTY(cYear13Tcg);
                                    WHEN {||HelpRead('FAVOR INGRESE EL A¥O 13')}
               ENDIF

	    ENDIF
**********FIN LECTURA DE CAMPO

**********LECTURA DE CAMPO
            IF nNroOpc == 1

               nNroFil++
               nColTem := nNroCol
               cTxtTem := 'GRADO13               :'

               IF nTipMod == 3
                  @ nNroFil,nColTem SAY cTxtTem
                  @ nNroFil,nColTem+LEN(cTxtTem)+1 SAY cGrad13Tcg COLOR('I')
               ELSE
                  @ nNroFil,nColTem SAY cTxtTem;
                                    GET cGrad13Tcg PICT '@!A';
                                    VALID !EMPTY(cGrad13Tcg);
                                    WHEN {||HelpRead('FAVOR INGRESE EL GRADO 02')}
               ENDIF

	    ENDIF
**********FIN LECTURA DE CAMPO

**********LECTURA DE CAMPO
            IF nNroOpc == 1

               nNroFil++
               nColTem := nNroCol
               cTxtTem := 'COLEGIO 13            :'

               IF nTipMod == 3
                  @ nNroFil,nColTem SAY cTxtTem
                  @ nNroFil,nColTem+LEN(cTxtTem)+1 SAY cCole13Tcg COLOR('I')
               ELSE
                  @ nNroFil,nColTem SAY cTxtTem;
                                    GET cCole13Tcg PICT '@!A';
                                    VALID !EMPTY(cCole13Tcg);
                                    WHEN {||HelpRead('FAVOR INGRESE EL NOMBRE DEL COLEGIO')}
               ENDIF

	    ENDIF
**********FIN LECTURA DE CAMPO

**********LECTURA DE CAMPO
            IF nNroOpc == 1

               nNroFil++
               nColTem := nNroCol
               cTxtTem := 'CIUDAD 13             :'

               IF nTipMod == 3
                  @ nNroFil,nColTem SAY cTxtTem
                  @ nNroFil,nColTem+LEN(cTxtTem)+1 SAY cCiud13Tcg COLOR('I')
               ELSE
                  @ nNroFil,nColTem SAY cTxtTem;
                                    GET cCiud13Tcg PICT '@!A';
                                    VALID !EMPTY(cCiud13Tcg);
                                    WHEN {||HelpRead('FAVOR INGRESE LA CIUDAD DEL COLEGIO 02')}
               ENDIF

	    ENDIF
**********FIN LECTURA DE CAMPO

**********LECTURA DE CAMPO
            IF nNroOpc == 1

               nNroFil++
               nColTem := nNroCol
               cTxtTem := 'A¥O                   :'

               IF nTipMod == 3
                  @ nNroFil,nColTem SAY cTxtTem
                  @ nNroFil,nColTem+LEN(cTxtTem)+1 SAY cYear14Tcg COLOR('I')
               ELSE
                  @ nNroFil,nColTem SAY cTxtTem;
                                    GET cYear14Tcg PICT '9999';
                                    VALID !EMPTY(cYear14Tcg);
                                    WHEN {||HelpRead('FAVOR INGRESE EL A¥O 14')}
               ENDIF

	    ENDIF
**********FIN LECTURA DE CAMPO

**********LECTURA DE CAMPO
            IF nNroOpc == 1

               nNroFil++
               nColTem := nNroCol
               cTxtTem := 'GRADO14               :'

               IF nTipMod == 3
                  @ nNroFil,nColTem SAY cTxtTem
                  @ nNroFil,nColTem+LEN(cTxtTem)+1 SAY cGrad14Tcg COLOR('I')
               ELSE
                  @ nNroFil,nColTem SAY cTxtTem;
                                    GET cGrad14Tcg PICT '@!A';
                                    VALID !EMPTY(cGrad14Tcg);
                                    WHEN {||HelpRead('FAVOR INGRESE EL GRADO 02')}
               ENDIF

	    ENDIF
**********FIN LECTURA DE CAMPO

**********LECTURA DE CAMPO
            IF nNroOpc == 1

               nNroFil++
               nColTem := nNroCol
               cTxtTem := 'COLEGIO 14            :'

               IF nTipMod == 3
                  @ nNroFil,nColTem SAY cTxtTem
                  @ nNroFil,nColTem+LEN(cTxtTem)+1 SAY cCole14Tcg COLOR('I')
               ELSE
                  @ nNroFil,nColTem SAY cTxtTem;
                                    GET cCole14Tcg PICT '@!A';
                                    VALID !EMPTY(cCole14Tcg);
                                    WHEN {||HelpRead('FAVOR INGRESE EL NOMBRE DEL COLEGIO')}
               ENDIF

	    ENDIF
**********FIN LECTURA DE CAMPO

**********LECTURA DE CAMPO
            IF nNroOpc == 1

               nNroFil++
               nColTem := nNroCol
               cTxtTem := 'CIUDAD 14             :'

               IF nTipMod == 3
                  @ nNroFil,nColTem SAY cTxtTem
                  @ nNroFil,nColTem+LEN(cTxtTem)+1 SAY cCiud14Tcg COLOR('I')
               ELSE
                  @ nNroFil,nColTem SAY cTxtTem;
                                    GET cCiud14Tcg PICT '@!A';
                                    VALID !EMPTY(cCiud14Tcg);
                                    WHEN {||HelpRead('FAVOR INGRESE LA CIUDAD DEL COLEGIO 02')}
               ENDIF

	    ENDIF
**********FIN LECTURA DE CAMPO

**********LECTURA DE CAMPO
            IF nNroOpc == 1

               nNroFil++
               nColTem := nNroCol
               cTxtTem := 'A¥O                   :'

               IF nTipMod == 3
                  @ nNroFil,nColTem SAY cTxtTem
                  @ nNroFil,nColTem+LEN(cTxtTem)+1 SAY cYear15Tcg COLOR('I')
               ELSE
                  @ nNroFil,nColTem SAY cTxtTem;
                                    GET cYear15Tcg PICT '9999';
                                    VALID !EMPTY(cYear15Tcg);
                                    WHEN {||HelpRead('FAVOR INGRESE EL A¥O 15')}
               ENDIF

	    ENDIF
**********FIN LECTURA DE CAMPO

**********LECTURA DE CAMPO
            IF nNroOpc == 1

               nNroFil++
               nColTem := nNroCol
               cTxtTem := 'GRADO15               :'

               IF nTipMod == 3
                  @ nNroFil,nColTem SAY cTxtTem
                  @ nNroFil,nColTem+LEN(cTxtTem)+1 SAY cGrad15Tcg COLOR('I')
               ELSE
                  @ nNroFil,nColTem SAY cTxtTem;
                                    GET cGrad15Tcg PICT '@!A';
                                    VALID !EMPTY(cGrad15Tcg);
                                    WHEN {||HelpRead('FAVOR INGRESE EL GRADO 02')}
               ENDIF

	    ENDIF
**********FIN LECTURA DE CAMPO

**********LECTURA DE CAMPO
            IF nNroOpc == 1

               nNroFil++
               nColTem := nNroCol
               cTxtTem := 'COLEGIO 15            :'

               IF nTipMod == 3
                  @ nNroFil,nColTem SAY cTxtTem
                  @ nNroFil,nColTem+LEN(cTxtTem)+1 SAY cCole15Tcg COLOR('I')
               ELSE
                  @ nNroFil,nColTem SAY cTxtTem;
                                    GET cCole15Tcg PICT '@!A';
                                    VALID !EMPTY(cCole15Tcg);
                                    WHEN {||HelpRead('FAVOR INGRESE EL NOMBRE DEL COLEGIO')}
               ENDIF

	    ENDIF
**********FIN LECTURA DE CAMPO

**********LECTURA DE CAMPO
            IF nNroOpc == 1

               nNroFil++
               nColTem := nNroCol
               cTxtTem := 'CIUDAD 15             :'

               IF nTipMod == 3
                  @ nNroFil,nColTem SAY cTxtTem
                  @ nNroFil,nColTem+LEN(cTxtTem)+1 SAY cCiud15Tcg COLOR('I')
               ELSE
                  @ nNroFil,nColTem SAY cTxtTem;
                                    GET cCiud15Tcg PICT '@!A';
                                    VALID !EMPTY(cCiud15Tcg);
                                    WHEN {||HelpRead('FAVOR INGRESE LA CIUDAD DEL COLEGIO 02')}
               ENDIF

	    ENDIF
**********FIN LECTURA DE CAMPO

**********LECTURA DE CAMPO
            IF nNroOpc == 1

               nNroFil++
               nColTem := nNroCol
               cTxtTem := 'A¥O                   :'

               IF nTipMod == 3
                  @ nNroFil,nColTem SAY cTxtTem
                  @ nNroFil,nColTem+LEN(cTxtTem)+1 SAY cYear16Tcg COLOR('I')
               ELSE
                  @ nNroFil,nColTem SAY cTxtTem;
                                    GET cYear16Tcg PICT '9999';
                                    VALID !EMPTY(cYear16Tcg);
                                    WHEN {||HelpRead('FAVOR INGRESE EL A¥O 16')}
               ENDIF

	    ENDIF
**********FIN LECTURA DE CAMPO

**********LECTURA DE CAMPO
            IF nNroOpc == 1

               nNroFil++
               nColTem := nNroCol
               cTxtTem := 'GRADO16               :'

               IF nTipMod == 3
                  @ nNroFil,nColTem SAY cTxtTem
                  @ nNroFil,nColTem+LEN(cTxtTem)+1 SAY cGrad16Tcg COLOR('I')
               ELSE
                  @ nNroFil,nColTem SAY cTxtTem;
                                    GET cGrad16Tcg PICT '@!A';
                                    VALID !EMPTY(cGrad16Tcg);
                                    WHEN {||HelpRead('FAVOR INGRESE EL GRADO 02')}
               ENDIF

	    ENDIF
**********FIN LECTURA DE CAMPO

**********LECTURA DE CAMPO
            IF nNroOpc == 1

               nNroFil++
               nColTem := nNroCol
               cTxtTem := 'COLEGIO 16            :'

               IF nTipMod == 3
                  @ nNroFil,nColTem SAY cTxtTem
                  @ nNroFil,nColTem+LEN(cTxtTem)+1 SAY cCole16Tcg COLOR('I')
               ELSE
                  @ nNroFil,nColTem SAY cTxtTem;
                                    GET cCole16Tcg PICT '@!A';
                                    VALID !EMPTY(cCole16Tcg);
                                    WHEN {||HelpRead('FAVOR INGRESE EL NOMBRE DEL COLEGIO')}
               ENDIF

	    ENDIF
**********FIN LECTURA DE CAMPO

**********LECTURA DE CAMPO
            IF nNroOpc == 1

               nNroFil++
               nColTem := nNroCol
               cTxtTem := 'CIUDAD 16             :'

               IF nTipMod == 3
                  @ nNroFil,nColTem SAY cTxtTem
                  @ nNroFil,nColTem+LEN(cTxtTem)+1 SAY cCiud16Tcg COLOR('I')
               ELSE
                  @ nNroFil,nColTem SAY cTxtTem;
                                    GET cCiud16Tcg PICT '@!A';
                                    VALID !EMPTY(cCiud16Tcg);
                                    WHEN {||HelpRead('FAVOR INGRESE LA CIUDAD DEL COLEGIO 02')}
               ENDIF

	    ENDIF
**********FIN LECTURA DE CAMPO

**********LECTURA DE CAMPO
            IF nNroOpc == 1

               nNroFil++
               nColTem := nNroCol
               cTxtTem := 'A¥O                   :'

               IF nTipMod == 3
                  @ nNroFil,nColTem SAY cTxtTem
                  @ nNroFil,nColTem+LEN(cTxtTem)+1 SAY cYear17Tcg COLOR('I')
               ELSE
                  @ nNroFil,nColTem SAY cTxtTem;
                                    GET cYear17Tcg PICT '9999';
                                    VALID !EMPTY(cYear17Tcg);
                                    WHEN {||HelpRead('FAVOR INGRESE EL A¥O 17')}
               ENDIF

	    ENDIF
**********FIN LECTURA DE CAMPO

**********LECTURA DE CAMPO
            IF nNroOpc == 1

               nNroFil++
               nColTem := nNroCol
               cTxtTem := 'GRADO17               :'

               IF nTipMod == 3
                  @ nNroFil,nColTem SAY cTxtTem
                  @ nNroFil,nColTem+LEN(cTxtTem)+1 SAY cGrad17Tcg COLOR('I')
               ELSE
                  @ nNroFil,nColTem SAY cTxtTem;
                                    GET cGrad17Tcg PICT '@!A';
                                    VALID !EMPTY(cGrad17Tcg);
                                    WHEN {||HelpRead('FAVOR INGRESE EL GRADO 02')}
               ENDIF

	    ENDIF
**********FIN LECTURA DE CAMPO

**********LECTURA DE CAMPO
            IF nNroOpc == 1

               nNroFil++
               nColTem := nNroCol
               cTxtTem := 'COLEGIO 17            :'

               IF nTipMod == 3
                  @ nNroFil,nColTem SAY cTxtTem
                  @ nNroFil,nColTem+LEN(cTxtTem)+1 SAY cCole17Tcg COLOR('I')
               ELSE
                  @ nNroFil,nColTem SAY cTxtTem;
                                    GET cCole17Tcg PICT '@!A';
                                    VALID !EMPTY(cCole17Tcg);
                                    WHEN {||HelpRead('FAVOR INGRESE EL NOMBRE DEL COLEGIO')}
               ENDIF

	    ENDIF
**********FIN LECTURA DE CAMPO

**********LECTURA DE CAMPO
            IF nNroOpc == 1

               nNroFil++
               nColTem := nNroCol
               cTxtTem := 'CIUDAD 17             :'

               IF nTipMod == 3
                  @ nNroFil,nColTem SAY cTxtTem
                  @ nNroFil,nColTem+LEN(cTxtTem)+1 SAY cCiud17Tcg COLOR('I')
               ELSE
                  @ nNroFil,nColTem SAY cTxtTem;
                                    GET cCiud17Tcg PICT '@!A';
                                    VALID !EMPTY(cCiud17Tcg);
                                    WHEN {||HelpRead('FAVOR INGRESE LA CIUDAD DEL COLEGIO 02')}
               ENDIF

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
       SELECT COL
       IF nTipMod # 3 .AND. lGrabar

          lInsReg := IF(nTipMod == 1,.T.,.F.)
          IF COL->(lRegLock(lShared,lInsReg))

             IF lInsReg
                REPL COL->nIdeCodCol WITH COL->(RECNO())
                REPL COL->cCodigoEst WITH cCodigo
             ENDIF

             REPL COL->cCodigoGru WITH cCodigoTes
             REPL COL->cNombreEst WITH cNombreTes
             REPL COL->cApelliEst WITH cApelliTes
             REPL COL->cYear01Col WITH cYear01Tcg
             REPL COL->cGrad01Col WITH cGrad01Tcg
             REPL COL->cCole01Col WITH cCole01Tcg
             REPL COL->cCiud01Col WITH cCiud01Tcg
             REPL COL->cYear02Col WITH cYear02Tcg
             REPL COL->cGrad02Col WITH cGrad02Tcg
             REPL COL->cCole02Col WITH cCole02Tcg
             REPL COL->cCiud02Col WITH cCiud02Tcg
             REPL COL->cYear03Col WITH cYear03Tcg
             REPL COL->cGrad03Col WITH cGrad03Tcg
             REPL COL->cCole03Col WITH cCole03Tcg
             REPL COL->cCiud03Col WITH cCiud03Tcg
             REPL COL->cYear04Col WITH cYear04Tcg
             REPL COL->cGrad04Col WITH cGrad04Tcg
             REPL COL->cCole04Col WITH cCole04Tcg
             REPL COL->cCiud04Col WITH cCiud04Tcg
             REPL COL->cYear05Col WITH cYear05Tcg
             REPL COL->cGrad05Col WITH cGrad05Tcg
             REPL COL->cCole05Col WITH cCole05Tcg
             REPL COL->cCiud05Col WITH cCiud05Tcg
             REPL COL->cYear06Col WITH cYear06Tcg
             REPL COL->cGrad06Col WITH cGrad06Tcg
             REPL COL->cCole06Col WITH cCole06Tcg
             REPL COL->cCiud06Col WITH cCiud06Tcg
             REPL COL->cYear07Col WITH cYear07Tcg
             REPL COL->cGrad07Col WITH cGrad07Tcg
             REPL COL->cCole07Col WITH cCole07Tcg
             REPL COL->cCiud07Col WITH cCiud07Tcg
             REPL COL->cYear08Col WITH cYear08Tcg
             REPL COL->cGrad08Col WITH cGrad08Tcg
             REPL COL->cCole08Col WITH cCole08Tcg
             REPL COL->cCiud08Col WITH cCiud08Tcg
             REPL COL->cYear09Col WITH cYear09Tcg
             REPL COL->cGrad09Col WITH cGrad09Tcg
             REPL COL->cCole09Col WITH cCole09Tcg
             REPL COL->cCiud09Col WITH cCiud09Tcg
             REPL COL->cYear10Col WITH cYear10Tcg
             REPL COL->cGrad10Col WITH cGrad10Tcg
             REPL COL->cCole10Col WITH cCole10Tcg
             REPL COL->cCiud10Col WITH cCiud10Tcg
             REPL COL->cYear11Col WITH cYear11Tcg
             REPL COL->cGrad11Col WITH cGrad11Tcg
             REPL COL->cCole11Col WITH cCole11Tcg
             REPL COL->cCiud11Col WITH cCiud11Tcg
             REPL COL->cYear12Col WITH cYear12Tcg
             REPL COL->cGrad12Col WITH cGrad12Tcg
             REPL COL->cCole12Col WITH cCole12Tcg
             REPL COL->cCiud12Col WITH cCiud12Tcg
             REPL COL->cYear13Col WITH cYear13Tcg
             REPL COL->cGrad13Col WITH cGrad13Tcg
             REPL COL->cCole13Col WITH cCole13Tcg
             REPL COL->cCiud13Col WITH cCiud13Tcg
             REPL COL->cYear14Col WITH cYear14Tcg
             REPL COL->cGrad14Col WITH cGrad14Tcg
             REPL COL->cCole14Col WITH cCole14Tcg
             REPL COL->cCiud14Col WITH cCiud14Tcg
             REPL COL->cYear15Col WITH cYear15Tcg
             REPL COL->cGrad15Col WITH cGrad15Tcg
             REPL COL->cCole15Col WITH cCole15Tcg
             REPL COL->cCiud15Col WITH cCiud15Tcg
             REPL COL->cYear16Col WITH cYear16Tcg
             REPL COL->cGrad16Col WITH cGrad16Tcg
             REPL COL->cCole16Col WITH cCole16Tcg
             REPL COL->cCiud16Col WITH cCiud16Tcg
             REPL COL->cYear17Col WITH cYear17Tcg
             REPL COL->cGrad17Col WITH cGrad17Tcg
             REPL COL->cCole17Col WITH cCole17Tcg
             REPL COL->cCiud17Col WITH cCiud17Tcg

             REPL COL->cNomUsrCol WITH cNomUsr
             REPL COL->dFecUsrCol WITH DATE()
             REPL COL->cHorUsrCol WITH TIME()
             COL->(DBCOMMIT())
          ENDIF

          IF lShared
             COL->(DBUNLOCK())
          ENDIF

       ENDIF
       RESTSCREEN(0,0,24,79,cSavPan)
       SETCURSOR(nTipCur)
*>>>>FIN GRABACION DEL REGISTRO

*>>>>REFRESCAR EL BROWSE
       IF nTipMod == 2
          nNroReg := COL->(RECNO())
          COL->(DBGOTOP())
          oBrowse:GOTOP()
          COL->(DBGOTO(nNroReg))
          oBrowse:FORCESTABLE()
       ENDIF
       RETURN .T.
*>>>>FIN REFRESCAR EL BROWSE

/*************************************************************************
* TITULO..: VALIDACION DE EXISTENCIA DEL CODIGO                          *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: JUN  4/2014 MIE A
       Colombia, Bucaramanga        INICIO:  3:59 PM   JUN  4/2014 MIE

OBJETIVOS:

1- Debe estar en uso el archivo.

2- Realiza la validaci¢n de existencia del C¢digo.

3- Retorna .T. si hay problemas

SINTAXIS:

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION lValCodCol(cCodigo)

*>>>>DESCRIPCION DE PARAMETROS
/*     cCodigo                              // C¢digo a Validar */
*>>>>FIN DESCRIPCION DE PARAMETROS

*>>>>DECLARACION DE VARIABLES
       LOCAL lHayErr := .F.                 // .T. Hay Error
*>>>>FIN DECLARACION DE VARIABLES

*>>>>VALIDACION DEL CODIGO
       IF cCodigo # cSpaces('COL','cCodigoEst')
          IF lLocCodigo('cCodigoEst','COL',cCodigo)
             cError('ESTE CODIGO YA EXISTE')
             lHayErr := .T.
          ENDIF
       ENDIF
       RETURN lHayErr
*>>>>FIN VALIDACION DEL CODIGO

/*************************************************************************
* TITULO..: BUSQUEDA DEL CODIGO                                          *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: JUN  4/2014 MIE A
       Colombia, Bucaramanga        INICIO:  3:59 PM   JUN  4/2014 MIE

OBJETIVOS:

1- Permite localizar un c¢digo dentro del archivo.

2- Retorna NIL

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION BuscarCol(oBrowse)

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
       cCodigo := cSpaces('COL','cCodigoEst')
       TitBuscar(LEN(cCodigo),@nNroFil,@nNroCol)
       @ nNroFil,nNroCol GET cCodigo PICT '@!';
			 VALID lValCol(ROW(),COL()-3,@cCodigo)
       READ
*>>>>FIN CAPTURA DEL CODIGO

*>>>>VALIDACION DEL CODIGO
       IF cCodigo == cSpaces('COL','cCodigoEst')
          cError('PATRON DE BUSQUEDA NO ESPECIFICADO',;
                 'ADVERTENCIA')
          lBuscar := .F.
       ENDIF
*>>>>FIN VALIDACION DEL CODIGO

*>>>>BUSQUEDA DEL CODIGO
       SELECT COL
       IF lBuscar .AND. lLocCodigo('cCodigoEst','COL',cCodigo)
          nNroReg := COL->(RECNO())
          COL->(DBGOTOP())
          oBrowse:GOTOP()
          COL->(DBGOTO(nNroReg))
          oBrowse:FORCESTABLE()
       ELSE
          oBrowse:GOTOP()
       ENDIF
       RETURN NIL
*>>>>FIN BUSQUEDA DEL CODIGO

/*************************************************************************
* TITULO..: VALIDACION DEL CODIGO                                        *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: JUN  4/2014 MIE A
       Colombia, Bucaramanga        INICIO:  3:59 PM   JUN  4/2014 MIE

OBJETIVOS:

1- Debe estar en uso el archivo

2- Realiza la validaci¢n del c¢digo

3- Retorna .T. si hay problemas

SINTAXIS:

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION lValCol(nNroFil,nNroCol,cCodigo)

*>>>>DESCRIPCION DE PARAMETROS
/*     nNroFil                              // Fila de lectura
       nNroCol                              // Columna de lectura
       cCodigo                              // C¢digo a Validar */
*>>>>FIN DESCRIPCION DE PARAMETROS

*>>>>DECLARACION DE VARIABLES
       LOCAL nNroReg := 0                   // N£mero del Registro
*>>>>FIN DECLARACION DE VARIABLES

*>>>>VALIDACION DEL CODIGO
       IF !lLocCodigo('cCodigoEst','COL',cCodigo)
          nNroReg := nSelCol(nNroFil,nNroCol)
          IF nNroReg == 0
             cCodigo := cSpaces('COL','cCodigoEst')
          ELSE
             COL->(DBGOTO(nNroReg))
             cCodigo := COL->cCodigoEst
          ENDIF
       ENDIF
       RETURN .T.
*>>>>FIN VALIDACION DEL CODIGO

/*************************************************************************
* TITULO..: SELECCION DEL CODIGO                                         *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: JUN  4/2014 MIE A
       Colombia, Bucaramanga        INICIO:  3:59 PM   JUN  4/2014 MIE

OBJETIVOS:

1- Debe estar en uso el archivo

2- Permite escoger el registro de acuerdo al c¢digo o descripci¢n

3- Retorna el n£mero del registro escogido

SINTAXIS:

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION nSelCol(nNroFil,nNroCol)

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
       IF COL->(RECCOUNT()) == 0
          cError('NO EXISTEN REGISTROS GRABADOS')
          RETURN 0
       ENDIF
*>>>>FIN VALIDACION DE CONTENIDOS DE ARCHIVOS

*>>>>INICIALIZACION DE LAS COORDENADAS
       SELECT COL
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
       COL->(DBGOTOP())
       cSavPan := SAVESCREEN(0,0,24,79)
       @ nFilSup-1,nColSup-1 TO nFilInf,nColInf+1 DOUBLE
       nNroReg := nBrowseDbf(nFilSup,nColSup,nFilInf-1,nColInf,;
			     {||COL->cCodigoEst})
       RESTSCREEN(0,0,24,79,cSavPan)
       RETURN nNroReg
*>>>>FIN SELECCION DEL CODIGO

/*************************************************************************
* TITULO..: MENU DE OTROS PARA EL ARCHIVO                                *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: JUN  4/2014 MIE A
       Colombia, Bucaramanga        INICIO:  3:59 PM   JUN  4/2014 MIE

OBJETIVOS:

1- Menu de Otros para el archivo

2- Retorna NIL

SINTAXIS:

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION MenuOtrCol(lShared,nModCry,cNomSis,cCodEmp,cNitEmp,cEmpPal,;
                    cNomEmp,cNomSec,cNomUsr,cAnoUsr,aArchvo,lPrnArc,;
                    cOpcPrn,nCodPrn,lModReg,lDelReg,lInsReg,lHaySql,;
                    oBrowse)

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
       aArchvo                              // Archivo en Uso
       lPrnArc                              // .T. Imprimir a Archivo
       cOpcPrn                              // Opciones de Impresi¢n
       nCodPrn                              // C¢digo de Impresi¢n
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
       AADD(aMenus,'1<COLEGIOS PROCEDENCIA>')

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
            OtrCol011(lShared,nModCry,cNomSis,cCodEmp,cNitEmp,cEmpPal,;
                      cNomEmp,cNomSec,cNomUsr,cAnoUsr,aArchvo,lPrnArc,;
                      cOpcPrn,nCodPrn,lModReg,lDelReg,lInsReg,lHaySql,;
                      oBrowse)
           *Impresi¢n de los campos del Archivo

       ENDCASE
       RETURN NIL
*>>>>FIN ANALISIS DE OPCION ESCOGIDA

/*************************************************************************
* TITULO..: IMPRESION CAMPOS DEL MANTENIMIENTO                           *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: JUN  4/2014 MIE A
       Colombia, Bucaramanga        INICIO:  3:59 PM   JUN  4/2014 MIE

OBJETIVOS:

1- Imprime los campos del archivo de mantenimiento

2- Retorna NIL

SINTAXIS:

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION OtrCol011(lShared,nModCry,cNomSis,cCodEmp,cNitEmp,cEmpPal,;
              cNomEmp,cNomSec,cNomUsr,cAnoUsr,aArchvo,lPrnArc,;
              cOpcPrn,nCodPrn,lModReg,lDelReg,lInsReg,lHaySql,;
              oBrowse)

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
       aArchvo                              // Archivos en Uso
       lPrnArc                              // .T. Imprimir a Archivo
       cOpcPrn                              // Opciones de Impresi¢n
       nCodPrn                              // C¢digo de Impresi¢n
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
       LOCAL nRegPrn := 0                   // Registro de Impresi¢n
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

*>>>>ACTIVACION DE LA IMPRESORA
       nRegPrn := PRN->(RECNO())
       nLenPrn := PCL('n17Stan')

       IF lPrnArc
          SET DEVICE TO PRINT
       ELSE
          FilePrn := 'Col'
          nOpcPrn := nPrinter_On(cNomUsr,@FilePrn,cOpcPrn,.F.,.T.)
          IF EMPTY(nOpcPrn)
             RETURN NIL
          ENDIF
       ENDIF
*>>>>FIN ACTIVACION DE LA IMPRESORA

*>>>>DEFINICION DEL ENCABEZADO
       nNroPag := 0
       lTamAnc := .F.

       nTotReg := 0

       aCabPrn := {cNomEmp,cNomSis,;
                   'COLEGIOS PROCEDENCIA',;
                   '',;
                   ''}

       aCabeza := {aCabPrn[1],aCabPrn[2],aCabPrn[3],aCabPrn[4],aCabPrn[5],;
                   nNroPag++,;
                   cTotPagina(nTotReg),lTamAnc}

       cCodIni := PCL({'DraftOn','Elite','CondenOn'})
       cCodFin := PCL({'NegraOf','DobGolOf'})
*>>>>FIN DEFINICION DEL ENCABEZADO

*>>>>ENCABEZADOS DE COLUMNA
       aNroCol := {}
       aTitPrn := {}

       AADD(aNroCol,6)
       AADD(aTitPrn,'CODIGO')

       AADD(aNroCol,6)
       AADD(aTitPrn,'GRUPO')

       AADD(aNroCol,30)
       AADD(aTitPrn,'NOMBRE')

       AADD(aNroCol,30)
       AADD(aTitPrn,'NOMBRE')

       AADD(aNroCol,6)
       AADD(aTitPrn,'YEAR01')

       AADD(aNroCol,20)
       AADD(aTitPrn,'GRADO01')

       AADD(aNroCol,40)
       AADD(aTitPrn,'COLEGIO 01')

       AADD(aNroCol,40)
       AADD(aTitPrn,'CIUDAD 01')

       AADD(aNroCol,6)
       AADD(aTitPrn,'YEAR02')

       AADD(aNroCol,20)
       AADD(aTitPrn,'GRADO02')

       AADD(aNroCol,40)
       AADD(aTitPrn,'COLEGIO 02')

       AADD(aNroCol,40)
       AADD(aTitPrn,'CIUDAD 02')

       AADD(aNroCol,6)
       AADD(aTitPrn,'YEAR03')

       AADD(aNroCol,20)
       AADD(aTitPrn,'GRADO03')

       AADD(aNroCol,40)
       AADD(aTitPrn,'COLEGIO 03')

       AADD(aNroCol,40)
       AADD(aTitPrn,'CIUDAD 03')

       AADD(aNroCol,6)
       AADD(aTitPrn,'YEAR04')

       AADD(aNroCol,20)
       AADD(aTitPrn,'GRADO04')

       AADD(aNroCol,40)
       AADD(aTitPrn,'COLEGIO 04')

       AADD(aNroCol,40)
       AADD(aTitPrn,'CIUDAD 04')

       AADD(aNroCol,6)
       AADD(aTitPrn,'YEAR05')

       AADD(aNroCol,20)
       AADD(aTitPrn,'GRADO05')

       AADD(aNroCol,40)
       AADD(aTitPrn,'COLEGIO 05')

       AADD(aNroCol,40)
       AADD(aTitPrn,'CIUDAD 05')

       AADD(aNroCol,6)
       AADD(aTitPrn,'YEAR06')

       AADD(aNroCol,20)
       AADD(aTitPrn,'GRADO06')

       AADD(aNroCol,40)
       AADD(aTitPrn,'COLEGIO 06')

       AADD(aNroCol,40)
       AADD(aTitPrn,'CIUDAD 06')

       AADD(aNroCol,6)
       AADD(aTitPrn,'YEAR07')

       AADD(aNroCol,20)
       AADD(aTitPrn,'GRADO07')

       AADD(aNroCol,40)
       AADD(aTitPrn,'COLEGIO 07')

       AADD(aNroCol,40)
       AADD(aTitPrn,'CIUDAD 07')

       AADD(aNroCol,6)
       AADD(aTitPrn,'YEAR08')

       AADD(aNroCol,20)
       AADD(aTitPrn,'GRADO08')

       AADD(aNroCol,40)
       AADD(aTitPrn,'COLEGIO 08')

       AADD(aNroCol,40)
       AADD(aTitPrn,'CIUDAD 08')

       AADD(aNroCol,6)
       AADD(aTitPrn,'YEAR09')

       AADD(aNroCol,20)
       AADD(aTitPrn,'GRADO09')

       AADD(aNroCol,40)
       AADD(aTitPrn,'COLEGIO 09')

       AADD(aNroCol,40)
       AADD(aTitPrn,'CIUDAD 09')

       AADD(aNroCol,6)
       AADD(aTitPrn,'YEAR10')

       AADD(aNroCol,20)
       AADD(aTitPrn,'GRADO10')

       AADD(aNroCol,40)
       AADD(aTitPrn,'COLEGIO 10')

       AADD(aNroCol,40)
       AADD(aTitPrn,'CIUDAD 10')

       AADD(aNroCol,6)
       AADD(aTitPrn,'YEAR11')

       AADD(aNroCol,20)
       AADD(aTitPrn,'GRADO11')

       AADD(aNroCol,40)
       AADD(aTitPrn,'COLEGIO 11')

       AADD(aNroCol,40)
       AADD(aTitPrn,'CIUDAD 11')

       AADD(aNroCol,6)
       AADD(aTitPrn,'YEAR12')

       AADD(aNroCol,20)
       AADD(aTitPrn,'GRADO12')

       AADD(aNroCol,40)
       AADD(aTitPrn,'COLEGIO 12')

       AADD(aNroCol,40)
       AADD(aTitPrn,'CIUDAD 12')

       AADD(aNroCol,6)
       AADD(aTitPrn,'YEAR13')

       AADD(aNroCol,20)
       AADD(aTitPrn,'GRADO13')

       AADD(aNroCol,40)
       AADD(aTitPrn,'COLEGIO 13')

       AADD(aNroCol,40)
       AADD(aTitPrn,'CIUDAD 13')

       AADD(aNroCol,6)
       AADD(aTitPrn,'YEAR14')

       AADD(aNroCol,20)
       AADD(aTitPrn,'GRADO14')

       AADD(aNroCol,40)
       AADD(aTitPrn,'COLEGIO 14')

       AADD(aNroCol,40)
       AADD(aTitPrn,'CIUDAD 14')

       AADD(aNroCol,6)
       AADD(aTitPrn,'YEAR15')

       AADD(aNroCol,20)
       AADD(aTitPrn,'GRADO15')

       AADD(aNroCol,40)
       AADD(aTitPrn,'COLEGIO 15')

       AADD(aNroCol,40)
       AADD(aTitPrn,'CIUDAD 15')

       AADD(aNroCol,6)
       AADD(aTitPrn,'YEAR16')

       AADD(aNroCol,20)
       AADD(aTitPrn,'GRADO16')

       AADD(aNroCol,40)
       AADD(aTitPrn,'COLEGIO 16')

       AADD(aNroCol,40)
       AADD(aTitPrn,'CIUDAD 16')

       AADD(aNroCol,6)
       AADD(aTitPrn,'YEAR17')

       AADD(aNroCol,20)
       AADD(aTitPrn,'GRADO17')

       AADD(aNroCol,40)
       AADD(aTitPrn,'COLEGIO 17')

       AADD(aNroCol,40)
       AADD(aTitPrn,'CIUDAD 17')

       cCabCol := cRegPrint(aTitPrn,aNroCol)
*>>>>FIN ENCABEZADOS DE COLUMNA

*>>>>ANALISIS PARA CENTRAR EL INFORME
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

*>>>>IMPRESION DEL ENCABEZADO
       SendCodes(PCL('Reset'))

       EVAL(bCabeza)
      *Impresi¢n del Encabezado

       AADD(aCabPrn,cFecPrn)
       AADD(aCabPrn,cHorPrn)
       AADD(aCabPrn,cDiaPrn)

       nHanXml := CreaFrmPrn(lShared,FilePrn,aNroCol,nOpcPrn,aCabPrn,aTitPrn)
*>>>>FIN IMPRESION DEL ENCABEZADO

*>>>>RECORRIDO DE LOS REGISTROS
       cSavPan := SAVESCREEN(0,0,24,79)
       SET DEVICE TO SCREEN
       Termometro(0,'IMPRIMIENDO')
       SET DEVICE TO PRINT

       SELECT COL
       COL->(DBGOTOP())
       DO WHILE .NOT. COL->(EOF())

**********VISUALIZACION DE AVANCE
            nAvance := INT(( COL->(RECNO()) / COL->(RECCOUNT()) )*100)

            IF STR(nAvance,3) $ '25 50 75100'
               SET DEVICE TO SCREEN
               Termometro(nAvance)
               SET DEVICE TO PRINT
            ENDIF
**********FIN VISUALIZACION DE AVANCE

**********IMPRESION DEL REGISTRO
            aRegPrn := {}
            AADD(aRegPrn,COL->cCodigoEst)
            AADD(aRegPrn,COL->cCodigoGru)
            AADD(aRegPrn,COL->cNombreEst)
            AADD(aRegPrn,COL->cApelliEst)
            AADD(aRegPrn,COL->cYear01Col)
            AADD(aRegPrn,COL->cGrad01Col)
            AADD(aRegPrn,COL->cCole01Col)
            AADD(aRegPrn,COL->cCiud01Col)
            AADD(aRegPrn,COL->cYear02Col)
            AADD(aRegPrn,COL->cGrad02Col)
            AADD(aRegPrn,COL->cCole02Col)
            AADD(aRegPrn,COL->cCiud02Col)
            AADD(aRegPrn,COL->cYear03Col)
            AADD(aRegPrn,COL->cGrad03Col)
            AADD(aRegPrn,COL->cCole03Col)
            AADD(aRegPrn,COL->cCiud03Col)
            AADD(aRegPrn,COL->cYear04Col)
            AADD(aRegPrn,COL->cGrad04Col)
            AADD(aRegPrn,COL->cCole04Col)
            AADD(aRegPrn,COL->cCiud04Col)
            AADD(aRegPrn,COL->cYear05Col)
            AADD(aRegPrn,COL->cGrad05Col)
            AADD(aRegPrn,COL->cCole05Col)
            AADD(aRegPrn,COL->cCiud05Col)
            AADD(aRegPrn,COL->cYear06Col)
            AADD(aRegPrn,COL->cGrad06Col)
            AADD(aRegPrn,COL->cCole06Col)
            AADD(aRegPrn,COL->cCiud06Col)
            AADD(aRegPrn,COL->cYear07Col)
            AADD(aRegPrn,COL->cGrad07Col)
            AADD(aRegPrn,COL->cCole07Col)
            AADD(aRegPrn,COL->cCiud07Col)
            AADD(aRegPrn,COL->cYear08Col)
            AADD(aRegPrn,COL->cGrad08Col)
            AADD(aRegPrn,COL->cCole08Col)
            AADD(aRegPrn,COL->cCiud08Col)
            AADD(aRegPrn,COL->cYear09Col)
            AADD(aRegPrn,COL->cGrad09Col)
            AADD(aRegPrn,COL->cCole09Col)
            AADD(aRegPrn,COL->cCiud09Col)
            AADD(aRegPrn,COL->cYear10Col)
            AADD(aRegPrn,COL->cGrad10Col)
            AADD(aRegPrn,COL->cCole10Col)
            AADD(aRegPrn,COL->cCiud10Col)
            AADD(aRegPrn,COL->cYear11Col)
            AADD(aRegPrn,COL->cGrad11Col)
            AADD(aRegPrn,COL->cCole11Col)
            AADD(aRegPrn,COL->cCiud11Col)
            AADD(aRegPrn,COL->cYear12Col)
            AADD(aRegPrn,COL->cGrad12Col)
            AADD(aRegPrn,COL->cCole12Col)
            AADD(aRegPrn,COL->cCiud12Col)
            AADD(aRegPrn,COL->cYear13Col)
            AADD(aRegPrn,COL->cGrad13Col)
            AADD(aRegPrn,COL->cCole13Col)
            AADD(aRegPrn,COL->cCiud13Col)
            AADD(aRegPrn,COL->cYear14Col)
            AADD(aRegPrn,COL->cGrad14Col)
            AADD(aRegPrn,COL->cCole14Col)
            AADD(aRegPrn,COL->cCiud14Col)
            AADD(aRegPrn,COL->cYear15Col)
            AADD(aRegPrn,COL->cGrad15Col)
            AADD(aRegPrn,COL->cCole15Col)
            AADD(aRegPrn,COL->cCiud15Col)
            AADD(aRegPrn,COL->cYear16Col)
            AADD(aRegPrn,COL->cGrad16Col)
            AADD(aRegPrn,COL->cCole16Col)
            AADD(aRegPrn,COL->cCiud16Col)
            AADD(aRegPrn,COL->cYear17Col)
            AADD(aRegPrn,COL->cGrad17Col)
            AADD(aRegPrn,COL->cCole17Col)
            AADD(aRegPrn,COL->cCiud17Col)

            lPrnOpc(lShared,nOpcPrn,FilePrn,nHanXml,01,nColCab,;
                    aTitPrn,aRegPrn,aNroCol,bPagina,bDerAut,bCabeza)
**********FIN IMPRESION DEL REGISTRO

**********AVANCE DEL SIGUIENTE REGISTRO
	    SELECT COL
	    COL->(DBSKIP())
	    IF COL->(EOF())
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
       PRN->(DBGOTO(nRegPrn))

       SET DEVICE TO SCREEN
       RETURN NIL
*>>>>FIN IMPRESION DERECHOS
