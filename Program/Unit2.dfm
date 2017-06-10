object Form2: TForm2
  Left = 0
  Top = 0
  Caption = 'Edytowanie'
  ClientHeight = 435
  ClientWidth = 273
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCloseQuery = FormCloseQuery
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 83
    Top = 377
    Width = 118
    Height = 14
    Caption = 'Ten wiersz edytujesz'
    Font.Charset = EASTEUROPE_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label2: TLabel
    Left = 36
    Top = 24
    Width = 83
    Height = 13
    Caption = 'Edytowane dane'
    Font.Charset = EASTEUROPE_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Times New Roman'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object ListBox1: TListBox
    Left = 36
    Top = 349
    Width = 201
    Height = 22
    Cursor = crNo
    ItemHeight = 13
    TabOrder = 8
  end
  object Button1: TButton
    Left = 36
    Top = 288
    Width = 201
    Height = 55
    Cursor = crHandPoint
    Caption = 'Zako'#324'cz edycj'#281
    Font.Charset = EASTEUROPE_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Times New Roman'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 7
    OnClick = Button1Click
  end
  object Edit1: TEdit
    Left = 36
    Top = 43
    Width = 201
    Height = 21
    MaxLength = 22
    TabOrder = 0
    TextHint = 'Nazwa pojazdu'
  end
  object ComboBox1: TComboBox
    Left = 36
    Top = 79
    Width = 201
    Height = 21
    MaxLength = 20
    TabOrder = 1
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
  object ComboBox2: TComboBox
    Left = 36
    Top = 115
    Width = 201
    Height = 21
    MaxLength = 20
    TabOrder = 2
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
    Top = 151
    Width = 201
    Height = 21
    MaxLength = 5
    NumbersOnly = True
    TabOrder = 3
    TextHint = 'Kaliber (w milimetrach)'
  end
  object Edit3: TEdit
    Left = 36
    Top = 187
    Width = 201
    Height = 21
    MaxLength = 5
    NumbersOnly = True
    TabOrder = 4
    TextHint = 'Penetracja (w milimetrach)'
  end
  object Edit4: TEdit
    Left = 36
    Top = 223
    Width = 201
    Height = 21
    MaxLength = 5
    NumbersOnly = True
    TabOrder = 5
    TextHint = 'Pr'#281'dko'#347#263' maksymalna'
  end
  object MaskEdit1: TMaskEdit
    Left = 36
    Top = 259
    Width = 201
    Height = 21
    Hint = 'Pancerz: przedni \ boczny \ tylny'
    EditMask = '999\\999\\999;1;_'
    MaxLength = 11
    ParentShowHint = False
    ShowHint = True
    TabOrder = 6
    Text = '   \   \   '
  end
  object Edit5: TEdit
    Left = 188
    Top = 8
    Width = 49
    Height = 21
    TabOrder = 9
    Visible = False
  end
end
