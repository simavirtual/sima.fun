/*************************************************************************
* TITULO..: MANTENIMIENTO DEL ARCHIVO                                    *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: OCT 31/2005 LUN A
       Colombia, Bucaramanga        INICIO:  3:47 PM   OCT 31/2005 LUN

OBJETIVOS:

1- Permite el mantenimiento del archivo

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION MantenReg(lShared,nModCry,cNomSis,cCodEmp,cNitEmp,cEmpPal,;
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
       lModReg := IF(lModReg .AND. REG->(RECCOUNT())==0,.F.,lModReg)

       lDelReg := IF(lDelReg==NIL,.F.,lDelReg)

       lInsReg := IF(lInsReg==NIL,.F.,lInsReg)

       lHaySql := IF(lHaySql==NIL,.F.,lHaySql)
*>>>>FIN PARAMETROS POR DEFECTO

*>>>>MANTENIMIENTO DEL ARCHIVO
       oBrowse := oBrwDbfReg(lShared,cNomUsr,cAnoUsr,03,00,22,79,;
                             lModReg,lDelReg,lInsReg,lHaySql)

       SETKEY(K_F2,{||lManRegReg(lShared,cNomUsr,3,oBrowse)})
     *ÀConsulta

       IF lModReg
          SETKEY(K_F4,{||lManRegReg(lShared,cNomUsr,2,oBrowse,;
                                    REG->cPlacaVeh )})
       ENDIF
     *ÀActualizar

       SETKEY(K_F5,{||BuscarReg(lShared,oBrowse)})

       SETKEY(K_F9,{||MenuOtrReg(lShared,nModCry,cNomSis,cCodEmp,cNitEmp,;
                                 cEmpPal,cNomEmp,cNomSec,cNomUsr,cAnoUsr,;
                                 aArchvo,lPrnArc,cOpcPrn,nCodPrn,lModReg,;
                                 lDelReg,lInsReg,lHaySql,oBrowse)})

       REG->(CtrlBrw(lShared,oBrowse))

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

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: OCT 31/2005 LUN A
       Colombia, Bucaramanga        INICIO:  3:47 PM   OCT 31/2005 LUN

OBJETIVOS:

1- Define el objeto Browse del archivo

SINTAXIS:

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION oBrwDbfReg(lShared,cNomUsr,cAnoUsr,nFilSup,nColSup,nFilInf,nColInf,;
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

       cTitSup := '<< REGISTRO >>'
       cTitInf := '<F2>Consultar <F5>Buscar'+;
                   IF(lModReg,' <F4>Actualizar','')+' <F9>Otros'+;
                   IF(lDelReg,' <DEL>Borrar','')+;
                   IF(lInsReg,' <INS>Incluir','')

       IF lInsReg
          oBrowse:Cargo := {cTitSup,cTitInf,{||lManRegReg(lShared,cNomUsr)}}
       ELSE
          oBrowse:Cargo := {cTitSup,cTitInf}
       ENDIF
     *ÀDefinici¢n de cabeceras y l¡neas de cabeceras

       SELECT REG
       oColumn := TBCOLUMNNEW('PLACA',{||REG->cPlacaVeh })
       oColumn:Cargo := {{'MODI',.F.},{'ALIAS','REG'},;
			 {'FIELD','cPlacaVeh '},{'PICTURE','@!'}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn := TBCOLUMNNEW('RECIBO',{||REG->nNroFacReg})
       oColumn:Cargo := {{'MODI',lModReg},{'ALIAS','REG'},;
			 {'FIELD','nNroFacReg'},{'PICTURE','999999999'}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn := TBCOLUMNNEW('TIPO;VEHICULO',{||REG->cTipVehCat})
       oColumn:Cargo := {{'MODI',.F.},{'ALIAS','REG'},;
			 {'FIELD','cTipVehCat'},{'PICTURE','@!'}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn := TBCOLUMNNEW('FECHA;INGRESO',{||REG->dFecIngReg})
       oColumn:Cargo := {{'MODI',lModReg},{'ALIAS','REG'},;
			 {'FIELD','dFecIngReg'},{'PICTURE','@!D'}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn := TBCOLUMNNEW('FECHA;SALIDA',{||REG->dFecOutReg})
       oColumn:Cargo := {{'MODI',lModReg},{'ALIAS','REG'},;
			 {'FIELD','dFecOutReg'},{'PICTURE','@!D'}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       IF ALLTRIM(UPPER(cNomUsr)) == 'SUPER'
	  oColumn	     := TBCOLUMNNEW('FECHA DE;PROCESO',;
				       {||REG->dFecUsrReg})
	  oColumn:Cargo := {{'MODI',.F.}}
	  oBrowse:ADDCOLUMN(oColumn)
	*ÀDefinici¢n Columna
       ENDIF

       oColumn := TBCOLUMNNEW('HORA;INGRESO',{||REG->cHorIngReg})
       oColumn:Cargo := {{'MODI',lModReg},{'ALIAS','REG'},;
			 {'FIELD','cHorIngReg'},{'PICTURE','@!'}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn := TBCOLUMNNEW('HORA;SALIDA',{||REG->cHorOutReg})
       oColumn:Cargo := {{'MODI',lModReg},{'ALIAS','REG'},;
			 {'FIELD','cHorOutReg'},{'PICTURE','@!'}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       IF ALLTRIM(UPPER(cNomUsr)) == 'SUPER'
	  oColumn	     := TBCOLUMNNEW('HORA DE;PROCESO',;
				       {||REG->cHorUsrReg})
	  oColumn:Cargo := {{'MODI',.F.}}
	  oBrowse:ADDCOLUMN(oColumn)
	*ÀDefinici¢n Columna
       ENDIF

       oColumn := TBCOLUMNNEW('TIEMPO;AA:MM:DD:HD:MD:HN:MN:SS',{||REG->cTiempoReg})
       oColumn:Cargo := {{'MODI',lModReg},{'ALIAS','REG'},;
			 {'FIELD','cTiempoReg'},{'PICTURE','@!'}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn := TBCOLUMNNEW('TIEMPO COBRADO;AA:MM:DD:HD:HN:FD:FN',{||REG->cTieCobReg})
       oColumn:Cargo := {{'MODI',lModReg},{'ALIAS','REG'},;
			 {'FIELD','cTieCobReg'},{'PICTURE','@!'}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn := TBCOLUMNNEW('CAJA',{||REG->nCodigoCaj})
       oColumn:Cargo := {{'MODI',.F.},{'ALIAS','REG'},;
			 {'FIELD','nCodigoCaj'},{'PICTURE','@!'}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn := TBCOLUMNNEW('VALOR;SERVICIO',{||REG->nVlrTotReg})
       oColumn:Cargo := {{'MODI',lModReg},{'ALIAS','REG'},;
			 {'FIELD','nVlrTotReg'},{'PICTURE','999999999.99'}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn := TBCOLUMNNEW('BASE;DEL IVA',{||REG->nBasIvaReg})
       oColumn:Cargo := {{'MODI',lModReg},{'ALIAS','REG'},;
			 {'FIELD','nBasIvaReg'},{'PICTURE','999999999.99'}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn := TBCOLUMNNEW('%IVA',{||REG->nPorIvaReg})
       oColumn:Cargo := {{'MODI',lModReg},{'ALIAS','REG'},;
			 {'FIELD','nPorIvaReg'},{'PICTURE','99.99'}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn := TBCOLUMNNEW('VALOR;DEL IVA',{||REG->nVlrIvaReg})
       oColumn:Cargo := {{'MODI',lModReg},{'ALIAS','REG'},;
			 {'FIELD','nVlrIvaReg'},{'PICTURE','999999999.99'}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn := TBCOLUMNNEW('FECHA;RETIRO',{||REG->dFecRetRca})
       oColumn:Cargo := {{'MODI',lModReg},{'ALIAS','REG'},;
			 {'FIELD','dFecRetRca'},{'PICTURE','@!D'}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn := TBCOLUMNNEW('HORA;RETIRO',{||REG->cHorRetRca})
       oColumn:Cargo := {{'MODI',lModReg},{'ALIAS','REG'},;
			 {'FIELD','cHorRetRca'},{'PICTURE','@!'}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn := TBCOLUMNNEW('FECHA;CONSIGNACION',{||REG->dFecDepReg})
       oColumn:Cargo := {{'MODI',lModReg},{'ALIAS','REG'},;
			 {'FIELD','dFecDepReg'},{'PICTURE','@!D'}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn := TBCOLUMNNEW('COMPROBANTE',{||REG->cNroComReg})
       oColumn:Cargo := {{'MODI',lModReg},{'ALIAS','REG'},;
			 {'FIELD','cNroComReg'},{'PICTURE','@X'}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn := TBCOLUMNNEW('OBSERVACION',{||REG->cObservReg})
       oColumn:Cargo := {{'MODI',lModReg},{'ALIAS','REG'},;
			 {'FIELD','cObservReg'},{'PICTURE','@X'}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn	     := TBCOLUMNNEW('NOMBRE;DEL USUARIO',{||REG->cNomUsrReg})
       oColumn:Cargo := {{'MODI',.F.}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn	     := TBCOLUMNNEW('CODIGO',{||REG->nIdeCodReg})
       oColumn:Cargo := {{'MODI',.F.}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn	     := TBCOLUMNNEW('No.',{||REG->(RECNO())})
       oColumn:Cargo := {{'MODI',.F.}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       RETURN oBrowse
*>>>>FIN DEFINICION DEL OBJETO BROWSE

/*************************************************************************
* TITULO..: BUSQUEDA DEL CODIGO                                          *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: OCT 31/2005 LUN A
       Colombia, Bucaramanga        INICIO:  3:47 PM   OCT 31/2005 LUN

OBJETIVOS:

1- Permite localizar un c¢digo dentro del archivo.

2- Retorna NIL

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION BuscarReg(lShared,oBrowse)

*>>>>DESCRIPCION DE PARAMETROS
/*     lShared                              // .T. Archivos Compartidos
       oBrowse                              // Browse del Archivo */
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
       cCodigo := cSpaces('REG','cPlacaVeh')
       TitBuscar(LEN(cCodigo),@nNroFil,@nNroCol)
       @ nNroFil,nNroCol GET cCodigo PICT '@!';
			 VALID lValReg(ROW(),COL()-3,@cCodigo)
       READ
