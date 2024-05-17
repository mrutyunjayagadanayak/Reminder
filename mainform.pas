unit MainForm;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, SoundAlarm;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Edit1: TEdit;
    Label1: TLabel;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    Alarm: TAlarm;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

procedure TForm1.Button1Click(Sender: TObject);
var
  Time: Integer;
begin
  if TryStrToInt(Edit1.Text, Time) then
  begin
    Alarm.Start(Time);
    Edit1.ReadOnly:=True;
    Label1.Caption:='Reminder set to ' + IntToStr(Time) + ' Min.';
  end
  else
    ShowMessage(Edit1.Text + ' is not a valid input');
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  Alarm.Stop;
  Edit1.ReadOnly:=False;
  Label1.Caption:='No Reminder Set';
end;

constructor TForm1.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Alarm:=TAlarm.Create(Self);
  Label1.Caption:='No Reminder Set';
end;

destructor TForm1.Destroy;
begin
  Alarm.Free;
  inherited Destroy;
end;


end.

