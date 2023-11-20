unit COBOLRunner;

interface

uses
  SysUtils, Classes, StdCtrls, ShellAPI, SynEdit, Windows;

type
  TCOBOLRunner = class(TCustomMemo)
  private
    procedure ExecuteCOBOLCode(const Code: string);
  public
    constructor Create(AOwner: TComponent); override;
    procedure RunCOBOLCode;
  end;

implementation

{ TCOBOLRunner }

constructor TCOBOLRunner.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
end;

procedure TCOBOLRunner.ExecuteCOBOLCode(const Code: string);
var
  CompilerPath: string;
  CommandLine: string;
begin
  CompilerPath := 'gnucobol\bin\'; // Укажите путь к компилятору GnuCOBOL
  CommandLine := '"' + CompilerPath + '" -x -';
  // Чтение кода из стандартного ввода

  Lines.SaveToFile('temp.cob'); // Сохраняем код во временный файл

  // Запускаем внешний процесс для выполнения кода
  ShellExecute(0, 'open', 'cmd.exe', PChar('/c ' + CommandLine + ' < temp.cob'),
    nil, SW_HIDE);

  // Удаляем временный файл
  DeleteFile('temp.cob');
end;

procedure TCOBOLRunner.RunCOBOLCode;
begin
  ExecuteCOBOLCode(Lines.Text);
end;

end.
