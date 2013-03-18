object DM: TDM
  OldCreateOrder = False
  Left = 215
  Top = 155
  Height = 377
  Width = 522
  object DB: TDatabase
    DatabaseName = 'DBDiplom'
    DriverName = 'STANDARD'
    KeepConnection = False
    LoginPrompt = False
    Params.Strings = (
      'PATH=db'
      'DEFAULT DRIVER=PARADOX'
      'ENABLE BCD=FALSE')
    SessionName = 'Default'
    AfterConnect = DBAfterConnect
    AfterDisconnect = DBAfterDisconnect
    Left = 112
    Top = 80
  end
  object tblStatistiks: TTable
    DatabaseName = 'DBDiplom'
    FieldDefs = <
      item
        Name = 'id'
        DataType = ftAutoInc
      end
      item
        Name = 'D'
        DataType = ftFloat
      end
      item
        Name = 'N'
        DataType = ftInteger
      end
      item
        Name = 'Glubina'
        DataType = ftInteger
      end
      item
        Name = 'PPorog'
        DataType = ftFloat
      end
      item
        Name = 'm'
        DataType = ftFloat
      end
      item
        Name = 'a'
        DataType = ftFloat
      end
      item
        Name = 'b'
        DataType = ftFloat
      end>
    IndexDefs = <
      item
        Name = 'tblStatistiksIndex1'
        Fields = 'id'
        Options = [ixPrimary]
      end>
    StoreDefs = True
    TableName = 'Statistiks'
    Left = 160
    Top = 80
  end
  object qStatistiks: TQuery
    DatabaseName = 'DBDiplom'
    RequestLive = True
    SQL.Strings = (
      'select * from statistiks')
    UpdateObject = usStatistiks
    Left = 48
    Top = 152
  end
  object usStatistiks: TUpdateSQL
    ModifySQL.Strings = (
      'update statistiks'
      'set'
      '  D = :D,'
      '  N = :N,'
      '  Glubina = :Glubina,'
      '  PPorog = :PPorog,'
      '  m = :m,'
      '  a = :a,'
      '  b = :b'
      'where'
      '  id = :OLD_id')
    InsertSQL.Strings = (
      'insert into statistiks'
      '  (D, N, Glubina, PPorog, m, a, b)'
      'values'
      '  (:D, :N, :Glubina, :PPorog, :m, :a, :b)')
    DeleteSQL.Strings = (
      'delete from statistiks'
      'where'
      '  id = :OLD_id')
    Left = 184
    Top = 152
  end
  object dsStatistiks: TDataSource
    DataSet = qStatistiks
    Left = 120
    Top = 152
  end
end
