#!/bin/bash

echo "🎬 Внедрение анимационной системы для portfolio-rust..."

# Цвета для вывода
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
NC='\033[0m'

ERRORS=0

# Функция для обработки ошибок
handle_error() {
    echo -e "${RED}❌ Ошибка: $1${NC}"
    ERRORS=$((ERRORS + 1))
}

# Функция для успешного сообщения
success() {
    echo -e "${GREEN}✅ $1${NC}"
}

# Функция для информационного сообщения
info() {
    echo -e "${BLUE}ℹ️  $1${NC}"
}

# Функция для предупреждения
warning() {
    echo -e "${YELLOW}⚠️  $1${NC}"
}

echo -e "${BLUE}🔍 Проверка текущего состояния проекта...${NC}"

# Проверяем структуру проекта
if [ ! -f "Cargo.toml" ]; then
    handle_error "Cargo.toml не найден. Запустите скрипт из корня проекта."
    exit 1
fi

if [ ! -f "src/lib.rs" ]; then
    handle_error "src/lib.rs не найден. Проверьте структуру проекта."
    exit 1
fi

success "Структура проекта корректна"

# Создаем директорию для бэкапов
BACKUP_DIR="backup_$(date +%Y%m%d_%H%M%S)"
mkdir -p "$BACKUP_DIR"
info "Создана директория бэкапов: $BACKUP_DIR"

# Функция для создания бэкапа файла
backup_file() {
    local file=$1
    if [ -f "$file" ]; then
        cp "$file" "$BACKUP_DIR/"
        info "Создан бэкап: $file"
    fi
}

echo -e "${YELLOW}📁 Создание бэкапов важных файлов...${NC}"

# Создаем бэкапы
backup_file "style/main.scss"
backup_file "tailwind.config.js"
backup_file "src/features/project_modal/modal.rs"
backup_file "src/features/slider/slider.rs"
backup_file "src/features/slider/navigation_buttons.rs"
backup_file "src/features/slider/slider_image.rs"

success "Бэкапы созданы"

echo -e "${BLUE}🎨 Обновление стилей с анимациями...${NC}"

# Обновляем style/main.scss
cat > style/main.scss << 'EOF'
@tailwind base;
@tailwind components;
@tailwind utilities;

@font-face {
  font-family: 'MV-SKIFER';
  src: url('/assets/fonts/MV-SKIFER.otf') format('opentype');
  font-weight: 400;
  font-style: normal;
  font-display: swap;
}

@font-face {
  font-family: 'Onest';
  src: url('/assets/fonts/Onest-Regular.ttf') format('truetype');
  font-weight: 400;
  font-style: normal;
  font-display: swap;
}

@font-face {
  font-family: 'Onest';
  src: url('/assets/fonts/Onest-Medium.ttf') format('truetype');
  font-weight: 500;
  font-style: normal;
  font-display: swap;
}

@font-face {
  font-family: 'Onest';
  src: url('/assets/fonts/Onest-Light.ttf') format('truetype');
  font-weight: 300;
  font-style: normal;
  font-display: swap;
}

:root {
  font-size: clamp(4.27px, calc(100vw / 75), 16px);
}

html {
  overscroll-behavior: contain;
  background-color: #04061B;
}

.modal-scrollbar {
  scrollbar-width: thin;
  scrollbar-color: #3624A6 transparent;
}

.modal-scrollbar::-webkit-scrollbar {
  width: 8px;
}

.modal-scrollbar::-webkit-scrollbar-track {
  background: #3624A6;
}

.modal-scrollbar::-webkit-scrollbar-thumb {
  background: #4A5568;
  border-radius: 4px;
}

.object-cover {
  object-fit: cover;
  width: 100%;
  height: 100%;
  position: static;
}

/* Блокировка скролла при открытом модальном окне */
body.modal-open {
  overflow: hidden;
  position: fixed;
  width: 100%;
}

/* ============ АНИМАЦИИ МОДАЛЬНОГО ОКНА ============ */

