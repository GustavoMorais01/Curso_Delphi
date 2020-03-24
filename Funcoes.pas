unit Funcoes;

interface

Uses  Windows,   Messages,  SysUtils,  Classes,    Graphics,  Controls, URLMon, WinSock,
      Forms,      Dialogs,  ComCtrls,  Buttons,   StdCtrls,   ExtCtrls,  Grids,
      DBGrids,    Db,       DBTables,  Mask,       DBCtrls, spin,FileCtrl,
      Printers,  Math,      Registry,   DbiProcs,  Menu, Shellapi,
      MAPI, Richedit, Gauges,DBXpress,SqlExpr,DbClient, Variants;


   function  StrZero(VFString: String; VFTamanho: Integer): String;
   Function  FCrypta(VFString:String) : String;
   Function  FDesCrypta(VFString:String):String;
   function  FAsc(VFString : String) : Integer;
   function  PDireita(VFString : String; VFQuantidade : Integer) : String;
   function  FMuda(VFString : String; VFAnterior : String; VFNovo : String) : String;
   function  FProcura(VFParte : String ; VFString : String) : Boolean;
   Function  FValidaDadoQuery(VEdit : TEdit; VTabela : TClientDataSet; VCampo : String;
                     VMensagem,VMensagemBranco : String; VMostraLookup : TDbLookupComboBox;
                     VCompletaZero : Boolean) : Boolean;
   Function  FFormataValor(VPMascara : String; VPValor : Real; VPtamanho : Word) : String;
   Function  FArredonda(VFCasasDecimais : Integer; VFNumero : Double) : Double;
   function  FUltimoDiaMes(VFMes, VFAno : String) : String;
   function  AnoBiSexto(Ayear: Integer): Boolean;
   Function  FUltDiaMes(Data : TDate) : TDate;
   Function  FAnulaLetra(VFKey : char): Boolean;
   Function  FValidaData(var Data : TMaskEdit; MLabel : String; VIni,VFim : Boolean) : Boolean;
   Function  FMontaAno(VData: String) : String;
   function  RetirarAcentos(Str: String): String;
   function  FCGCCPF(VPCgcCpf : String; VPPessoa : String) : Boolean;
   function  FResto11(VFCodigo : String) : String;
   procedure FAlinhaGrid (var VFStringGrid : TStringGrid; Col, Row, Coluna : Integer; Rect: TRect);
   function Encripta(VFPar_Str: String;VFTamanho : Word) : String;
   function Descripta(VFPar_Str: String;VFTamanho:Word) : String;
   Function PadL(VFString : String; VFTamanho: Integer) : String;
   function Space(VFTamanho : Integer) : String;

   procedure PIniciaTransacao(VPConnection: TSQLConnection);
   procedure PConfirmaTransacao(VPConnection: TSQLConnection);
   procedure PCancelaTransacao(VPConnection: TSQLConnection);

const

  FmtCentered = DT_SingleLine or DT_VCenter or DT_NoClip or DT_Center;
  FmtLeft     = DT_SingleLine or DT_VCenter or DT_NoClip or DT_Left;
  FmtRight    = DT_SingleLine or DT_VCenter or DT_NoClip or DT_Right;

var
     VRetornoCli,
     VRetornoForn,
     VRetornoProd  : string;
     TempString    : array[0..80]  of char;

     MTransaction : TTransactionDesc;     

implementation

var
      VAnoBase    : Word;


Function StrZero(VFString: String; VFTamanho: Integer): String;
Var
   VFRetorno       : String;
   I,
   VFZerosAColocar : Integer;
Begin
   VFZerosAColocar := VFTamanho - Length(TrimLeft(TrimRight(VFString)));
   VFRetorno       := '';

   For I := 1 To VFZerosAColocar Do
       VFRetorno := VFRetorno + '0';

   Result := VFRetorno + TrimLeft(TrimRight(VFString));
End;

Function FCrypta(VFString:String) : String;
Var
   Y,
   VTamanho,
   k        : Word;
   VAsc     : Real;
   VCrypta  : String;
   VNumAsc,
   VAjuda,
   VFLetra  : String;
   VImpar   : Boolean;
