//Andressa Yida Pinheiro de Souza
//Willian Yoshio Murayama

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
    procedure EnviarOperacao(Operacao, Simbolo: string);
    procedure Backspace();
    procedure PilhaTemporariaPolonesa(Operador: string);
    procedure Calculo(Operacao: string);
    procedure Inverso(Angulo: string);
    procedure ParentesesEsquerdo();
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
//Variaveis globais para a calculadora
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
//Inicializacao dos indices e algumas variaveis quando a calculadora eh executada pela primeira vz
procedure Inicializacao();
begin
  IndexPilhaPolonesa := 0;
  IndexPilhaOperadores := 0;
  IndexBackspace := 0;
  PrecedenciaAtual := 0;
end;

//---Inicio da criacao de funcoes para o projeto---
//Funcoes para realizar os calculos na FPU
function ValidaOperador(Operador: string): boolean;
  //Quando essa funcao eh invocada, retorna se o operador eh valido ou nao
begin
  case Operador of
    '+': Exit(True);
    '-': Exit(True);
    '/': Exit(True);
    '*': Exit(True);
    '^': Exit(True);
    '√': Exit(True);
    'ysqrtx': Exit(True);
    'ln': Exit(True);
    'log': Exit(True);
    '!': Exit(True);
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
    '^': Exit(4);
    '√': Exit(4);
    'ysqrtx': Exit(4);
    'ln': Exit(4);
    'log': Exit(4);
    '!': Exit(4);
    'tan': Exit(5);
    'cos': Exit(5);
    'sin': Exit(5);
    '~': Exit(6);
  end;
end;

function Pi(): real;
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
  Exit(temp);
  //Retorna diretamente o numero pi para a pilha polonesa e no visor
end;

//---Fim das funcoes---
//---Inicio das procedures---
procedure TCalculator.ParentesesEsquerdo();
begin
  PilhaTemporariaOperadores[IndexPilhaOperadores] := '(';
  IndexPilhaOperadores += 1;
  visor.Text := visor.Text + '(';
end;

procedure TCalculator.Calculo(Operacao: string);
var
  FirstNumber, SecondNumber, Resultado, PiCalculo, Dez, Euler, ContadorFatorial: real;
