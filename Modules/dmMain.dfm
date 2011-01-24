object Data: TData
  OldCreateOrder = False
  Left = 154
  Top = 184
  Height = 202
  Width = 187
  object Database: TIBDatabase
    Params.Strings = (
      'user_name=SYSDBA'
      'password=masterkey')
    LoginPrompt = False
    IdleTimer = 0
    SQLDialect = 1
    TraceFlags = [tfQPrepare, tfQExecute, tfQFetch, tfError, tfStmt, tfConnect, tfTransact, tfBlob, tfService, tfMisc]
    AllowStreamedConnected = False
    AfterConnect = DatabaseAfterConnect
    BeforeConnect = DatabaseBeforeConnect
    Left = 24
    Top = 8
  end
  object Transaction: TIBTransaction
    Active = False
    DefaultDatabase = Database
    AutoStopAction = saNone
    Left = 24
    Top = 56
  end
  object qrNextID: TIBSQL
    Database = Database
    ParamCheck = True
    SQL.Strings = (
      'SELECT New_ID FROM Next_ID')
    Transaction = Transaction
    Left = 80
    Top = 8
  end
  object qrAnyExist: TIBSQL
    Database = Database
    ParamCheck = True
    SQL.Strings = (
      'SELECT COUNT(*) FROM Account')
    Transaction = Transaction
    Left = 80
    Top = 56
  end
  object spMaxLevel: TIBStoredProc
    Database = Database
    Transaction = Transaction
    StoredProcName = 'MAXLEVEL'
    Left = 80
    Top = 104
    ParamData = <
      item
        DataType = ftInteger
        Name = 'RESULT'
        ParamType = ptOutput
      end>
  end
  object txEntry: TIBTransaction
    Active = False
    DefaultDatabase = Database
    AutoStopAction = saNone
    Left = 24
    Top = 104
  end
end