Begin
   VTamanho := Length(trim(VFString));
   VCrypta  := '';
   VNumAsc  := '';
   VFString := Trim(VFString);
   For y := 1 To VTamanho Do
       Begin
       Application.ProcessMessages;
       VFLetra  := Copy(VFString,y,1);
       VNumAsc  := StrZero(FloatToStr(FAsc(VFLetra)),3);
       VAjuda   := '';
       For k := 3 Downto 1 Do
           VAjuda := VAjuda + copy(VNumAsc,k,1);

       VImpar := False;

       If (y mod 2) = 0 Then
          VAsc   := StrToFloat(VAjuda)
       Else
          Begin
          VAsc   := StrToFloat(Vajuda)+3;
          VImpar := True;
       End;

       If VAsc > 255 Then
          If Vimpar Then
             VCrypta := VCrypta + Chr(252)+Chr(145)+Chr(254)+Chr(StrToInt(Copy(StrZero(FloatToStr(VAsc),3),1,2)))+Chr(StrToInt(PDireita(StrZero(FloatToStr(VAsc),3),2)))
          Else
             VCrypta := VCrypta + Chr(252)+Chr(145)+Chr(247)+Chr(StrToInt(Copy(StrZero(FloatToStr(VAsc),3),1,2)))+Chr(StrToInt(PDireita(StrZero(FloatToStr(VAsc),3),2)))
       Else
          If Vimpar Then
             VCrypta := VCrypta + Chr(254)+ Chr(StrToInt(FloatToStr(VAsc)))
          Else
             VCrypta := VCrypta + Chr(247)+ Chr(StrToInt(FloatToStr(VAsc)));
   End;
   Result := VCrypta;
End;

Function FDesCrypta(VFString:String):String;
Var
   y,
   k         : Word;
   VCrypta,
   VProc,
   VFLetra,
   VAjuda,
   VNumASc   : String;
   VAsc      : Real;
   VPrimNum,
   VContProc,
   VPegouPar,
   VPar,
   VParLetra : Boolean;
Begin             
   VCrypta    := '';
   VProc      := '';
   VNumASc    := '';
   VPrimNum   := False;
   VContProc  := False;
   VPegouPar := False;
   VParLetra  := False;
   For y := 1 To Length(VFString) Do
       Begin
       //Application.ProcessMessages;
       VFLetra  := Copy(VFString,y,1);
       If (FAsc(VFLetra) = 252) And (VProc = '') Then
          Begin
          VProc := Vproc + VFletra;
          Continue;
       End;
       If (FAsc(VFLetra) = 145) And (VFLetra <> '') Then
          Begin
          VProc := VProc + VFletra;
          Continue;
       End;
       If VProc = Chr(252)+Chr(145) Then
          Begin
          VPrimNum  := True;
          VProc     := '';
          If VFLetra = Chr(247) Then
             VPar := True
          Else
             VPar := False;

          VPegoupar := True;
          Continue;
       End;
       If VPrimNum Then
          Begin
          VPrimNum := False;
          VNumAsc  := Trim(FloatToStr(FAsc(VFLetra)));
          Continue;
       End;
       If VPegoupar Then
          Begin
          VPegouPar := False;
          VNumAsc   := VNumAsc + PDireita(Trim(FloatToStr(FAsc(VFLetra))),1);
          VAsc      := StrToFloat(VNumASc);
          If Not Vpar Then
             VAsc  := VAsc - 3;

          VAjuda := '';
          For k := 3 Downto 1 Do
              VAjuda := VAjuda + Copy(FloatToStr(VAsc),k,1);

          VAsc := StrToFloat(VAjuda);
       End
       Else
          Begin
          If Not VParLetra Then
             Begin
             If VFletra = Chr(247) Then
                VPar := True
             Else
                Vpar := False;

             VParLetra := True;
             Continue;
          End
          Else
            VParletra := False;

          VAjuda := FloatToStr(FAsc(VFLetra));

          If VPar Then
             VAsc := StrToFloat(VAjuda)
          Else
             VAsc := StrToFloat(VAjuda) - 3;

          VNumAsc  := StrZero(FloatToStr(VAsc),3);
          VAjuda   := '';
          For k := 3 Downto 1 Do
              VAjuda := VAjuda + Copy(VNumAsc,k,1);

          VAsc := StrToFloat(VAjuda);
       End;
       VCrypta := VCrypta + Chr(StrToInt(FloatToStr(VAsc)));
   End;
   Result := VCrypta;
