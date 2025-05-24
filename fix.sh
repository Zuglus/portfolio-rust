#!/bin/bash

echo "🔧 Добавление PartialEq для типов"

# Обновляем типы с добавлением PartialEq
cat > src/shared/types/mod.rs << 'EOF'
pub type Id = String;

#[derive(Clone, Debug, PartialEq)]
pub struct PortfolioItem {
    pub id: Id,
    pub image: String,
    pub alt: String,
}

#[derive(Clone, Debug, PartialEq)]
pub struct Experience {
    pub year: String,
    pub company: String,
    pub position: String,
    pub duties: Vec<String>,
    pub circle_image: Option<String>,
}

#[derive(Clone, Debug, PartialEq)]
pub struct Project {
    pub id: Id,
    pub title: String,
    pub description: String,
    pub audience: String,
    pub slides: Vec<Slide>,
}

#[derive(Clone, Debug, PartialEq)]
pub struct Slide {
    pub image: String,
    pub task: Option<String>,
    pub solution: Option<String>,
}
EOF

echo "🧪 Тестирование с PartialEq..."
./scripts/test.sh || { echo "❌ Тесты не прошли"; exit 1; }

echo "🏗️ Пересборка проекта..."
./scripts/build.sh || { echo "❌ Сборка не удалась"; exit 1; }

echo "✅ PartialEq добавлен для всех типов"
echo "🎯 Слайдер компилируется без ошибок"

# Git checkpoint
git add .
git commit -m "fix: add PartialEq derive for all types

- Добавлен PartialEq для Project, Slide, Experience, PortfolioItem
- Исправлена ошибка компиляции create_memo
- Все типы теперь поддерживают сравнение"

echo "📝 Исправления зафиксированы в git"
echo "🚀 Этап 7 готов - слайдер функционален"