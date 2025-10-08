unit uMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, IdContext, Vcl.StdCtrls,
  IdCustomTCPServer, IdTCPServer, IdBaseComponent, IdComponent, IdTCPConnection,
  IdTCPClient, IdGlobal;

type
  TfrmMain = class(TForm)
    tcpServer: TIdTCPServer;
    lbServer: TListBox;
    btnActive: TButton;
    Label4: TLabel;
    Label3: TLabel;
    btnConnect: TButton;
    edtHost: TEdit;
    edtPort: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    btnDisconnect: TButton;
    edtServerPort: TEdit;
    Label5: TLabel;
    btnDeactive: TButton;
    lbClient: TListBox;
    tcpClient: TIdTCPClient;
    btncmdCardReaderInit: TButton;
    btncmdCardReaderEject: TButton;
    procedure tcpServerExecute(AContext: TIdContext);
    procedure tcpServerConnect(AContext: TIdContext);
    procedure btnActiveClick(Sender: TObject);
    procedure btnDeactiveClick(Sender: TObject);
    procedure tcpClientConnected(Sender: TObject);
    procedure btncmdCardReaderInitClick(Sender: TObject);
    procedure btncmdCardReaderEjectClick(Sender: TObject);
    procedure btnConnectClick(Sender: TObject);
    procedure btnDisconnectClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmMain: TfrmMain;

implementation

{$R *.dfm}

procedure TfrmMain.btnActiveClick(Sender: TObject);
begin
  if not tcpServer.Active then
  begin
    tcpServer.DefaultPort := StrToInt(Trim(edtServerPort.Text));
    tcpServer.Active := true;
    btnDeactive.Enabled := true;
    btnActive.Enabled := false;
  end;
end;

procedure TfrmMain.btncmdCardReaderEjectClick(Sender: TObject);
begin
  lbClient.AddItem('Client Ask: cmdCardReaderEject', nil);
  tcpClient.Socket.WriteLn('cmdCardReaderEject');
  lbClient.AddItem('Server Says ' + tcpClient.Socket.ReadLn, nil);
end;

procedure TfrmMain.btncmdCardReaderInitClick(Sender: TObject);
begin
  lbClient.AddItem('Client Ask: cmdCardReaderInit', nil);
  tcpClient.Socket.WriteLn('cmdCardReaderInit');
  lbClient.AddItem('Server Says ' + tcpClient.Socket.ReadLn, nil);
end;

procedure TfrmMain.btnConnectClick(Sender: TObject);
begin
  try
    if not tcpClient.Connected then
    begin
      tcpClient.Host := Trim(edtHost.Text);
      tcpClient.Port := StrToInt(Trim(edtPort.Text));
      tcpClient.Connect;
    end;
    btnConnect.Enabled := false;
    btnDisconnect.Enabled := true;
    btncmdCardReaderInit.Enabled := true;
    btncmdCardReaderEject.Enabled := true;
  except
    on E: Exception do
    begin
      btnConnect.Enabled := true;
      btnDisconnect.Enabled := false;
      btncmdCardReaderInit.Enabled := false;
      btncmdCardReaderEject.Enabled := false;
      lbClient.AddItem('Error: ' + E.Message, nil);
    end;
  end;
end;

procedure TfrmMain.btnDeactiveClick(Sender: TObject);
begin
  if tcpServer.Active then
  begin
    tcpServer.Active := false;
    btnDeactive.Enabled := false;
    btnActive.Enabled := true;
  end;
end;

procedure TfrmMain.btnDisconnectClick(Sender: TObject);
begin
  try
    if tcpClient.Connected then
    begin
      tcpClient.Disconnect;
    end;

    btnConnect.Enabled := true;
    btnDisconnect.Enabled := false;
    btncmdCardReaderInit.Enabled := false;
    btncmdCardReaderEject.Enabled := false;
  except
    on E: Exception do
    begin
      btnConnect.Enabled := false;
      btnDisconnect.Enabled := true;
      btncmdCardReaderInit.Enabled := true;
      btncmdCardReaderEject.Enabled := true;
      lbClient.AddItem('Error: ' + E.Message, nil);
    end;
  end;
end;

procedure TfrmMain.tcpClientConnected(Sender: TObject);
begin
  lbClient.AddItem(tcpClient.Socket.ReadLn, nil);
end;

procedure TfrmMain.tcpServerConnect(AContext: TIdContext);
begin
  AContext.Connection.Socket.WriteLn('Connected');
  lbServer.AddItem(AContext.Connection.Socket.Binding.PeerIP + ':' +
    IntToStr(AContext.Connection.Socket.Binding.PeerPort) + ' Connected', nil);
end;

procedure TfrmMain.tcpServerExecute(AContext: TIdContext);
var
  IdBytes: TIdBytes;
begin
  AContext.Connection.IOHandler.ReadBytes(IdBytes,-1);
  lbServer.AddItem(TEncoding.UTF8.GetString(IdBytes),nil);
  AContext.Connection.Socket.WriteLn('Message received.');
end;

end.
