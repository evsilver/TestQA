﻿#language: ru

@tree

Функционал: сценарий проверяет создание документа Расход товара


Контекст:
	Дано Я запускаю сценарий открытия TestClient или подключаю уже существующий

Сценарий: Проведение документа Расход товара
	# открываем форму создания нового документа "Расход товара":
	Когда я открываю навигационную ссылку "e1cib/list/ЖурналДокументов.ДокументыПродаж"
	Тогда открылось окно "Документы продаж"
	И я нажимаю на кнопку с именем 'ФормаСоздатьПоПараметруРасходТовара'
	Тогда открылось окно "Продажа товара (создание)"
	#проверим, что нельзя провести документ с незаполненными полями:
	И я нажимаю на кнопку с именем 'ФормаПровестиИЗакрыть'
	Тогда в логе сообщений TestClient есть строки:
		| 'Не указан Покупатель, для которого выписывается накладная!' |
		| 'Поле "Склад" не заполнено' |
		| 'Поле "Вид цен" не заполнено' |
		| 'Поле "Организация" не заполнено' |
		| 'Не введено ни одной строки в список "Товары"' |
	#заполняем поля документа и проводим его:	 
	И из выпадающего списка с именем 'Организация' я выбираю точное значение 'ООО "Все для дома"'
	И я нажимаю кнопку выбора у поля с именем 'Покупатель'
	Тогда открылось окно "Контрагенты"
	И я нажимаю на кнопку с именем 'ФормаСписок'
	И в таблице 'Список' я перехожу к строке:
		| 'Код'	      | 'Наименование' |
		| '000000010' | 'Корнет ЗАО'   |
	И я нажимаю на кнопку с именем 'ФормаВыбрать'
	Тогда открылось окно "Продажа товара (создание) *"
	И из выпадающего списка с именем 'Склад' я выбираю точное значение "Малый"
	И из выпадающего списка с именем 'Валюта' я выбираю точное значение "Рубли"
	И в таблице 'Товары' я нажимаю на кнопку с именем 'ТоварыДобавить'
	И в таблице 'Товары' я нажимаю кнопку выбора у реквизита с именем 'ТоварыТовар'
	Тогда открылось окно "Товары"
	И в таблице 'Список' я перехожу к строке:
		| 'Код'	   	  | 'Наименование'   |
		| '000000106' | 'ТестовыйТовар1' |
	И я нажимаю на кнопку с именем 'ФормаВыбрать'
	Тогда открылось окно "Продажа товара (создание) *"
	И в таблице 'Товары' я завершаю редактирование строки
	И я перехожу к закладке с именем 'Прочее'
	И в поле с именем 'ОбоснованиеОтгрузки' я ввожу текст "тест"
	И я нажимаю на кнопку с именем 'ФормаЗаписать'
	#запомним дату и номер в переменные для последующей проверки появления документа на форме списка "Документы продаж":
	И я нажимаю на кнопку с именем 'ФормаПровести'
	Тогда открылось окно "Продажа * от *"	
	И я запоминаю значение поля "Номер" как "НомерДокаРасходТовара"
	И я запоминаю значение поля "Дата" как "ДатаДокаРасходТовара"
	И я закрываю окно "Продажа * от *"	
	Тогда открылось окно "Документы продаж"
	И таблица 'Список' содержит строки:
		| 'Дата'                   | 'Номер'     			   | 'Тип документа' | 'Покупатель' | 'Склад' | 'Валюта' | 'Вид цен'    | 'Организация'  		 | 'Состояние заказа' |
		| '$ДатаДокаРасходТовара$' | '$НомерДокаРасходТовара$' | 'Продажа'       | 'Корнет ЗАО'	| 'Малый' | 'Рубли'  | 'Закупочная' | 'ООО "Все для дома"' | ''                 |
	И я закрываю сеанс текущего клиента тестирования