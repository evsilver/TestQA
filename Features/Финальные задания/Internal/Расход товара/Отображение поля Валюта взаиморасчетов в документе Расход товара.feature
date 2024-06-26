﻿#language: ru

@tree

Функционал: сценарий проверяет отображение поля Валюта взаиморасчетов в документе Расход товара


Контекст:
	Дано Я запускаю сценарий открытия TestClient или подключаю уже существующий

Сценарий: Отображение поля Валюта взаиморасчетов в документе Расход товара
	# открываем форму создания нового документа "Расход товара":
	Когда я открываю навигационную ссылку "e1cib/list/ЖурналДокументов.ДокументыПродаж"
	Тогда открылось окно "Документы продаж"
	И я нажимаю на кнопку с именем 'ФормаСоздатьПоПараметруРасходТовара'
	Тогда открылось окно "Продажа товара (создание)"
	# проверим, что поле "Валюта взаиморасчетов" отображается на форме при указании организаций ООО "Все для дома" и ООО "Товары":
	И из выпадающего списка с именем 'Организация' я выбираю точное значение 'ООО "Все для дома"'
	И элемент формы с именем 'Валюта' присутствует на форме
	И из выпадающего списка с именем 'Организация' я выбираю точное значение 'ООО "Товары"'
	И элемент формы с именем 'Валюта' присутствует на форме
	#проверим редактирование поля:
	И из выпадающего списка с именем 'Валюта' я выбираю точное значение "Рубли"
	И элемент формы с именем 'Валюта' стал равен "Рубли"
	# проверим, что поле "Валюта взаиморасчетов" не отображается на форме при указании организации ООО "1000 мелочей":
	И из выпадающего списка с именем 'Организация' я выбираю точное значение 'ООО "1000 мелочей"'
	И элемент формы с именем 'Валюта' отсутствует на форме	
	И я закрываю сеанс текущего клиента тестирования 