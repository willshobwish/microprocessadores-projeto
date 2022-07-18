unit CalculadoraPascal;

{$mode objfpc}{$H+}

interface

uses
  Classes, Controls, Dialogs, Forms, Graphics, StdCtrls, SysUtils;

type

  { TCalculator }

  TCalculator = class(TForm)
    DebugVisualization: TEdit;
    IndexDisplay: TEdit;
    FirstNumberVisualization: TEdit;
    ListaOperandos: TMemo;
    ListaOperadores: TMemo;
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
    //---Procedimentos criados para o projeto---
    procedure EnviarNumeroLista(Numero: string);
    procedure LimparZero();
    procedure ClearOperationFlag();
    procedure Debug();
    procedure EnviarOperacao(Operacao, Simbolo: string);
    //---Fim da criacao dos procedimentos---
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
    procedure IndexDisplayChange(Sender: TObject);
    procedure LeftParenthesisClick(Sender: TObject);
    procedure ListaOperadoresChange(Sender: TObject);
    procedure LnButtonClick(Sender: TObject);
    procedure LogButtonClick(Sender: TObject);
    procedure ListaOperandosChange(Sender: TObject);
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
  public
  end;

var
  Calculator: TCalculator;
  //Declaracao de variavel para a operacao de restauracao de memoria
  MemoryCalculator, MemoryStore: real;
  TemporaryNumber: string;
  OperationFlag, BlockOperation, FloatingPoint, Sum, Subtraction,
  Division, Multiplication, ClearEntryFlag: boolean;
  IndexListaL1, IndexTemporariaPolonesa: integer;
  //ListaOperandos de todas as operacoes que o usuario digitar
  PilhaL1: array[0..100] of string;//ListaOperandos 1
  PilhaTemporariaPolonesa: array[0..100] of string;//Expressao polonesa
  PilhaCalculo: array[0..100] of string;

implementation

{$R *.lfm}

{ TCalculator }
procedure Inicializacao();
begin
  IndexListaL1 := 0;
  IndexTemporariaPolonesa := 0;

end;

//---Inicio de criacao de funcoes para o projeto---
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

function MinusFunction(FirstNumber, SecondNumber: real): real;
var
  Final: real;
begin
    {$asmmode intel}
  asm
           FINIT
           FLD     SecondNumber
           FLD     FirstNumber
           FSUB    ST,ST(1)
           FSTP    Final
  end;
  MinusFunction := Final;
end;

function MulFunction(FirstNumber, SecondNumber: real): real;
var
  Final: real;
begin
    {$asmmode intel}
  asm
           FINIT
           FLD     FirstNumber
           FLD     SecondNumber
           FMUL    ST,ST(1)
           FSTP    Final
  end;
  MulFunction := Final;
end;

function DivFunction(FirstNumber, SecondNumber: real): real;
var
  Final: real;
begin
    {$asmmode intel}
  asm
           FINIT
           FLD     SecondNumber
           FLD     FirstNumber
           FDIV    ST,ST(1)
           FSTP    Final
  end;
  DivFunction := Final;
end;

function ValidaOperador(Operador: string): boolean;
begin
  case Operador of
    '+': Exit(True);
    '-': Exit(True);
    '/': Exit(True);
    '*': Exit(True);
    'sqr': Exit(True);
    'pow': Exit(True);
    'ysqrtx': Exit(True);
    'tan': Exit(True);
    'cos': Exit(True);
    'sin': Exit(True);
    'ln': Exit(True);
    'log': Exit(True);
    '!': Exit(True);
    'e^': Exit(True);
  end;
  Exit(False);
end;

function OrdemProcedencia(Operador: string): integer;
  //Funcao retorna a ordem de procedencia de cada operacao
