/*************************************************************************
* TITULO..: CREACION DE LA ESTRUCTURA                                    *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: OCT  8/2014 MIE A
       Colombia, Bucaramanga        INICIO: 10:21 AM   OCT  8/2014 MIE

OBJETIVOS:

1- Crea la estructura del archivo

2- Retorna NIL

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION CreaDbfRfa(lShared,nModCry,PathArc,fArchvo,aStrDbf)

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
       AADD(aDbfStr,{'nIdeCodRfa','Numeric'  ,16,0}) // Ide del Registro
      *Llave Principal

       AADD(aDbfStr,{'cCodigoEst','Character',6,0}) // C¢digo del Estudiante
       AADD(aDbfStr,{'nMesIniPag','Numeric',2,0}) // Mes Inicial
       AADD(aDbfStr,{'nMesFinPag','Numeric',2,0}) // Mes Final
       AADD(aDbfStr,{'cEmpPalRec','Character',100,0}) // Nombre de la Empresa Principal
       AADD(aDbfStr,{'cNroNitRec','Character',14,0}) // N£mero del Nit
       AADD(aDbfStr,{'cNomEmpRec','Character',100,0}) // Nombre de la Empresa
       AADD(aDbfStr,{'cCodEmpCon','Character',3,0}) // C¢digo de la Empresa
       AADD(aDbfStr,{'cCodFacCar','Character',2,0}) // C¢digo Servicio Facturado
       AADD(aDbfStr,{'cNroFacCaA','Character',12,0}) // N£mero del Recibo
       AADD(aDbfStr,{'cNomBanRec','Character',20,0}) // Nombre del Banco
       AADD(aDbfStr,{'cCodEanRec','Character',13,0}) // C¢digo EAN-13 del recibo
       AADD(aDbfStr,{'cNroCtaBan','Character',20,0}) // N£mero de la Cuenta
       AADD(aDbfStr,{'cNombreRec','Character',60,0}) // Nombre
       AADD(aDbfStr,{'cCodRefRec','Character',20,0}) // C¢digo de la Referencia
       AADD(aDbfStr,{'cCodigoGru','Character',4,0}) // C¢digo del Grupo
       AADD(aDbfStr,{'cFecFacPag','Character',16,0}) // Fecha de Facturaci¢n
       AADD(aDbfStr,{'cPagOpoPag','Character',16,0}) // Fecha Pago Oportuno
       AADD(aDbfStr,{'cPagExtPag','Character',16,0}) // Fecha Pago Extemporaneo
       AADD(aDbfStr,{'cPerFacRec','Character',16,0}) // Periodo Facturado
       AADD(aDbfStr,{'cNomCo1Rec','Character',16,0}) // Concepto No.1
       AADD(aDbfStr,{'cVlrMo1Rec','Character',16,0}) // Valor Mora No.1
       AADD(aDbfStr,{'cVlrMe1Rec','Character',16,0}) // Valor Mes No.1
       AADD(aDbfStr,{'cVlrTo1Rec','Character',16,0}) // Valor Total No.1
       AADD(aDbfStr,{'cNomCo2Rec','Character',16,0}) // Concepto No.2
       AADD(aDbfStr,{'cVlrMo2Rec','Character',16,0}) // Valor Mora No.2
       AADD(aDbfStr,{'cVlrMe2Rec','Character',16,0}) // Valor Mes No.2
       AADD(aDbfStr,{'cVlrTo2Rec','Character',16,0}) // Valor Total No.2
       AADD(aDbfStr,{'cNomCo3Rec','Character',16,0}) // Concepto No.3
       AADD(aDbfStr,{'cVlrMo3Rec','Character',16,0}) // Valor Mora No.3
       AADD(aDbfStr,{'cVlrMe3Rec','Character',16,0}) // Valor Mes No.3
       AADD(aDbfStr,{'cVlrTo3Rec','Character',16,0}) // Valor Total No.3
       AADD(aDbfStr,{'cNomCo4Rec','Character',16,0}) // Concepto No.4
       AADD(aDbfStr,{'cVlrMo4Rec','Character',16,0}) // Valor Mora No.4
       AADD(aDbfStr,{'cVlrMe4Rec','Character',16,0}) // Valor Mes No.4
       AADD(aDbfStr,{'cVlrTo4Rec','Character',16,0}) // Valor Total No.4
       AADD(aDbfStr,{'cNomCo5Rec','Character',16,0}) // Concepto No.5
       AADD(aDbfStr,{'cVlrMo5Rec','Character',16,0}) // Valor Mora No.5
       AADD(aDbfStr,{'cVlrMe5Rec','Character',16,0}) // Valor Mes No.5
       AADD(aDbfStr,{'cVlrTo5Rec','Character',16,0}) // Valor Total No.5
       AADD(aDbfStr,{'cNomCo6Rec','Character',16,0}) // Concepto No.6
       AADD(aDbfStr,{'cVlrMo6Rec','Character',16,0}) // Valor Mora No.6
       AADD(aDbfStr,{'cVlrMe6Rec','Character',16,0}) // Valor Mes No.6
       AADD(aDbfStr,{'cVlrTo6Rec','Character',16,0}) // Valor Total No.6
       AADD(aDbfStr,{'cNomCo7Rec','Character',16,0}) // Concepto No.7
       AADD(aDbfStr,{'cVlrMo7Rec','Character',16,0}) // Valor Mora No.7
       AADD(aDbfStr,{'cVlrMe7Rec','Character',16,0}) // Valor Mes No.7
       AADD(aDbfStr,{'cVlrTo7Rec','Character',16,0}) // Valor Total No.7
       AADD(aDbfStr,{'cNomCo8Rec','Character',16,0}) // Concepto No.8
       AADD(aDbfStr,{'cVlrMo8Rec','Character',16,0}) // Valor Mora No.8
       AADD(aDbfStr,{'cVlrMe8Rec','Character',16,0}) // Valor Mes No.8
       AADD(aDbfStr,{'cVlrTo8Rec','Character',16,0}) // Valor Total No.8
       AADD(aDbfStr,{'cNomCo9Rec','Character',16,0}) // Concepto No.9
       AADD(aDbfStr,{'cVlrMo9Rec','Character',16,0}) // Valor Mora No.9
       AADD(aDbfStr,{'cVlrMe9Rec','Character',16,0}) // Valor Mes No.9
       AADD(aDbfStr,{'cVlrTo9Rec','Character',16,0}) // Valor Total No.9
       AADD(aDbfStr,{'cVlrOpoRec','Character',16,0}) // Valor Oportuno
       AADD(aDbfStr,{'cVlrExtRec','Character',16,0}) // Valor Extemporaneo
       AADD(aDbfStr,{'cBarOpoRec','Character',100,0}) // Codigo Barra Oportuno
       AADD(aDbfStr,{'cBarExtRec','Character',100,0}) // Codigo Barra Extemporaneo
       AADD(aDbfStr,{'cTxtUnoRec','Character',400,0}) // Texto1
       AADD(aDbfStr,{'cTxtDosRec','Character',400,0}) // Texto2
       AADD(aDbfStr,{'cCodeQrRec','Character',250,0}) // Code Qr
       AADD(aDbfStr,{'cNitCn1Rec','Character',16,0}) // Documento Contratante No.1
       AADD(aDbfStr,{'cNomCn1Rec','Character',70,0}) // Nombre del Contratante No.1
       AADD(aDbfStr,{'cMaiCn1Rec','Character',40,0}) // Mail del Contratante No.1
       AADD(aDbfStr,{'cPwdCn1Rec','Character',20,0}) // Pwd del Contratante No.1
       AADD(aDbfStr,{'cNitCn2Rec','Character',16,0}) // Documento Contratante No.2
       AADD(aDbfStr,{'cNomCn2Rec','Character',70,0}) // Nombre del Contratante No.2
       AADD(aDbfStr,{'cMaiCn2Rec','Character',40,0}) // Mail del Contratante No.2
       AADD(aDbfStr,{'cPwdCn2Rec','Character',20,0}) // Pwd del Contratante No.2

       AADD(aDbfStr,{'cNomUsrRfa','Character',10,0}) // Nombre del Usuario
       AADD(aDbfStr,{'dFecUsrRfa','Date'     ,08,0}) // Fecha del Usuario
       AADD(aDbfStr,{'cHorUsrRfa','Character',10,0}) // Hora del Usuario
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

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: OCT  8/2014 MIE A
       Colombia, Bucaramanga        INICIO: 10:21 AM   OCT  8/2014 MIE

OBJETIVOS:

1- Recupera la estructura del archivo

2- Retorna NIL

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION RecuDbfRfa(lShared,nModCry,PathArc,fArchvo)

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
       CreaDbfRfa(lShared,nModCry,PathArc,fArchvo)
       RESTORE SCREEN
       RETURN NIL
*>>>>FIN RECUPERA LA ESTRUCTURA DEL ARCHIVO

/*************************************************************************
* TITULO..: ACTUALIZACION DE LA ESTRUCTURA                               *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: OCT  8/2014 MIE A
       Colombia, Bucaramanga        INICIO: 10:21 AM   OCT  8/2014 MIE

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

FUNCTION nActStrRfa(lShared,nModCry,PathArc,cNomArc)

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
       CreaDbfRfa(lShared,nModCry,PathArc,cNomArc,@aStrNew)
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
                         {||CreaDbfRfa(lShared,nModCry,PathArc,FileTem)})
             cError('NO SE ACTUALIZO LA ESTRUCTURA DEL ARCHIVO')
             nNroErr := 1
          ENDIF
          RESTSCREEN(0,0,24,79,cSavPan)
       ENDIF
       RETURN nNroErr
*>>>>FIN ACTUALIZACION DE LA ESTRUCTURA