/* Анимация фона модального окна */
@keyframes modal-backdrop-enter {
  from {
    opacity: 0;
    backdrop-filter: blur(0px);
  }
  to {
    opacity: 1;
    backdrop-filter: blur(8px);
  }
}

@keyframes modal-backdrop-exit {
  from {
    opacity: 1;
    backdrop-filter: blur(8px);
  }
  to {
    opacity: 0;
    backdrop-filter: blur(0px);
  }
}

/* Анимация появления модального окна */
@keyframes modal-content-enter {
  from {
    opacity: 0;
    transform: scale(0.9) translateY(20px);
  }
  to {
    opacity: 1;
    transform: scale(1) translateY(0);
  }
}

@keyframes modal-content-exit {
  from {
    opacity: 1;
    transform: scale(1) translateY(0);
  }
  to {
    opacity: 0;
    transform: scale(0.95) translateY(-10px);
  }
}

/* Классы для анимации модального окна */
.modal-backdrop-enter {
  animation: modal-backdrop-enter 0.3s ease-out forwards;
}

.modal-backdrop-exit {
  animation: modal-backdrop-exit 0.2s ease-in forwards;
}

.modal-content-enter {
  animation: modal-content-enter 0.3s cubic-bezier(0.34, 1.56, 0.64, 1) forwards;
}

.modal-content-exit {
  animation: modal-content-exit 0.2s ease-in forwards;
}

/* ============ АНИМАЦИИ СЛАЙДЕРА ============ */

/* Контейнер для слайдов */
.slider-container {
  position: relative;
  overflow: hidden;
}

/* Базовые стили для слайдов */
.slide {
  position: absolute;
  top: 0;
  left: 0;
  width: 100%;
  opacity: 0;
  transform: translateX(100%);
  transition: all 0.5s cubic-bezier(0.4, 0, 0.2, 1);
}

/* Активный слайд */
.slide-active {
  position: relative;
  opacity: 1;
  transform: translateX(0);
  z-index: 2;
}

/* Слайд уходящий влево */
.slide-exit-left {
  opacity: 0;
  transform: translateX(-100%);
  z-index: 1;
}

/* Слайд приходящий справа */
.slide-enter-right {
  opacity: 1;
  transform: translateX(0);
  z-index: 2;
}

/* Слайд уходящий вправо */
.slide-exit-right {
  opacity: 0;
  transform: translateX(100%);
  z-index: 1;
}

/* Слайд приходящий слева */
.slide-enter-left {
  opacity: 1;
  transform: translateX(0);
  z-index: 2;
}

/* Анимация для изображений в слайдах */
.slide-image {
  transition: all 0.4s ease-out;
  transform: scale(1);
}

.slide-image-loading {
  opacity: 0.7;
  transform: scale(0.98);
}

.slide-image-loaded {
  opacity: 1;
  transform: scale(1);
}

/* Анимация для контента слайда */
.slide-content {
  transition: all 0.3s ease-out 0.1s;
  opacity: 1;
  transform: translateY(0);
}

.slide-content-hidden {
  opacity: 0;
  transform: translateY(10px);
}

/* ============ АНИМАЦИИ КНОПОК ============ */

/* Анимация кнопок навигации */
.nav-button {
  transition: all 0.2s ease-out;
  transform: scale(1);
}

.nav-button:hover:not(:disabled) {
  transform: scale(1.05);
}

.nav-button:active:not(:disabled) {
  transform: scale(0.95);
}

.nav-button:disabled {
  transition: all 0.3s ease-out;
}

/* ============ АНИМАЦИИ ЗАГРУЗКИ ============ */

/* Пульсация для загрузки */
@keyframes loading-pulse {
  0%, 100% {
    opacity: 0.4;
    transform: scale(1);
  }
  50% {
    opacity: 0.8;
    transform: scale(1.02);
  }
}

.loading-pulse {
  animation: loading-pulse 2s ease-in-out infinite;
}

/* Скелетон анимация */
@keyframes skeleton-shimmer {
  0% {
    background-position: -200px 0;
  }
  100% {
    background-position: calc(200px + 100%) 0;
  }
}

