#!/bin/bash

echo "🏗️ Сборка проекта с современными оптимизациями..."

# Цвета для вывода
GREEN='\033[0;32m'
RED='\033[0;31m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m'

# Компиляция стилей с оптимизацией для продакшена
echo -e "${BLUE}🎨 Компиляция стилей с оптимизацией...${NC}"
npx tailwindcss -i ./style/main.scss -o ./style/output.css --minify

# Проверка оптимизированного CSS
if [ -f "./style/output.css" ]; then
    CSS_SIZE=$(du -h "./style/output.css" | cut -f1)
    echo -e "${GREEN}✅ CSS оптимизирован: ${CSS_SIZE}${NC}"
else
    echo -e "${RED}❌ Ошибка компиляции CSS${NC}"
    exit 1
fi

# Сборка через Trunk с оптимизациями
echo -e "${BLUE}📦 Сборка WASM приложения с оптимизациями...${NC}"
RUSTFLAGS="--cfg=erase_components" trunk build --release

# Проверка результата
if [ -d "dist" ]; then
    echo -e "${GREEN}✅ Сборка успешно завершена!${NC}"
    echo "📁 Файлы находятся в директории dist/"
    
    # Показываем размеры файлов с анализом
    echo -e "${BLUE}📊 Анализ размеров файлов:${NC}"
    find dist -type f -name "*.wasm" -exec ls -lh {} \; 2>/dev/null | awk '{print "🦀 WASM:", $5, $9}' || true
    find dist -type f -name "*.css" -exec ls -lh {} \; 2>/dev/null | awk '{print "🎨 CSS: ", $5, $9}' || true
    find dist -type f -name "*.js" -exec ls -lh {} \; 2>/dev/null | awk '{print "📜 JS:  ", $5, $9}' || true
    
    # Общий размер
    TOTAL_SIZE=$(du -sh dist | cut -f1)
    echo -e "${YELLOW}📦 Общий размер: ${TOTAL_SIZE}${NC}"
    
else
    echo -e "${RED}❌ Ошибка сборки${NC}"
    exit 1
fi