begin
  case Operador of
    '+': Exit(2);
    '-': Exit(2);
    '/': Exit(3);
    '*': Exit(3);
    'sqr': Exit(4);
    'pow': Exit(4);
    'ysqrtx': Exit(4);
    'ln': Exit(4);
    'log': Exit(4);
    '!': Exit(4);
    'e^': Exit(4);
    'tan': Exit(5);
    'cos': Exit(5);
    'sin': Exit(5);
    '~': Exit(6);
  end;
  Exit(0);
end;
//---Fim das funcoes---
//---Inicio das procedures---
procedure TCalculator.Debug();
var
  Index: integer;
begin
  for Index := 0 to IndexTemporariaPolonesa do
  begin
    ListaOperadores.Text := ListaOperadores.Text + '[' + IntToStr(Index) +
      ']' + PilhaTemporariaPolonesa[Index] + sLineBreak;
  end;
  for Index := 0 to IndexListaL1 do
  begin
    ListaOperandos.Text :=
      ListaOperandos.Text + '[' + IntToStr(Index) + ']' + PilhaL1[Index] + sLineBreak;
  end;
end;

procedure TCalculator.ClearOperationFlag();
begin
  Sum := False;
  Subtraction := False;
  Division := False;
  Multiplication := False;
end;

procedure TCalculator.LimparZero();
// Metodo para checar se ha zero no visor e substituir com a primeira operacao ou numero que o usuario digitar
begin
  if Visualization.Text = '0' then
  begin
    Visualization.Text := '';
  end;
end;

procedure TCalculator.EnviarOperacao(Operacao, Simbolo: string);
begin
  OperationFlag := True;
  ClearEntryFlag := True;
  //PilhaTemporariaPolonesa[IndexTemporariaPolonesa] := TemporaryNumber;     //Pega o numero da visualizacao e coloca no final da ListaOperandos polonesa
  //IndexTemporariaPolonesa -= 1;                                  //Diminui o indice da ListaOperandos polonesa
  //TemporaryNumber := '';                               //Substitui o valor da variavel temporaria
  //Visualization.Text := Visualization.Text + Operacao;
  //IndexListaL1 -= 1;
  if TemporaryNumber <> '' then
    //Verifica se a variavel de numero temporario possui algum valor, caso tenha, esse valor eh colocado no vetor temporario
  begin
    PilhaL1[IndexListaL1] := TemporaryNumber;
    TemporaryNumber := '';
    IndexListaL1 += 1;
  end;
  Visualization.Text := Visualization.Text + Simbolo;
  PilhaTemporariaPolonesa[IndexTemporariaPolonesa] := Operacao;
  IndexTemporariaPolonesa += 1;
end;

//---Fim das procedures---
procedure TCalculator.ClearEntryButtonClick(Sender: TObject);
// Botao para limpar a entrada de operacao
var
  Index: integer;
begin
  if ClearEntryFlag = True then
  begin
    ClearEntryFlag := False;
    Visualization.Text := '';
    PilhaL1[IndexListaL1] := '';
    for Index := 0 to IndexListaL1 - 1 do
    begin
      Visualization.Text := Visualization.Text + PilhaL1[Index];
    end;
    IndexListaL1 -= 1;
  end;
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
  for Index := 0 to IndexListaL1 do
  begin
    PilhaL1[Index] := '';
  end;
  for Index := 0 to IndexTemporariaPolonesa do
  begin
    PilhaTemporariaPolonesa[Index] := '';
  end;
  IndexListaL1 := 0;
  IndexTemporariaPolonesa := 0;
  //[Debug]
  ListaOperandos.Lines.Add('---Fim da operação---');
  ListaOperadores.Lines.Add('---Fim da operação---');
  //[Debug]
  Visualization.Text := '0';
  MemoryCalculator := 0;
  FloatingPoint := False;
end;

//Enviar o numero para a visualizacao e variavel temporaria que armazena o numero
procedure TCalculator.EnviarNumeroLista(Numero: string);
begin
  LimparZero();
  Visualization.Text := Visualization.Text + Numero;
  TemporaryNumber := TemporaryNumber + Numero;