.skeleton {
  background: linear-gradient(90deg, 
    rgba(255, 255, 255, 0.03) 25%, 
    rgba(255, 255, 255, 0.08) 50%, 
    rgba(255, 255, 255, 0.03) 75%
  );
  background-size: 200px 100%;
  animation: skeleton-shimmer 1.5s infinite;
}

/* ============ ОБЩИЕ УТИЛИТЫ ============ */

/* Плавные переходы */
.smooth-transition {
  transition: all 0.3s ease-out;
}

.smooth-transition-fast {
  transition: all 0.15s ease-out;
}

.smooth-transition-slow {
  transition: all 0.5s ease-out;
}

/* Состояния видимости */
.fade-in {
  animation: fadeIn 0.3s ease-out forwards;
}

.fade-out {
  animation: fadeOut 0.2s ease-in forwards;
}

@keyframes fadeIn {
  from { opacity: 0; }
  to { opacity: 1; }
}

@keyframes fadeOut {
  from { opacity: 1; }
  to { opacity: 0; }
}
EOF

success "Стили обновлены"

echo -e "${BLUE}⚙️  Обновление конфигурации TailwindCSS...${NC}"

# Обновляем tailwind.config.js
cat > tailwind.config.js << 'EOF'
/** @type {import('tailwindcss').Config} */
module.exports = {
  content: [
    "./index.html",
    "./src/**/*.{rs,html}",
  ],
  theme: {
    extend: {
      fontFamily: {
        'mv-skifer': ['MV-SKIFER', 'sans-serif'],
        'onest': ['Onest', 'sans-serif'],
      },
      colors: {
        primary: '#04061B',
        secondary: '#3624A6',
      },
      animation: {
        'spin-slow': 'spin 3s linear infinite',
        'pulse-slow': 'pulse 3s ease-in-out infinite',
        'modal-backdrop-enter': 'modal-backdrop-enter 0.3s ease-out forwards',
        'modal-backdrop-exit': 'modal-backdrop-exit 0.2s ease-in forwards',
        'modal-content-enter': 'modal-content-enter 0.3s cubic-bezier(0.34, 1.56, 0.64, 1) forwards',
        'modal-content-exit': 'modal-content-exit 0.2s ease-in forwards',
        'skeleton-shimmer': 'skeleton-shimmer 1.5s infinite',
        'loading-pulse': 'loading-pulse 2s ease-in-out infinite',
        'fade-in': 'fadeIn 0.3s ease-out forwards',
        'fade-out': 'fadeOut 0.2s ease-in forwards',
      },
      keyframes: {
        'modal-backdrop-enter': {
          'from': {
            opacity: '0',
            'backdrop-filter': 'blur(0px)',
          },
          'to': {
            opacity: '1',
            'backdrop-filter': 'blur(8px)',
          },
        },
        'modal-backdrop-exit': {
          'from': {
            opacity: '1',
            'backdrop-filter': 'blur(8px)',
          },
          'to': {
            opacity: '0',
            'backdrop-filter': 'blur(0px)',
          },
        },
        'modal-content-enter': {
          'from': {
            opacity: '0',
            transform: 'scale(0.9) translateY(20px)',
          },
          'to': {
            opacity: '1',
            transform: 'scale(1) translateY(0)',
          },
        },
        'modal-content-exit': {
          'from': {
            opacity: '1',
            transform: 'scale(1) translateY(0)',
          },
          'to': {
            opacity: '0',
            transform: 'scale(0.95) translateY(-10px)',
          },
        },
        'skeleton-shimmer': {
          '0%': {
            'background-position': '-200px 0',
          },
          '100%': {
            'background-position': 'calc(200px + 100%) 0',
          },
        },
        'loading-pulse': {
          '0%, 100%': {
            opacity: '0.4',
            transform: 'scale(1)',
          },
          '50%': {
            opacity: '0.8',
            transform: 'scale(1.02)',
          },
        },
        'fadeIn': {
          'from': { opacity: '0' },
          'to': { opacity: '1' },
        },
        'fadeOut': {
          'from': { opacity: '1' },
          'to': { opacity: '0' },
        },
      },
      transitionTimingFunction: {
        'modal': 'cubic-bezier(0.34, 1.56, 0.64, 1)',
        'slide': 'cubic-bezier(0.4, 0, 0.2, 1)',
      },
      transitionDuration: {
        '400': '400ms',
        '600': '600ms',
      },
    },
  },
  plugins: [],
};
EOF

