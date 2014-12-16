/*                   SIMA. SISTEMA INTEGRADO MULTIUSUARIO
		      BIBLIOTECAS DE FUNCIONES GENERALES

OBJETIVOS:

- Definici¢n de todos los recibos de facturaci¢n genericos del sima
  de los diferentes Colegios.

***************************************************************************
*-------------------- DECLARACION DE LAS FUNCIONES -----------------------*
**************************************************************************/

*>>>>DECLARACION DE CONSTANTES GENERALES
       #INCLUDE "inkey.ch"
*>>>>FIN DECLARACION DE CONSTANTES GENERALES


/*************************************************************************
* TITULO..: FORMATO DEL RECIBO No. 08                                    *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: NOV 19/2014 MIE A
       Colombia, Bucaramanga        INICIO: 08:30 PM   NOV 19/2014 MIE

OBJETIVOS:

1- Recibo en c¢digos de barras. Colegios de la Salle

2- Imprime el recibo de pago con c¢digo de barras utilizando
   el lenguaje PRESCRIBE de las impresoras Kiosera.

3- Imprime el recibo SIN formato preimpreso

5- Permite imprimir los recibos sencillos o los recibos por adelantado
   de acuerdo como se pasen los parametros de la funci¢n.

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION FrmRec08(aPrmRec)

*>>>>DESCRIPCION DE PARAMETROS
/*     aPrmRec				    // Parametros del Recibo */
*>>>>FIN DESCRIPCION DE PARAMETROS

*>>>>DECLARACION PARAMETROS DEL RECIBO
       LOCAL cNomEmp := xPrm(aPrmRec,'cNomEmp') // Nombre de la Empresa
       LOCAL cEmpPal := xPrm(aPrmRec,'cEmpPal') // Empresa Principal
       LOCAL cNitEmp := xPrm(aPrmRec,'cNitEmp') // Nit de la Empresa
       LOCAL cCodIso := xPrm(aPrmRec,'cCodIso') // C¢digo Iso
       LOCAL cNroFac := xPrm(aPrmRec,'cNroFac') // N£mero de la Factura

       LOCAL cNomBan := xPrm(aPrmRec,'cNomBan') // Nombre del Banco
       LOCAL cCtaBan := xPrm(aPrmRec,'cCtaBan') // Cuenta del Banco
       LOCAL cNomEst := xPrm(aPrmRec,'cNomEst') // Nombre del Estudiante
       LOCAL cCodRef := xPrm(aPrmRec,'cCodRef') // C¢digo de la Referencia
       LOCAL cCurso  := xPrm(aPrmRec,'cCurso')  // C£rso del Estudiante
       LOCAL cFecFac := xPrm(aPrmRec,'cFecFac') // Fecha de Facturaci¢n
       LOCAL cMeses  := xPrm(aPrmRec,'cMeses')  // Meses a Pagar
       LOCAL aConRec := xPrm(aPrmRec,'aConRec') // Conceptos del recibo

       LOCAL cFecOpo := xPrm(aPrmRec,'cFecOpo') // Fecha Oporturna
       LOCAL cFecExt := xPrm(aPrmRec,'cFecExt') // Fecha Extemporaneo

       LOCAL cVlrOpo := xPrm(aPrmRec,'cVlrOpo') // Valor a Pagar Oportuno
       LOCAL cVlrExt := xPrm(aPrmRec,'cVlrExt') // Valor a Pagar Extemporaneo

       LOCAL cBarOpo := xPrm(aPrmRec,'cBarOpo') // C¢digo de Barras Oportuno
       LOCAL cBarExt := xPrm(aPrmRec,'cBarExt') // C¢digo de Barras Extemporaneo

       LOCAL cTxtOpo := xPrm(aPrmRec,'cTxtOpo') // Texto Pago Oportuno
       LOCAL cTxtExt := xPrm(aPrmRec,'cTxtExt') // Texto Pago Extemporaneo

       LOCAL cTxtUno := xPrm(aPrmRec,'cTxtUno') // Texto Uno para la Facturaci¢n
       LOCAL cTxtDos := xPrm(aPrmRec,'cTxtDos') // Texto Dos para la Facturaci¢n
