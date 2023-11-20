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
  CompilerPath := 'gnucobol\bin\'; // ������� ���� � ����������� GnuCOBOL
  CommandLine := '"' + CompilerPath + '" -x -';
  // ������ ���� �� ������������ �����

  Lines.SaveToFile('temp.cob'); // ��������� ��� �� ��������� ����

  // ��������� ������� ������� ��� ���������� ����
  ShellExecute(0, 'open', 'cmd.exe', PChar('/c ' + CommandLine + ' < temp.cob'),
    nil, SW_HIDE);

  // ������� ��������� ����
  DeleteFile('temp.cob');
end;

procedure TCOBOLRunner.RunCOBOLCode;
begin
  ExecuteCOBOLCode(Lines.Text);
end;

end.