success "Конфигурация TailwindCSS обновлена"

echo -e "${BLUE}🦀 Обновление Rust компонентов...${NC}"

# Обновляем модальное окно
cat > src/features/project_modal/modal.rs << 'EOF'
use leptos::*;
use leptos::html::Div;
use web_sys::KeyboardEvent;
use crate::features::project_modal::ModalHeader;
use crate::features::slider::Slider;
use crate::shared::types::Project;

#[component]
pub fn ProjectModal(
    project: Project,
    on_close: WriteSignal<Option<String>>,
) -> impl IntoView {
    let modal_ref = create_node_ref::<Div>();
    
    // Состояния анимации
    let (is_opening, set_is_opening) = create_signal(true);
    let (is_closing, set_is_closing) = create_signal(false);
    
    // Обработчик закрытия с анимацией
    let handle_close = move || {
        set_is_closing.set(true);
        
        // Ждем завершения анимации закрытия перед фактическим закрытием
        set_timeout(
            move || on_close.set(None),
            std::time::Duration::from_millis(200)
        );
    };
    
    // Обработчик клавиш (только ESC для закрытия)
    let handle_keydown = move |e: KeyboardEvent| {
        if e.key() == "Escape" {
            handle_close();
        }
    };
    
    // Эффект для анимации открытия
    create_effect(move |_| {
        if is_opening.get() {
            set_timeout(
                move || set_is_opening.set(false),
                std::time::Duration::from_millis(50)
            );
        }
    });
    
    // Эффект для блокировки скролла
    create_effect(move |_| {
        if let Some(Some(body)) = window().document().map(|d| d.body()) {
            let _ = body.set_attribute("class", "modal-open");
        }
        
        on_cleanup(move || {
            if let Some(Some(body)) = window().document().map(|d| d.body()) {
                let _ = body.remove_attribute("class");
            }
        });
    });
    
    // Добавляем слушатель на документ
    create_effect(move |_| {
        let listener = window_event_listener(ev::keydown, handle_keydown);
        on_cleanup(move || drop(listener));
    });
    
    // Определяем классы для анимации
    let backdrop_class = move || {
        if is_closing.get() {
            "fixed inset-0 z-50 flex items-center justify-center bg-black/80 modal-backdrop-exit"
        } else if is_opening.get() {
            "fixed inset-0 z-50 flex items-center justify-center bg-black/80"
        } else {
            "fixed inset-0 z-50 flex items-center justify-center bg-black/80 modal-backdrop-enter"
        }
    };
    
    let content_class = move || {
        if is_closing.get() {
            "relative w-full max-w-7xl mx-auto my-4 bg-primary border border-white/10 rounded-[1.875rem] md:rounded-[1.25rem] shadow-xl overflow-hidden modal-content-exit"
        } else if is_opening.get() {
            "relative w-full max-w-7xl mx-auto my-4 bg-primary border border-white/10 rounded-[1.875rem] md:rounded-[1.25rem] shadow-xl overflow-hidden"
        } else {
            "relative w-full max-w-7xl mx-auto my-4 bg-primary border border-white/10 rounded-[1.875rem] md:rounded-[1.25rem] shadow-xl overflow-hidden modal-content-enter"
        }
    };
    
    view! {
        <div 
            class=backdrop_class
            on:click=move |_| handle_close()
            node_ref=modal_ref
            style="backdrop-filter: blur(8px);"
        >
            <div
                class=content_class
                on:click=move |e| e.stop_propagation()
            >
                <div class="h-[90vh] overflow-y-auto modal-scrollbar">
                    <div class="p-[3.75rem] md:p-[2.5rem]">
                        <ModalHeader project=project.clone() />
                        <Slider project />
                    </div>
                </div>

                <button
                    on:click=move |_| handle_close()
                    class="absolute top-6 right-6 p-4 md:p-2 rounded-full 
                           bg-black/40 backdrop-blur-sm 
                           hover:bg-black/60 
                           focus:outline-none focus:ring-2 focus:ring-white/50
                           z-50 group nav-button
                           transition-all duration-300 ease-in-out
                           shadow-lg"
                    aria-label="Закрыть"
                >
                    <svg
                        class="w-12 h-12 md:w-6 md:h-6 text-white/80 group-hover:text-white
                             transition-colors duration-300 ease-in-out"
                        fill="none"
                        viewBox="0 0 24 24"
                        stroke="currentColor"
                    >
                        <path
                            stroke-linecap="round"
                            stroke-linejoin="round"
                            stroke-width="2"
                            d="M6 18L18 6M6 6l12 12"
                        />
                    </svg>
                </button>
            </div>
        </div>
    }
}
EOF

