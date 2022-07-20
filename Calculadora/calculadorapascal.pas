unit CalculadoraPascal;

{$mode objfpc}{$H+}

interface

uses
  Classes, Controls, Dialogs, Forms, Graphics, StdCtrls, SysUtils;

type

  { TCalculator }

  TCalculator = class(TForm)
    ListaOperandos: TMemo;
    ListaOperadores: TMemo;
    ListaCalculo: TMemo;
    RightParenthesis: TButton;
    LeftParenthesis: TButton;
    ClearButton: TButton;
    EqualButton: TButton;
    BackspaceButton: TButton;
    Button8: TButton;
    Button5: TButton;
    Button2: TButton;
    PontoButton: TButton;
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
    SqrButton: TButton;
    XyButton: TButton;
    ExButton: TButton;
    SinButton: TButton;
    MultiplicationButton: TButton;
    OneXButton: TButton;
    FactorialButton: TButton;
    LogButton: TButton;
    LnButton: TButton;
    PiButton: TButton;
    MinusButton: TButton;
    PlusButton: TButton;
    Button9: TButton;
    Button6: TButton;
    Button3: TButton;
    InverseCheck: TCheckBox;
    DegreeRadio: TRadioButton;
    RadianRadio: TRadioButton;
    Visor: TEdit;
    //---Procedimentos criados para o projeto---
    procedure ColocaNumero(Numero: string);
    procedure LimparZero();
    procedure ClearOperationFlag();
    procedure Debug();
    procedure EnviarOperacao(Operacao, Simbolo: string);
    procedure Backspace();
    procedure PilhaTemporariaParaL1(Operador: string);
    procedure Calculo(Operacao: string);
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
    procedure PontoButtonClick(Sender: TObject);
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
    procedure VisorChange(Sender: TObject);
    procedure SqrButtonClick(Sender: TObject);
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
  IndexPilhaPolonesa, IndexPilhaOperadores, IndexPilhaCalculo,
  IndexBackspace, PrecedenciaAtual: integer;
  //ListaOperandos de todas as operacoes que o usuario digitar
  PilhaPolonesa: array[0..100] of string;//ListaOperandos 1
  PilhaTemporariaOperadores: array[0..100] of string;//Expressao polonesa
  PilhaCalculoResultado: array[0..100] of string;

implementation

{$R *.lfm}

{ TCalculator }
procedure Inicializacao();
begin
  IndexPilhaPolonesa := 0;
  IndexPilhaOperadores := 0;
  IndexBackspace := 0;
  PrecedenciaAtual := 0;
end;

//---Inicio de criacao de funcoes para o projeto---
//Funcoes para realizar os calculos na FPU


function ValidaOperador(Operador: string): boolean;
begin
  case Operador of
    '+': Exit(True);
    '-': Exit(True);
    '/': Exit(True);
    '*': Exit(True);
    '²': Exit(True);
    '^': Exit(True);
    '√': Exit(True);
    'ysqrtx': Exit(True);
    'ln': Exit(True);
    'log': Exit(True);
    '!': Exit(True);
    'e^': Exit(True);
    'tan': Exit(True);
    'cos': Exit(True);
    'sin': Exit(True);
    '~': Exit(True);
  end;
  Exit(False);
end;

function OrdemPrecedencia(Operador: string): integer;
  //Funcao retorna a ordem de procedencia de cada operacao
begin
  case Operador of
    '+': Exit(2);
    '-': Exit(2);
    '/': Exit(3);
    '*': Exit(3);
    '²': Exit(4);
    '^': Exit(4);
    '√': Exit(4);
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
//Procedimento para visualizacao da lista
var
  Index: integer;
begin
  for Index := 0 to IndexPilhaOperadores do
  begin
    ListaOperadores.Text := ListaOperadores.Text + '[' + IntToStr(Index) +
      ']' + PilhaTemporariaOperadores[Index] + sLineBreak;
  end;
  for Index := 0 to IndexPilhaPolonesa do
  begin
    ListaOperandos.Text :=
      ListaOperandos.Text + '[' + IntToStr(Index) + ']' +
      PilhaPolonesa[Index] + sLineBreak;
  end;
  ListaOperadores.Lines.Add('------');
  ListaOperandos.Lines.Add('------');