begin
  PiCalculo := Pi();
  //Calcula o pi direto da FPU
  Dez := 10;
  //Variavel com 10 para utilizar como base em logaritmo
  Euler := 2.71828;
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
                 FDIV  ST,ST(1)
                 FSTP  Resultado
        end;
      end;
      '^': begin
      {$asmmode intel}
        asm
                 //Utilizacao das instrucoes apresentados durante a aula
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
    //Caso nao seja nenhuma das operacoes que utilizam dois operandos
    //Ele utilizara somente um operando
  begin
    FirstNumber := strtofloat(PilhaCalculoResultado[IndexPilhaCalculo - 1]);
    //Pegando o numero "anterior" ao operador para a operacao
    IndexPilhaCalculo -= 1;
    //Decremento do indice

    case Operacao of
      '√': begin
          {$asmmode intel}
        asm
                 FINIT
                 FLD   FirstNumber
                 FSQRT
                 FSTP  Resultado
        end;
      end;
      'ln': begin
          {$asmmode intel}
        asm
                 FINIT
                 FLD1
                 FLD     FirstNumber
                 FYL2X
                 FLD1
                 FLD     Euler
                 //Logaritmo de base constante de Euler
                 FYL2X
                 FDIV
                 FSTP    Resultado
        end;
      end;
      'log': begin
          {$asmmode intel}
        asm
                 //Utilizacao do algoritmo apresentado em aula
                 FINIT
                 FLD1
                 //Carrega 1 na pilha
                 FLD     FirstNumber
                 FYL2X
                 FLD1
                 FLD     Dez
                 //Logaritmo de base 10
                 FYL2X
                 FDIV
                 FSTP    Resultado
        end;
      end;
      '!': begin
        ContadorFatorial := FirstNumber;
        //A cada execucao, sera decrementado 1 do contador e esse contador sera utilizado para a multiplicacao
    {$asmmode intel}
        asm
                 FINIT
                 FLD   FirstNumber;
                 FLD   ContadorFatorial
                 //Carrega o numero e o contador
                 FLD1
                 //Carrega 1 na pilha para subtrair do contador
                 FSUB
                 //Subtrai 1 do contador
                 FST   ContadorFatorial
                 //Salva o numero do contador
                 @repeticao:
                 FTST
                 //Codigo de comparacao na FPU
                 FSTSW AX
                 //Copia do valor de CC
                 SAHF
                 //Envio do numero de AX para os flags para ser utilizado nas instrucoes condicionais
                 JE    @final  //se o topo for zero acabou o loop
                 FMUL
                 //Faz a multiplicao do numero-1 * numero
                 FLD   ContadorFatorial
                 FLD1
                 //Carrega 1 na pilha para subtrair do contador
                 FSUB
                 //Subtrai 1 do contador
                 FST   ContadorFatorial
                 //Salva o novo numero do contador
                 JMP   @repeticao
                 @final:
                 FXCH
                 //Como no topo esta o contador, sera necessario trocar de posicao dos elementos da pilha
                 FST   Resultado
        end;
      end;
      'tan': begin
        if (DegreeRadio.Checked = True) then
          FirstNumber := (FirstNumber * PiCalculo) / 180;
        //A FPU calcula somente em radianos, eh necessario a conversao de grau para radianos
    {$asmmode intel}
        asm
                 FINIT
                 FLD   FirstNumber
                 FSINCOS
                 //tangente = seno/cosseno
                 FDIV
                 FSTP  Resultado
        end;
      end;
      'cos': begin
        if (DegreeRadio.Checked = True) then
          FirstNumber := (FirstNumber * PiCalculo) / 180;
    {$asmmode intel}
        asm
                 FINIT
                 FLD   FirstNumber
                 FCOS
                 FSTP  Resultado
        end;
      end;
      'sin': begin
        if (DegreeRadio.Checked = True) then
          FirstNumber := (FirstNumber * PiCalculo) / 180;
    {$asmmode intel}
        asm
                 FINIT
                 FLD   FirstNumber
                 FSIN
                 FSTP  Resultado
        end;
      end;
      '~': begin
    {$asmmode intel}
        asm
                 FINIT
                 FLD   FirstNumber
                 FCHS
                 //Muda o sinal do numero e retorna o resultado
                 FSTP  Resultado
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
  MaxDelete: integer;
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
    //Caso o tamanho da string do numero seja maior que zero, ele apagara e atualizara o visor
    Delete(Temp, Length(Temp), 1);
    Visor.Text := Temp;
  end;
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
//Este procedimento utiliza como parametro o tipo de operacao e o simbolo que aparecera no visor
begin
  FloatingPoint := False;
  //Verifica se ha zeros no visor da calculadora
  OperationFlag := True;
  //Indica que foi enviado uma operacao e que eh possivel executar o sinal de igual
  ClearEntryFlag := True;
  //Indica que foi enviado uma operacao e que eh possivel apagar a operacao
  if TemporaryNumber <> '' then
    //Verifica se a variavel de numero temporario possui algum valor, caso tenha, esse valor eh colocado no vetor temporario
  begin
    PilhaPolonesa[IndexPilhaPolonesa] := TemporaryNumber;
    IndexPilhaPolonesa += 1;
    TemporaryNumber := '';
  end;
  PilhaTemporariaPolonesa(Operacao);
  //Invoca o procedimento para realizar a pilha polonesa a cada operacao que eh enviada
  Visor.Text := Visor.Text + Simbolo;
  PilhaTemporariaOperadores[IndexPilhaOperadores] := Operacao;
  IndexPilhaOperadores += 1;
end;

procedure TCalculator.PilhaTemporariaPolonesa(Operador: string);
//Procedimento que transfere os operadores da pilha temporaria para a polonesa
var
  PrecedenciaOperador, PrecedenciaOperadorPilha: integer;
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

procedure TCalculator.Inverso(Angulo: string);
//A operacao inversa pode ser descrita como 1/angulo = secante
begin
  TemporaryNumber := TemporaryNumber + '1';
  ClearEntryFlag := False;
  //A parte abaixo seria somente para a modificacao da visualizacao
  EnviarOperacao('/', '');
  EnviarOperacao(Angulo, Angulo + '^-1');
  ParentesesEsquerdo();
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
    //A funcao delete apaga uma parte da string, indicando o indice de inicio e a quantidade de caracteres que deve ser apagado
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
    //Realiza uma varredura pelo vetor colocando "nada" como string
  begin
    PilhaPolonesa[Index] := '';
  end;
  for Index := 0 to IndexPilhaOperadores do
  begin
    PilhaTemporariaOperadores[Index] := '';
  end;
  IndexPilhaPolonesa := 0;
  //Reseta os indices dos vetores e flags utilizados
  IndexPilhaOperadores := 0;
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
  if InverseCheck.Checked = True then
  begin
    Inverso('cos');
  end
  else
  begin
    EnviarOperacao('cos', 'cos');
    ParentesesEsquerdo();
  end;
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
    //Como ja foi organizado de maneira pos fixa, podera ser transferido do final para o comeco para a pilha polonesa
  begin
    PilhaPolonesa[IndexPilhaPolonesa] :=
      PilhaTemporariaOperadores[IndexPilhaOperadores - 1];
    IndexPilhaOperadores -= 1;
    IndexPilhaPolonesa += 1;
  end;
  IndexPilhaCalculo := 0;
  //Reseta o indice de calculo
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
end;

