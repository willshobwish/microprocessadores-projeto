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
    EightButton: TButton;
    FiveButton: TButton;
    TwoButton: TButton;
    PointButton: TButton;
    SignalButton: TButton;
    SevenButton: TButton;
    FourButton: TButton;
    OneButton: TButton;
    DivisionButton: TButton;
    ZeroButton: TButton;
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
    NineButton: TButton;
    SixButton: TButton;
    ThreeButton: TButton;
    InverseCheck: TCheckBox;
    DegreeRadio: TRadioButton;
    RadianRadio: TRadioButton;
    Visualization: TEdit;
    //procedure SendNumber();
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
    procedure EightButtonClick(Sender: TObject);
    procedure EqualButtonClick(Sender: TObject);
    procedure ExButtonClick(Sender: TObject);
    procedure FactorialButtonClick(Sender: TObject);
    procedure FiveButtonClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FourButtonClick(Sender: TObject);
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
    procedure NineButtonClick(Sender: TObject);
    procedure OneButtonClick(Sender: TObject);
    procedure OneXButtonClick(Sender: TObject);
    procedure PiButtonClick(Sender: TObject);
    procedure PlusButtonClick(Sender: TObject);
    procedure PointButtonClick(Sender: TObject);
    procedure RadianRadioChange(Sender: TObject);
    procedure RightParenthesisClick(Sender: TObject);
    procedure SevenButtonClick(Sender: TObject);
    procedure SignalButtonClick(Sender: TObject);
    procedure SinButtonClick(Sender: TObject);
    procedure SixButtonClick(Sender: TObject);
    procedure SqrtxButtonClick(Sender: TObject);
    procedure TanButtonClick(Sender: TObject);
    procedure ThreeButtonClick(Sender: TObject);
    procedure InverseCheckChange(Sender: TObject);
    procedure TwoButtonClick(Sender: TObject);
    procedure VisualizationChange(Sender: TObject);
    procedure X2ButtonClick(Sender: TObject);
    procedure XyButtonClick(Sender: TObject);
    procedure YsqrtxButtonClick(Sender: TObject);
    procedure ZeroButtonClick(Sender: TObject);
  private

    //Declaracao de tipos e variaveis globais
  public

    //Declaracao de tipos
  type

    //Criacao de um array com as operacoes
    Operations = array[0..50] of string;

    //Declaracao de variaveis globais
  var

    //Declaracao de variavel para a operacao de restauracao de memoria
    MemoryCalculator, MemoryStore: real;
    TemporaryNumber: string;
    OperationFlag, FloatingPoint, Sum, Subtraction, Division, Multiplication: boolean;
    OperationIndex: integer;
    OperationList: Operations;
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

//procedure TCalculator.SendNumber();
//begin
//  OperationIndex := OperationIndex + 1;
//  OperationList[OperationIndex] := Visualization.Text;
//end;

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
end;

procedure TCalculator.DebugVisualizationChange(Sender: TObject);
begin

end;

procedure TCalculator.FirstNumberVisualizationChange(Sender: TObject);
begin

end;

procedure TCalculator.EightButtonClick(Sender: TObject);
begin
  ClearVisualization();
  Visualization.Text := Visualization.Text + '8';
  TemporaryNumber := TemporaryNumber + '8';
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
      Memo1.Text := Memo1.Text + '[' + inttostr(Index) + ']' + OperationList[Index] + sLineBreak ;
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

procedure TCalculator.FiveButtonClick(Sender: TObject);
begin
  ClearVisualization();
  Visualization.Text := Visualization.Text + '5';
  TemporaryNumber := TemporaryNumber + '5';
  //MemoryCalculator := StrToFloat(Visualization.Text);
end;

procedure TCalculator.FormCreate(Sender: TObject);
begin

end;

procedure TCalculator.FourButtonClick(Sender: TObject);
begin
  ClearVisualization();
  Visualization.Text := Visualization.Text + '4';
  TemporaryNumber := TemporaryNumber + '4';
  //MemoryCalculator := strtofloat(Visualization.Text);
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
end;

procedure TCalculator.NineButtonClick(Sender: TObject);
begin
  ClearVisualization();
  Visualization.Text := Visualization.Text + '9';
  TemporaryNumber := TemporaryNumber + '9';
  //MemoryCalculator := strtofloat(Visualization.Text);
end;

procedure TCalculator.OneButtonClick(Sender: TObject);
begin
  ClearVisualization();
  Visualization.Text := Visualization.Text + '1';
  TemporaryNumber := TemporaryNumber + '1';
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

procedure TCalculator.SevenButtonClick(Sender: TObject);
begin
  ClearVisualization();
  Visualization.Text := Visualization.Text + '7';
  TemporaryNumber := TemporaryNumber + '7';
  //MemoryCalculator := strtofloat(Visualization.Text);
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

procedure TCalculator.SixButtonClick(Sender: TObject);
begin
  ClearVisualization();
  Visualization.Text := Visualization.Text + '6';
  TemporaryNumber := TemporaryNumber + '6';
  //MemoryCalculator := strtofloat(Visualization.Text);
end;

procedure TCalculator.SqrtxButtonClick(Sender: TObject);
var
  Temp: real;
begin
  OperationFlag := True;
  //ClearVisualization();
  //Visualization.Text := Visualization.Text + '√';
  //Temp := MemoryCalculator;
  //{$asmmode intel}
  //asm
  //         FINIT
  //         FLD     Temp
  //         FSQRT
  //         FSTP    Temp
  //end;
  //MemoryCalculator := Temp;
  //Visualization.Text := floattostr(MemoryCalculator);
end;

procedure TCalculator.TanButtonClick(Sender: TObject);
begin
  OperationFlag := True;
  ClearVisualization();
  Visualization.Text := Visualization.Text + 'tan(';
end;

procedure TCalculator.ThreeButtonClick(Sender: TObject);
begin
  ClearVisualization();
  Visualization.Text := Visualization.Text + '3';
  TemporaryNumber := TemporaryNumber + '3';
  //MemoryCalculator := strtofloat(Visualization.Text);
end;

procedure TCalculator.InverseCheckChange(Sender: TObject);
begin

end;

procedure TCalculator.TwoButtonClick(Sender: TObject);
begin
  ClearVisualization();
  Visualization.Text := Visualization.Text + '2';
  TemporaryNumber := TemporaryNumber + '2';
  //MemoryCalculator := strtofloat(Visualization.Text);
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

procedure TCalculator.ZeroButtonClick(Sender: TObject);
begin
  Visualization.Text := Visualization.Text + '0';
  TemporaryNumber := TemporaryNumber + '0';

end;



end.
