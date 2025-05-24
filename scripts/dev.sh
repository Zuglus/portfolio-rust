#!/bin/bash

echo "🚀 Запуск dev-сервера с современными оптимизациями..."

# Цвета для вывода
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m'

# Запускаем TailwindCSS в режиме watch в фоне
echo -e "${BLUE}🎨 Запуск TailwindCSS watcher с JIT...${NC}"
npx tailwindcss -i ./style/main.scss -o ./style/output.css --watch &
TAILWIND_PID=$!

# Функция для очистки при выходе
cleanup() {
    echo -e "${YELLOW}🛑 Остановка процессов...${NC}"
    kill $TAILWIND_PID 2>/dev/null
    exit 0
}

# Перехватываем сигналы для корректного завершения
trap cleanup INT TERM

# Настройка переменных для оптимизации dev-режима
export RUSTFLAGS="--cfg=erase_components"

echo -e "${GREEN}⚡ Включены оптимизации для dev-режима:${NC}"
echo "   • erase_components для быстрой компиляции"
echo "   • TailwindCSS JIT режим"
echo "   • Hot reload для стилей"

# Запускаем Trunk dev-сервер с оптимизациями
echo -e "${BLUE}🦀 Запуск Trunk dev-сервера...${NC}"
trunk serve --open

# Очистка после завершения
cleanup
