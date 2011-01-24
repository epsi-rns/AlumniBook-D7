inherited LookupOrganization: TLookupOrganization
  Caption = 'Lookup Organization'
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 13
  inherited PanelBtm: TPanel
    inherited BtnSelect: TBitBtn
      Kind = bkOK
    end
    inherited BtnCancel: TBitBtn
      Kind = bkCancel
    end
    inherited DBNav: TDBNavigator
      Hints.Strings = ()
    end
  end
  inherited DBGrid: TDBGrid
    Hint = 'Lookup Organization'
  end
  inherited CoolBar: TCoolBar
    inherited PanelFilter: TPanel [0]
    end
    inherited PanelFind: TPanel [1]
    end
    inherited PanelExport: TPanel [3]
    end
    inherited PanelSelect: TPanel [4]
    end
  end
end
