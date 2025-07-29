
# 📄 SVG to PDF Generator API

Этот проект реализует REST API на Ruby on Rails для генерации PDF документов из SVG файлов.  
В сгенерированный PDF добавляется водяной знак (watermark).

---

## 🚀 Возможности

- 🔄 Загрузка SVG-файла через API
- 📄 Генерация PDF с водяным знаком (имя: `Timur Karimov`)
- 📥 Скачивание PDF по ссылке
- 🧪 Покрытие тестами (RSpec, Rswag)
- 📚 Swagger-документация (OpenAPI)
- 🌐 Минимальный веб-интерфейс для загрузки файла

---

## 📦 Установка

```bash
bundle install
rails db:create db:migrate
```

---

## ▶️ Запуск

```bash
rails server
```

Открой [http://localhost:3000](http://localhost:3000) для загрузки SVG через веб-форму.  
Swagger-документация доступна по адресу: [http://localhost:3000/api-docs](http://localhost:3000/api-docs)

---

## 🧪 Тестирование

```bash
bundle exec rspec
```

Для запуска Rswag-интеграционных тестов и генерации документации:

```bash
bundle exec rake rswag:specs:swaggerize
```

---

## 📁 Структура

| Компонент               | Назначение                               |
|------------------------|------------------------------------------|
| `PdfGenerator`         | Сервис для генерации PDF из SVG          |
| `Document`             | ActiveRecord модель с PDF attachment     |
| `DocumentsController`  | API контроллер для загрузки и генерации  |
| `DocumentSerializer`   | Сериалайзер для ответа API               |
| `spec/`                | Тесты (unit и интеграционные)            |
| `public/form.html`     | Простая HTML-форма для загрузки файла    |

---

## ✅ Выполненные задачи

- ✅ Сервис генерации PDF
- ✅ REST API
- ✅ Сериализация JSON
- ✅ Веб-интерфейс
- ✅ Тестирование (RSpec + Rswag)
- ✅ Swagger документация

---

## ✍️ Автор

**Timur Karimov**