End;

function FAsc(VFString : String) : Integer;
var
   VFS: String;
begin
   VFS    := VFString;
   Result := Ord(VFS[1]);
end;

function PDireita(VFString : String; VFQuantidade : Integer) : String;
begin
   Result := Copy(VFString,Length(VFString)-VFQuantidade+1,VFQuantidade);
end;

Function FMuda(VFString : String; VFAnterior : String; VFNovo : String) : String;
Var
   X, VFTamanhoParte : Integer;
   S                 : String;
Begin
   VFTamanhoParte := Length(VFAnterior);
   S              := VFString;


   For X := 1 To Length(VFString) Do
       If Copy(VFString,X,VFTamanhoParte) = VFAnterior Then
          If X = 1 Then
             S := VFNovo+Copy(VFString,X+VFTamanhoParte,Length(VFString))
          Else
             S := Copy(VFString,1,X-1)+VFNovo+Copy(VFString,X+VFTamanhoParte,Length(VFString));

   If FProcura(VFAnterior,S) Then
      S := FMuda(S,VFAnterior,VFNovo);

   Result := S;
End;

Function FProcura(VFParte : String ; VFString : String) : Boolean;
var
   X,
   VFTamanhoParte : Integer;
begin
   Result         := False;
   VFTamanhoParte := Length(VFParte);

   For X := 1 To Length(VFString) Do
       If Copy(VFString,X,VFTamanhoParte) = VFParte Then
          Result := True;
End;

Function FValidaDadoQuery(VEdit : TEdit; VTabela : TClientDataSet; VCampo : String;
                     VMensagem,VMensagemBranco : String; VMostraLookup : TDbLookupComboBox;
                     VCompletaZero : Boolean) : Boolean;
Begin
   Result := False;

   If (VMensagemBranco = '') And
      (VEdit.Text = '')      Then
      Begin
      Result := True;
      Exit;
   End;

   If (VEdit.Text = '')           And
      (Not VMostraLookup.Focused) Then
      Begin
      MessageDlg(VMensagemBranco,mterror,[mbok],0);
      VEdit.SetFocus;
      Exit;
   End;

   If VEdit.Text = '' Then
      exit;

   If (VEdit.Text <> '') And
      (VCompletaZero)    Then
      VEdit.Text := StrZero(VEdit.Text,VEdit.MaxLength);

   If (Not VTabela.Locate(VCampo,VEdit.Text,[])) Then
      Begin
      MessageDlg(VMensagem,mterror,[mbok],0);
      VEdit.Clear;
   End
   Else
      Result := True;
End;

Function FFormataValor(VPMascara : String; VPValor : Real; VPtamanho : Word) : String;
Var
   VCont,
   VBrancosFrente : Word;
Begin
   Result := '';
   VBrancosFrente := VPtamanho - Length(FormatFloat(VPMascara,VPValor));
   For VCont := 1 To VBrancosFrente Do
       Begin
       Application.ProcessMessages;
       Result := Result + ' ';
   End;

   Result := Result + FormatFloat(VPMascara, VPValor);

   If Length(Result) < VPTamanho Then
      For VCont := 1 To (VPTamanho - Length(Result)) Do
          Begin
          Application.ProcessMessages;
          Result := Result + ' ';
      End;
End;

function FArredonda(VFCasasDecimais : Integer; VFNumero : Double) : Double;
var
   i                   : Integer;
   MMascara,
   VFDivisorDec,
   MNumeroConvString   : String;
