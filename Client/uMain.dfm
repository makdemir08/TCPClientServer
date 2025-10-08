object frmClient: TfrmClient
  Left = 1103
  Top = 0
  Caption = 'Client Application'
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
  object Label1: TLabel
    Left = 8
    Top = 48
    Width = 25
    Height = 15
    Caption = 'Host'
  end
  object Label2: TLabel
    Left = 119
    Top = 48
    Width = 22
    Height = 15
    Caption = 'Port'
  end
  object Label3: TLabel
    Left = 8
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
  object Label4: TLabel
    Left = 399
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
  object Label5: TLabel
    Left = 399
    Top = 48
    Width = 57
    Height = 15
    Caption = 'Server Port'
  end
  object btnConnect: TButton
    Left = 183
    Top = 8
    Width = 75
    Height = 44
    Caption = 'Connect'
    TabOrder = 0
    OnClick = btnConnectClick
  end
  object edtData: TEdit
    Left = 8
    Top = 306
    Width = 313
    Height = 23
    TabOrder = 1
    Text = 'CARDNO;CARDNAME'
  end
  object edtHost: TEdit
    Left = 8
    Top = 69
    Width = 105
    Height = 23
    TabOrder = 2
    Text = 'localhost'
  end
  object edtPort: TEdit
    Left = 119
    Top = 69
    Width = 58
    Height = 23
    TabOrder = 3
    Text = '60'
  end
  object btnDisconnect: TButton
    Left = 183
    Top = 58
    Width = 75
    Height = 34
    Caption = 'Disconnect'
    TabOrder = 4
    OnClick = btnDisconnectClick
  end
  object btncmdProcessData: TButton
    Left = 8
    Top = 335
    Width = 133
    Height = 50
    Caption = 'cmdProcessData'
    Enabled = False
    TabOrder = 5
    OnClick = btncmdProcessDataClick
  end
  object btncmdHESScreenActive: TButton
    Left = 147
    Top = 335
    Width = 139
    Height = 50
    Caption = 'cmdHESScreenActive'
    Enabled = False
    TabOrder = 6
    OnClick = btncmdHESScreenActiveClick
  end
  object btnActive: TButton
    Left = 526
    Top = 48
    Width = 75
    Height = 44
    Caption = 'Active'
    TabOrder = 7
    OnClick = btnActiveClick
  end
  object edtServerPort: TEdit
    Left = 399
    Top = 69
    Width = 121
    Height = 23
    TabOrder = 8
    Text = '65'
  end
  object btnDeactive: TButton
    Left = 607
    Top = 48
    Width = 75
    Height = 44
    Caption = 'Deactive'
    Enabled = False
    TabOrder = 9
    OnClick = btnDeactiveClick
  end
  object mmClient: TMemo
    Left = 8
    Top = 98
    Width = 313
    Height = 202
    Lines.Strings = (
      'mmClient')
    TabOrder = 10
  end
  object btnSendToAll: TBitBtn
    Left = 264
    Top = 8
    Width = 113
    Height = 84
    Caption = 'Send to all'
    TabOrder = 11
    OnClick = btnSendToAllClick
  end
  object mmServer: TMemo
    Left = 463
    Top = 98
    Width = 313
    Height = 202
    Lines.Strings = (
      'mmClient')
    TabOrder = 12
  end
  object mmMessage: TMemo
    Left = 327
    Top = 98
    Width = 130
    Height = 103
    Lines.Strings = (
      'mmMessage')
    TabOrder = 13
  end
  object mmIPList: TMemo
    Left = 327
    Top = 207
    Width = 130
    Height = 178
    Lines.Strings = (
      'mmIPList')
    TabOrder = 14
  end
  object tcpClient: TIdTCPClient
    OnConnected = tcpClientConnected
    ConnectTimeout = 0
    Host = 'localhost'
    Port = 60
    ReadTimeout = -1
    Left = 104
    Top = 8
  end
  object tcpServer: TIdTCPServer
    Bindings = <>
    DefaultPort = 65
    OnConnect = tcpServerConnect
    OnExecute = tcpServerExecute
    Left = 536
    Top = 344
  end
end
