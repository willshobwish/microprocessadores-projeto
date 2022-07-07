unit CalculadoraPascal;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls;

type

  { TCalculator }

  TCalculator = class(TForm)
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
    procedure ClearVisualization();
    procedure ClearOperationFlag();
    procedure BackspaceButtonClick(Sender: TObject);
    procedure ClearEntryButtonClick(Sender: TObject);
    procedure ClearButtonClick(Sender: TObject);
    procedure CosButtonClick(Sender: TObject);
    procedure DegreeRadioChange(Sender: TObject);
    procedure DivisionButtonClick(Sender: TObject);
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

  public
  var
    MemoryCalculator, MemoryStore: real;
    FloatingPoint, Sum, Subtraction, Division, Multiplication: boolean;
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
begin
  Visualization.Text := FloatToStr(0);
  MemoryCalculator := 0;
  FloatingPoint := False;
end;

procedure TCalculator.CosButtonClick(Sender: TObject);
begin
  ClearVisualization();
  Visualization.Text := Visualization.Text + 'cos(';
end;

procedure TCalculator.DegreeRadioChange(Sender: TObject);
begin

end;

procedure TCalculator.DivisionButtonClick(Sender: TObject);
begin

end;

procedure TCalculator.EightButtonClick(Sender: TObject);
begin
  ClearVisualization();
  Visualization.Text := Visualization.Text + '8';
  //MemoryCalculator := strtofloat(Visualization.Text);
end;

procedure TCalculator.EqualButtonClick(Sender: TObject);
begin

end;

procedure TCalculator.ExButtonClick(Sender: TObject);
begin
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
  //MemoryCalculator := StrToFloat(Visualization.Text);
end;

procedure TCalculator.FormCreate(Sender: TObject);
begin

end;

procedure TCalculator.FourButtonClick(Sender: TObject);
begin
  ClearVisualization();
  Visualization.Text := Visualization.Text + '4';
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

end;

procedure TCalculator.MultiplicationButtonClick(Sender: TObject);
begin

end;

procedure TCalculator.NineButtonClick(Sender: TObject);
begin
  ClearVisualization();
  Visualization.Text := Visualization.Text + '9';
  //MemoryCalculator := strtofloat(Visualization.Text);
end;

procedure TCalculator.OneButtonClick(Sender: TObject);
begin
  ClearVisualization();
  Visualization.Text := Visualization.Text + '1';
  //MemoryCalculator := StrToFloat(Visualization.Text);
end;

procedure TCalculator.OneXButtonClick(Sender: TObject);
begin
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
  //MemoryCalculator := strtofloat(Visualization.Text);
end;

procedure TCalculator.SignalButtonClick(Sender: TObject);
begin

end;

procedure TCalculator.SinButtonClick(Sender: TObject);
begin
  ClearVisualization();
  Visualization.Text := Visualization.Text + 'sin(';
  //MemoryCalculator := strtofloat(Visualization.Text);
end;

procedure TCalculator.SixButtonClick(Sender: TObject);
begin
  ClearVisualization();
  Visualization.Text := Visualization.Text + '6';
  //MemoryCalculator := strtofloat(Visualization.Text);
end;

procedure TCalculator.SqrtxButtonClick(Sender: TObject);
var
  Temp: real;
begin
  ClearVisualization();
  Visualization.Text := Visualization.Text + '√';
  Temp := MemoryCalculator;
  {$asmmode intel}
  asm
           FINIT
           FLD     Temp
           FSQRT
           FSTP    Temp
  end;
  MemoryCalculator := Temp;
  //Visualization.Text := floattostr(MemoryCalculator);
end;

procedure TCalculator.TanButtonClick(Sender: TObject);
begin
  ClearVisualization();
  Visualization.Text := Visualization.Text + 'tan(';
end;

procedure TCalculator.ThreeButtonClick(Sender: TObject);
begin
  ClearVisualization();
  Visualization.Text := Visualization.Text + '3';
  //MemoryCalculator := strtofloat(Visualization.Text);
end;

procedure TCalculator.InverseCheckChange(Sender: TObject);
begin

end;

procedure TCalculator.TwoButtonClick(Sender: TObject);
begin
  ClearVisualization();
  Visualization.Text := Visualization.Text + '2';
  //MemoryCalculator := strtofloat(Visualization.Text);
end;

procedure TCalculator.VisualizationChange(Sender: TObject);
begin

end;


procedure TCalculator.X2ButtonClick(Sender: TObject);
begin
  ClearVisualization();
  Visualization.Text := Visualization.Text + '²';
end;

procedure TCalculator.XyButtonClick(Sender: TObject);
begin
  ClearVisualization();
  Visualization.Text := Visualization.Text + '^';
end;

procedure TCalculator.YsqrtxButtonClick(Sender: TObject);
begin

end;

procedure TCalculator.ZeroButtonClick(Sender: TObject);
begin
  Visualization.Text := Visualization.Text + '0';
  MemoryCalculator := strtofloat(Visualization.Text);
end;



end.