end;

procedure TCalculator.Calculo(Operacao: string);
var
  FirstNumber, SecondNumber, Resultado: real;
begin
  if ((Operacao = '+') or (Operacao = '-') or (Operacao = '*') or
    (Operacao = '/') or (Operacao = '^')) then
    //Checa se a operacao necessita de dois operandos
  begin
    FirstNumber := strtofloat(PilhaCalculoResultado[IndexPilhaCalculo - 1]);
    //Pega o primeiro numero de baixo para cima
    IndexPilhaCalculo -= 1;
    //Remove um do indice para apontar para o "proximo"
    SecondNumber := strtofloat(PilhaCalculoResultado[IndexPilhaCalculo - 1]);
    //Pega o segundo numero de baixo para cima
    IndexPilhaCalculo -= 1;
    //Remove um do indice para apontar para o "proximo"
    case Operacao of
      //Utilizacao da estrutura de switch case para saber qual eh a operacao que deve ser realizado consultando a pilha polonesa
      '+': begin
     {$asmmode intel}
        asm
                 FINIT
                 FLD   FirstNumber
                 FLD   SecondNumber
                 FADD  ST,ST(1)
                 //Utilizacao de operandos durante as operacoes na fpu por recomendacao do proprio Lazarus
                 FSTP  Resultado
        end;
      end;
      '-': begin
     {$asmmode intel}
        asm
                 FINIT
                 FLD   FirstNumber
                 FLD   SecondNumber
                 FSUBR ST,ST(1)
                 FSTP  Resultado
        end;
      end;
      '*': begin
      {$asmmode intel}
        asm
                 FINIT
                 FLD   FirstNumber
                 FLD   SecondNumber
                 FMUL  ST,ST(1)
                 FSTP  Resultado
        end;
      end;
      '/': begin
      {$asmmode intel}
        asm
                 FINIT
                 FLD   FirstNumber
                 FLD   SecondNumber
                 FDIVR ST,ST(1)
                 FSTP  Resultado
        end;
      end;
      '^': begin
      {$asmmode intel}
        asm
                 FINIT
                 FLD     FirstNumber
                 FLD     SecondNumber
                 FYL2X
                 FLD     ST
                 FRNDINT
                 FSUB    ST(1),ST
                 FXCH
                 F2XM1
                 FLD1
                 FADD
                 FSCALE
                 FSTP    Resultado
        end;
      end;
    end;
  end
  else
    //Caso nao seja nenhum desses operadores acima, ele utilizara somente um operando
  begin
    case Operacao of
      'ln': begin
          {$asmmode intel}
        asm

        end;
      end;
      'log': begin
          {$asmmode intel}
        asm

        end;
      end;
      '!': begin
    {$asmmode intel}
        asm

        end;
      end;
      'e^': begin
    {$asmmode intel}
        asm

        end;
      end;
      'tan': begin
    {$asmmode intel}
        asm

        end;
      end;
      'cos': begin
    {$asmmode intel}
        asm

        end;
      end;
      'sin': begin
    {$asmmode intel}
        asm

        end;
      end;
      '~': begin
    {$asmmode intel}
        asm

        end;
      end;
    end;
  end;
  PilhaCalculoResultado[IndexPilhaCalculo] := floattostr(Resultado);
  //Envio dos resultados para uma terceira pilha que facilitara os calculos futuros
  IndexPilhaCalculo += 1;
end;

procedure TCalculator.Backspace();
//Procedimento que apaga o que foi escrito, apaga somente o ultimo numero que foi inserido
var
  Temp: string;
  MaxDelete, Index: integer;