*>>>>FIN DECLARACION PARAMETROS DEL RECIBO

*>>>>DECLARACION DE VARIABLES
       LOCAL       i := i                   // Contador
       LOCAL aNroFil := {}                  // N£mero de la Fila
       LOCAL aNroCol := {}                  // N£mero de la Columna
       LOCAL cCodMzp := ''                  // C¢digos de las coordenadas de impresi¢n
*>>>>FIN DECLARACION DE VARIABLES

*>>>>FORMATO DEL RECIBO
       Post('!R!')
       Post('RES;SCU;SCF;SCP;UOM 300;')
       Post('UNIT C;')

       Post('MZP 0.0,2.5; BOX 20.33,7.3;')
       Post('MZP 0.0,3.6; BOX 20.33,0.4;')
       Post('MZP 0.0,3.6; BOX 3.33,0.4;')
       Post('MZP 10.0,3.6;BOX 3.33,0.4;')
       Post('MZP 0.0,4.0; BOX 20.33,0.4;')
       Post('MZP 0.0,4.0; BOX 3.33,0.4;')
       Post('MZP 0.0,4.4; BOX 20.33,0.8;')
       Post('MZP 0.0,4.4; BOX 5.0,0.8;')
       Post('MZP 5.0,4.4; BOX 5.0,0.8;')
       Post('MZP 10.0,4.4; BOX 5.0,0.8;')
       Post('MZP 0.0,5.2; BOX 20.33,0.4;')
       Post('MZP 0.0,5.2; BOX 5.0,3.8;')
       Post('MZP 5.0,5.2; BOX 5.0,3.8;')
       Post('MZP 10.0,5.2; BOX 5.0,3.8;')
       Post('MZP 0.0,9.0; BOX 20.33,0.4;')
       Post('MZP 0.0,9.0; BOX 6.5,0.8;')
       Post('MZP 12.5,9.0; BOX 2.5,0.8;')
       Post('MZP 17.0,10.2; TEXT "ALUMNO";')
       Post('MZP 0.0,11.2; TEXT ">-------------------------------------------------------------------------------<";')

       Post('CMNT "BOLANTE COLEGIO";')
       Post('MZP 0.0,11.5; BOX 20.33,7.3;')
       Post('MZP 0.0,12.6; BOX 20.33,0.4;')
       Post('MZP 0.0,12.6; BOX 3.33,0.4;')
       Post('MZP 10.0,12.6; BOX 3.33,0.4;')
       Post('MZP 0.0,13.0; BOX 20.33,0.4;')
       Post('MZP 0.0,13.0; BOX 3.33,0.4;')
       Post('MZP 0.0,13.4; BOX 20.33,0.8;')
       Post('MZP 0.0,13.4; BOX 5.0,0.8;')
       Post('MZP 5.0,13.4; BOX 5.0,0.8;')
       Post('MZP 10.0,13.4; BOX 5.0,0.8;')
       Post('MZP 0.0,14.2; BOX 20.33,0.4;')
       Post('MZP 0.0,14.2; BOX 5.0,3.8;')
       Post('MZP 5.0,14.2; BOX 5.0,3.8;')
       Post('MZP 10.0,14.2; BOX 5.0,3.8;')
       Post('MZP 0.0,18.0; BOX 20.33,0.4;')
       Post('MZP 0.0,18.0; BOX 6.5,0.8;')
       Post('MZP 12.5,18.0; BOX 2.5,0.8;')
       Post('MZP 17.0,19.3; TEXT "COLEGIO";')
       Post('MZP 0.0,19.7; TEXT ">-------------------------------------------------------------------------------<";')

       Post('CMNT "BOLANTE BANCO";')
       Post('MZP 0.0,20.0; BOX 20.33,6.5;')
       Post('MZP 0.0,20.8; BOX 20.33,0.4;')
       Post('MZP 0.0,21.2; BOX 20.33,0.4;')
       Post('MZP 0.0,21.2; BOX 3.33,0.4;')
       Post('MZP 0.0,21.6; BOX 6.0,4.9;')
       Post('MZP 0.0,21.6; BOX 6.0,0.5;')
       Post('MZP 0.0,22.1; BOX 6.0,0.5;')
       Post('MZP 0.0,22.6; BOX 6.0,0.5;')
       Post('MZP 0.0,22.1; BOX 2.0,1.0;')
       Post('MZP 0.0,23.6; BOX 2.0,1.0;')
       Post('MZP 0.0,23.1; BOX 6.0,0.5;')
       Post('MZP 0.0,23.6; BOX 6.0,0.5;')
       Post('MZP 0.0,24.1; BOX 6.0,0.5;')

       Post('MZP 6.0,21.6; BOX 14.33,0.3;')
       Post('MZP 6.0,21.6; BOX 8.5,0.3;')
       Post('MZP 6.0,24.1; BOX 14.33,0.3;')
       Post('MZP 6.0,24.1; BOX 8.5,0.3;')

       Post('MZP 17.0,27.0; TEXT "BANCO";')
       Post('FSET 1p5v;')
       Post('CMNT "BOLANTE ALUMNO";')

       Post('FSET 1p10v;')
       Post('MZP 0.3,2.8;  TEXT "'+cNomEmp+'";')
       Post('MZP 0.3,11.8; TEXT "'+cNomEmp+'";')
       Post('MZP 0.3,20.3; TEXT "'+cNomEmp+'";')

       Post('FSET 1p6v;')
       Post('MZP 0.3,3.2;  TEXT "'+cEmpPal+'";')
       Post('MZP 0.3,12.2; TEXT "'+cEmpPal+'";')
       Post('MZP 0.3,20.5; TEXT "'+cEmpPal+'";')

       Post('FSET 1p6v;')
       Post('MZP 0.3,3.5;  TEXT "NIT '+cNitEmp+'";')
       Post('MZP 0.3,12.5; TEXT "NIT '+cNitEmp+'";')
       Post('MZP 0.3,20.7; TEXT "NIT '+cNitEmp+'";')

