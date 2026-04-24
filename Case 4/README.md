# Кейс-задача №4

## Тема проекта
WEB-приложение "Tourism Orders" для учета заказов туров.

## Описание
В рамках кейс-задачи было разработано учебное WEB-приложение на Delphi 10.2 с использованием WEB-архитектуры.  
Приложение предназначено для отображения информации о заказах туров.

WEB-приложение предполагает размещение на MS Internet Information Server (IIS).  
База данных для приложения создана в MS SQL Server.

## Используемые технологии
- Delphi 10.2
- MS Internet Information Server (IIS)
- MS SQL Server
- SQL

## Структура базы данных
База данных `TourismOrdersDB` включает следующие таблицы:

- `Clients` — клиенты;
- `Tours` — туры;
- `Services` — дополнительные услуги;
- `PaymentMethods` — способы оплаты;
- `Orders` — заказы туров.

Для всех таблиц созданы первичные ключи.  
В таблице `Orders` реализованы внешние ключи для связи со справочниками.

## Структура проекта

```text
case-task-4/
│
├── README.md
├── database.sql
│
└── TourismOrdersWebApp/
    ├── TourismOrdersWebApp.dpr
    ├── WebModuleUnit.pas
    └── WebModuleUnit.dfm