begin
  MaxDelete := Length(TemporaryNumber);
  //  Determina o quanto que pode ser apagado
  Temp := Visor.Text;
  //  A variavel temporaria recebe o que esta escrito no visor
  Delete(TemporaryNumber, Length(TemporaryNumber), 1);
  //  Funcao que apaga uma parte do string
  if MaxDelete > 0 then
    //  Delimita o quanto que pode ser apagado do visor da calculadora
  begin
    //    Caso o tamanho da string do numero seja maior que zero, ele apagara e atualizara o visor
    Delete(Temp, Length(TemporaryNumber), 1);
    Visor.Text := Temp;
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
  if Visor.Text = '0' then
  begin
    Visor.Text := '';
  end;
end;

procedure TCalculator.EnviarOperacao(Operacao, Simbolo: string);
begin
  FloatingPoint := False;
  //  Verifica se ha zeros no visor da calculadora
  OperationFlag := True;
  //  Indica que foi enviado uma operacao e que eh possivel executar o sinal de igual
  ClearEntryFlag := True;
  //  Indica que foi enviado uma operacao e que eh possivel apagar a operacao
  if TemporaryNumber <> '' then
    //Verifica se a variavel de numero temporario possui algum valor, caso tenha, esse valor eh colocado no vetor temporario
  begin
    PilhaPolonesa[IndexPilhaPolonesa] := TemporaryNumber;
    IndexPilhaPolonesa += 1;
    TemporaryNumber := '';
  end;
  PilhaTemporariaParaL1(Operacao);
  Visor.Text := Visor.Text + Simbolo;
  PilhaTemporariaOperadores[IndexPilhaOperadores] := Operacao;
  IndexPilhaOperadores += 1;
  Debug();
end;

procedure TCalculator.PilhaTemporariaParaL1(Operador: string);
var
  Index, PrecedenciaOperador, PrecedenciaOperadorPilha: integer;
begin
  if (IndexPilhaOperadores > 0) and (IndexPilhaPolonesa > 0) then
    //Inicializa esse procedimento somente se ha operadores e numeros na lista
  begin
    while ((ValidaOperador(PilhaTemporariaOperadores[IndexPilhaOperadores - 1])) and
        (IndexPilhaOperadores > 0) and
        (PilhaTemporariaOperadores[IndexPilhaOperadores - 1] <> '(')) do
    begin
      PrecedenciaOperador := OrdemPrecedencia(Operador);
      PrecedenciaOperadorPilha :=
        OrdemPrecedencia(PilhaTemporariaOperadores[IndexPilhaOperadores - 1]);
      if PrecedenciaOperadorPilha >= PrecedenciaOperador then
        //Verifica a ordem de precedencia do operador da pilha e do ultimo da pilha temporaria
      begin
        //Caso seja verdadeiro, ele coloca o ultimo operador na pilha temporaria
        PilhaPolonesa[IndexPilhaPolonesa] :=
          PilhaTemporariaOperadores[IndexPilhaOperadores - 1];
        IndexPilhaOperadores -= 1;
        //Reducao no indice do vetor de lista de operadores temporario para demonstrar o que foi processado
        IndexPilhaPolonesa += 1;
        //Incremento do indice do vetor da pilha polonesa
      end
      else
      begin
        break;
        //Imterrompendo o loop, caso contrario ele nao saira dessa condicional
      end;
    end;
  end;
end;


//---Fim das procedures---
procedure TCalculator.ClearEntryButtonClick(Sender: TObject);
// Botao para limpar a entrada de operacao
var
  Temp: string;
begin
  //  Checa se foi inserido uma operacao para ser apagado
  if ClearEntryFlag = True then
  begin
    Temp := Visor.Text;
    Delete(Temp, Length(Temp), 1);
    Visor.Text := Temp;
    PilhaTemporariaOperadores[IndexPilhaOperadores - 1] := '';
    ClearEntryFlag := False;
  end;
end;

procedure TCalculator.BackspaceButtonClick(Sender: TObject);
// Botao para apagar um digito ou operacao, ele verifica qual numero ou operacao que esta no array e apaga
begin
  Backspace();
end;

procedure TCalculator.ClearButtonClick(Sender: TObject);
var
  Index: integer;
