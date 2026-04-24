unit WebModuleUnit;

interface

uses
  System.SysUtils,
  System.Classes,
  Web.HTTPApp,
  Data.DB,
  FireDAC.Comp.Client,
  FireDAC.Stan.Def,
  FireDAC.Stan.Async,
  FireDAC.Stan.Option,
  FireDAC.Stan.Param,
  FireDAC.Stan.Error,
  FireDAC.DatS,
  FireDAC.DApt,
  FireDAC.Phys,
  FireDAC.Phys.MSSQL,
  FireDAC.Phys.MSSQLDef;

type
  TWebModule1 = class(TWebModule)
    procedure WebModule1DefaultHandlerAction(Sender: TObject;
      Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
  private
    function GenerateHTMLPage: string;
    function LoadOrdersFromDatabase: string;
  public
  end;

var
  WebModuleClass: TComponentClass = TWebModule1;

implementation

{%CLASSGROUP 'System.Classes.TPersistent'}

{$R *.dfm}

function TWebModule1.LoadOrdersFromDatabase: string;
var
  Connection: TFDConnection;
  Query: TFDQuery;
begin
  Result := '';

  Connection := TFDConnection.Create(nil);
  Query := TFDQuery.Create(nil);

  try
    Query.Connection := Connection;

    { 
      Параметры подключения к MS SQL Server.
      При необходимости значение Server можно заменить, например:
      localhost
      .\SQLEXPRESS
      имя_сервера\имя_экземпляра
    }
    Connection.Params.Clear;
    Connection.Params.Add('DriverID=MSSQL');
    Connection.Params.Add('Server=localhost');
    Connection.Params.Add('Database=TourismOrdersDB');
    Connection.Params.Add('OSAuthent=Yes');
    Connection.LoginPrompt := False;

    Connection.Connected := True;

    Query.SQL.Text :=
      'SELECT ' +
      'o.OrderID, ' +
      'c.FullName, ' +
      't.TourName, ' +
      's.ServiceName, ' +
      'pm.MethodName, ' +
      'o.OrderDate, ' +
      'o.PersonsCount, ' +
      'o.TotalAmount ' +
      'FROM Orders o ' +
      'INNER JOIN Clients c ON o.ClientID = c.ClientID ' +
      'INNER JOIN Tours t ON o.TourID = t.TourID ' +
      'LEFT JOIN Services s ON o.ServiceID = s.ServiceID ' +
      'INNER JOIN PaymentMethods pm ON o.PaymentMethodID = pm.PaymentMethodID ' +
      'ORDER BY o.OrderID';

    Query.Open;

    while not Query.Eof do
    begin
      Result := Result +
        '<tr>' +
        '<td>' + Query.FieldByName('OrderID').AsString + '</td>' +
        '<td>' + Query.FieldByName('FullName').AsString + '</td>' +
        '<td>' + Query.FieldByName('TourName').AsString + '</td>' +
        '<td>' + Query.FieldByName('ServiceName').AsString + '</td>' +
        '<td>' + Query.FieldByName('MethodName').AsString + '</td>' +
        '<td>' + FormatDateTime('dd.mm.yyyy', Query.FieldByName('OrderDate').AsDateTime) + '</td>' +
        '<td>' + Query.FieldByName('PersonsCount').AsString + '</td>' +
        '<td>' + Query.FieldByName('TotalAmount').AsString + '</td>' +
        '</tr>';

      Query.Next;
    end;

    if Result = '' then
      Result := '<tr><td colspan="8">Заказы не найдены</td></tr>';

  except
    on E: Exception do
    begin
      Result :=
        '<tr>' +
        '<td colspan="8">Ошибка подключения к базе данных: ' +
        E.Message +
        '</td>' +
        '</tr>';
    end;
  end;

  Query.Free;
  Connection.Free;
end;

function TWebModule1.GenerateHTMLPage: string;
begin
  Result :=
    '<!DOCTYPE html>' +
    '<html lang="ru">' +
    '<head>' +
    '<meta charset="UTF-8">' +
    '<title>Tourism Orders</title>' +
    '<style>' +
    'body { font-family: Arial; margin: 40px; background-color: #f5f5f5; }' +
    'h1 { color: #2c3e50; }' +
    'p { font-size: 16px; }' +
    'table { border-collapse: collapse; width: 100%; background: white; }' +
    'th, td { border: 1px solid #ccc; padding: 10px; text-align: left; }' +
    'th { background-color: #e8e8e8; }' +
    '</style>' +
    '</head>' +
    '<body>' +
    '<h1>WEB-приложение "Tourism Orders"</h1>' +
    '<p>Приложение предназначено для учета заказов туров и получает данные из базы MS SQL Server.</p>' +
    '<table>' +
    '<tr>' +
    '<th>№ заказа</th>' +
    '<th>Клиент</th>' +
    '<th>Тур</th>' +
    '<th>Услуга</th>' +
    '<th>Способ оплаты</th>' +
    '<th>Дата заказа</th>' +
    '<th>Количество человек</th>' +
    '<th>Сумма</th>' +
    '</tr>' +
    LoadOrdersFromDatabase +
    '</table>' +
    '</body>' +
    '</html>';
end;

procedure TWebModule1.WebModule1DefaultHandlerAction(Sender: TObject;
  Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
begin
  Response.ContentType := 'text/html; charset=utf-8';
  Response.Content := GenerateHTMLPage;
  Handled := True;
end;

end.
