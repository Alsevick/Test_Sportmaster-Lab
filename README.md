# Test_Sportmaster-Lab
- Исходные данные:

Есть ученики, они могут найтись сами (сарафанное радио), могут найтись через сервисы.

Во втором варианте задана комиссия в виде "сколько платежей отдать сервису" (пример: сервис нашел ученика, и просит, чтобы первые 3 занятия была оплата сервису, а только с 4ого она пойдет репетитору).

У репетитора есть услуги-курсы, которые стоят по-разному (Примеры: подготовка к ЕГЭ 11 класс - 2000, математика 6 кл Петерсон - 1700, математика 6 кл. обычная - 1500).

Репетитор оформлен как самозанятый (налог 4% от доходов). Налоги платит сам ежемесячно перечисляя сумму в налоговую.

- Задачи:

1. Построить модель данных и реализовать API для редактирования справочников.

2. Составить расписание на неделю + редактирование его через API.

*3. Реализовать расчет доходов, налогов, платежей сервисам поиска учеников.

Структура файлов: 
table.sql - Файл с кодом осздания таблиц
API.sql  -Файл с кодом пакета API
test_data.sql - Файл с кодом для заливки тестовых данных
profit.sql - Файл с кодомпакета Profit (Доп. задание)