/*
       Post('FSET 1p6v;')
       Post('MZP 2.0,3.5;  TEXT "ASIMILADOS A GRANDES CONTRIBUYENTES - AGENTES RETENEDORES";')
       Post('MZP 2.0,12.5; TEXT "ASIMILADOS A GRANDES CONTRIBUYENTES - AGENTES RETENEDORES";')
       Post('MZP 2.0,20.7; TEXT "ASIMILADOS A GRANDES CONTRIBUYENTES - AGENTES RETENEDORES";')
*/

      Post('FSET 1p6v;')
      Post('MZP 2.0,3.5;  TEXT "'+cCodIso+'";')
      Post('MZP 2.0,12.5; TEXT "'+cCodIso+'";')
      Post('MZP 2.0,20.7; TEXT "'+cCodIso+'";')
*>>>>FORMATO DEL RECIBO

*>>>>IMPRESION DEL ENCABEZADO
       Post('FSET 1p10v;')
       Post('MZP 15.0,3.5;  TEXT "RECIBO No.'+cNroFac+'";')
       Post('MZP 15.0,12.5; TEXT "RECIBO No.'+cNroFac+'";')
       Post('MZP 15.0,20.7; TEXT "RECIBO No.'+cNroFac+'";')

       Post('FSET 1p7v;')
       Post('MZP 0.3,3.9;  TEXT "BANCO";MZP 3.9,3.9; TEXT "'+cNomBan+'";')
       Post('MZP 0.3,12.9; TEXT "BANCO";MZP 3.9,12.9;TEXT "'+cNomBan+'";')
       Post('MZP 0.3,22.4; TEXT "BANCO";MZP 2.5,22.4;TEXT "'+cNomBan+'";')

       Post('MZP 10.5,3.9;  TEXT "CUENTA"; MZP 14.0,3.9; TEXT "'+cCtaBan+'";')
       Post('MZP 10.5,12.9; TEXT "CUENTA"; MZP 14.0,12.9;TEXT "'+cCtaBan+'";')
       Post('MZP 0.3 ,22.9; TEXT "CUENTA"; MZP 2.5,22.9; TEXT "'+cCtaBan+'";')

       Post('MZP 0.3,4.3; TEXT "NOMBRE"; MZP 3.9,4.3; TEXT "'+cNomEst+'";')
       Post('MZP 0.3,13.3;TEXT "NOMBRE"; MZP 3.9,13.3;TEXT "'+cNomEst+'";')
       Post('MZP 0.3,21.5;TEXT "NOMBRE"; MZP 4.0,21.5;TEXT "'+cNomEst+'";')

       Post('MZP 0.3,4.7; TEXT "CODIGO ESTUDIANTE"; MZP 0.5,5.1; TEXT "'+cCodRef+'";')
       Post('MZP 0.3,13.7;TEXT "CODIGO ESTUDIANTE"; MZP 0.5,14.1;TEXT "'+cCodRef+'";')
       Post('MZP 0.3,24.0;TEXT "CODIGO"; MZP 2.5,24.0;TEXT "'+cCodRef+'";')

       Post('MZP 5.5,4.7; TEXT "CURSO"; MZP 5.7,5.1; TEXT "'+cCurso+'";')
       Post('MZP 5.5,13.7;TEXT "CURSO"; MZP 5.7,14.1;TEXT "'+cCurso+'";')
       Post('MZP 0.3,24.5;TEXT "CURSO";MZP 2.5,24.5;TEXT "'+cCurso+'";')

       Post('MZP 10.5,4.7; TEXT "FACTURADO"; MZP 10.7,5.1; TEXT "'+cFecFac+'";')
       Post('MZP 10.5,13.7;TEXT "FACTURADO"; MZP 10.7,14.1;TEXT "'+cFecFac+'";')
       Post('MZP  0.3,21.1;TEXT "FACTURADO"; MZP 3.9,21.1;TEXT "'+cFecFac+'";')

       Post('MZP 15.5,4.7; TEXT "MES(ES) A PAGAR"; MZP 15.7,5.1; TEXT "'+cMeses+'";')
       Post('MZP 15.5,13.7;TEXT "MES(ES) A PAGAR"; MZP 15.7,14.1;TEXT "'+cMeses+'";')
       Post('MZP 13.5,21.1;TEXT "MES(ES) A PAGAR"; MZP 17.5,21.1;TEXT "'+cMeses+'";')
