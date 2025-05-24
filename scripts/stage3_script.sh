#!/bin/bash

echo "🏗️ ЭТАП 3: Создание статических компонентов с заглушками"
echo "============================================================"

# Цвета для вывода
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
NC='\033[0m'

# Проверка, что мы в правильной директории
if [ ! -f "Cargo.toml" ]; then
    echo "❌ Запустите скрипт из корня проекта portfolio-rust"
    exit 1
fi

echo -e "${BLUE}📁 Создание структуры директорий...${NC}"

# Создаем недостающие директории
mkdir -p src/entities
mkdir -p src/shared/data
mkdir -p src/widgets

echo -e "${YELLOW}📝 Создание mock данных...${NC}"

# Создаем файл с mock данными
cat > src/shared/data/mod.rs << 'EOF'
use crate::shared::types::{PortfolioItem, Experience};

pub fn get_portfolio_mock_data() -> Vec<PortfolioItem> {
    vec![
        PortfolioItem {
            id: "project1".to_string(),
            image: "/mock-project1.jpg".to_string(),
            alt: "НИТИ".to_string(),
        },
        PortfolioItem {
            id: "project2".to_string(),
            image: "/mock-project2.jpg".to_string(),
            alt: "КОДИИМ".to_string(),
        },
        PortfolioItem {
            id: "project3".to_string(),
            image: "/mock-project3.jpg".to_string(),
            alt: "День физики".to_string(),
        },
        PortfolioItem {
            id: "project4".to_string(),
            image: "/mock-project4.jpg".to_string(),
            alt: "Дизайн презентаций".to_string(),
        },
    ]
}

pub fn get_experience_mock_data() -> Vec<Experience> {
    vec![
        Experience {
            year: "2023-2024".to_string(),
            company: "Центр Педагогического Мастерства".to_string(),
            position: "Графический дизайнер".to_string(),
            duties: vec![
                "Фирменный стиль".to_string(),
                "SMM-дизайн (соцсети)".to_string(),
                "Презентации".to_string(),
                "Полиграфия".to_string(),
            ],
            circle_image: Some("/mock-circle.png".to_string()),
        },
        Experience {
            year: "2021-2022".to_string(),
            company: "Банк УБРиР".to_string(),
            position: "Ведущий дизайнер отдела коммуникаций".to_string(),
            duties: vec![
                "Презентации".to_string(),
                "Коммуникационный дизайн".to_string(),
                "Полиграфия".to_string(),
            ],
            circle_image: None,
        },
    ]
}

pub fn get_skills_data() -> (Vec<String>, Vec<String>) {
    let hard_skills = vec![
        "PowerPoint".to_string(),
        "Figma".to_string(),
        "Photoshop, Illustrator, InDesign".to_string(),
    ];
    
    let soft_skills = vec![
        "Системность".to_string(),
        "Креативность".to_string(),
        "Ответственность".to_string(),
    ];
    
    (hard_skills, soft_skills)
}
EOF

echo -e "${YELLOW}🧩 Создание entity компонентов...${NC}"

# Создаем компонент карточки проекта
cat > src/entities/project_card.rs << 'EOF'
use leptos::*;
use crate::shared::types::PortfolioItem;

#[component]
pub fn ProjectCard(item: PortfolioItem) -> impl IntoView {
    view! {
        <div class="bg-white/5 hover:shadow-lg rounded-[1.875rem] md:rounded-[1.25rem] transition-all hover:-translate-y-2 duration-300 cursor-pointer overflow-hidden focus:outline-none focus:ring-2 focus:ring-blue-500 group">
            <div class="w-full h-64 bg-secondary/20 flex items-center justify-center group-hover:bg-secondary/30 transition-colors">
                <div class="text-center text-white/80">
                    <div class="text-xl font-mv-skifer mb-2">{&item.alt}</div>
                    <div class="text-sm font-onest opacity-60">"Заглушка изображения"</div>
                </div>
            </div>
        </div>
    }
}
EOF

# Создаем компонент элемента опыта
cat > src/entities/experience_item.rs << 'EOF'
use leptos::*;
use crate::shared::types::Experience;

