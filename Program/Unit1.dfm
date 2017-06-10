object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Dodaj'
  ClientHeight = 399
  ClientWidth = 274
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnCloseQuery = FormCloseQuery
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 38
    Top = 8
    Width = 65
    Height = 19
    Caption = 'POJAZD'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label2: TLabel
    Left = 38
    Top = 40
    Width = 106
    Height = 14
    Caption = 'Poni'#380'ej wpisz dane'
    Font.Charset = EASTEUROPE_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Edit1: TEdit
    Left = 36
    Top = 75
    Width = 201
    Height = 21
    MaxLength = 22
    TabOrder = 1
    TextHint = 'Nazwa pojazdu'
  end
  object ComboBox1: TComboBox
    Left = 36
    Top = 111
    Width = 201
    Height = 21
    MaxLength = 20
    TabOrder = 2
    TextHint = 'Kraj'
    OnKeyPress = ComboBox1KeyPress
    Items.Strings = (
      'Niemcy'
      'ZSRR'
      'USA'
      'Wielka Brytania'
      'Francja'
      'Chiny'
      'Japonia'
      'Polska')
  end
  object Button2: TButton
    Left = 150
    Top = 13
    Width = 87
    Height = 41
    Cursor = crHandPoint
    Caption = 'Wyczy'#347#263
    Font.Charset = EASTEUROPE_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Times New Roman'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    OnClick = Button2Click
  end
  object ComboBox2: TComboBox
    Left = 36
    Top = 147
    Width = 201
    Height = 21
    MaxLength = 20
    TabOrder = 3
    TextHint = 'Typ'
    OnKeyPress = ComboBox2KeyPress
    Items.Strings = (
      'Czo'#322'g lekki'
      'Czo'#322'g '#347'redni'
      'Czo'#322'g ci'#281#380'ki'
      'Czo'#322'g superci'#281#380'ki'
      'Niszczyciel czo'#322'g'#243'w'
      'Artyleria'
      'Tankietka')
  end
  object Edit2: TEdit
    Left = 36
    Top = 183
    Width = 201
    Height = 21
    MaxLength = 5
    NumbersOnly = True
    TabOrder = 4
    TextHint = 'Kaliber (w milimetrach)'
  end
  object Edit3: TEdit
    Left = 36
    Top = 219
    Width = 201
    Height = 21
    MaxLength = 5
    NumbersOnly = True
    TabOrder = 5
    TextHint = 'Penetracja (w milimetrach)'
  end
  object Edit4: TEdit
    Left = 36
    Top = 255
    Width = 201
    Height = 21
    MaxLength = 5
    NumbersOnly = True
    TabOrder = 6
    TextHint = 'Pr'#281'dko'#347#263' maksymalna'
  end
  object MaskEdit1: TMaskEdit
    Left = 36
    Top = 298
    Width = 201
    Height = 21
    Hint = 'Pancerz: przedni \ boczny \ tylny'
    EditMask = '999\\999\\999;1;_'
    MaxLength = 11
    ParentShowHint = False
    ShowHint = True
    TabOrder = 7
    Text = '   \   \   '
  end
  object Button1: TButton
    Left = 36
    Top = 325
    Width = 201
    Height = 58
    Cursor = crHandPoint
    Caption = 'Dodaj nowy'
    Font.Charset = EASTEUROPE_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Times New Roman'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 8
    OnClick = Button1Click
  end
end
