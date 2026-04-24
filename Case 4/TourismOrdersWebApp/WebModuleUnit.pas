unit WebModuleUnit;

interface

uses
  System.SysUtils,
  System.Classes,
  Web.HTTPApp;

type
  TWebModule1 = class(TWebModule)
    procedure WebModule1DefaultHandlerAction(Sender: TObject;
      Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
  private
    function GenerateHTMLPage: string;
  public
  end;

var
  WebModuleClass: TComponentClass = TWebModule1;

implementation

{%CLASSGROUP 'System.Classes.TPersistent'}

{$R *.dfm}

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
    'table { border-collapse: collapse; width: 100%; background: white; }' +
    'th, td { border: 1px solid #ccc; padding: 10px; text-align: left; }' +
    'th { background-color: #e8e8e8; }' +
    '</style>' +
    '</head>' +
    '<body>' +
    '<h1>WEB-приложение "Tourism Orders"</h1>' +
    '<p>Приложение предназначено для учета заказов туров.</p>' +
    '<table>' +
    '<tr>' +
    '<th>№ заказа</th>' +
    '<th>Клиент</th>' +
    '<th>Тур</th>' +
    '<th>Услуга</th>' +
    '<th>Дата заказа</th>' +
    '<th>Сумма</th>' +
    '</tr>' +
    '<tr>' +
    '<td>1</td>' +
    '<td>Иванов Иван Иванович</td>' +
    '<td>Отдых в Анталии</td>' +
    '<td>Трансфер из аэропорта</td>' +
    '<td>20.04.2026</td>' +
    '<td>155000.00</td>' +
    '</tr>' +
    '<tr>' +
    '<td>2</td>' +
    '<td>Петрова Анна Сергеевна</td>' +
    '<td>Экскурсионный тур в Рим</td>' +
    '<td>Медицинская страховка</td>' +
    '<td>21.04.2026</td>' +
    '<td>98000.00</td>' +
    '</tr>' +
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
