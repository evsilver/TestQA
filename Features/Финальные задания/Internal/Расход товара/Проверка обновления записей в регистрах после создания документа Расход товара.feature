﻿#language: ru

@tree

Функционал: сценарий проверяет обновление записей в регистрах
в регистре взаиморасчетов с контрагентами, регистре продаж, регистре товарных запасов
документа Расход товара


Контекст:
	Дано Я запускаю сценарий открытия TestClient или подключаю уже существующий
	И Я создаю документ Расход товара

Сценарий: Обновление записей в регистрах документа Расход товара
	# открываем созданный в экспортном сценарии документ "Расход товара":
	Когда я открываю навигационную ссылку "$СсылкаНаДокументРасходТовара$"
	Тогда открылось окно "Продажа * от *"
	И я запоминаю значение поля "Номер" как "НомерДокаРасходТовара"
	#меняем данные в ТЧ:
	И в таблице 'Товары' я нажимаю на кнопку с именем 'ТоварыДобавить'
	И в таблице 'Товары' я нажимаю кнопку выбора у реквизита с именем 'ТоварыТовар'
	Тогда открылось окно "Товары"
	И в таблице 'Список' я перехожу к строке:
		| 'Код'	   	  | 'Наименование'   |
		| '000000107' | 'ТестовыйТовар2' |
	И я нажимаю на кнопку с именем 'ФормаВыбрать'
	Тогда открылось окно "Продажа * от * *"
	И в таблице 'Товары' я завершаю редактирование строки
	Тогда таблица 'Товары' стала равной:
		| 'N' | 'Товар'          | 'Цена'     | 'Количество' | 'Сумма'    |
		| '1' | 'ТестовыйТовар1' | '7 000,00' | '1,00'       | '7 000,00' |
		| '2' | 'ТестовыйТовар2' | '2 345,00' | '1,00'       | '2 345,00' |
	И элемент формы 'Количество (итог)' стал равен '2'
	И элемент формы 'Сумма (итог)' стал равен '9 345'
	И в таблице 'Товары' я перехожу к строке:
		| 'N' | 'Количество' | 'Сумма'    | 'Товар'    		 | 'Цена'     |
		| '1' | '1,00'       | '7 000,00' | 'ТестовыйТовар1' | '7 000,00' |
	И в таблице 'Товары' в поле с именем 'ТоварыКоличество' я ввожу текст "2,00"
	И в таблице 'Товары' я завершаю редактирование строки
	И элемент формы 'Количество (итог)' стал равен '3'
	И элемент формы 'Сумма (итог)' стал равен '16 345'
	И я нажимаю на кнопку с именем 'ФормаЗаписать'
	И я запоминаю значение поля "Дата" как "ДатаДокаРасходТовара"
	#проверяем изменения в регистрах:
	И В текущем окне я нажимаю кнопку командного интерфейса "Регистр взаиморасчетов с контрагентами"
	Тогда таблица "Список" стала равной:
		| 'Период'                 | 'Регистратор'                              				 | 'Номер строки' | 'Контрагент' | 'Сумма'     | 'Валюта' |
		| '$ДатаДокаРасходТовара$' | 'Продажа $НомерДокаРасходТовара$ от $ДатаДокаРасходТовара$' | '1'            | 'Корнет ЗАО' | '16 345,00' | 'Рубли'  |
	И В текущем окне я нажимаю кнопку командного интерфейса "Регистр продаж"
	Тогда таблица "Список" стала равной:
		| 'Период'                 | 'Регистратор'                              				 | 'Номер строки' | 'Покупатель' | 'Товар'     		| 'Количество' | 'Сумма'     |
		| '$ДатаДокаРасходТовара$' | 'Продажа $НомерДокаРасходТовара$ от $ДатаДокаРасходТовара$' | '1'            | 'Корнет ЗАО' | 'ТестовыйТовар1' | '2,00'       | '14 000,00' |
		| '$ДатаДокаРасходТовара$' | 'Продажа $НомерДокаРасходТовара$ от $ДатаДокаРасходТовара$' | '2'            | 'Корнет ЗАО' | 'ТестовыйТовар2' | '1,00'       | '2 345,00'  |
	И В текущем окне я нажимаю кнопку командного интерфейса "Регистр товарных запасов"
	Тогда таблица "Список" стала равной:
		| 'Период'                 | 'Регистратор'                              			     | 'Номер строки' | 'Товар'          | 'Склад'   | 'Количество' |
		| '$ДатаДокаРасходТовара$' | 'Продажа $НомерДокаРасходТовара$ от $ДатаДокаРасходТовара$' | '1'            | 'ТестовыйТовар1' | 	'Малый'	 | '2,00'       |
		| '$ДатаДокаРасходТовара$' | 'Продажа $НомерДокаРасходТовара$ от $ДатаДокаРасходТовара$' | '2'            | 'ТестовыйТовар2' | 	'Малый'	 | '1,00'       |
	#проверим добавление товара, которого больше нет на складе:
	И В текущем окне я нажимаю кнопку командного интерфейса "Основное"
	И в таблице 'Товары' я перехожу к строке:
		| 'N' | 'Количество' | 'Сумма'    | 'Товар'    		 | 'Цена'     |
		| '2' | '1,00'       | '2 345,00' | 'ТестовыйТовар2' | '2 345,00' |
	И в таблице 'Товары' в поле с именем 'ТоварыКоличество' я ввожу текст "2,00"
	И в таблице 'Товары' я завершаю редактирование строки
	И я нажимаю на кнопку с именем 'ФормаПровести'
	Тогда открылось окно "1С:Предприятие"
	И элемент формы с именем 'ErrorInfo' стал равен по шаблону 'Не удалось провести "Продажа $НомерДокаРасходТовара$ от *"!'
	И я нажимаю на кнопку "OK"
	Тогда открылось окно "Продажа * от * *"
	И в логе сообщений TestClient есть строки:
		| 'Не хватает 1 единиц товара"ТестовыйТовар2" на складе"Малый".Максимальное количество: 1.' |
	#возвращаем товар на склад для повторного прохождения теста путем отмены проведения документа:
	И я закрываю окно "Продажа * от * *"
	И я нажимаю на кнопку 'Нет'
	И я открываю навигационную ссылку "e1cib/list/ЖурналДокументов.ДокументыПродаж"
	Тогда открылось окно "Документы продаж"
	И в таблице 'Список' я перехожу к строке:
		| 'Дата'                   | 'Номер'     			   | 'Тип документа' | 'Покупатель' | 'Склад' | 'Валюта' | 'Вид цен'    | 'Организация'  	   | 'Состояние заказа' |
		| '$ДатаДокаРасходТовара$' | '$НомерДокаРасходТовара$' | 'Продажа'       | 'Корнет ЗАО'	| 'Малый' | 'Рубли'  | 'Закупочная' | 'ООО "Все для дома"' | ''                 |
	И я выбираю пункт контекстного меню с именем 'СписокКонтекстноеМенюОтменаПроведения' на элементе формы с именем 'Список'
	И я закрываю сеанс текущего клиента тестирования