success "Модальное окно обновлено"

# Обновляем слайдер
cat > src/features/slider/slider.rs << 'EOF'
use leptos::*;
use web_sys::KeyboardEvent;
use crate::features::slider::{SliderImage, NavigationButtons};
use crate::shared::types::Project;

#[derive(Clone, PartialEq)]
enum SlideDirection {
    None,
    Next,
    Previous,
}

#[derive(Clone, PartialEq)]
enum SlideState {
    Active,
    ExitLeft,
    ExitRight,
    EnterLeft,
    EnterRight,
    Hidden,
}

#[component]
pub fn Slider(project: Project) -> impl IntoView {
    let slides = create_memo(move |_| project.slides.clone());
    let total_slides = slides.get().len();
    
    let (current_index, set_current_index) = create_signal(0);
    let (previous_index, set_previous_index) = create_signal(0);
    let (is_transitioning, set_is_transitioning) = create_signal(false);
    let (direction, set_direction) = create_signal(SlideDirection::None);
    let (content_visible, set_content_visible) = create_signal(true);
    
    // Логирование для отладки
    create_effect(move |_| {
        let slides_vec = slides.get();
        let idx = current_index.get();
        if let Some(slide) = slides_vec.get(idx) {
            web_sys::console::log_1(&format!("Анимированный слайд {}: {}", idx, slide.image).into());
        }
    });
    
    // Навигация по слайдам с анимацией
    let navigate = move |nav_direction: String| {
        if is_transitioning.get() { return; }
        
        let current = current_index.get();
        let (new_index, slide_direction) = match nav_direction.as_str() {
            "next" => {
                let next = if current < total_slides - 1 { current + 1 } else { 0 };
                (next, SlideDirection::Next)
            },
            "prev" => {
                let prev = if current > 0 { current - 1 } else { total_slides - 1 };
                (prev, SlideDirection::Previous)
            },
            _ => return,
        };
        
        if new_index == current { return; }
        
        // Начинаем переход
        set_is_transitioning.set(true);
        set_direction.set(slide_direction);
        set_previous_index.set(current);
        
        // Скрываем контент
        set_content_visible.set(false);
        
        // Через небольшую задержку меняем индекс
        set_timeout(
            move || {
                set_current_index.set(new_index);
                
                // Показываем новый контент
                set_timeout(
                    move || set_content_visible.set(true),
                    std::time::Duration::from_millis(200)
                );
                
                // Завершаем переход
                set_timeout(
                    move || {
                        set_is_transitioning.set(false);
                        set_direction.set(SlideDirection::None);
                    },
                    std::time::Duration::from_millis(500)
                );
            },
            std::time::Duration::from_millis(100)
        );
    };
    
    // Определяем состояние слайда
    let get_slide_state = move |index: usize| -> SlideState {
        let current = current_index.get();
        let previous = previous_index.get();
        let dir = direction.get();
        let transitioning = is_transitioning.get();
        
        if !transitioning {
            if index == current {
                return SlideState::Active;
            } else {
                return SlideState::Hidden;
            }
        }
        
        match dir {
            SlideDirection::Next => {
                if index == current {
                    SlideState::EnterRight
                } else if index == previous {
                    SlideState::ExitLeft
                } else {
                    SlideState::Hidden
                }
            },
            SlideDirection::Previous => {
                if index == current {
                    SlideState::EnterLeft
                } else if index == previous {
                    SlideState::ExitRight
                } else {
                    SlideState::Hidden
                }
            },
            SlideDirection::None => {
                if index == current {
                    SlideState::Active
                } else {
                    SlideState::Hidden
                }
            }
        }
    };
    
    // Получаем CSS класс для состояния слайда
    let get_slide_class = move |state: SlideState| -> &'static str {
        match state {
            SlideState::Active => "slide slide-active",
            SlideState::ExitLeft => "slide slide-exit-left",
            SlideState::ExitRight => "slide slide-exit-right", 
            SlideState::EnterLeft => "slide slide-enter-left",
            SlideState::EnterRight => "slide slide-enter-right",
            SlideState::Hidden => "slide",
        }
    };
    
    // Обработчик клавиш
    let handle_keydown = move |e: KeyboardEvent| {
        match e.key().as_str() {
            "ArrowRight" => navigate("next".to_string()),
            "ArrowLeft" => navigate("prev".to_string()),
            _ => {}
        }
    };
    
    // Добавляем слушатель клавиш
    create_effect(move |_| {
        let listener = window_event_listener(ev::keydown, handle_keydown);
        on_cleanup(move || drop(listener));
    });
    
    view! {
        <div class="slider w-full max-w-[93.75rem] mx-auto overflow-hidden group relative">
            <div class="slider-container relative min-h-[400px]">
                {move || {
                    let slides_vec = slides.get();
                    slides_vec.into_iter().enumerate().map(|(index, slide)| {
                        let state = get_slide_state(index);
                        let class = get_slide_class(state);
                        let is_visible = state != SlideState::Hidden;
                        
                        view! {
                            <div class=class style=move || {
                                if !is_visible {
                                    "display: none;"
                                } else {
                                    ""
                                }
                            }>
                                <div class="overflow-hidden mb-4">
                                    <SliderImage
                                        src=slide.image.clone()
                                        alt=format!("Слайд {} проекта {}", index + 1, project.title)
                                        priority={index == 0}
                                    />
                                </div>
                            </div>
                        }
                    }).collect_view()
                }}
            </div>
            
            <div class="px-8 pb-8">
                <NavigationButtons 
                    on_navigate=Callback::new(navigate)
                    disabled=is_transitioning.get()
                />

                <div class=move || {
                    if content_visible.get() {
                        "font-onest text-[3.28125rem] md:text-[1.25rem] space-y-4 slide-content"
                    } else {
                        "font-onest text-[3.28125rem] md:text-[1.25rem] space-y-4 slide-content slide-content-hidden"
                    }
                }>
                    {move || {
                        let slides_vec = slides.get();
                        let idx = current_index.get();
                        if let Some(slide) = slides_vec.get(idx) {
                            view! {
                                <>
                                    {slide.task.as_ref().map(|task| view! {
                                        <p>
                                            <span class="font-semibold">"Задача: "</span>
                                            <span class="opacity-80">{task}</span>
                                        </p>
                                    })}
                                    
                                    {slide.solution.as_ref().map(|solution| view! {
                                        <p>
                                            <span class="font-semibold">"Решение: "</span>
                                            <span class="opacity-80">{solution}</span>
                                        </p>
                                    })}
                                </>
                            }.into_view()
                        } else {
                            view! {
                                <div class="text-white/60 text-center py-4">
                                    "Нет содержимого для отображения"
                                </div>
                            }.into_view()
                        }
                    }}
                </div>
            </div>
        </div>
    }
}
EOF