*>>>>FIN CAPTURA DEL CODIGO

*>>>>VALIDACION DEL CODIGO
       IF cCodigo == cSpaces('REG','cPlacaVeh')
          cError('PATRON DE BUSQUEDA NO ESPECIFICADO',;
                 'ADVERTENCIA')
          lBuscar := .F.
       ENDIF
*>>>>FIN VALIDACION DEL CODIGO

*>>>>FILTRACION DEL ARCHIVO
       SELECT REG
       SET FILTER TO REG->cPlacaVeh == cCodigo
       REG->(DBGOTOP())
       IF REG->(EOF())
	  SET FILTER TO
       ENDIF
*>>>>FIN FILTRACION DEL ARCHIVO

lShared := .T.

*>>>>BUSQUEDA DEL CODIGO
       SELECT REG
       REG->(CtrlBrw(lShared,oBrowse))
       SET FILTER TO

       nNroReg := REG->(RECNO())
       REG->(DBGOTOP())
       oBrowse:GOTOP()
       REG->(DBGOTO(nNroReg))
       oBrowse:FORCESTABLE()
       RETURN NIL
*>>>>FIN BUSQUEDA DEL CODIGO


/*************************************************************************
* TITULO..: MENU DE OTROS PARA EL ARCHIVO                                *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: AGO 22/2005 LUN A
       Colombia, Bucaramanga        INICIO: 11:23 AM   AGO 22/2005 LUN

OBJETIVOS:

1- Menu de Otros para el archivo

2- Retorna NIL

SINTAXIS:

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION MenuOtrReg(lShared,nModCry,cNomSis,cCodEmp,cNitEmp,cEmpPal,;
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
       #DEFINE ANO 1                        // A¤os
       #DEFINE MES 2                        // Meses
       #DEFINE DIA 3                        // Dias
       #DEFINE HOD 4                        // Horas Diurnas
       #DEFINE MDI 5                        // Minutos Diurnos
       #DEFINE HON 6                        // Horas Nocturnas
       #DEFINE MNO 7                        // Minutos Nocturnos
       #DEFINE SEG 8                        // Segundos

       LOCAL cSavPan := ''                  // Salvar Pantalla
       LOCAL cAnoSis := SUBS(cAnoUsr,3,2)   // A¤o del sistema
       LOCAL lHayErr := .F.                 // .T. Hay Error

       LOCAL aMenus  := {}                  // Vector de declaracion de men£
       LOCAL aAyuda  := {}                  // Vector de ayudas para el men£
       LOCAL nNroOpc := 1                   // Numero de la opcion
       LOCAL aTiempo := {}                  // Tiempo
       LOCAL cTiempo := ''                  // Tiempo
       LOCAL nTipHor := 0                   // Tiempo de Horario

       LOCAL nNroFil := 0                   // Fila de lectura
       LOCAL nNroCol := 0                   // Columna de lectura

       LOCAL cTimes1 := ''                  // Tiempo Uno
       LOCAL cTimes2 := ''                  // Tiempo Dos

       LOCAL nTotSeg := 0                   // Total Segundos
       LOCAL nNroHor := 0                   // N£mero de Horas
       LOCAL nNroMin := 0                   // N£mero de Minutos
       LOCAL nNroSeg := 0                   // N£mero de Segundos
       LOCAL lHayDes := .F.                 // .T. Hay Descuento

       LOCAL GetList := {}                  // Variable del Sistema
*>>>>FIN DECLARACION DE VARIABLES

*>>>>DECLARCION Y EJECUCION DEL MENU
       aMenus := {}
       AADD(aMenus,'1<REGISTRO INGRESOS    >')
       AADD(aMenus,'2<TIEMPO TRASCURRIDO   >')
       AADD(aMenus,'3<TIEMPO DE PARQUEO    >')
       AADD(aMenus,'4<VEHICULOS EN PARQUEO >')
       AADD(aMenus,'5<DIFERENCIA DE TIEMPOS>')
       AADD(aMenus,'6<HH:MM:SS A SEGUNDOS  >')
       AADD(aMenus,'7<SEGUNDOS A HH:MM:SS  >')


       aAyuda := {}
       AADD(aAyuda,'Imprime los Registros de Ingresos y Salidad del Parqueadero')
       AADD(aAyuda,'Calcula el Tiempo Trascurrido')
       AADD(aAyuda,'Calcula el Tiempo Cobrado')
       AADD(aAyuda,'Vehiculos en el Parqueadero')
       AADD(aAyuda,'Permite restar dos Tiempos')
       AADD(aAyuda,'Convierte HH:MM:SS a Segundos')
       AADD(aAyuda,'Convierte Segundos a HH:MM:SS')


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
            OtrReg011(lShared,nModCry,cNomSis,cCodEmp,cNitEmp,cEmpPal,;
                      cNomEmp,cNomSec,cNomUsr,cAnoUsr,aArchvo,lPrnArc,;
                      cOpcPrn,nCodPrn,lModReg,lDelReg,lInsReg,lHaySql,;
                      oBrowse)
	   *Impresi¢n de los campos del Archivo

       CASE nNroOpc == 2

	    cTiempo := cTimeTxt(aHoraDias(REG->dFecIngReg,REG->dFecOutReg,;
					  REG->cHorIngReg,REG->cHorOutReg,;
					  PAR->cIniDiaPak,PAR->cFinDiaPak,;
					  PAR->cIniNocPak,PAR->cFinNocPak))
	  *ÀTiempo transcurrido

	    cError(cTiempo,'AA:MM:DD:HD:MD:HN:MN:SS')

       CASE nNroOpc == 3

************CALCULO DEL TIEMPO TRANSCURRIDO
	      aTiempo := aHoraDias(REG->dFecIngReg,;
				   REG->dFecOutReg,;
				   REG->cHorIngReg,;
				   REG->cHorOutReg,;
				   PAR->cIniDiaPak,;
				   PAR->cFinDiaPak,;
				   PAR->cIniNocPak,;
				   PAR->cFinNocPak,;
				   @nTipHor)

	      cTiempo := cTimeTxt(aTiempo)
	      cError(cTiempo,'AA:MM:DD:HD:MD:HN:MN:SS','TIEMPO TRANSCURRIDO')
************FIN CALCULO DEL TIEMPO TRANSCURRIDO

************LOCALIZACION DEL DESCUENTO
	      lHayDes := .F.
	      IF !lInsReg

		 SELECT DES
		 DES->(DBGOTOP())

		 LOCATE FOR DES->cTipVehCat == REG->cTipVehCat .AND.;
			    DES->nNroHorDes == aTiempo[HOD]+aTiempo[HON]

		 IF DES->(FOUND())
		    lHayDes := DES->lDesMinDes
		 ENDIF

	      ENDIF
************FIN LOCALIZACION DEL DESCUENTO

************TIEMPO DE PARQUEO
	      aTiempo := aTimePak(aTiempo,PAR->nMinFraPak,PAR->nMinDesPak,;
				  nTipHor,PAR->lMinDesPak,lHayDes)

	      cTiempo := cTimeTxt(aTiempo)
	      cError(IF(lHayDes,'','NO ')+'HAY DESCUENTO')
	      cError(cTiempo,'AA:MM:DD:HD:HN:FD:FN','TIEMPO DE PARQUEO')
************FIN TIEMPO DE PARQUEO

       CASE nNroOpc == 4
	    OtrReg014(lShared,nModCry,cNomSis,cCodEmp,cNitEmp,cEmpPal,;
		      cNomEmp,cNomSec,cNomUsr,cAnoUsr,aArchvo,lPrnArc,;
                      cOpcPrn,nCodPrn,lModReg,lDelReg,lInsReg,lHaySql,;
                      oBrowse)
	   *Impresi¢n de los campos del Archivo

       CASE nNroOpc == 5

************DIFERENCIA DE TIEMPOS
	      cSavPan := SAVESCREEN(0,0,24,79)
	      SETCURSOR(1)
	      TitBuscar(20,@nNroFil,@nNroCol,'DIFERENCIA DE TIEMPOS',;
					     'TIEMPOS',15)

	      cTimes1 := '00:00:00'
	      cTimes2 := TIME()
	      @ nNroFil,nNroCol   SAY 'SALIDA :' GET cTimes2 PICT '99:99:99'
	      @ nNroFil+1,nNroCol SAY 'INGRESO:' GET cTimes1 PICT '99:99:99'
	      READ

	      nTotSeg := nHoraSeg(cTimes2) - nHoraSeg(cTimes1)
	      nNroHor := nHHMMSS(nTotSeg,@nNroMin,@nNroSeg)
	      @nNroFil+2,nNroCol+9 SAY STR(nNroHor,2)+':'+;
				       STR(nNroMin,2)+':'+;
				       STR(nNroSeg,2)
	      cPausa()
	      SETCURSOR(0)
	      RESTSCREEN(0,0,24,79,cSavPan)
************FIN DIFERENCIA DE TIEMPOS

       CASE nNroOpc == 6

************HH:MM:SS A SEGUNDOS
	      cSavPan := SAVESCREEN(0,0,24,79)
	      SETCURSOR(1)
	      TitBuscar(20,@nNroFil,@nNroCol,'INGRESE LA HORA',;
					     'HH:MM:SS A SEGUNDOS',15)

	      cTimes1 := TIME()
	      @ nNroFil,nNroCol SAY 'HORA    :' GET cTimes1 PICT '99:99:99'
	      READ

	      nTotSeg := nHoraSeg(cTimes1)
	      @nNroFil+1,nNroCol SAY 'SEGUNDOS: '+ALLTRIM(STR(nTotSeg))
	      cPausa()
	      SETCURSOR(0)
	      RESTSCREEN(0,0,24,79,cSavPan)
************FIN HH:MM:SS A SEGUNDOS

       CASE nNroOpc == 7

************SEGUNDOS A HH:MM:SS
	      cSavPan := SAVESCREEN(0,0,24,79)
	      SETCURSOR(1)
	      TitBuscar(20,@nNroFil,@nNroCol,'INGRESE LOS SEGUNDOS',;
					     'SEGUNDOS A HH:MM:SS',15)

	      nTotSeg := nHoraSeg(TIME())
	      @ nNroFil,nNroCol SAY 'SEGUNDOS:' GET nTotSeg PICT '99999'
	      READ

	      nNroHor := nHHMMSS(nTotSeg,@nNroMin,@nNroSeg)
	      @nNroFil+1,nNroCol SAY 'HH:MM:SS '+;
				     STR(nNroHor,2)+':'+;
				     STR(nNroMin,2)+':'+;
				     STR(nNroSeg,2)
	      cPausa()
	      SETCURSOR(0)
	      RESTSCREEN(0,0,24,79,cSavPan)
************FIN SEGUNDOS A HH:MM:SS


       ENDCASE
       RETURN NIL
*>>>>FIN ANALISIS DE OPCION ESCOGIDA

/*************************************************************************
* TITULO..: VEHICULOS EN EL PARQUEADERO                                  *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: SEP 06/2005 MIE A
       Colombia, Bucaramanga        INICIO: 12:00 AM   SEP 06/2005 MIE

OBJETIVOS:

1- Imprime los autos en el parqueadero

2- Retorna NIL

SINTAXIS:

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION OtrReg014(lShared,nModCry,cNomSis,cCodEmp,cNitEmp,cEmpPal,;
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

       LOCAL       i := 0                   // Contador
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
	  FilePrn := 'Parqueo'
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
		   'VEHICULOS EN EL PARQUEADERO',;
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

       AADD(aNroCol,4)
       AADD(aTitPrn,'No.')

       AADD(aNroCol,6)
       AADD(aTitPrn,'PLACA')

       AADD(aNroCol,4)
       AADD(aTitPrn,'TIPO')

       AADD(aNroCol,12)
       AADD(aTitPrn,'F.INGRESO')

       AADD(aNroCol,10)
       AADD(aTitPrn,'H. INGRESO')

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

       SELECT REG
       REG->(DBGOTOP())
       DO WHILE .NOT. REG->(EOF())

**********VISUALIZACION DE AVANCE
            nAvance := INT(( REG->(RECNO()) / REG->(RECCOUNT()) )*100)

            IF STR(nAvance,3) $ '25 50 75100'
               SET DEVICE TO SCREEN
               Termometro(nAvance)
               SET DEVICE TO PRINT
            ENDIF
**********FIN VISUALIZACION DE AVANCE

**********IMPRESION DEL REGISTRO
	    IF EMPTY(REG->dFecOutReg)

	       aRegPrn := {}
	       AADD(aRegPrn,STR(++i,4))
	       AADD(aRegPrn,REG->cPlacaVeh)
	       AADD(aRegPrn,REG->cTipVehCat)
	       AADD(aRegPrn,cFecha(REG->dFecIngReg))
	       AADD(aRegPrn,REG->cHorIngReg)

	       lPrnOpc(lShared,nOpcPrn,FilePrn,nHanXml,01,nColCab,;
		       aTitPrn,aRegPrn,aNroCol,bPagina,bDerAut,bCabeza)

	    ENDIF
**********FIN IMPRESION DEL REGISTRO

**********AVANCE DEL SIGUIENTE REGISTRO
	    SELECT REG
	    REG->(DBSKIP())
	    IF REG->(EOF())
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