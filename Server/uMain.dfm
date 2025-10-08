object frmMain: TfrmMain
  Left = 0
  Top = 0
  Caption = 'Host Application'
  ClientHeight = 391
  ClientWidth = 784
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poDesigned
  TextHeight = 15
  object Label4: TLabel
    Left = 8
    Top = 8
    Width = 73
    Height = 32
    Caption = 'Server'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -24
    Font.Name = 'Segoe UI'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label3: TLabel
    Left = 399
    Top = 8
    Width = 66
    Height = 32
    Caption = 'Client'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -24
    Font.Name = 'Segoe UI'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label1: TLabel
    Left = 400
    Top = 48
    Width = 25
    Height = 15
    Caption = 'Host'
  end
  object Label2: TLabel
    Left = 511
    Top = 48
    Width = 22
    Height = 15
    Caption = 'Port'
  end
  object Label5: TLabel
    Left = 8
    Top = 48
    Width = 57
    Height = 15
    Caption = 'Server Port'
  end
  object lbServer: TListBox
    Left = 9
    Top = 98
    Width = 377
    Height = 201
    ItemHeight = 15
    TabOrder = 0
  end
  object btnActive: TButton
    Left = 135
    Top = 48
    Width = 75
    Height = 44
    Caption = 'Active'
    TabOrder = 1
    OnClick = btnActiveClick
  end
  object btnConnect: TButton
    Left = 575
    Top = 48
    Width = 75
    Height = 44
    Caption = 'Connect'
    TabOrder = 2
    OnClick = btnConnectClick
  end
  object edtHost: TEdit
    Left = 400
    Top = 69
    Width = 105
    Height = 23
    TabOrder = 3
    Text = 'localhost'
  end
  object edtPort: TEdit
    Left = 511
    Top = 69
    Width = 58
    Height = 23
    TabOrder = 4
    Text = '65'
  end
  object btnDisconnect: TButton
    Left = 656
    Top = 48
    Width = 75
    Height = 44
    Caption = 'Disconnect'
    Enabled = False
    TabOrder = 5
    OnClick = btnDisconnectClick
  end
  object edtServerPort: TEdit
    Left = 8
    Top = 69
    Width = 121
    Height = 23
    TabOrder = 6
    Text = '60'
  end
  object btnDeactive: TButton
    Left = 216
    Top = 48
    Width = 75
    Height = 44
    Caption = 'Deactive'
    Enabled = False
    TabOrder = 7
    OnClick = btnDeactiveClick
  end
  object lbClient: TListBox
    Left = 399
    Top = 98
    Width = 377
    Height = 201
    ItemHeight = 15
    TabOrder = 8
  end
  object btncmdCardReaderInit: TButton
    Left = 400
    Top = 305
    Width = 133
    Height = 50
    Caption = 'cmdCardReaderInit'
    Enabled = False
    TabOrder = 9
    OnClick = btncmdCardReaderInitClick
  end
  object btncmdCardReaderEject: TButton
    Left = 539
    Top = 305
    Width = 139
    Height = 50
    Caption = 'cmdCardReaderEject'
    Enabled = False
    TabOrder = 10
    OnClick = btncmdCardReaderEjectClick
  end
  object tcpServer: TIdTCPServer
    Bindings = <>
    DefaultPort = 65
    OnConnect = tcpServerConnect
    OnExecute = tcpServerExecute
    Left = 32
    Top = 112
  end
  object tcpClient: TIdTCPClient
    OnConnected = tcpClientConnected
    ConnectTimeout = 0
    Host = 'localhost'
    Port = 60
    ReadTimeout = -1
    Left = 416
    Top = 112
  end
end