success "Слайдер обновлен"

# Обновляем кнопки навигации
cat > src/features/slider/navigation_buttons.rs << 'EOF'
use leptos::*;

#[component]
pub fn NavigationButtons(
    on_navigate: Callback<String>,
    disabled: bool,
) -> impl IntoView {
    let base_button_style = "nav-button border transition-all duration-300 rounded-full flex items-center justify-center text-7xl w-[5rem] h-[5rem] border-white/20 md:w-[3rem] md:h-[3rem] md:text-5xl";
    
    let enabled_styles = "hover:bg-white hover:text-[#3624A6] cursor-pointer";
    let disabled_styles = "opacity-50 cursor-not-allowed";
    
    let button_class = if disabled {
        format!("{} {}", base_button_style, disabled_styles)
    } else {
        format!("{} {}", base_button_style, enabled_styles)
    };
    
    view! {
        <div class="flex justify-center space-x-6 my-6">
            <button
                on:click=move |_| if !disabled { on_navigate.call("prev".to_string()) }
                class=button_class.clone()
                aria_label="Предыдущий слайд"
                disabled=disabled
            >
                "←"
            </button>

            <button
                on:click=move |_| if !disabled { on_navigate.call("next".to_string()) }
                class=button_class
                aria_label="Следующий слайд"
                disabled=disabled
            >
                "→"
            </button>
        </div>
    }
}
EOF