#[component]
pub fn ExperienceItem(experience: Experience) -> impl IntoView {
    view! {
        <div class="ml-[30.1025rem] md:ml-[31.875rem] mb-[7.21875rem] md:mb-[4.8125rem]">
            <div class="relative">
                {experience.circle_image.map(|_| view! {
                    <div class="absolute -top-[1.40625rem] md:-top-[0.9375rem] -left-[12.375rem] md:-left-[8.25rem] w-[7.875rem] md:w-[5.25rem] h-[7.875rem] md:h-[5.25rem]">
                        <div class="w-full h-full bg-secondary/20 rounded-full flex items-center justify-center">
                            <span class="text-secondary text-xs">"●"</span>
                        </div>
                    </div>
                })}
                
                <div>
                    <p class="mb-[0.1875rem] md:mb-[0.125rem] font-extralight font-onest text-[3.28125rem] md:text-[2.1875rem] leading-[1.33] tracking-[0.01em]">
                        {&experience.year}
                    </p>
                    <h3 class="mb-[0.65625rem] md:mb-[0.4375rem] font-medium font-onest text-[3.28125rem] md:text-[2.1875rem] leading-[1.25] tracking-[0.01em]">
                        {&experience.company}
                    </h3>
                    <h3 class="mb-[0.65625rem] md:mb-[0.4375rem] font-medium font-onest text-[3.28125rem] md:text-[2.1875rem] leading-[1.33] tracking-[0.01em]">
                        {&experience.position}
                    </h3>
                    <ul class="font-extralight text-[3.28125rem] md:text-[2.1875rem] list-none relative">
                        {experience.duties.into_iter().map(|duty| view! {
                            <li class="mb-[0.75rem] md:mb-[0.5rem]">
                                <span class="-left-[4.71rem] md:-left-[3.14rem] absolute font-onest font-thin">
                                    "→"
                                </span>
                                {duty}
                            </li>
                        }).collect_view()}
                    </ul>
                </div>
            </div>
        </div>
    }
}
EOF

# Создаем mod.rs для entities
cat > src/entities/mod.rs << 'EOF'
pub mod project_card;
pub mod experience_item;
EOF

echo -e "${YELLOW}🎨 Создание widget компонентов...${NC}"

# Создаем секцию портфолио
cat > src/widgets/portfolio_section.rs << 'EOF'
use leptos::*;
use crate::entities::project_card::ProjectCard;
use crate::shared::data::get_portfolio_mock_data;

#[component]
pub fn PortfolioSection() -> impl IntoView {
    let portfolio_data = get_portfolio_mock_data();
    
    view! {
        <section class="relative mx-auto px-4 py-[7.75rem] max-w-[75rem]">
            <div class="relative mb-[4.1875rem] text-center z-0">
                <div class="absolute top-[-2.875rem] md:top-[-1.875rem] left-[50%] w-[25.875rem] md:w-[17.25rem] h-[28.0125rem] md:h-[18.675rem] transform -translate-x-[20.6rem] md:-translate-x-[13.625rem] z-0">
                    <div class="w-full h-full bg-secondary/10 rounded-full opacity-20"></div>
                </div>
                <h2 class="font-mv-skifer text-[4.6875rem] md:text-[3.125rem] leading-[1.24] tracking-[0.01em] relative z-10">
                    "Портфолио"
                </h2>
            </div>

            <div class="relative z-10 gap-[2.71875rem] md:gap-[1.8125rem] grid grid-cols-1 md:grid-cols-2 mx-auto max-w-[70.65625rem] md:max-w-full">
                {portfolio_data.into_iter().map(|item| view! {
                    <ProjectCard item />
                }).collect_view()}
            </div>
        </section>
    }
}
EOF

# Создаем секцию резюме
cat > src/widgets/resume_section.rs << 'EOF'
use leptos::*;
use crate::shared::data::get_skills_data;

#[component]
pub fn ResumeSection() -> impl IntoView {
    let (hard_skills, soft_skills) = get_skills_data();
    
    view! {
        <section class="relative mx-auto px-4 py-[3.75rem] max-w-[75rem]">
            <div class="absolute left-1/2 top-[40.5rem] md:top-[27rem] w-[48.78125rem] overflow-hidden -translate-x-[16rem] md:-translate-x-[16rem]">
                <div class="w-full h-[400px] bg-secondary/5 rounded-full opacity-30"></div>
            </div>
            
            <div class="relative mb-[1.25rem] text-center">
                <div class="absolute top-[-2.875rem] md:top-[-1.875rem] left-[50%] w-[25.875rem] md:w-[17.25rem] h-[28.0125rem] md:h-[18.675rem] transform -translate-x-[14.7rem] md:-translate-x-[9.8rem]">
                    <div class="w-full h-full bg-secondary/10 rounded-full opacity-20"></div>
                </div>
                <h2 class="font-mv-skifer text-[4.6875rem] md:text-[3.125rem] leading-[1.24] tracking-[0.01em] relative">
                    "Резюме"
                </h2>
            </div>

            <div class="flex justify-center items-center gap-[1.875rem] md:gap-[1.25rem] mb-[1.25rem]">
                <div class="rounded-full w-[16.6875rem] md:w-[11.125rem] h-[17.25rem] md:h-[11.55rem] bg-secondary/20 flex items-center justify-center">
                    <span class="text-4xl text-secondary font-mv-skifer">"ПМ"</span>
                </div>
                <h3 class="font-mv-skifer text-[4.6875rem] md:text-[3.125rem] leading-[1.05] tracking-[0.01em]">
                    "Полина" <br/> "Мигранова"
                </h3>
            </div>

            <div class="ml-[29.8125rem] md:ml-[31.875rem]">
                <div class="mb-[5.5rem] md:mb-[3rem]">
                    <h3 class="mb-[0.84375rem] md:mb-[0.5625rem] font-medium font-onest text-[3.75rem] md:text-[2.5rem]">
                        "Hard skills"
                    </h3>
                    <ul class="font-extralight text-[3.28125rem] md:text-[2.1875rem] list-none relative">
                        {hard_skills.into_iter().map(|skill| view! {
                            <li class="mb-[0.75rem] md:mb-[0.1rem]">
                                <span class="-left-[4.71rem] md:-left-[3.14rem] absolute font-onest font-thin">"→"</span>
                                {skill}
                            </li>
                        }).collect_view()}
                    </ul>
                </div>

                <div>
                    <h3 class="mb-[0.84375rem] md:mb-[0.5625rem] font-medium font-onest text-[3.75rem] md:text-[2.5rem]">
                        "Soft skills"
                    </h3>
                    <ul class="font-extralight text-[3.28125rem] md:text-[2.1875rem] list-none relative">
                        {soft_skills.into_iter().map(|skill| view! {
                            <li class="mb-[0.75rem] md:mb-[0.1rem]">
                                <span class="-left-[4.71rem] md:-left-[3.14rem] absolute font-onest font-thin">"→"</span>
                                {skill}
                            </li>
                        }).collect_view()}
                    </ul>
                </div>
            </div>
        </section>
    }
}
EOF

