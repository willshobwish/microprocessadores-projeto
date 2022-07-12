unit CalculadoraPascal;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls;

type

  { TCalculator }

  TCalculator = class(TForm)
    DebugVisualization: TEdit;
    IndexDisplay: TEdit;
    FirstNumberVisualization: TEdit;
    Memo1: TMemo;
    SecondNumberVisualization: TEdit;
    RightParenthesis: TButton;
    LeftParenthesis: TButton;
    ClearButton: TButton;
    EqualButton: TButton;
    BackspaceButton: TButton;
    Button8: TButton;
    Button5: TButton;
    Button2: TButton;
    PointButton: TButton;
    SignalButton: TButton;
    Button7: TButton;
    Button4: TButton;
    Button1: TButton;
    DivisionButton: TButton;
    Button0: TButton;
    ClearEntryButton: TButton;
    YsqrtxButton: TButton;
    TanButton: TButton;
    CosButton: TButton;
    SqrtxButton: TButton;
    X2Button: TButton;
    XyButton: TButton;
    ExButton: TButton;
    SinButton: TButton;
    MultiplicationButton: TButton;
    OneXButton: TButton;
    FactorialButton: TButton;
    LogButton: TButton;
    LnButton: TButton;
    MemoryRestoreButton: TButton;
    MemoryStoreButton: TButton;
    MemoryPlusButton: TButton;
    PiButton: TButton;
    MemoryClearButton: TButton;
    MinusButton: TButton;
    PlusButton: TButton;
    Button9: TButton;
    Button6: TButton;
    Button3: TButton;
    InverseCheck: TCheckBox;
    DegreeRadio: TRadioButton;
    RadianRadio: TRadioButton;
    Visualization: TEdit;
    //procedure SendNumber();
    procedure EnviarNumeroLista(Numero: string);
    procedure ClearVisualization();
    procedure ClearOperationFlag();
    procedure BackspaceButtonClick(Sender: TObject);
    procedure ClearEntryButtonClick(Sender: TObject);
    procedure ClearButtonClick(Sender: TObject);
    procedure CosButtonClick(Sender: TObject);
    procedure DegreeRadioChange(Sender: TObject);
    procedure DivisionButtonClick(Sender: TObject);
    procedure DebugVisualizationChange(Sender: TObject);
    procedure FirstNumberVisualizationChange(Sender: TObject);
    procedure Button8Click(Sender: TObject);
    procedure EqualButtonClick(Sender: TObject);
    procedure ExButtonClick(Sender: TObject);
    procedure FactorialButtonClick(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure LeftParenthesisClick(Sender: TObject);
    procedure LnButtonClick(Sender: TObject);
    procedure LogButtonClick(Sender: TObject);
    procedure Memo1Change(Sender: TObject);
    procedure MemoryClearButtonClick(Sender: TObject);
    procedure MemoryPlusButtonClick(Sender: TObject);
    procedure MemoryRestoreButtonClick(Sender: TObject);
    procedure MemoryStoreButtonClick(Sender: TObject);
    procedure MinusButtonClick(Sender: TObject);
    procedure MultiplicationButtonClick(Sender: TObject);
    procedure Button9Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure OneXButtonClick(Sender: TObject);
    procedure PiButtonClick(Sender: TObject);
    procedure PlusButtonClick(Sender: TObject);
    procedure PointButtonClick(Sender: TObject);
    procedure RadianRadioChange(Sender: TObject);
    procedure RightParenthesisClick(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure SignalButtonClick(Sender: TObject);
    procedure SinButtonClick(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure SqrtxButtonClick(Sender: TObject);
    procedure TanButtonClick(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure InverseCheckChange(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure VisualizationChange(Sender: TObject);
    procedure X2ButtonClick(Sender: TObject);
    procedure XyButtonClick(Sender: TObject);
    procedure YsqrtxButtonClick(Sender: TObject);
    procedure Button0Click(Sender: TObject);
  private

    //Declaracao de tipos e variaveis globais
  public

    //Declaracao de tipos
    //type

    //  //Criacao de um array com as operacoes
    //  Operations = array[0..50] of string;

    //Declaracao de variaveis globais
  var

    //Declaracao de variavel para a operacao de restauracao de memoria
    MemoryCalculator, MemoryStore: real;
    TemporaryNumber: string;
    OperationFlag, BlockOperation, FloatingPoint, Sum, Subtraction, Division, Multiplication: boolean;
    OperationIndex: integer;
    //Lista de todas as operacoes que o usuario digitar
    OperationList: array[0..100] of string;
    NotacaoPolonesaList: array[0..100] of string;
    //OperationList: array[0..100] of string;

  end;

var
  Calculator: TCalculator;

implementation

{$R *.lfm}

{ TCalculator }

procedure TCalculator.ClearOperationFlag();
begin
  Sum := False;
  Subtraction := False;
  Division := False;
  Multiplication := False;
end;

procedure TCalculator.ClearVisualization();
// Metodo para checar se ha zero no visor e substituir com a primeira operacao ou numero que o usuario digitar
begin
  if Visualization.Text = '0' then
  begin
    Visualization.Text := '';
  end;
end;

procedure TCalculator.ClearEntryButtonClick(Sender: TObject);
// Botao para limpar a entrada de operacao
begin
  ClearOperationFlag();
end;

procedure TCalculator.BackspaceButtonClick(Sender: TObject);
// Botao para apagar um digito ou operacao, ele verifica qual numero ou operacao que esta no array e apaga
begin

end;

procedure TCalculator.ClearButtonClick(Sender: TObject);
var
  Index: integer;
begin
  //  [Debug] Limpar a exibicao em testes
  DebugVisualization.Text := '0';
  //  [Debug]
  OperationFlag := False;
  for Index := 0 to OperationIndex do
  begin
    OperationList[Index] := '0';
  end;
  OperationIndex := 0;
  Visualization.Text := FloatToStr(0);
  MemoryCalculator := 0;
  FloatingPoint := False;
end;

//Enviar o numero para a visualizacao e variavel temporaria que armazena o numero
procedure TCalculator.EnviarNumeroLista(Numero: string);
begin
  ClearVisualization();
  Visualization.Text := Visualization.Text + Numero;
  TemporaryNumber := TemporaryNumber + Numero;
end;

procedure TCalculator.CosButtonClick(Sender: TObject);
begin
  OperationFlag := True;
  ClearVisualization();
  Visualization.Text := Visualization.Text + 'cos(';
end;

procedure TCalculator.DegreeRadioChange(Sender: TObject);
begin

end;

procedure TCalculator.DivisionButtonClick(Sender: TObject);
begin
  OperationFlag := True;
  OperationIndex += 1;
  OperationList[OperationIndex] := TemporaryNumber;
  TemporaryNumber := '';
  Visualization.Text := Visualization.Text + '/';
  OperationIndex += 1;
  OperationList[OperationIndex] := '/';
end;

procedure TCalculator.DebugVisualizationChange(Sender: TObject);
begin

end;

procedure TCalculator.FirstNumberVisualizationChange(Sender: TObject);
begin

end;

procedure TCalculator.Button8Click(Sender: TObject);
begin
  EnviarNumeroLista('8');
end;

//Funcoes para realizar os calculos na FPU
function SumFunction(FirstNumber, SecondNumber: real): real;
var
  Final: real;
begin
    {$asmmode intel}
  asm
           FINIT
           FLD     FirstNumber
           FLD     SecondNumber
           FADD    ST,ST(1)
           FSTP    Final
  end;
  SumFunction := Final;
end;

procedure TCalculator.EqualButtonClick(Sender: TObject);

var
  Index: integer;
  TempString: string;
  TempNumberFirst, TempNumberSecond, Result: real;
begin
  //[Debug]
  IndexDisplay.Text := floattostr(OperationIndex);
  //[Debug]
  //A calculadora funcionara somente se alguma operacao for acionada
  if OperationFlag = True then
  begin
    //Para contabilizar o ultimo numero que for inserido
    OperationIndex += 1;
    OperationList[OperationIndex] := TemporaryNumber;
    TemporaryNumber := '';
    //Inicio da varredura do array de operacoes
    for Index := 1 to OperationIndex do
    begin
      //[Debug] Exibicao na visualizacao para testes
      //TempString := TempString + OperationList[Index];
      Memo1.Text := Memo1.Text + '[' + IntToStr(Index) + ']' +
        OperationList[Index] + sLineBreak;
      case OperationList[Index] of
        '+': begin
          Result := 0;
          //Pega o numero anterior e o proximo da lista com referencia no operador dentro do array
          TempNumberFirst := strtofloat(OperationList[Index - 1]);
          TempNumberSecond := strtofloat(OperationList[Index + 1]);
          FirstNumberVisualization.Text := floattostr(TempNumberFirst);
          SecondNumberVisualization.Text := floattostr(TempNumberSecond);
          DebugVisualization.Text :=
            floattostr(SumFunction(TempNumberFirst, TempNumberSecond));
        end;
        '-': begin
          Result := 0;
          TempNumberFirst := strtofloat(OperationList[Index - 1]);
          TempNumberSecond := strtofloat(OperationList[Index + 1]);
          FirstNumberVisualization.Text := floattostr(TempNumberFirst);
          SecondNumberVisualization.Text := floattostr(TempNumberSecond);
          DebugVisualization.Text :=
            floattostr(SumFunction(TempNumberFirst, TempNumberSecond));
        end;
        else
      end;
    end;
  end;
end;

procedure TCalculator.ExButtonClick(Sender: TObject);
begin
  OperationFlag := True;
  ClearVisualization();
  Visualization.Text := Visualization.Text + 'e^';
end;

procedure TCalculator.FactorialButtonClick(Sender: TObject);
begin
  ClearVisualization();
  Visualization.Text := Visualization.Text + '!';
end;

procedure TCalculator.Button5Click(Sender: TObject);
begin
  EnviarNumeroLista('5');
end;

procedure TCalculator.FormCreate(Sender: TObject);
begin

end;

procedure TCalculator.Button4Click(Sender: TObject);
begin
  EnviarNumeroLista('4');
end;

procedure TCalculator.LeftParenthesisClick(Sender: TObject);
begin
  ClearVisualization();
  Visualization.Text := Visualization.Text + '(';
end;

procedure TCalculator.LnButtonClick(Sender: TObject);
begin
  ClearVisualization();
  Visualization.Text := Visualization.Text + 'ln(';
end;

procedure TCalculator.LogButtonClick(Sender: TObject);
begin
  ClearVisualization();
  Visualization.Text := Visualization.Text + 'log(';
end;

procedure TCalculator.Memo1Change(Sender: TObject);
begin

end;

procedure TCalculator.MemoryClearButtonClick(Sender: TObject);
begin
  MemoryStore := 0;
end;

procedure TCalculator.MemoryPlusButtonClick(Sender: TObject);
begin

end;

procedure TCalculator.MemoryRestoreButtonClick(Sender: TObject);
begin
  MemoryCalculator := MemoryStore;
  Visualization.Text := floattostr(MemoryCalculator);
end;

procedure TCalculator.MemoryStoreButtonClick(Sender: TObject);
begin
  MemoryStore := MemoryCalculator;

end;

procedure TCalculator.MinusButtonClick(Sender: TObject);
begin
  OperationFlag := True;
  OperationIndex += 1;
  OperationList[OperationIndex] := TemporaryNumber;
  TemporaryNumber := '';
  Visualization.Text := Visualization.Text + '-';
  OperationIndex += 1;
  OperationList[OperationIndex] := '-';
end;

procedure TCalculator.MultiplicationButtonClick(Sender: TObject);
begin
  OperationFlag := True;
  OperationIndex += 1;
  OperationList[OperationIndex] := TemporaryNumber;
  TemporaryNumber := '';
  Visualization.Text := Visualization.Text + '*';
  OperationIndex += 1;
  OperationList[OperationIndex] := '*';
end;

procedure TCalculator.Button9Click(Sender: TObject);
begin
  EnviarNumeroLista('9');
end;

procedure TCalculator.Button1Click(Sender: TObject);
begin
  EnviarNumeroLista('1');
end;

procedure TCalculator.OneXButtonClick(Sender: TObject);
begin
  OperationFlag := True;
  ClearVisualization();
  Visualization.Text := Visualization.Text + '1/';
end;

procedure TCalculator.PiButtonClick(Sender: TObject);
var
  Temp: real;
begin

  {$asmmode intel}
  asm
           FINIT
           FLDPI
           FSTP    Temp
  end;
  Visualization.Text := FloatToStr(Temp);
  //MemoryCalculator := StrToFloat(Visualization.Text);
end;

procedure TCalculator.PlusButtonClick(Sender: TObject);
begin
  //[Debug]
  IndexDisplay.Text := floattostr(OperationIndex);
  //[Debug]
  OperationFlag := True;
  OperationIndex += 1;
  OperationList[OperationIndex] := TemporaryNumber;
  TemporaryNumber := '';
  Visualization.Text := Visualization.Text + '+';
  OperationIndex += 1;
  OperationList[OperationIndex] := '+';
end;

procedure TCalculator.PointButtonClick(Sender: TObject);
begin
  if (FloatingPoint = False) then
  begin
    Visualization.Text := Visualization.Text + ',';
    MemoryCalculator := strtofloat(Visualization.Text);
    FloatingPoint := True;
  end;

end;

procedure TCalculator.RadianRadioChange(Sender: TObject);
begin

end;

procedure TCalculator.RightParenthesisClick(Sender: TObject);
begin
  ClearVisualization();
  Visualization.Text := Visualization.Text + ')';
end;

procedure TCalculator.Button7Click(Sender: TObject);
begin
  EnviarNumeroLista('7');
end;

procedure TCalculator.SignalButtonClick(Sender: TObject);
begin

end;

procedure TCalculator.SinButtonClick(Sender: TObject);
begin
  OperationFlag := True;
  ClearVisualization();
  Visualization.Text := Visualization.Text + 'sin(';
  //MemoryCalculator := strtofloat(Visualization.Text);
end;

procedure TCalculator.Button6Click(Sender: TObject);
begin
  EnviarNumeroLista('6');
end;

procedure TCalculator.SqrtxButtonClick(Sender: TObject);
var
  Temp: real;
begin
  OperationFlag := True;
end;

procedure TCalculator.TanButtonClick(Sender: TObject);
begin
  OperationFlag := True;
  ClearVisualization();
  Visualization.Text := Visualization.Text + 'tan(';
end;

procedure TCalculator.Button3Click(Sender: TObject);
begin
  EnviarNumeroLista('3');
end;

procedure TCalculator.InverseCheckChange(Sender: TObject);
begin

end;

procedure TCalculator.Button2Click(Sender: TObject);
begin
  EnviarNumeroLista('2');
end;

procedure TCalculator.VisualizationChange(Sender: TObject);
begin

end;


procedure TCalculator.X2ButtonClick(Sender: TObject);
begin
  OperationFlag := True;
  ClearVisualization();
  Visualization.Text := Visualization.Text + '²';
end;

procedure TCalculator.XyButtonClick(Sender: TObject);
begin
  OperationFlag := True;
  ClearVisualization();
  Visualization.Text := Visualization.Text + '^';
end;

procedure TCalculator.YsqrtxButtonClick(Sender: TObject);
begin
  OperationFlag := True;
end;

procedure TCalculator.Button0Click(Sender: TObject);
begin
  if Visualization.Text <> '0' then
  begin
    EnviarNumeroLista('0');
  end;

end;



end.