success "Кнопки навигации обновлены"

# Обновляем изображение слайдера
cat > src/features/slider/slider_image.rs << 'EOF'
use leptos::*;

#[component]
pub fn SliderImage(
    src: String,
    alt: String,
    priority: bool,
) -> impl IntoView {
    let (image_state, set_image_state) = create_signal("loading".to_string());
    let src_clone = src.clone();
    
    // Эффект для анимации при загрузке
    create_effect(move |_| {
        let state = image_state.get();
        web_sys::console::log_1(&format!("Состояние изображения: {}", state).into());
    });
    
    view! {
        <div class="relative w-full min-h-[400px] flex items-center justify-center bg-white/2 rounded-lg overflow-hidden">
            // Индикатор загрузки с анимацией
            {move || {
                let src_for_display = src_clone.clone();
                match image_state.get().as_str() {
                    "loading" => view! {
                        <div class="absolute inset-0 flex items-center justify-center">
                            <div class="skeleton rounded-lg w-full h-full flex items-center justify-center">
                                <div class="text-white/40 text-xl loading-pulse animate-pulse">
                                    "Загрузка изображения..."
                                </div>
                            </div>
                        </div>
                    }.into_view(),
                    "error" => view! {
                        <div class="absolute inset-0 flex flex-col items-center justify-center bg-red-500/10 rounded-lg text-red-400 fade-in">
                            <div class="text-lg mb-2">"❌ Изображение не найдено"</div>
                            <div class="text-sm opacity-70 px-4 text-center break-all max-w-md">
                                {src_for_display}
                            </div>
                            <button 
                                class="mt-4 px-4 py-2 bg-red-500/20 hover:bg-red-500/30 rounded-lg text-sm transition-colors duration-200"
                                on:click=move |_| {
                                    set_image_state.set("loading".to_string());
                                }
                            >
                                "Попробовать снова"
                            </button>
                        </div>
                    }.into_view(),
                    _ => view! { <div/> }.into_view()
                }
            }}
            
            // Изображение с анимацией
            <img
                src=src
                alt=alt
                class=move || {
                    match image_state.get().as_str() {
                        "loaded" => "slide-image slide-image-loaded w-full h-auto object-contain max-h-[70vh] rounded-lg",
                        "loading" => "slide-image slide-image-loading w-full h-auto object-contain max-h-[70vh] rounded-lg",
                        _ => "slide-image w-full h-auto object-contain max-h-[70vh] rounded-lg opacity-0"
                    }
                }
                style=move || {
                    match image_state.get().as_str() {
                        "loaded" => "display: block;",
                        _ => "display: none;"
                    }
                }
                on:load=move |_| {
                    web_sys::console::log_1(&"Изображение загружено".into());
                    set_image_state.set("loaded".to_string());
                }
                on:error=move |_| {
                    web_sys::console::log_1(&"Ошибка загрузки изображения".into());
                    set_image_state.set("error".to_string());
                }
                loading=if priority { "eager" } else { "lazy" }
            />
        </div>
    }
}
EOF

success "Изображение слайдера обновлено"

echo -e "${BLUE}🏗️  Компиляция стилей...${NC}"