begin
  OperationFlag := False;
  for Index := 0 to IndexPilhaPolonesa do
  begin
    PilhaPolonesa[Index] := '';
  end;
  for Index := 0 to IndexPilhaOperadores do
  begin
    PilhaTemporariaOperadores[Index] := '';
  end;
  IndexPilhaPolonesa := 0;
  IndexPilhaOperadores := 0;
  //[Debug]
  ListaOperandos.Lines.Add('---Fim da operação---');
  ListaOperadores.Lines.Add('---Fim da operação---');
  //[Debug]
  Visor.Text := '';
  MemoryCalculator := 0;
  FloatingPoint := False;
  PrecedenciaAtual := 0;
end;

//Enviar o numero para a visualizacao e variavel temporaria que armazena o numero
procedure TCalculator.ColocaNumero(Numero: string);
begin
  LimparZero();
  Visor.Text := Visor.Text + Numero;
  TemporaryNumber := TemporaryNumber + Numero;
  ClearEntryFlag := False;
end;

procedure TCalculator.CosButtonClick(Sender: TObject);
begin
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
  ColocaNumero('8');
end;


procedure TCalculator.EqualButtonClick(Sender: TObject);
var
  Index: integer;
begin
  Index := 0;
  if TemporaryNumber <> '' then
    //Verifica se ha numero no "visor" para ser enviado para a pilha polonesa antes de realizar as operacoes
  begin
    PilhaPolonesa[IndexPilhaPolonesa] := TemporaryNumber;
    IndexPilhaPolonesa += 1;
    TemporaryNumber := '';
  end;
  while (IndexPilhaOperadores > 0) do
    //Pega todos os operadores e transfere para a pilha polonesa
    //Como ja foi organizado de maneira pos fixa, pode ir transferindo do final para o comeco para a pilha polonesa
  begin
    PilhaPolonesa[IndexPilhaPolonesa] :=
      PilhaTemporariaOperadores[IndexPilhaOperadores - 1];
    IndexPilhaOperadores -= 1;
    IndexPilhaPolonesa += 1;
  end;
  IndexPilhaCalculo := 0;
  while Index < IndexPilhaPolonesa do
  begin
    if ValidaOperador(PilhaPolonesa[Index]) then
      //Caso a funcao retorne true, ele processa a operacao e o resultado ira para a pilha de calculos
    begin
      Calculo(PilhaPolonesa[Index]);
    end
    else
      //Caso a funcao retorne false, sera um numero que devera ser colocado na pilha de calculos
    begin
      PilhaCalculoResultado[IndexPilhaCalculo] := PilhaPolonesa[Index];
      IndexPilhaCalculo += 1;
    end;
    index += 1;
  end;
  Visor.Text := PilhaCalculoResultado[IndexPilhaCalculo - 1];
  Debug();
end;

procedure TCalculator.ExButtonClick(Sender: TObject);
begin
  ColocaNumero('2,71828');
  EnviarOperacao('^', '^');
end;

procedure TCalculator.FactorialButtonClick(Sender: TObject);
begin
  EnviarOperacao('!', '!');
end;

procedure TCalculator.Button5Click(Sender: TObject);
begin
  ColocaNumero('5');
end;

procedure TCalculator.FormCreate(Sender: TObject);
begin

end;

procedure TCalculator.Button4Click(Sender: TObject);
begin
  ColocaNumero('4');
end;

procedure TCalculator.IndexDisplayChange(Sender: TObject);
begin

end;

procedure TCalculator.LeftParenthesisClick(Sender: TObject);
begin
  //EnviarOperacao('(', '(');
  PilhaTemporariaOperadores[IndexPilhaOperadores] := '(';
  IndexPilhaOperadores += 1;
  visor.Text := visor.Text + '(';
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
  Visor.Text := floattostr(MemoryCalculator);
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
  ColocaNumero('9');
end;

procedure TCalculator.Button1Click(Sender: TObject);
begin
  ColocaNumero('1');
end;

procedure TCalculator.OneXButtonClick(Sender: TObject);
begin
  ColocaNumero('1');
  EnviarOperacao('/', '/');
end;

