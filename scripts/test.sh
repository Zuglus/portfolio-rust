#!/bin/bash

echo "🧪 Тестирование проекта..."

# Цвета для вывода
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[0;33m'
NC='\033[0m'

ERRORS=0

# Проверка компиляции Rust кода
echo "🦀 Проверка компиляции Rust..."
if cargo check; then
    echo -e "${GREEN}✅ Rust код компилируется успешно${NC}"
else
    echo -e "${RED}❌ Ошибка компиляции Rust${NC}"
    ERRORS=$((ERRORS + 1))
fi

# Проверка WASM target
echo "🎯 Проверка WASM target..."
if cargo check --target wasm32-unknown-unknown; then
    echo -e "${GREEN}✅ WASM target проверен${NC}"
else
    echo -e "${RED}❌ Ошибка WASM target${NC}"
    ERRORS=$((ERRORS + 1))
fi

# Проверка структуры файлов
echo "📁 Проверка структуры проекта..."
REQUIRED_FILES=(
    "Cargo.toml"
    "index.html"
    "src/main.rs"
    "src/app.rs"
    "src/lib.rs"
    "style/main.scss"
    "tailwind.config.js"
)

for file in "${REQUIRED_FILES[@]}"; do
    if [ -f "$file" ]; then
        echo -e "${GREEN}✅ $file существует${NC}"
    else
        echo -e "${RED}❌ $file не найден${NC}"
        ERRORS=$((ERRORS + 1))
    fi
done

# Проверка TailwindCSS
echo "🎨 Проверка TailwindCSS..."
if npx tailwindcss -i ./style/main.scss -o ./style/output.css; then
    echo -e "${GREEN}✅ TailwindCSS работает корректно${NC}"
else
    echo -e "${RED}❌ Ошибка TailwindCSS${NC}"
    ERRORS=$((ERRORS + 1))
fi

# Итоговый результат
echo ""
if [ $ERRORS -eq 0 ]; then
    echo -e "${GREEN}🎉 Все тесты пройдены успешно!${NC}"
    exit 0
else
    echo -e "${RED}❌ Обнаружено ошибок: $ERRORS${NC}"
    exit 1
fi