procedure TCalculator.ExButtonClick(Sender: TObject);
begin
  ColocaNumero('2,71828');
  //Numero de euler
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
  //  Precisa de um procedimento especial porque nao pode ser processado como os outros operadores
  ParentesesEsquerdo();
end;

procedure TCalculator.ListaOperadoresChange(Sender: TObject);
begin

end;

procedure TCalculator.LnButtonClick(Sender: TObject);
begin
  EnviarOperacao('ln', 'ln');
  ParentesesEsquerdo();
end;

procedure TCalculator.LogButtonClick(Sender: TObject);
begin
  EnviarOperacao('log', 'log');
  ParentesesEsquerdo();
end;

procedure TCalculator.ListaOperandosChange(Sender: TObject);
begin

end;

procedure TCalculator.MemoryClearButtonClick(Sender: TObject);
begin

end;

procedure TCalculator.MemoryPlusButtonClick(Sender: TObject);
begin

end;

procedure TCalculator.MemoryRestoreButtonClick(Sender: TObject);
begin

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
    //Este flag pode ativar somente uma vez, para que nao tenha mais de um ponto flutuante por numero
    //Sempre eh resetado quando um numero vai para a pilha
  begin
    Visor.Text := Visor.Text + ',';
    TemporaryNumber := TemporaryNumber + ',';
    FloatingPoint := True;
  end;
end;

procedure TCalculator.RadianRadioChange(Sender: TObject);
begin

end;

procedure TCalculator.RightParenthesisClick(Sender: TObject);
begin
  //Quando o botao de parenteses direito eh precionado, todos os operadores precisa ser transferido para a pilha polonesa
  if TemporaryNumber <> '' then
    //Checa se ha numero na variavel temporaria
  begin
    PilhaPolonesa[IndexPilhaPolonesa] := TemporaryNumber;
    IndexPilhaPolonesa += 1;
    TemporaryNumber := '';
  end;
  if Visor.Text <> '' then
    //Checa se ha algo no visor para realizar a operacoes
  begin
    while (PilhaTemporariaOperadores[IndexPilhaOperadores - 1] <> '(') do
      //Quando o botao de parenteses direito eh acionado, ele precisa transferir todas as operacoes de dentro para a pilha polonesa
      //Esse processo dura ate encontrar o parenteses esquerdo
    begin
      PilhaPolonesa[IndexPilhaPolonesa] :=
        PilhaTemporariaOperadores[IndexPilhaOperadores - 1];
      IndexPilhaPolonesa += 1;
      IndexPilhaOperadores -= 1;
    end;
    IndexPilhaOperadores -= 1;
    Visor.Text := Visor.Text + ')';
    //Nao pode utilizar a funcao de enviar operacoes porque ele acionaria flags e indices que apresentaria o mal funcionamento da calculadora
  end;
end;

procedure TCalculator.Button7Click(Sender: TObject);
begin
  ColocaNumero('7');
end;

procedure TCalculator.SignalButtonClick(Sender: TObject);
//Numero negativo
begin
  EnviarOperacao('~', '-');
end;

procedure TCalculator.SinButtonClick(Sender: TObject);
begin
  if InverseCheck.Checked = True then
    //Caso o inverso esteja marcado, ele invoca o procedimento que envia as operacoes para realizar o inverso do angulo
  begin
    Inverso('sin');
  end
  else
  begin
    EnviarOperacao('sin', 'sin');
    ParentesesEsquerdo();
  end;
end;

procedure TCalculator.Button6Click(Sender: TObject);
begin
  ColocaNumero('6');
end;

procedure TCalculator.SqrtxButtonClick(Sender: TObject);
begin
  EnviarOperacao('√', '√');
  ParentesesEsquerdo();
end;

procedure TCalculator.TanButtonClick(Sender: TObject);
begin
  if InverseCheck.Checked = True then
  begin
    Inverso('tan');
  end
  else
  begin
    EnviarOperacao('tan', 'tan');
    ParentesesEsquerdo();
  end;
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
  //Em numeros elevados ao quadrado, eh enviado a operacao de potencia mais o 2
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
  //Envio de operacoes para realizar a raiz enesima utilizando a propriedade
  EnviarOperacao('/', '');
  PilhaPolonesa[IndexPilhaPolonesa] := '1';
  IndexPilhaPolonesa += 1;
  EnviarOperacao('^', '√');
end;

procedure TCalculator.Button0Click(Sender: TObject);
begin
  if Visor.Text <> '0' then
  begin
    ColocaNumero('0');
  end;
end;

end.