procedure TCalculator.PiButtonClick(Sender: TObject);
//O numero pi eh calculado direto na FPU para maior precisao
var
  temp: real;
begin
  {$asmmode intel}
  asm
           FINIT
           FLDPI
           FSTP    temp
  end;
  ColocaNumero(floattostr(temp));
  //Retorna diretamente o numero pi para a pilha polonesa e no visor
end;

procedure TCalculator.PlusButtonClick(Sender: TObject);
begin
  EnviarOperacao('+', '+');
end;

procedure TCalculator.PontoButtonClick(Sender: TObject);
begin
  if (FloatingPoint = False) then
  begin
    Visor.Text := Visor.Text + '.';
    TemporaryNumber := TemporaryNumber + '.';
    FloatingPoint := True;
  end;

end;

procedure TCalculator.RadianRadioChange(Sender: TObject);
begin

end;

procedure TCalculator.RightParenthesisClick(Sender: TObject);
begin
  if TemporaryNumber <> '' then
    //Quando o botao de parenteses direito eh acionado, ele precisa transferir todas as operacoes de dentro para a pilha polonesa
    //Esse processo dura ate encontrar o parenteses esquerdo
  begin
    PilhaPolonesa[IndexPilhaPolonesa] := TemporaryNumber;
    IndexPilhaPolonesa += 1;
    TemporaryNumber := '';
  end;
  if Visor.Text <> '' then
  begin
    while (PilhaTemporariaOperadores[IndexPilhaOperadores - 1] <> '(') do
    begin
      PilhaPolonesa[IndexPilhaPolonesa] :=
        PilhaTemporariaOperadores[IndexPilhaOperadores - 1];
      IndexPilhaPolonesa += 1;
      IndexPilhaOperadores -= 1;
    end;
    IndexPilhaOperadores -= 1;
    Visor.Text := Visor.Text + ')';
    //Nao pode utilizar a funcao de enviar operacoes porque ele acionaria flags e indices que quebraria a calculadora
  end;
  debug();
end;

procedure TCalculator.Button7Click(Sender: TObject);
begin
  ColocaNumero('7');
end;

procedure TCalculator.SignalButtonClick(Sender: TObject);
begin
  EnviarOperacao('~', '-');
end;

procedure TCalculator.SinButtonClick(Sender: TObject);
begin
  EnviarOperacao('sin', 'sin');
  EnviarOperacao('(', '(');
end;

procedure TCalculator.Button6Click(Sender: TObject);
begin
  ColocaNumero('6');
end;

procedure TCalculator.SqrtxButtonClick(Sender: TObject);
begin
  EnviarOperacao('√', '√');
  EnviarOperacao('(', '(');
end;

procedure TCalculator.TanButtonClick(Sender: TObject);
begin
  EnviarOperacao('tan', 'tan');
  EnviarOperacao('(', '(');
end;

procedure TCalculator.Button3Click(Sender: TObject);
begin
  ColocaNumero('3');
end;

procedure TCalculator.InverseCheckChange(Sender: TObject);
begin

end;

procedure TCalculator.Button2Click(Sender: TObject);
begin
  ColocaNumero('2');
end;

procedure TCalculator.VisorChange(Sender: TObject);
begin

end;


procedure TCalculator.SqrButtonClick(Sender: TObject);
begin
  EnviarOperacao('^', '^');
  ColocaNumero('2');
end;

procedure TCalculator.XyButtonClick(Sender: TObject);
begin
  EnviarOperacao('^', '^');
end;

procedure TCalculator.YsqrtxButtonClick(Sender: TObject);
//Pode-se utilizar a propriedade da potencia fracionaria
//a^1/2 = sqrt(a)
//a^1/n = nrt(a)
begin
  EnviarOperacao('^', '√');
  PilhaPolonesa[IndexPilhaPolonesa] := '1';
  IndexPilhaPolonesa += 1;
  EnviarOperacao('/', '');
end;

procedure TCalculator.Button0Click(Sender: TObject);
begin
  if Visor.Text <> '0' then
  begin
    ColocaNumero('0');
  end;

end;


end.
