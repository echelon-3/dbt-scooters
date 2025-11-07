# dbt_scooters

## Краткое описание

- **Назначение:** dbt-проект для трансформации и моделирования данных телеметрии/аренды самокатов.  
- **Архитектура:** примеры моделей, источников (staging), marts (analytics), тесты качества данных и документация.  
- **Цель:** централизовать ELT-логику, обеспечить повторяемые и тестируемые преобразования для downstream-аналитики.

***

### Окружение и менеджер пакетов

- **Менеджер пакетов:** uv  
- **Python:** используйте виртуальное окружение (рекомендуется) и uv для управления зависимостями и запусков.

***

### Структура проекта (важные папки)

- `models/` — модели dbt (staging, marts и проч.)  
- `macros/` — макросы dbt  
- `seeds/` — CSV-файлы для загрузки как таблиц  
- `snapshots/` — снапшоты для исторических данных  
- `tests/` — кастомные тесты (если есть)  
- `patches/` или `analyses/` — дополнительные артефакты  
- `profiles.yml` — конфигурация подключения (не включается в репозиторий)

***

### Быстрая настройка (локально)

1. Создать виртуальное окружение (рекомендуется):  
   ```bash
   python -m venv .venv
   source .venv/bin/activate   # Linux/macOS
   .venv\Scripts\activate      # Windows
   ```

2. Установить зависимости через uv:  
   ```bash
   uv install
   ```
   *(или используйте uv.lock / uv.toml, если они есть)*

3. Настроить `profiles.yml`:  
   ```bash
   cp profiles.yml.example ~/.dbt/profiles.yml
   ```
   Заполнить поля подключения к базе данных.

4. Активируйте PostGIS в базе PostgreSQL, если еще этого не делали:

```sql
create extension postgis schema public;
```

***

### Основные команды dbt

- `dbt debug` - проверка подключения к хранилищу данных (проверка профиля)
- `dbt parse` - парсинг файлов проекта (проверка корректности)
- `dbt compile` - компилирует dbt-модели и создает SQL-файлы
- `dbt run` - материализация моделей в таблицы и представления
- `dbt test` - запускает тесты для проверки качества данных
- `dbt seed` - загружает данные в таблицы из CSV-файлов
- `dbt build` - основная команда, комбинирует run, test и seed
- `dbt source freshness` - проверка актуальности данных в источниках
- `dbt docs generate` - генерирует документацию проекта
- `dbt docs serve` - запускает локальный сервер для просмотра документации


### Короткая шпаргалка по dbt-командам

**Инициализация проекта:**
```bash
dbt init dbt_scooters
```

**Компиляция моделей (без выполнения):**
```bash
dbt compile
```

**Выполнение моделей:**
```bash
dbt run
dbt run --models +mymodel
dbt run --models mymodel+
dbt run --models tag:staging
```

**Тестирование:**
```bash
dbt test
dbt test --models mymodel
```

**Документация:**
```bash
dbt docs generate
dbt docs serve
```

**Просмотр DAG / зависимостей:**
```bash
dbt ls --select state:modified
dbt graph
dbt ls --models --output graph
```

**Очистка / удаление моделей:**
```bash
dbt run-operation delete
dbt clean
```

**Seeds (CSV из seeds/):**
```bash
dbt seed
dbt seed --select my_seed
```

***

### Полезные флаги и селекторы

- `--models` / `-m`: выбор моделей по имени, тегу или селекторам (`tag:core`, `path:models/staging/*`, `+model`)  
- `--profiles-dir`: указать альтернативную папку с `profiles.yml`  
- `--target`: выбрать `target` из `profiles.yml` (например, `--target prod`)  
- `--threads`: задать параллельность (например, `--threads 8`)

***

### Рекомендации по рабочему процессу

- Разбивайте модели на `staging → intermediate → marts` для читаемости и переиспользования.  
- Добавляйте тесты (`unique`, `not_null`, `relationships`) для критичных полей.  
- Документируйте модели и поля в `schema.yml` для генерации dbt docs.  
- Используйте `source()` для обозначения внешних таблиц и тестируйте источники.  
- Не храните `credentials` или `profiles.yml` в репозитории.

***

### Примеры полезных команд для повседневной работы

**Запуск всех новых или модифицированных моделей:**
```bash
dbt run --models state:modified
```

**Локальная отладка одной модели:**
```bash
dbt run --models mymodel --full-refresh
```

**Запуск тестов для изменённых моделей:**
```bash
dbt test --models state:modified
```

### Полезные макросы

- `dbt run-operation create_role --args "name: finance"` - создание роли в базе (на примере роли "finance")