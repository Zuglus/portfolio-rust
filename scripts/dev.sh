#!/bin/bash

echo "🚀 Запуск dev-сервера..."

# Запускаем TailwindCSS в режиме watch в фоне
echo "🎨 Запуск TailwindCSS watcher..."
npx tailwindcss -i ./style/main.scss -o ./style/output.css --watch &
TAILWIND_PID=$!

# Функция для очистки при выходе
cleanup() {
    echo "🛑 Остановка процессов..."
    kill $TAILWIND_PID 2>/dev/null
    exit 0
}

# Перехватываем сигналы для корректного завершения
trap cleanup INT TERM

# Запускаем Trunk dev-сервер
echo "🦀 Запуск Trunk dev-сервера..."
trunk serve --open

# Очистка после завершения
cleanup