begin
// Controlar de acordo com a ultima casa. acrescentar + 1 em VFCasasDecimais e analisar
// ultima casa. se < 4 Trunca senao soma.

   MMascara     := '########0.';
   VFDivisorDec := '';
   For i := 1 to (VFCasasDecimais+1) Do
       Begin
       MMascara := MMascara + '0';
       If i > 1 Then
          VFDivisorDec := VFDivisorDec + '0';
   End;
   VFDivisorDec := '1'+VFDivisorDec;

   MNumeroConvString := FormatFloat(MMascara,VFNumero);

   If StrToFloat(PDireita(MNumeroConvString,1)) < 5 Then
      Result := StrToFloat(Copy(MNumeroConvString,1,Length(MNumeroConvString)-1))
   Else
      Result := StrToFloat(Copy(MNumeroConvString,1,Length(MNumeroConvString)-1)) + (1/StrToFloat(VFDivisorDec));
end;

function FUltimoDiaMes(VFMes, VFAno : String) : String;
Begin
   If ( VFMes = '01' ) Or
      ( VFMes = '03' ) Or
      ( VFMes = '05' ) Or
      ( VFMes = '07' ) Or
      ( VFMes = '08' ) Or
      ( VFMes = '10' ) Or
      ( VFMes = '12' ) Then
      Result := '31'
   Else
   If ( VFMes = '04' ) Or
      ( VFMes = '06' ) Or
      ( VFMes = '09' ) Or
      ( VFMes = '11' ) Then
      Result := '30'
   Else
      Begin
      if AnoBiSexto(StrToInt(VFAno)) Then
         Result := '29'
      Else
         Result := '28';
   End;
End;

function AnoBiSexto(Ayear: Integer): Boolean;
begin
   Result := (AYear mod 4 = 0) and ((AYear mod 100 <> 0) or (AYear mod 400 = 0));
end;

Function FUltDiaMes(Data : TDate) : TDate;
var
   Ano, Mes, Dia : word;
begin
   DecodeDate(Data, Ano, Mes, Dia);
   Dia := 1;

   If (Mes = 12) Then
      Begin
      Mes := 1;
      Ano := Ano + 1;
   End Else
      Mes := Mes + 1;

   result := EncodeDate(Ano, Mes, Dia) - 1;
end;

Function FAnulaLetra(VFKey : char): Boolean;
Var
   VOk : Boolean;