*>>>>FIN IMPRESION DEL ENCABEZADO

*>>>>ENCABEZADOS DE LA TABLA
       Post('MZP 1.5,5.5; TEXT "CONCEPTO";')
       Post('MZP 1.5,14.5;TEXT "CONCEPTO";')

       Post('MZP 6.5,5.5; TEXT "MORA";')
       Post('MZP 6.5,14.5;TEXT "MORA";')

       Post('MZP 11.5,5.5; TEXT "VALOR MES";')
       Post('MZP 11.5,14.5;TEXT "VALOR MES";')

       Post('MZP 16.5,5.5; TEXT "TOTAL";')
       Post('MZP 16.5,14.5;TEXT "TOTAL";')
*>>>>ENCABEZADOS DE LA TABLA

*>>>>TABLA DE CONCEPTOS
       /*----------------------------------------------
       |CONCEPTO  | MORA     | VALOR MES  |  TOTAL    |
       ------------------------------------------------
       |0.3,6.3   |8.5,6.3   |13.5,6.3    |18.5,6.3   |
       |0.3,6.7   |8.5,6.7   |13.5,6.7    |18.5,6.7   |
       |0.3,7.1   |8.5,7.1   |13.5,7,1    |18.5,7.1   |
       |0.3,7.5   |8.5,7.5   |13.5,7.5    |18.5,7.5   |
       |0.3,7.9   |8.5,7.9   |13.5,7.9    |18.5,7.9   |
       |0.3,8.3   |8.5,8.3   |13.5,8.3    |18.5,8.3   |
       |0.3,8.7   |8.5,8.4   |13.5,8.4    |18.5,8.4   |
       |0.3,9.1   |8.5,9.1   |13.5,9.1    |18.5,9.1   |
       |-----------------------------------------------
						 ALUMNO
       ------------------------------------------------
       |CONCEPTO  | MORA     | VALOR MES  |  TOTAL    |
       ------------------------------------------------
       |0.3,14.9  |8.5,14.9  |13.5,14.9   |18.5,14.9  |
       |0.3,15.3  |8.5,15.3  |13.5,15.3   |18.5,15.3  |
       |0.3,15.7  |8.5,15.7  |13.5,15.7   |18.5,15.7  |
       |0.3,16.1  |8.5,16.1  |13.5,16.1   |18.5,16.1  |
       |0.3,16.5  |8.5,16.5  |13.5,16.5   |18.5,16.5  |
       |0.3,16.9  |8.5,16.9  |13.5,16.9   |18.5,16.9  |
       |0.3,17.3  |8.5,17.3  |13.5,17.3   |18.5,17.3  |
       |0.3,17.7  |8.5,17.7  |13.5,17.7   |18.5,17.7  |
       |-----------------------------------------------
					      COLEGIO*/

       aNroFil := {}
       AADD(aNroFil,{"5.9","6.3","6.7","7.1","7.5","7.9","8.3","8.7"})
       AADD(aNroFil,{"14.9","15.3","15.7","16.1","16.5","16.9","17.3","17.7"})

       aNroCol := {"0.3","8.5","13.5","18.5"}
