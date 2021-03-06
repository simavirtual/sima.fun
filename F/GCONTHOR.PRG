/*************************************************************************
* TITULO..: CREACION DE LA ESTRUCTURA                                    *
**************************************************************************

AUTOR: Nelson Fern�ndez G�mez       FECHA DE CREACION: MAY 23/2007 MIE A
       Colombia, Bucaramanga        INICIO:  7:48 PM   MAY 23/2007 MIE

OBJETIVOS:

1- Crea la estructura del archivo

2- Retorna NIL

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION CreaDbfHor(lShared,nModCry,PathArc,fArchvo,aStrDbf)

*>>>>DESCRIPCION DE PARAMETROS
/*     lShared                              // .T. Sistema Compartido
       nModCry                              // Modo de Protecci�n
       PathArc                              // Path del Archivo
       fArchvo                              // Nombre del Archivo
       aStrDbf                              // Estructura del Archivo */
*>>>>FIN DESCRIPCION DE PARAMETROS

*>>>>DECLARACION DE VARIABLES
       LOCAL PathAct := ''                  // Path Actual

       LOCAL aDbfStr := {}                  // Estructura del Archivo
*>>>>FIN DECLARACION DE VARIABLES

*>>>>DECLARACION DE LA ESTRUCTURA
       AADD(aDbfStr,{'nIdeCodHor','Numeric'  ,16,0}) // Ide del Registro
      *Llave Principal

       AADD(aDbfStr,{'nDiaSemHor','Numeric',1,0}) // D�a de la Semama
       AADD(aDbfStr,{'cCodHraHor','Character',2,0}) // C�digo de la hora
       AADD(aDbfStr,{'cCodGruHor','Character',4,0}) // C�digo del Grupo
       AADD(aDbfStr,{'cCodMatHor','Character',4,0}) // C�digo de la Materia
       AADD(aDbfStr,{'cCodAulHor','Character',4,0}) // C�digo del Aula o Salon
       AADD(aDbfStr,{'cCodProHor','Character',6,0}) // C�digo del Profesor

       AADD(aDbfStr,{'cNomUsrHor','Character',10,0}) // Nombre del Usuario
       AADD(aDbfStr,{'dFecUsrHor','Date'     ,08,0}) // Fecha del Usuario
       AADD(aDbfStr,{'cHorUsrHor','Character',10,0}) // Hora del Usuario
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

AUTOR: Nelson Fern�ndez G�mez       FECHA DE CREACION: MAY 23/2007 MIE A
       Colombia, Bucaramanga        INICIO:  7:48 PM   MAY 23/2007 MIE

OBJETIVOS:

1- Recupera la estructura del archivo

2- Retorna NIL

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION RecuDbfHor(lShared,nModCry,PathArc,fArchvo)

*>>>>DESCRIPCION DE PARAMETROS
/*     lShared                        // .T. Sistema Compartido
       nModCry                        // Modo de Protecci�n
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
       CreaDbfHor(lShared,nModCry,PathArc,fArchvo)
       RESTORE SCREEN
       RETURN NIL
*>>>>FIN RECUPERA LA ESTRUCTURA DEL ARCHIVO

/*************************************************************************
* TITULO..: ACTUALIZACION DE LA ESTRUCTURA                               *
**************************************************************************

AUTOR: Nelson Fern�ndez G�mez       FECHA DE CREACION: MAY 23/2007 MIE A
       Colombia, Bucaramanga        INICIO:  7:48 PM   MAY 23/2007 MIE

OBJETIVOS:

1- Actualiza la Estructura del Archivo

2- Retorna el N�mero de Error:
   0 => No hay Error
	Estructura Actualizada
	Estructura Sin problemas
   1 => Estructura No Actualizada

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION nActStrHor(lShared,nModCry,PathArc,cNomArc)

*>>>>DESCRIPCION DE PARAMETROS
/*     lShared                              // .T. Sistema Compartido
       nModCry                              // Modo de Protecci�n
       PathArc                              // Path del Archivo
       cNomArc                              // Nombre del Archivo */
*>>>>FIN DESCRIPCION DE PARAMETROS

*>>>>DECLARACION DE VARIABLES
       LOCAL cSavPan := ''                  // Salvar Pantalla
       LOCAL nNroErr := 0                   // N�mero del Error
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
       CreaDbfHor(lShared,nModCry,PathArc,cNomArc,@aStrNew)
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
          'Para Actualizarla NO Debe Haber Ning�n Usuario en la Red.')
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
                         {||CreaDbfHor(lShared,nModCry,PathArc,FileTem)})
             cError('NO SE ACTUALIZO LA ESTRUCTURA DEL ARCHIVO')
             nNroErr := 1
          ENDIF
          RESTSCREEN(0,0,24,79,cSavPan)
       ENDIF
       RETURN nNroErr
*>>>>FIN ACTUALIZACION DE LA ESTRUCTURA

/*************************************************************************
* TITULO..: BUSQUEDA DEL CODIGO                                          *
**************************************************************************

AUTOR: Nelson Fern�ndez G�mez       FECHA DE CREACION: MAY 23/2007 MIE A
       Colombia, Bucaramanga        INICIO:  7:48 PM   MAY 23/2007 MIE

OBJETIVOS:

1- Permite localizar un c�digo dentro del archivo.

2- Retorna NIL

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION BuscarHor(oBrowse)

*>>>>DESCRIPCION DE PARAMETROS
/*     oBrowse                              // Browse del Archivo */
*>>>>FIN DESCRIPCION DE PARAMETROS