end;

procedure TCalculator.CosButtonClick(Sender: TObject);
begin
  OperationFlag := True;
  LimparZero();
  EnviarOperacao('cos', 'cos');
  EnviarOperacao('(', '(');
end;

procedure TCalculator.DegreeRadioChange(Sender: TObject);
begin

end;

procedure TCalculator.DivisionButtonClick(Sender: TObject);
begin
  EnviarOperacao('/', '/');
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


procedure TCalculator.EqualButtonClick(Sender: TObject);
var
  Index: integer;
  TempString, teste: string;
  TempNumberFirst, TempNumberSecond, Result: real;
begin
  //A calculadora funcionara somente se alguma operacao for acionada
  if OperationFlag = True then
  begin
    //Para contabilizar o ultimo numero que for inserido
    PilhaL1[IndexListaL1] := TemporaryNumber;
    IndexListaL1 += 1;
    TemporaryNumber := '';
    //Inicio da varredura do array de operacoes

    Debug();
  end;
end;

procedure TCalculator.ExButtonClick(Sender: TObject);
begin
  EnviarOperacao('e^', 'e^');
end;

procedure TCalculator.FactorialButtonClick(Sender: TObject);
begin
  EnviarOperacao('!', '!');
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

procedure TCalculator.IndexDisplayChange(Sender: TObject);
begin

end;

procedure TCalculator.LeftParenthesisClick(Sender: TObject);
begin
  LimparZero();
  Visualization.Text := Visualization.Text + '(';
end;

procedure TCalculator.ListaOperadoresChange(Sender: TObject);
begin

end;

procedure TCalculator.LnButtonClick(Sender: TObject);
begin
  EnviarOperacao('ln', 'ln');
  EnviarOperacao('(', '(');
end;

procedure TCalculator.LogButtonClick(Sender: TObject);
begin
  EnviarOperacao('log', 'log');
  EnviarOperacao('(', '(');
end;

procedure TCalculator.ListaOperandosChange(Sender: TObject);
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
  EnviarOperacao('-', '-');
end;

procedure TCalculator.MultiplicationButtonClick(Sender: TObject);
begin

  EnviarOperacao('*', '*');
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
  EnviarOperacao('1/x', '1/');
end;

procedure TCalculator.PiButtonClick(Sender: TObject);
var
  temp: real;
begin
  {$asmmode intel}
  asm
           FINIT
           FLDPI
           FSTP    temp
  end;
  EnviarNumeroLista(floattostr(temp));
end;

procedure TCalculator.PlusButtonClick(Sender: TObject);
begin
  EnviarOperacao('+', '+');
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
  LimparZero();
  EnviarOperacao(')', ')');
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
  EnviarOperacao('sin', 'sin');
  EnviarOperacao('(', '(');
end;

procedure TCalculator.Button6Click(Sender: TObject);
begin
  EnviarNumeroLista('6');
end;

procedure TCalculator.SqrtxButtonClick(Sender: TObject);
begin
  EnviarOperacao('sqrt', '√');
  EnviarOperacao('(', '(');
end;

procedure TCalculator.TanButtonClick(Sender: TObject);
begin
  EnviarOperacao('tan', 'tan');
  EnviarOperacao('(', '(');
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
var
  Index: integer;
begin

end;


procedure TCalculator.X2ButtonClick(Sender: TObject);
begin
  EnviarOperacao('sqr', '²');
end;

procedure TCalculator.XyButtonClick(Sender: TObject);
begin
  EnviarOperacao('pow', '^');
end;

procedure TCalculator.YsqrtxButtonClick(Sender: TObject);
begin
  EnviarOperacao('ysqrtx', '√');
end;

procedure TCalculator.Button0Click(Sender: TObject);
begin
  if Visualization.Text <> '0' then
  begin
    EnviarNumeroLista('0');
  end;

end;


end.