*>>>>TABLA DE CONCEPTOS

*>>>>RECORRIDO DE LOS CONCEPTOS
       FOR i := 1 TO LEN(aConRec)

***********CONCEPTO
	     cCodMzp := aNroCol[1]+','+aNroFil[1,i]+';'+;
			aNroCol[1]+','+aNroFil[2,i]+';'

	     LineaMzp(cCodMzp,aConRec[i,1],2)
***********FIN CONCEPTO

***********MORA
	     cCodMzp := aNroCol[2]+','+aNroFil[1,i]+';'+;
			aNroCol[2]+','+aNroFil[2,i]+';'

	     LineaMzp(cCodMzp,aConRec[i,2],2)
***********FIN MORA

***********VALOR MES
	     cCodMzp := aNroCol[3]+','+aNroFil[1,i]+';'+;
			aNroCol[3]+','+aNroFil[2,i]+';'

	     LineaMzp(cCodMzp,aConRec[i,3],2)
***********FIN VALOR MES

***********TOTAL
	     cCodMzp := aNroCol[4]+','+aNroFil[1,i]+';'+;
			aNroCol[4]+','+aNroFil[2,i]+';'

	     LineaMzp(cCodMzp,aConRec[i,4],2)
***********FIN TOTAL


       ENDFOR
*>>>>FIN RECORRIDO DE LOS CONCEPTOS


