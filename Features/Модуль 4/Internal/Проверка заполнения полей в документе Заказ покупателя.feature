﻿#language: ru

@tree

Функционал: сценарий проверяет заполнение полей в документе Заказ покупателя


Контекст:
	Дано Я запускаю сценарий открытия TestClient или подключаю уже существующий

Сценарий: Проверка заполнения полей в документе Заказ покупателя
	# открываем форму создания нового документа "Заказ покупателя":
	Когда я открываю навигационную ссылку "e1cib/list/Document.SalesOrder"
	Тогда открылось окно "Заказы покупателей"
	И я нажимаю на кнопку с именем 'FormCreate'
	Тогда открылось окно "Заказ покупателя (создание)"
	#проверим первоначальное заполнение полей шапки документа:
	И я валидирую форму
		Тогда элемент формы с именем "Partner" стал равен ""
		И элемент формы с именем "LegalName" стал равен ""
		И элемент формы с именем "Agreement" стал равен ""
		И элемент формы с именем "Status" стал равен "Согласовано"
		И элемент формы с именем "Company" стал равен ""
		И элемент формы с именем "Store" стал равен ""
	#проверим, что поле "Контрагент" недоступно для редактирования при пустом значении поля "Партнер":
	Когда Проверяю шаги на Исключение:
        |'И в поле с именем "LegalName" я ввожу текст "ТЕСТ"'|
	#проверим заполнение связки полей "Партнер", "Соглашение", "Контрагент"

	#проверка заполнения полей "Соглашение", "Контрагент" при выборе в поле "Партнер" значения "Клиент 1":
	И я нажимаю кнопку выбора у поля с именем 'Partner'
	Тогда открылось окно "Партнеры"
	И в таблице 'List' я перехожу к строке:
		| 'Код' | 'Наименование'            |
		| '1'   | 'Клиент 1 (1 соглашение)' |
	И я нажимаю на кнопку с именем 'FormChoose'
	Тогда открылось окно "Заказ покупателя (создание) *"
	И элемент формы с именем "Agreement" стал равен 'Соглашение с клиентами (расчет по документам + кредитный лимит)'
	И элемент формы с именем "LegalName" стал равен 'Клиент 1'
	#проверим, что на форме списка "Соглашения" содержится только один элемент:
	И я нажимаю кнопку выбора у поля с именем 'Agreement'
	Тогда открылось окно "Соглашения"
	И таблица 'List' стала равной:
		| 'Код' | 'Наименование'                                                    | 'Вид'     | 'Вид взаиморасчетов' |
		| '1'   | 'Соглашение с клиентами (расчет по документам + кредитный лимит)' | 'Обычное' | 'По документам'      |
	И я закрываю окно "Соглашения"
	Тогда открылось окно "Заказ покупателя (создание) *"
	#проверим, что поле "Контрагент" доступно для редактирования и на форме списка "Организации" содержится только один элемент:
	И я нажимаю кнопку выбора у поля с именем 'LegalName'
	Тогда открылось окно "Организации"
	И таблица 'List' стала равной:
		| 'Код' | 'Наименование' |
		| '5'   | 'Клиент 1'     |
	И я закрываю окно "Организации"
	Тогда открылось окно "Заказ покупателя (создание) *"

	#проверка заполнения полей "Соглашение", "Контрагент" при выборе в поле "Партнер" значения "Клиент 2":
	И я нажимаю кнопку выбора у поля с именем 'Partner'
	Тогда открылось окно "Партнеры"
	И в таблице 'List' я перехожу к строке:
		| 'Код' | 'Наименование'            |
		| '2'   | 'Клиент 2 (2 соглашения)' |
	И я нажимаю на кнопку с именем 'FormChoose'
	Тогда открылось окно "Заказ покупателя (создание) *"
	И элемент формы с именем "Agreement" стал равен ''
	И элемент формы с именем "LegalName" стал равен 'Клиент 2'
	#проверим, что на форме списка "Соглашения" содержится 2 элемента:
	И я нажимаю кнопку выбора у поля с именем 'Agreement'
	Тогда открылось окно "Соглашения"
	И таблица 'List' стала равной:
		| 'Код' | 'Наименование'                                        | 'Вид'     | 'Вид взаиморасчетов' |
		| '2'   | 'Индивидуальное соглашение 1 (расчет по соглашениям)' | 'Обычное' | 'По соглашениям'     |
		| '3'   | 'Индивидуальное соглашение 2 (расчет по соглашениям)' | 'Обычное' | 'По соглашениям'     |
	#выберем элемент:
	И в таблице 'List' я перехожу к строке:
		| 'Код' | 'Наименование'                                        | 'Вид'     | 'Вид взаиморасчетов' |
		| '2'   | 'Индивидуальное соглашение 1 (расчет по соглашениям)' | 'Обычное' | 'По соглашениям'     |
	И я нажимаю на кнопку с именем 'FormChoose'
	Тогда открылось окно "Табличная часть товаров будет обновлена"
	И я нажимаю на кнопку 'ОК'
	Тогда открылось окно "Заказ покупателя (создание) *"
	И элемент формы с именем "Agreement" стал равен 'Индивидуальное соглашение 1 (расчет по соглашениям)'
	#проверим, что поле "Контрагент" доступно для редактирования и на форме списка "Организации" содержится только один элемент:
	И я нажимаю кнопку выбора у поля с именем 'LegalName'
	Тогда открылось окно "Организации"
	И таблица 'List' стала равной:
		| 'Код' | 'Наименование' |
		| '6'   | 'Клиент 2'     |
	И я закрываю окно "Организации"
	Тогда открылось окно "Заказ покупателя (создание) *"	
	
	#проверка заполнения полей "Соглашение", "Контрагент" при выборе в поле "Партнер" значения "Клиент и поставщик":
	И я нажимаю кнопку выбора у поля с именем 'Partner'
	Тогда открылось окно "Партнеры"
	И в таблице 'List' я перехожу к строке:
		| 'Код' | 'Наименование'       |
		| '5'   | 'Клиент и поставщик' |
	И я нажимаю на кнопку с именем 'FormChoose'
	Тогда открылось окно "Заказ покупателя (создание) *"
	И элемент формы с именем "Agreement" стал равен 'Соглашение с клиентами (расчет по документам + кредитный лимит)'
	И элемент формы с именем "LegalName" стал равен 'Клиент и поставщик'
	#проверим, что на форме списка "Соглашения" содержится только один элемент:
	И я нажимаю кнопку выбора у поля с именем 'Agreement'
	Тогда открылось окно "Соглашения"
	И таблица 'List' стала равной:
		| 'Код' | 'Наименование'                                                    | 'Вид'     | 'Вид взаиморасчетов' |
		| '1'   | 'Соглашение с клиентами (расчет по документам + кредитный лимит)' | 'Обычное' | 'По документам'      |
	И я закрываю окно "Соглашения"
	Тогда открылось окно "Заказ покупателя (создание) *"
	#проверим, что поле "Контрагент" доступно для редактирования и на форме списка "Организации" содержится только один элемент:
	И я нажимаю кнопку выбора у поля с именем 'LegalName'
	Тогда открылось окно "Организации"
	И таблица 'List' стала равной:
		| 'Код' | 'Наименование' 	   |
		| '7'   | 'Клиент и поставщик' |
	И я закрываю окно "Организации"
	Тогда открылось окно "Заказ покупателя (создание) *"	

	#проверка заполнения полей "Соглашение", "Контрагент" при выборе в поле "Партнер" значения "Розничный покупатель":
	И я нажимаю кнопку выбора у поля с именем 'Partner'
	Тогда открылось окно "Партнеры"
	И в таблице 'List' я перехожу к строке:
		| 'Код'  | 'Наименование'         |
		| '10'   | 'Розничный покупатель' |
	И я нажимаю на кнопку с именем 'FormChoose'
	Тогда открылось окно "Табличная часть товаров будет обновлена"
	И я нажимаю на кнопку 'ОК'
	Тогда открылось окно "Заказ покупателя (создание) *"
	И элемент формы с именем "Agreement" стал равен 'Розничное'
	И элемент формы с именем "LegalName" стал равен 'Розничный покупатель'
	#проверим, что на форме списка "Соглашения" содержится только один элемент:
	И я нажимаю кнопку выбора у поля с именем 'Agreement'
	Тогда открылось окно "Соглашения"
	И таблица 'List' стала равной:
		| 'Код' | 'Наименование' | 'Вид'     | 'Вид взаиморасчетов' |
		| '8'   | 'Розничное'    | 'Обычное' | 'По соглашениям'     |
	И я закрываю окно "Соглашения"
	Тогда открылось окно "Заказ покупателя (создание) *"
	#проверим, что поле "Контрагент" доступно для редактирования и на форме списка "Организации" содержится только один элемент:
	И я нажимаю кнопку выбора у поля с именем 'LegalName'
	Тогда открылось окно "Организации"
	И таблица 'List' стала равной:
		| 'Код' | 'Наименование'         |
		| '9'   | 'Розничный покупатель' |
	И я закрываю окно "Организации"
	Тогда открылось окно "Заказ покупателя (создание) *"	

	#проверка заполнения полей "Соглашение", "Контрагент" при выборе в поле "Партнер" значения "Розничный клиент 1":
	И я нажимаю кнопку выбора у поля с именем 'Partner'
	Тогда открылось окно "Партнеры"
	И в таблице 'List' я перехожу к строке:
		| 'Код'  | 'Наименование'       |
		| '12'   | 'Розничный клиент 1' |
	И я нажимаю на кнопку с именем 'FormChoose'
	Тогда открылось окно "Заказ покупателя (создание) *"
	И элемент формы с именем "Agreement" стал равен 'Розничный клиент 1'
	И элемент формы с именем "LegalName" стал равен 'Розничный клиент 1'
	#проверим, что на форме списка "Соглашения" содержится только один элемент:
	И я нажимаю кнопку выбора у поля с именем 'Agreement'
	Тогда открылось окно "Соглашения"
	И таблица 'List' стала равной:
		| 'Код' | 'Наименование'        | 'Вид'     | 'Вид взаиморасчетов' |
		| '9'   | 'Розничный клиент 1'  | 'Обычное' | 'По соглашениям'     |
	И я закрываю окно "Соглашения"
	Тогда открылось окно "Заказ покупателя (создание) *"
	#проверим, что поле "Контрагент" доступно для редактирования и на форме списка "Организации" содержится только один элемент:
	И я нажимаю кнопку выбора у поля с именем 'LegalName'
	Тогда открылось окно "Организации"
	И таблица 'List' стала равной:
		| 'Код' | 'Наименование' 	   |
		| '10'  | 'Розничный клиент 1' |
	И я закрываю окно "Организации"
	Тогда открылось окно "Заказ покупателя (создание) *"	
	И я нажимаю на кнопку с именем 'FormPostAndClose'
	И я жду закрытия окна "Заказ покупателя * от *" в течение 20 секунд
	Тогда открылось окно "Заказы покупателей"
	И таблица 'List' содержит строки:
		| "Завершен" | "Партнер"            | "Автор" |
		| "Нет"      | "Розничный клиент 1" | "CI"    |
	И я закрываю сеанс текущего клиента тестирования