begin
   Result         := True;
   VOk := VFKey in ['0'..'9','.','-', #8, #127,','];

   If Not VOk Then
      Begin
      Result := False;
   End;
End;

Function FValidaData(var Data : TMaskEdit; MLabel : String; VIni,VFim : Boolean) : Boolean;
Begin
   Result := False;

   If Data.Enabled Then
      Begin

      If (VIni) And (Data.Text = '  /  /    ') Then
         Data.Text := '01/01/1900'
      Else
         If (VFim) And (Data.Text = '  /  /    ') Then
            Data.Text := '31/12/2999';

      Data.Text := FMontaAno(Data.Text);

      Try
        StrToDate(Data.Text);
      Except
        On EConvertError do
           If Data.Text = '  /  /    ' Then
              Begin
              MessageDlg(MLabel + ' não pode ficar em branco !',mtwarning,[mbok],0);
              Data.SetFocus;
              Exit;
           End
           Else
              Begin
              MessageDlg(MLabel + ' Inválida !',mtwarning,[mbok],0);
              Data.Clear;
              Data.SetFocus;
              Exit;
           End;
      End;

   End;

   Result := True;
end;

Function FMontaAno(VData: String) : String;
Var
   VAnoData : Integer;
   VAnoFim  : String;
   VMesFim  : String;
begin
   VAnoFim := Copy(Trim(VData),7,4);
   VMesFim := Copy(Trim(VData),4,2);

   If Trim(VMesFim) = ''  Then
      Begin
      VMesFim := Copy(Trim(DateToStr(SysUtils.Date)),4,2);
      VData   := StrZero(Copy(Trim(VData),1,2),2)+ '/' + VMesFim+'/';
   End;

   If ( Length(VAnoFim) = 2 ) Then
      VAnoFim := '20' + VAnoFim;

   If ( Trim(VAnoFim) = '' ) Or ( StrToFloat(Trim(VAnoFim)) < 1900 ) Then
      Begin
      VAnoFim := Copy(Trim(DateToStr(SysUtils.Date)),7,4);
      VData   := Copy(Trim(VData),1,6) + VAnoFim
   End;

   VAnoData := StrToInt(Copy(Trim(VData),7,2));
   VAnoFim  := Copy(Trim(VData),9,2);

   If Trim(VAnoFim) <> '' Then
      Begin
      Result := VData;
      Exit;
   End;

   If Copy(Trim(VData),7,2) = ''  Then
      Begin
      Result := VData;
      Exit;
   End;

   If VAnoData >= VAnoBase Then
      Begin
      Result := Copy(VData,1,6)+'19'+Copy(VData,7,2);
   End
   Else
      Result := Copy(VData,1,6)+'20'+Copy(VData,7,2);
End;

function RetirarAcentos(Str: String): String;
var
  i: Integer;
begin
  for i:=1 to Length(Str) do
  begin
    if Str[i] in ['á','à','ã','â','ä'] Then
       Str[i]:='a' else
    if Str[i] in ['Á','À','Ã','Â','Ä'] then
       Str[i]:='A' else
    if Str[i] in ['é','è','ê','ë'] then
       Str[i]:='e' else
    if Str[i] in ['É','È','Ê','Ë'] Then
       Str[i]:='E' else
    if Str[i] in ['í','ì','î','ï'] then
       Str[i]:='i' else
    if Str[i] in ['Í','Ì','Î','Ï'] Then
       Str[i]:='I' else
    if Str[i] in ['ó','ò','õ','ô','ö'] then
       Str[i]:='o' else
    if Str[i] in ['Ó','Ò','Õ','Ô','Ö'] Then
       Str[i]:='O' else
    if Str[i] in ['ú','ù','û','ü'] then
       Str[i]:='u' else
    if Str[i] in ['Ú','Ù','Û','Ü'] Then
       Str[i]:='U' else
    if Str[i] in ['ç','€'] then
       Str[i]:='c' else
    if Str[i] in ['Ç'] Then
       Str[i]:='C' else
    if ( Str[i] in ['º','ª','¨','#'] ) Or ( Str[i] = chr(248) ) Or ( Str[i] = chr(249) ) Or ( Str[i] = chr(250) ) Or
       ( Str[i] = chr(166) ) Or ( Str[i] = chr(167) ) Then
       Str[i]:='.' else
    if ( Str[i] = chr(155) ) Or ( Str[i] = chr(156) ) Or ( Str[i] = chr(157) ) Or ( Str[i] = chr(158) ) Or
       ( Str[i] = chr(159) ) Or ( Str[i] = chr(160) ) Or ( Str[i] = chr(161) ) Or ( Str[i] = chr(162) ) Or
       ( Str[i] = chr(163) ) Or ( Str[i] = chr(164) ) Or ( Str[i] = chr(165) ) Or ( Str[i] = chr(168) ) Or
       ( Str[i] = chr(169) ) Or ( Str[i] = chr(170) ) Or ( Str[i] = chr(171) ) Or ( Str[i] = chr(172) ) Or
       ( Str[i] = chr(173) ) Or ( Str[i] = chr(174) ) Or ( Str[i] = chr(175) ) Or ( Str[i] = chr(176) ) Or
       ( Str[i] = chr(177) ) Or ( Str[i] = chr(178) ) Or ( Str[i] = chr(179) ) Or ( Str[i] = chr(180) ) Or
       ( Str[i] = chr(181) ) Or ( Str[i] = chr(182) ) Or ( Str[i] = chr(183) ) Or ( Str[i] = chr(184) ) Or
       ( Str[i] = chr(185) ) Or ( Str[i] = chr(186) ) Or ( Str[i] = chr(187) ) Or ( Str[i] = chr(188) ) Or
       ( Str[i] = chr(189) ) Or ( Str[i] = chr(190) ) Or // ( Str[i] = chr(191) ) Chave do Intefil
       ( Str[i] = chr(192) ) Or ( Str[i] = chr(193) ) Or ( Str[i] = chr(194) ) Or ( Str[i] = chr(195) ) Or
       ( Str[i] = chr(196) ) Or ( Str[i] = chr(197) ) Or ( Str[i] = chr(198) ) Or ( Str[i] = chr(199) ) Or
       ( Str[i] = chr(200) ) Or ( Str[i] = chr(201) ) Or ( Str[i] = chr(202) ) Or ( Str[i] = chr(203) ) Or
       ( Str[i] = chr(204) ) Or ( Str[i] = chr(205) ) Or ( Str[i] = chr(206) ) Or ( Str[i] = chr(207) ) Or
       ( Str[i] = chr(208) ) Or ( Str[i] = chr(209) ) Or ( Str[i] = chr(210) ) Or ( Str[i] = chr(211) ) Or
       ( Str[i] = chr(212) ) Or ( Str[i] = chr(213) ) Or ( Str[i] = chr(214) ) Or ( Str[i] = chr(215) ) Or
       ( Str[i] = chr(216) ) Or ( Str[i] = chr(217) ) Or ( Str[i] = chr(218) ) Or ( Str[i] = chr(219) ) Or
       ( Str[i] = chr(220) ) Or ( Str[i] = chr(221) ) Or ( Str[i] = chr(222) ) Or ( Str[i] = chr(223) ) Or
       ( Str[i] = chr(224) ) Or ( Str[i] = chr(225) ) Or ( Str[i] = chr(226) ) Or ( Str[i] = chr(227) ) Or
       ( Str[i] = chr(228) ) Or ( Str[i] = chr(229) ) Or ( Str[i] = chr(230) ) Or ( Str[i] = chr(231) ) Or
       ( Str[i] = chr(232) ) Or ( Str[i] = chr(233) ) Or ( Str[i] = chr(234) ) Or ( Str[i] = chr(235) ) Or
       ( Str[i] = chr(236) ) Or ( Str[i] = chr(237) ) Or ( Str[i] = chr(238) ) Or ( Str[i] = chr(239) ) Or
       ( Str[i] = chr(240) ) Or ( Str[i] = chr(241) ) Or ( Str[i] = chr(242) ) Or ( Str[i] = chr(243) ) Or
       ( Str[i] = chr(244) ) Or ( Str[i] = chr(245) ) Or ( Str[i] = chr(246) ) Or ( Str[i] = chr(247) ) Or
       ( Str[i] = chr(251) ) Or ( Str[i] = chr(252) ) Or ( Str[i] = chr(253) ) Or ( Str[i] = chr(254) ) Or
       ( Str[i] = chr(255) ) Then
       Str[i]:=' ';  end;
  Result:=Str;
end;

Function FCGCCPF(VPCGCCPF : String; VPPessoa : String) : Boolean;
var
   Digito   : String;
   Digito1  : String;
   Digito2  : String;

   // Variáveis p/ CPF
   i,
   Contador : Integer;
   D101, D102, D103, D104, D105, D106, D107, D108, D109,
   D201, D202, D203, D204, D205, D206, D207, D208, D209,
   Df4,
   Df5,
   Df6,
   Resto1,
   PriDig,
   SegDig : Real;
begin
   Result := True;

   D101   := 0;
   D102   := 0;
   D103   := 0;
   D104   := 0;
   D105   := 0;
   D106   := 0;
   D107   := 0;
   D108   := 0;
   D109   := 0;
   D201   := 0;
   D202   := 0;
   D203   := 0;
   D204   := 0;
   D205   := 0;
   D206   := 0;
   D207   := 0;
   D208   := 0;
   D209   := 0;

   i := 1;

   While (Copy(VPCGCCPF,i,1) = Copy(VPCGCCPF,i+1,1)) And
         (i <= Length(VPCGCCPF))                    Do
         Inc(i);

   If i = Length(VPCGCCPF) Then
      Begin
      Result := False;
      Exit;
   End;

   If VPPessoa = 'J' Then
      Begin
      VPCGCCPF := Trim(VPCGCCPF);
      Digito  := PDireita(VPCGCCPF,2);
      Digito1 := FResto11(Copy(VPCGCCPF,1,12));
      Digito2 := FResto11(Copy(VPCGCCPF,1,13));

      If Digito = Digito1+Digito2 Then
         Result := True
      Else
         Result := False;
   End
   Else  // C.p.f
      Begin
      //********** Calculo do Primeiro Digito CPF pessoa Fisica ***********
      Contador := 1;

      While Contador <= 9 Do
            Begin
            If Contador = 1 Then
               D101 := StrToInt(Copy(VPCGCCPF,Contador,1));

            If Contador = 2 Then
               D102 := StrToInt(Copy(VPCGCCPF,Contador,1));

            If Contador = 3 Then
               D103 := StrToInt(Copy(VPCGCCPF,Contador,1));

            If Contador = 4 Then
               D104 := StrToInt(Copy(VPCGCCPF,Contador,1));

            If Contador = 5 Then
               D105 := StrToInt(Copy(VPCGCCPF,Contador,1));

            If Contador = 6 Then
               D106 := StrToInt(Copy(VPCGCCPF,Contador,1));

            If Contador = 7 Then
               D107 := StrToInt(Copy(VPCGCCPF,Contador,1));

            If Contador = 8 Then
               D108 := StrToInt(Copy(VPCGCCPF,Contador,1));

            If Contador = 9 Then
               D109 := StrToInt(Copy(VPCGCCPF,Contador,1));

            Contador := Contador + 1;
      End;

      Df4    := (10*D101 + 9*D102 + 8*D103 + 7*D104 + 6*D105 + 5*D106 + 4*D107 + 3*D108 + 2*D109);
      Df5    := (Df4 / 11);
      Df6    := (Int(Df5) * 11);
      Resto1 := (Df4 - Df6);

      If (Resto1 = 0) Or (Resto1 = 1) Then
         PriDig := 0
      Else
         PriDig := (11 - Resto1);

      //********** Calculo do Segundo Digito CPF pessoa Fisica ***************

      Contador := 1;
      While Contador <= 9 Do
            Begin
            If Contador = 1 Then
               D201 := StrToInt(Copy(VPCGCCPF,Contador,1));

            If Contador = 2 Then
               D202 := StrToInt(Copy(VPCGCCPF,Contador,1));

            If Contador = 3 Then
               D203 := StrToInt(Copy(VPCGCCPF,Contador,1));

            If Contador = 4 Then
               D204 := StrToInt(Copy(VPCGCCPF,Contador,1));

            If Contador = 5 Then
               D205 := StrToInt(Copy(VPCGCCPF,Contador,1));

            If Contador = 6 Then
               D206 := StrToInt(Copy(VPCGCCPF,Contador,1));

            If Contador = 7 Then
               D207 := StrToInt(Copy(VPCGCCPF,Contador,1));

            If Contador = 8 Then
               D208 := StrToInt(Copy(VPCGCCPF,Contador,1));

            If Contador = 9 Then
               D209 := StrToInt(Copy(VPCGCCPF,Contador,1));

            Contador := Contador + 1
      End;

      Df4    := (11*D201 + 10*D202 + 9*D203 + 8*D204 + 7*D205 + 6*D206 + 5*D207 + 4*D208 + 3*D209 + 2*PriDig);
      Df5    := (Df4 / 11);
      Df6    := (Int(Df5) * 11);
      Resto1 := (Df4 - Df6);

      If (Resto1 = 0) Or (Resto1 = 1) Then
         SegDig := 0
      Else
         SegDig := 11 - Resto1;

      If ( PriDig <> StrToInt(Copy(VPCGCCPF,10,1)) ) Or
         ( SegDig <> StrToInt(Copy(VPCGCCPF,11,1)) ) Then
         Result := False;
   End;
end;

Function FResto11(VFCodigo : String) : String;
var
  VFSoma : Integer;
//  VFInc  : Integer;
  K      : Integer;
  VFtemp : Integer;
begin
  VFCodigo := Trim(VFCodigo);
  VFSoma   := 0;
//VFInc    := 2;
  For K := Length(VFCodigo) DownTo 1 Do
    Begin
    Application.ProcessMessages;
    If (Length(VFCodigo)-K+2) <= 9 Then
       VFTemp := (Length(VFCodigo)-K+2)
    Else
       VFTemp := (Length(VFCodigo)-K+2) - 8;

    VFSoma := VFSoma + StrToInt(Copy(VFCodigo,K,1)) * VFTemp;
  End;

  If (11-(VFSoma Mod 11)) > 9 Then
     Result := '0'
  Else
     Result := Trim(IntToStr(11-(VFSoma Mod 11)));

End;

procedure FAlinhaGrid (var VFStringGrid : TStringGrid; Col, Row, Coluna : Integer; Rect: TRect);
var
   ACol : integer absolute Col;
   ARow : integer absolute Row;
   Format : integer;
begin
//   Rect.Right := 80;
   if (ACol <> Coluna) Or
      (ARow = 0)       Then
      Exit;

   with VFStringGrid do
        begin
        Format := FmtRight;

        Canvas.FillRect(Rect);
        Rect.Right := Rect.Right - 3;

        StrPCopy(@(TempString[0]),VFStringGrid.Cells[ACol,ARow]);
        DrawText(Canvas.Handle, TempString, -1, Rect, Format);
   end;

end;


function Encripta(VFPar_Str: String;VFTamanho : Word) : String;
var
   VFSeq2 : Integer;
   VFComp : Integer;
begin
   If VFTamanho < 10 Then
      For VFComp := Length(VFPar_Str) To 10 Do
          VFPar_Str := VFPar_Str + ' ';

   Result := '';

   For VFSeq2 := VFTamanho DownTo 1 Do
       Result := Result + StrZero(IntToStr(FAsc(Copy(VFPar_Str,VFSeq2,1))),3);
end;

function Descripta(VFPar_Str: String; VFTamanho: Word): String;
var
   VFSeq2 : Integer;
begin
   Result := '';

   For VFSeq2 := VFTamanho DownTo 1 Do
       Result := Result + Chr(StrToInt(Copy(VFPar_Str,VFSeq2*3-2,3)));
end;

function PadL(VFString: String; VFTamanho: Integer): String;
Var
  VFRetorno       : String;
  X               : Integer;
begin
  VFRetorno := '';

  For X := 1 To Length(VFString) Do
      Begin
      VFRetorno := Copy(VFString, Length(VFString) - (X-1), 1) + VFRetorno;
      If X = VFTamanho Then
         Break;
  End;

  Result := Space(VFTamanho-Length(vfRetorno)) + VFRetorno;
end;

function Space(VFTamanho: Integer): String;
Var
  X : Integer;
Begin
  Result := '';
  For X := 1 To VFTamanho Do
      Begin
      Result := Result + ' ';
  End;
end;

procedure PIniciaTransacao(VPConnection: TSQLConnection);
begin
   If VPConnection.InTransaction Then
      Exit;

   MTransaction.TransactionID  := 1;                  // Para controle, todas as transações recebem o mesmo id
   MTransaction.IsolationLevel := xilREADCOMMITTED;   // acessa somente dados realmente gravados

   VPConnection.StartTransaction(MTransaction);
end;

procedure PConfirmaTransacao(VPConnection: TSQLConnection);
begin
   If Not VPConnection.InTransaction Then
      Exit;

   MTransaction.TransactionID  := 1;
   MTransaction.IsolationLevel := xilREADCOMMITTED;

   VPConnection.Commit(MTransaction);
end;

procedure PCancelaTransacao(VPConnection: TSQLConnection);
begin
   If Not VPConnection.InTransaction Then
      Exit;

   MTransaction.TransactionID  := 1;
   MTransaction.IsolationLevel := xilREADCOMMITTED;

   VPConnection.Rollback(MTransaction);
end;

end.