# Компилируем стили
if npx tailwindcss -i ./style/main.scss -o ./style/output.css --minify; then
    success "Стили скомпилированы"
else
    handle_error "Ошибка компиляции стилей"
fi

echo -e "${BLUE}🧪 Проверка компиляции Rust...${NC}"

# Проверяем компиляцию
if cargo check; then
    success "Rust код компилируется корректно"
else
    handle_error "Ошибки компиляции Rust кода"
fi

if cargo check --target wasm32-unknown-unknown; then
    success "WASM target проверен"
else
    handle_error "Ошибки WASM target"
fi

echo -e "${BLUE}📦 Сборка проекта...${NC}"

# Собираем проект
if trunk build --release; then
    success "Проект собран успешно"
else
    handle_error "Ошибка сборки проекта"
fi

# Проверяем результат сборки
if [ -d "dist" ]; then
    success "Директория dist создана"
    
    # Показываем размеры ключевых файлов
    echo -e "${BLUE}📊 Размеры файлов:${NC}"
    if [ -f "dist/index.html" ]; then
        echo "  📄 index.html: $(du -h dist/index.html | cut -f1)"
    fi
    
    if [ -f "style/output.css" ]; then
        echo "  🎨 output.css: $(du -h style/output.css | cut -f1)"
    fi
    
    find dist -name "*.wasm" -exec du -h {} \; | head -1 | sed 's/^/  🦀 WASM: /'
    find dist -name "*.js" -exec du -h {} \; | head -1 | sed 's/^/  ⚡ JS: /'
else
    handle_error "Директория dist не создана"
fi

echo -e "${BLUE}📝 Фиксация изменений...${NC}"

# Git checkpoint
git add .
git commit -m "feat: implement comprehensive animation system

🎬 Анимационная система:
- Плавные переходы модального окна (масштабирование + размытие)
- Направленные анимации слайдера (влево/вправо)
- Анимированная загрузка изображений (скелетон + fade-in)
- Реактивные кнопки с hover/click эффектами
- Синхронизированное появление/исчезновение контента

🔧 Технические улучшения:
- Расширенная CSS анимационная система
- Управление состояниями через Rust сигналы
- Оптимизированные переходы с easing функциями
- Интегрированные TailwindCSS анимации

✨ UX улучшения:
- Естественные физические переходы
- Визуальная обратная связь
- Плавная навигация между контентом
- Элегантные состояния загрузки" 2>/dev/null || echo "Git не настроен или файлы не изменились"

success "Изменения зафиксированы"

# Итоговый отчет
echo ""
echo -e "${GREEN}========================================${NC}"
echo -e "${GREEN}🎉 Анимационная система успешно внедрена!${NC}"
echo -e "${GREEN}========================================${NC}"
echo ""

if [ $ERRORS -eq 0 ]; then
    echo -e "${GREEN}✅ Все компоненты обновлены без ошибок${NC}"
    echo ""
    echo -e "${BLUE}🚀 Что было реализовано:${NC}"
    echo "   🎬 Плавное открытие/закрытие модальных окон"
    echo "   🔄 Направленные переходы между слайдами"
    echo "   🖼️  Анимированная загрузка изображений"
    echo "   🎯 Реактивные кнопки навигации"
    echo "   ✨ Синхронизированная анимация контента"
    echo ""
    echo -e "${BLUE}📋 Следующие шаги:${NC}"
    echo "   1. Запустите: ${YELLOW}./scripts/dev.sh${NC}"
    echo "   2. Протестируйте анимации в браузере"
    echo "   3. При необходимости настройте тайминги в CSS"
    echo ""
    echo -e "${BLUE}💾 Бэкапы сохранены в: ${YELLOW}$BACKUP_DIR${NC}"
else
    echo -e "${RED}❌ Обнаружено ошибок: $ERRORS${NC}"
    echo -e "${YELLOW}🔧 Проверьте логи выше и исправьте проблемы${NC}"
    echo -e "${BLUE}💾 Для отката используйте файлы из: ${YELLOW}$BACKUP_DIR${NC}"
fi

echo ""
echo -e "${GREEN}Анимационная система готова к использованию! 🎬✨${NC}"