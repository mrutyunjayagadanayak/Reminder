unit SoundAlarm;

{$mode ObjFPC}{$H+}

interface

uses
  {$IFDEF UNIX}
  xlib,
  {$ENDIF}
  Classes, SysUtils, crt, DateUtils, ExtCtrls, Dialogs;

type
  TSoundThread = class (TThread)
    protected
      procedure Execute; override;
  end;

  TAlarm = class
    private
      FTimer : TTimer;
      procedure OnTimer(Sender : TObject);
    public
      constructor Create(AOwner : TComponent);
      procedure Start(IntervalMinutes : Integer);
      procedure Stop;
  end;

implementation

{ TSoundThread }
procedure TSoundThread.Execute;
{$IFDEF UNIX}
var
  dpy: PDisplay;
  {$ENDIF}
begin
  {$IFDEF WINDOWS}
  Sound(5000);
  Delay(1000);
  NoSound;
  {$ENDIF}
  {$IFDEF UNIX}
  dpy:=XOpenDisplay(nil);
  try
     XSynchronize(dpy,1);
     XBell(dpy,0);
     XFlush(dpy);
     //xkblib.XkbForceBell(dpy,1000);
     XCloseDisplay(dpy);
  finally
    XCloseDisplay(dpy);
  end;
  {$ENDIF}
end;

{ TAlarm }
constructor TAlarm.Create(AOwner : TComponent);
begin
  FTimer:=TTimer.Create(AOwner);
  FTimer.Enabled:=False;
  FTimer.OnTimer:=@OnTimer;
end;

procedure TAlarm.Start(IntervalMinutes : Integer);
begin
  FTimer.Interval:=IntervalMinutes * 60000;  //Converts min to milliseconds
  FTimer.Enabled:=True;
  ShowMessage('Reminder set for every ' + IntToStr(IntervalMinutes) + ' minutes.');
end;

procedure TAlarm.Stop;
begin
  FTimer.Enabled:=False;
  ShowMessage('Reminder Stopped');
end;

procedure TAlarm.OnTimer(Sender: TObject);
begin
  TSoundThread.Create(False);
  ShowMessage('Time to check ICMs');
end;

end.

