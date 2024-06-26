﻿#language: ru

@tree

Функционал: сценарий проверяет добавление картинки по элементам справочника Товары


Контекст:
	Дано Я запускаю сценарий открытия TestClient или подключаю уже существующий

Сценарий: Добавление картинки на форму элемента справочника Товары
	# открываем форму создания нового элемента справочника "Товары":
	Когда я открываю навигационную ссылку "e1cib/list/Справочник.Товары"
	Тогда открылось окно "Товары"
	И я нажимаю на кнопку с именем 'ФормаСоздать'
	Тогда открылось окно "Товар (создание)"
	#Проверим, что до записи элемента выбрать картинку нельзя:
	И я нажимаю кнопку выбора у поля с именем 'ФайлКартинки'
	Тогда открылось окно "1С:Предприятие"
	И элемент формы с именем 'Message' стал равен 'Данные не записаны'
	И я нажимаю на кнопку 'OK'
	Тогда открылось окно "Товар (создание)"
	#заполняем поля и записываем новый элемент
	И в поле с именем 'Наименование' я ввожу текст "ТестовыйТовар"
	И в поле с именем 'Артикул' я ввожу текст "Арт-тест1"
	И я нажимаю кнопку выбора у поля с именем 'Поставщик'
	Тогда открылось окно "Контрагенты"
	И я нажимаю на кнопку с именем 'ФормаСписок'
	И в таблице 'Список' я перехожу к строке:
		| 'Код'       | 'Наименование'        |
		| '000000009' | 'Животноводство ООО ' |
	И я нажимаю на кнопку с именем 'ФормаВыбрать'
	Тогда открылось окно "Товар (создание) *"
	И в поле с именем 'ВТ_Вес' я ввожу текст "123,000"
	И в поле с именем 'ШтрихКод' я ввожу текст "ШТК-тест"
	И я нажимаю на кнопку с именем 'ФормаЗаписать'
	Тогда открылось окно "ТестовыйТовар (Товар)"
	#запомним код файла в переменную для того, чтобы проверить в конце прохождения теста появление элемента на форме списка "Товары":
	И я запоминаю значение поля с именем "Код" как "КодТовара"
	#повторно пытаемся добавить картинку:
	И я нажимаю кнопку выбора у поля с именем 'ФайлКартинки'
	Тогда открылось окно "Файлы"
	И я нажимаю на кнопку с именем 'ФормаСоздать'
	Тогда открылось окно "Файл (создание)"
	И в поле с именем 'Наименование' я ввожу текст "ТестовыйФайл"
	И я выбираю файл "$КаталогПроекта$\Features\Финальные задания\External\ТестКартинка.png"
	И я нажимаю на кнопку с именем 'ВыбратьФайлСДискаИЗаписать'
	Тогда открылось окно "ТестовыйФайл (Файл)"
	И элемент формы с именем "ИмяФайла" стал равен "ТестКартинка.png"
	#запомним код файла в переменную для того, чтобы при повторном прохождении теста всегда выбирался новый файл:
	И я запоминаю значение поля с именем "Код" как "КодФайла"
	И я нажимаю на кнопку с именем 'ФормаЗаписатьИЗакрыть'
	И я жду закрытия окна "ТестовыйФайл (Файл)" в течение 20 секунд
	Тогда открылось окно "Файлы"
	И в таблице 'Список' я перехожу к строке:
		| 'Код'        | 'Наименование' |
		| '$КодФайла$' | 'ТестовыйФайл' |
	И в таблице 'Список' я выбираю текущую строку
	#проверим, что картинка добавлена:
	И элемент формы с именем 'ФайлКартинки' стал равен 'ТестовыйФайл'
	И я нажимаю на кнопку с именем 'ФормаЗаписатьИЗакрыть'
	И я жду закрытия окна "ТестовыйТовар (Товар) *" в течение 20 секунд
	Тогда открылось окно "Товары"
	И таблица 'Список' содержит строки:
		| 'Код'         | 'Наименование'  |
		| '$КодТовара$' | 'ТестовыйТовар' |
	И я закрываю сеанс текущего клиента тестирования