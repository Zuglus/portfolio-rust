#!/bin/bash

echo "🚀 Настройка окружения для portfolio-rust..."

# Цвета для вывода
GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m'

# Проверка Rust
if ! command -v rustc &> /dev/null; then
    echo -e "${RED}❌ Rust не установлен${NC}"
    echo "Установите Rust с https://rustup.rs/"
    exit 1
fi

echo -e "${GREEN}✅ Rust установлен: $(rustc --version)${NC}"

# Установка необходимых компонентов
echo "📦 Установка необходимых компонентов..."

# Добавляем WASM target
rustup target add wasm32-unknown-unknown

# Устанавливаем Trunk для сборки
if ! command -v trunk &> /dev/null; then
    echo "📦 Установка Trunk..."
    cargo install trunk
fi

# Устанавливаем wasm-bindgen-cli
if ! command -v wasm-bindgen &> /dev/null; then
    echo "📦 Установка wasm-bindgen-cli..."
    cargo install wasm-bindgen-cli
fi

# Проверка Node.js для TailwindCSS
if ! command -v node &> /dev/null; then
    echo -e "${RED}❌ Node.js не установлен${NC}"
    echo "Установите Node.js для работы с TailwindCSS"
    exit 1
fi

echo -e "${GREEN}✅ Node.js установлен: $(node --version)${NC}"

# Установка зависимостей для TailwindCSS
if [ ! -f "package.json" ]; then
    echo "📦 Инициализация npm..."
    npm init -y
fi

echo "📦 Установка TailwindCSS..."
npm install -D tailwindcss

# Создание директорий
echo "📁 Создание структуры директорий..."
mkdir -p src style public scripts

# Компиляция стилей
echo "🎨 Компиляция стилей..."
npx tailwindcss -i ./style/main.scss -o ./style/output.css

echo -e "${GREEN}✅ Настройка завершена!${NC}"
echo "Запустите ./scripts/dev.sh для запуска dev-сервера"
