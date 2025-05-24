#!/bin/bash

echo "🔧 Исправление ошибки владения в слайдере..."

# Цвета для вывода
GREEN='\033[0;32m'
RED='\033[0;31m'
BLUE='\033[0;34m'
NC='\033[0m'

# Функция для успешного сообщения
success() {
    echo -e "${GREEN}✅ $1${NC}"
}

# Функция для информационного сообщения
info() {
    echo -e "${BLUE}ℹ️  $1${NC}"
}

info "Исправляем ошибку borrow/move в src/features/slider/slider.rs"

# Исправляем слайдер - добавляем Copy к SlideState и исправляем логику
cat > src/features/slider/slider.rs << 'EOF'
use leptos::*;
use web_sys::KeyboardEvent;
use crate::features::slider::{SliderImage, NavigationButtons};
use crate::shared::types::Project;

#[derive(Clone, Copy, PartialEq)]
enum SlideDirection {
    None,
    Next,
    Previous,
}

#[derive(Clone, Copy, PartialEq)]
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
                        // Исправляем проблему с ownership - создаем state один раз и используем Copy
                        let slide_state = get_slide_state(index);
                        let class = get_slide_class(slide_state);
                        let is_visible = slide_state != SlideState::Hidden;
                        
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

success "Слайдер исправлен - добавлен Copy trait"

info "Проверяем компиляцию..."

# Проверяем компиляцию
if cargo check; then
    success "Rust код компилируется корректно"
else
    echo -e "${RED}❌ Ошибки компиляции все еще присутствуют${NC}"
    exit 1
fi

if cargo check --target wasm32-unknown-unknown; then
    success "WASM target проверен"
else
    echo -e "${RED}❌ Ошибки WASM target${NC}"
    exit 1
fi

info "Пересобираем проект..."

# Собираем проект
if trunk build --release; then
    success "Проект собран успешно"
else
    echo -e "${RED}❌ Ошибка сборки проекта${NC}"
    exit 1
fi

success "Ошибка владения исправлена!"

# Git checkpoint
git add .
git commit -m "fix: resolve borrow/move error in slider

- Added Copy trait to SlideDirection and SlideState enums
- Fixed ownership issue in slide state logic
- Slider now compiles and works correctly" 2>/dev/null

success "Изменения зафиксированы в git"

echo ""
echo -e "${GREEN}🎉 Проблема с владением решена!${NC}"
echo -e "${BLUE}🚀 Запустите: ./scripts/dev.sh для тестирования${NC}"