*>>>>MENSAJE DE TEXTO
       DO CASE
       CASE cNitEmp == '8600099850'
	    Post('MZP 0.3,10.2; TEXT "SOLO SE RECIBEN PAGOS EN EFECTIVO O CHEQUES DE GERENCIA.";')
	    Post('MZP 0.3,10.5; TEXT "LA CONGREGACION DE LOS HERMANOS DE LAS ESCUELAS CRISTIANAS REALIZA EL REPORTE DE HABITO DE PAGO DE TODOS LOS CONTRATANTES AL OPERADOR";')
	    Post('MZP 0.3,10.8; TEXT "DE INFORMACION DATACREDITO. RECUERDE QUE EL NO PAGO DE LOS SERVICIOS EDUCATIVOS SE REFLEJARA EN SU HISTORIA DE CREDITO. LEY 1266 DE 2008.";')
       ENDCASE
*>>>>FIN MENSAJE DE TEXTO

*>>>>IMPRESION DEL TOTAL A PAGAR EN FECHA OPORTUNA
       Post('MZP 0.3,9.3; TEXT "FECHA LIMITE OPORTUNA"; MZP 6.5,9.3; TEXT "'+cFecOpo+'";')
       Post('MZP 0.3,18.3; TEXT "FECHA LIMITE OPORTUNA"; MZP 6.5,18.3; TEXT "'+cFecOpo+'";')

       Post('MZP 13.0,9.3; TEXT "PAGUE $"; MZP 18.5,9.3; TEXT "'+cVlrOpo+'";')
       Post('MZP 13.0,18.3;TEXT "PAGUE $"; MZP 18.5,18.3; TEXT "'+cVlrOpo+'";')
*>>>>FIN IMPRESION DEL TOTAL A PAGAR EN FECHA OPORTUNA

*>>>>IMPRESION DEL TOTAL A PAGAR EN FECHA EXTEMPORANEA
       Post('MZP 0.3,9.7; TEXT "FECHA LIMITE EXTEMPORANEA"; MZP 6.5,9.7; TEXT "'+cFecExt+'";')
       Post('MZP 0.3,18.7;TEXT "FECHA LIMITE EXTEMPORANEA"; MZP 6.5,18.7; TEXT "'+cFecExt+'";')

       Post('MZP 13.0,9.7; TEXT "PAGUE $"; MZP 18.5,9.7; TEXT "'+cVlrExt+'";')
       Post('MZP 13.0,18.7;TEXT "PAGUE $"; MZP 18.5,18.7; TEXT "'+cVlrExt+'";')
*>>>>FIN IMPRESION DEL TOTAL A PAGAR EN FECHA EXTEMPORANEA

*>>>>IMPRESION PARTE DEL BANCO
       Post('FSET 1p6v;')

       Post('MZP 6.2,21.8; TEXT "FECHA LIMITE OPORTUNA"; MZP 10.5,21.8; TEXT "'+cFecOpo+'";')
       Post('MZP 14.9,21.8;TEXT "PAGUE $"; MZP 18.5,21.8; TEXT "'+cVlrOpo+'";')

       Post('MZP 6.2,24.3;TEXT "FECHA LIMITE EXTEMPORANEA"; MZP 10.5,24.3; TEXT "'+cFecExt+'";')
       Post('MZP 14.9,24.3;TEXT "PAGUE $"; MZP 18.5,24.3; TEXT "'+cVlrExt+'";')

       Post('FSET 1P6v;')
       Post('MZP 10.0,23.9; TEXT"'+cTxtOpo+'";')

       Post('MZP 10.0,26.5; TEXT"'+cTxtExt+'";')

       Post('UNIT C;')
       Post('MZP 9.0,22.1;')
       Post('FONT 7;')
       Post('UNIT D;')

       Post('Barc 42, N,'+'"'+cBarOpo+'"'+',180,180,3,6,9,12,3,6,9,12;')

       Post('UNIT C;')
       Post('MZP 9.0,24.6;')
       Post('FONT 7;')
       Post('Unit D;')
       Post('Barc 42, N,'+'"'+cBarExt+'"'+',180,180,3,6,9,12,3,6,9,12;')

       Post('RPU;RPF;RPP;')
       Post('Endm;')

       Post('EXIT;')
       RETURN NIL
*>>>>FIN IMPRESION PARTE DEL BANCO