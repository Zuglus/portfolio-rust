#!/bin/bash

echo "🏗️ Сборка проекта..."

# Цвета для вывода
GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m'

# Компиляция стилей
echo "🎨 Компиляция стилей..."
npx tailwindcss -i ./style/main.scss -o ./style/output.css --minify

# Сборка через Trunk
echo "📦 Сборка WASM приложения..."
trunk build --release

# Проверка результата
if [ -d "dist" ]; then
    echo -e "${GREEN}✅ Сборка успешно завершена!${NC}"
    echo "📁 Файлы находятся в директории dist/"
    
    # Показываем размеры файлов
    echo "📊 Размеры файлов:"
    find dist -type f -exec ls -lh {} \; | awk '{print $5, $9}'
else
    echo -e "${RED}❌ Ошибка сборки${NC}"
    exit 1
fi