*>>>>DECLARACION DE VARIABLES
       LOCAL nNroFil := 0                   // Fila de lectura
       LOCAL nNroCol := 0                   // Columna de lectura
       LOCAL nNroReg := 0                   // N�mero del Registro
       LOCAL lBuscar := .T.                 // .T. Realizar la b�squeda
       LOCAL GetList := {}                  // Variable del sistema

       LOCAL cCodigo := ''                  // C�digo de b�squeda
*>>>>FIN DECLARACION DE VARIABLES

*>>>>CAPTURA DEL CODIGO
       SET CURSOR ON
       cCodigo := cSpaces('HOR','nDiaSemHor')
       TitBuscar(LEN(cCodigo),@nNroFil,@nNroCol)
       @ nNroFil,nNroCol GET cCodigo PICT '@!';
			 VALID lValHor(ROW(),COL()-3,@cCodigo)
       READ
*>>>>FIN CAPTURA DEL CODIGO

*>>>>VALIDACION DEL CODIGO
       IF cCodigo == cSpaces('HOR','nDiaSemHor')
          cError('PATRON DE BUSQUEDA NO ESPECIFICADO',;
                 'ADVERTENCIA')
          lBuscar := .F.
       ENDIF
*>>>>FIN VALIDACION DEL CODIGO

*>>>>BUSQUEDA DEL CODIGO
       SELECT HOR
       IF lBuscar .AND. lLocCodigo('nDiaSemHor','HOR',cCodigo)
          nNroReg := HOR->(RECNO())
          HOR->(DBGOTOP())
          oBrowse:GOTOP()
          HOR->(DBGOTO(nNroReg))
          oBrowse:FORCESTABLE()
       ELSE
          oBrowse:GOTOP()
       ENDIF
       RETURN NIL
*>>>>FIN BUSQUEDA DEL CODIGO

/*************************************************************************
* TITULO..: VALIDACION DEL CODIGO                                        *
**************************************************************************

AUTOR: Nelson Fern�ndez G�mez       FECHA DE CREACION: MAY 23/2007 MIE A
       Colombia, Bucaramanga        INICIO:  7:48 PM   MAY 23/2007 MIE

OBJETIVOS:

1- Debe estar en uso el archivo

2- Realiza la validaci�n del c�digo

3- Retorna .T. si hay problemas

SINTAXIS:

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION lValHor(nNroFil,nNroCol,cCodigo)

*>>>>DESCRIPCION DE PARAMETROS
/*     nNroFil                              // Fila de lectura
       nNroCol                              // Columna de lectura
       cCodigo                              // C�digo a Validar */
*>>>>FIN DESCRIPCION DE PARAMETROS

*>>>>DECLARACION DE VARIABLES
       LOCAL nNroReg := 0                   // N�mero del Registro
*>>>>FIN DECLARACION DE VARIABLES

*>>>>VALIDACION DEL CODIGO
       IF !lLocCodigo('nDiaSemHor','HOR',cCodigo)
          nNroReg := nSelHor(nNroFil,nNroCol)
          IF nNroReg == 0
             cCodigo := cSpaces('HOR','nDiaSemHor')
          ELSE
             HOR->(DBGOTO(nNroReg))
             cCodigo := HOR->nDiaSemHor
          ENDIF
       ENDIF
       RETURN .T.
*>>>>FIN VALIDACION DEL CODIGO

/*************************************************************************
* TITULO..: SELECCION DEL CODIGO                                         *
**************************************************************************

AUTOR: Nelson Fern�ndez G�mez       FECHA DE CREACION: MAY 23/2007 MIE A
       Colombia, Bucaramanga        INICIO:  7:48 PM   MAY 23/2007 MIE

OBJETIVOS:

1- Debe estar en uso el archivo

2- Permite escoger el registro de acuerdo al c�digo o descripci�n

3- Retorna el n�mero del registro escogido

SINTAXIS:

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION nSelHor(nNroFil,nNroCol)

*>>>>DESCRIPCION DE PARAMETROS
/*     nNroFil                              // N�mero de la fila
       nNroCol                              // N�mero de la Columna */
*>>>>FIN DESCRIPCION DE PARAMETROS

*>>>>DECLARACION DE VARIABLES
       LOCAL cSavPan := ''                  // Salvar Pantalla
       LOCAL nFilSup := 0                   // Fila superior
       LOCAL nColSup := 0                   // Colunma superior
       LOCAL nFilInf := 0                   // Fila inferior
       LOCAL nColInf := 0                   // Columna inferior
       LOCAL nNroReg := 0                   // N�mero del Registro
*>>>>FIN DECLARACION DE VARIABLES

*>>>>VALIDACION DE CONTENIDOS DE ARCHIVOS
       IF HOR->(RECCOUNT()) == 0
          cError('NO EXISTEN REGISTROS GRABADOS')
          RETURN 0
       ENDIF
*>>>>FIN VALIDACION DE CONTENIDOS DE ARCHIVOS

*>>>>INICIALIZACION DE LAS COORDENADAS
       SELECT HOR
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
       HOR->(DBGOTOP())
       cSavPan := SAVESCREEN(0,0,24,79)
       @ nFilSup-1,nColSup-1 TO nFilInf,nColInf+1 DOUBLE
       nNroReg := nBrowseDbf(nFilSup,nColSup,nFilInf-1,nColInf,;
			     {||HOR->nDiaSemHor})
       RESTSCREEN(0,0,24,79,cSavPan)
       RETURN nNroReg
*>>>>FIN SELECCION DEL CODIGO
