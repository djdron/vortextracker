unit selectts;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TTSSel = class(TForm)
    ListBox1: TListBox;
    procedure FormCreate(Sender: TObject);
    procedure ListBox1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure ListBox1KeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  TSSel: TTSSel;

implementation

{$R *.dfm}

procedure TTSSel.FormCreate(Sender: TObject);
begin
ListBox1.Items.AddObject('2nd soundchip is disabled',nil);
ListBox1.ItemIndex := 0;
end;

procedure TTSSel.ListBox1MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
ModalResult := mrOk;
end;

procedure TTSSel.ListBox1KeyPress(Sender: TObject; var Key: Char);
begin
case Key of
#13: ModalResult := mrOk;
#27: ModalResult := mrCancel;
end;
end;

end.