# Создаем секцию опыта
cat > src/widgets/experience_section.rs << 'EOF'
use leptos::*;
use crate::entities::experience_item::ExperienceItem;
use crate::shared::data::get_experience_mock_data;

#[component]
pub fn ExperienceSection() -> impl IntoView {
    let experience_data = get_experience_mock_data();
    
    view! {
        <section class="relative mx-auto px-4 py-[0.75rem] max-w-[75rem]">
            <div class="absolute top-3/4 left-1/2 w-[56rem] md:w-auto -translate-x-[35.7rem] md:-translate-x-[23rem] overflow-hidden">
                <div class="w-full h-[300px] bg-secondary/5 rounded-full opacity-20"></div>
            </div>

            {experience_data.into_iter().map(|item| view! {
                <ExperienceItem experience=item />
            }).collect_view()}
        </section>
    }
}
EOF

echo -e "${YELLOW}🔧 Обновление модулей...${NC}"

# Обновляем mod.rs для widgets
cat > src/widgets/mod.rs << 'EOF'
pub mod header;
pub mod footer;
pub mod portfolio_section;
pub mod resume_section;
pub mod experience_section;
EOF

# Обновляем shared/mod.rs
cat > src/shared/mod.rs << 'EOF'
pub mod types;
pub mod ui;
pub mod data;
EOF

# Обновляем lib.rs
cat > src/lib.rs << 'EOF'
pub mod app;
pub mod pages;
pub mod widgets;
pub mod entities;
pub mod shared;
EOF

echo -e "${YELLOW}📄 Обновление главной страницы...${NC}"

# Обновляем главную страницу
cat > src/pages/home.rs << 'EOF'
use leptos::*;
use crate::widgets::header::Header;
use crate::widgets::footer::Footer;
use crate::widgets::portfolio_section::PortfolioSection;
use crate::widgets::resume_section::ResumeSection;
use crate::widgets::experience_section::ExperienceSection;

#[component]
pub fn HomePage() -> impl IntoView {
    view! {
        <div class="bg-primary text-white min-h-screen">
            <Header />
            
            <main>
                <PortfolioSection />
                <ResumeSection />
                <ExperienceSection />
            </main>
            
            <Footer />
        </div>
    }
}
EOF

echo -e "${BLUE}🧪 Тестирование этапа 3...${NC}"

# Компиляция стилей
echo "🎨 Компиляция TailwindCSS..."
npx tailwindcss -i ./style/main.scss -o ./style/output.css

# Проверка компиляции
echo "🦀 Проверка компиляции Rust..."
if cargo check; then
    echo -e "${GREEN}✅ Этап 3 реализован успешно!${NC}"
    echo ""
    echo "Что добавлено:"
    echo "• Полноценная структура портфолио"
    echo "• Все секции с заглушками данных"
    echo "• Entity компоненты (ProjectCard, ExperienceItem)"
    echo "• Widget компоненты (Portfolio, Resume, Experience)"
    echo "• Mock данные для всех секций"
    echo ""
    echo "Запустите 'npm run dev' для просмотра результата"
else
    echo -e "${RED}❌ Ошибка компиляции. Проверьте код.${NC}"
    exit 1
fi

echo -e "${GREEN}🎉 Этап 3 завершен! Готов к коммиту: feat: static-layout-with-mocks${NC}"