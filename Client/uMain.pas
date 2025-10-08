unit uMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, IdBaseComponent,
  IdComponent, IdTCPConnection, IdTCPClient, IdContext, IdCustomTCPServer,
  IdTCPServer, Vcl.Buttons;

type
  TfrmClient = class(TForm)
    btnConnect: TButton;
    edtData: TEdit;
    tcpClient: TIdTCPClient;
    edtHost: TEdit;
    edtPort: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    btnDisconnect: TButton;
    btncmdProcessData: TButton;
    btncmdHESScreenActive: TButton;
    Label3: TLabel;
    Label4: TLabel;
    btnActive: TButton;
    edtServerPort: TEdit;
    Label5: TLabel;
    tcpServer: TIdTCPServer;
    btnDeactive: TButton;
    mmClient: TMemo;
    btnSendToAll: TBitBtn;
    mmServer: TMemo;
    mmMessage: TMemo;
    mmIPList: TMemo;
    procedure btnConnectClick(Sender: TObject);
    procedure tcpClientConnected(Sender: TObject);
    procedure btnDisconnectClick(Sender: TObject);
    procedure btncmdProcessDataClick(Sender: TObject);
    procedure btncmdHESScreenActiveClick(Sender: TObject);
    procedure btnActiveClick(Sender: TObject);
    procedure btnDeactiveClick(Sender: TObject);
    procedure tcpServerConnect(AContext: TIdContext);
    procedure tcpServerExecute(AContext: TIdContext);
    procedure btnSendToAllClick(Sender: TObject);
    procedure prcSendMessage(IP:string; ClientMessage:TStringList);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmClient: TfrmClient;

implementation

{$R *.dfm}

procedure TfrmClient.btncmdHESScreenActiveClick(Sender: TObject);
begin
  mmClient.Lines.Add('You Ask: cmdHESScreenActive');
  tcpClient.Socket.WriteLn('cmdHESScreenActive');
  mmClient.Lines.Add('Host Says '+tcpClient.Socket.ReadLn);
end;

procedure TfrmClient.btncmdProcessDataClick(Sender: TObject);
begin
  mmClient.Lines.Add('Client Ask: '+'cmdProcessData  '+edtData.Text);
  tcpClient.Socket.WriteLn('cmdProcessData  '+edtData.Text);
  mmClient.Lines.Add('Server Says '+tcpClient.Socket.ReadLn);
end;

procedure TfrmClient.btnConnectClick(Sender: TObject);
begin
  try
    tcpClient.Host:=edtHost.Text;
    tcpClient.Port:=StrToInt(edtPort.Text);
    if not tcpClient.Connected then
    begin
      tcpClient.Connect;
      ShowMessage('bağlandı');
    end
    else
    begin
      ShowMessage('Zaten bağlı');
    end;
  except
  on E:Exception do
    begin
      ShowMessage('bağlantı hatası');
    end;
  end;

  {try
    if not tcpClient.Connected then
    begin
      tcpClient.Host:=Trim(edtHost.Text);
      tcpClient.Port:=StrToInt(Trim(edtPort.Text));
      tcpClient.Connect;
    end;
    btnConnect.Enabled:=false;
    btnDisconnect.Enabled:=true;
    btncmdProcessData.Enabled:=true;
    btncmdHESScreenActive.Enabled:=true;
  except
  on E:Exception do
    begin
      btnConnect.Enabled:=true;
      btnDisconnect.Enabled:=false;
      btncmdProcessData.Enabled:=false;
      btncmdHESScreenActive.Enabled:=false;
      lbClient.AddItem('Error: '+E.Message,nil);
    end;
  end;   }
end;

procedure TfrmClient.btnDeactiveClick(Sender: TObject);
begin
  if tcpServer.Active then
  begin
    tcpServer.Active:=false;
    btnDeactive.Enabled:=false;
    btnActive.Enabled:=true;
  end;
end;

procedure TfrmClient.btnDisconnectClick(Sender: TObject);
begin
  try
    if tcpClient.Connected then
    begin
      tcpClient.Disconnect;
    end;

    btnConnect.Enabled:=true;
    btnDisconnect.Enabled:=false;
    btncmdProcessData.Enabled:=false;
    btncmdHESScreenActive.Enabled:=false;
  except
  on E:Exception do
    begin
      btnConnect.Enabled:=false;
      btnDisconnect.Enabled:=true;
      btncmdProcessData.Enabled:=true;
      btncmdHESScreenActive.Enabled:=true;
      mmClient.Lines.Add('Error: '+E.Message);
    end;
  end;
end;

procedure TfrmClient.prcSendMessage(IP:string; ClientMessage:TStringList);
begin
  try
    tcpClient.Host:=trim(IP);
    tcpClient.Port:=StrToInt(edtPort.Text);
    if not tcpClient.Connected then
    begin
      tcpClient.Connect;
      tcpClient.Socket.WriteLn(ClientMessage.Text);
      mmClient.Lines.Add('Server Says '+tcpClient.Socket.ReadLn);
      tcpClient.Disconnect;
    end;
  except
  on E:Exception do
    begin
      ShowMessage('bağlantı hatası'+E.Message);
    end;
  end;
end;

procedure TfrmClient.btnSendToAllClick(Sender: TObject);
var
  i:integer;
  ClientMessage:TStringList;
begin
  ClientMessage:=TStringList.Create;
  try
    ClientMessage.Text:=mmMessage.Text;
    for i := 0 to mmIPList.Lines.Count-1 do
    begin
      prcSendMessage(mmIPList.Lines[i],ClientMessage);
    end;
  finally
    ClientMessage.Free;
  end;

end;

procedure TfrmClient.btnActiveClick(Sender: TObject);
begin
  if not tcpServer.Active then
  begin
    tcpServer.DefaultPort:=StrToInt(Trim(edtServerPort.Text));
    tcpServer.Active:=true;
    btnDeactive.Enabled:=true;
    btnActive.Enabled:=false;
  end;
end;

procedure TfrmClient.tcpClientConnected(Sender: TObject);
begin
  mmClient.Lines.Add(tcpClient.Socket.ReadLn);
end;

procedure TfrmClient.tcpServerConnect(AContext: TIdContext);
begin
  AContext.Connection.Socket.WriteLn('Connected');
  mmServer.Lines.Add(AContext.Connection.Socket.Binding.PeerIP+':'+IntToStr(AContext.Connection.Socket.Binding.PeerPort)+' Connected');
end;

procedure TfrmClient.tcpServerExecute(AContext: TIdContext);
begin
  mmServer.Lines.Add('Client Says: '+AContext.Connection.Socket.ReadLn);
  AContext.Connection.Socket.WriteLn('Message received.');
end;

end.
