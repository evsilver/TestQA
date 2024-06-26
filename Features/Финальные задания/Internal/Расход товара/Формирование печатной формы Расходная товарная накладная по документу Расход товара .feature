﻿#language: ru

@tree

Функционал: сценарий проверяет формирование печатной формы Расходная товарная накладная документа Расход товара
и создание записи в регистре Регистр взаиморасчетов с контрагентами


Контекст:
	Дано Я запускаю сценарий открытия TestClient или подключаю уже существующий
	И Я создаю документ Расход товара

Сценарий: Создание документа Поступление денег на основании документа Расход товара
	# открываем созданный в экспортном сценарии документ "Расход товара":
	Когда я открываю навигационную ссылку "$СсылкаНаДокументРасходТовара$"
	Тогда открылось окно "Продажа * от *"
	И я запоминаю значение поля "Номер" как "НомерДокаРасходТовара"
	И я запоминаю значение поля "Дата" как "ДатаДокаРасходТовара"
	# проверим формирование ПФ через форму документа:
	И я нажимаю на кнопку с именем 'ФормаДокументРасходТовараПечатьРасходнойНакладной'
	Тогда открылось окно "Таблица"
	И табличный документ 'SpreadsheetDocument' равен по шаблону:
		| 'Расход товара'  | ''                                 | ''           | ''      |
		| ''               | ''                                 | ''           | ''      |
		| 'Номер'          | '$НомерДокаРасходТовара$'          | ''           | ''      |
		| 'Дата'           | '*'              					| ''           | ''      |
		| 'Покупатель'     | 'Корнет ЗАО'                       | ''           | ''      |
		| 'Склад'          | 'Малый'                            | ''           | ''      |
		| 'Сумма'          | '7 000 рублей (Семь тысяч рублей)' | ''           | ''      |
		| 'Вес'            | '123'                              | ''           | ''      |
		| ''               | ''                                 | ''           | ''      |
		| 'Товар'          | 'Цена'                             | 'Количество' | 'Сумма' |
		| 'ТестовыйТовар1' | '7 000'                            | '1'          | '7 000' |	
	И я закрываю сеанс текущего клиента тестирования