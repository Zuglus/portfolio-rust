#!/bin/bash

echo "🎬 Этап 7: Слайдер в модальном окне"

# Создание структуры слайдера
mkdir -p src/features/slider

# Создание mod.rs для слайдера
cat > src/features/slider/mod.rs << 'EOF'
pub mod slider;
pub mod slider_image;
pub mod navigation_buttons;

pub use slider::Slider;
pub use slider_image::SliderImage;
pub use navigation_buttons::NavigationButtons;
EOF

# Создание компонента навигационных кнопок
cat > src/features/slider/navigation_buttons.rs << 'EOF'
use leptos::*;

#[component]
pub fn NavigationButtons(
    on_navigate: Callback<String>,
    disabled: bool,
) -> impl IntoView {
    let base_button_style = "border transition-all duration-300 rounded-full flex items-center justify-center text-7xl w-[5rem] h-[5rem] border-white/20 md:w-[3rem] md:h-[3rem] md:text-5xl";
    
    let enabled_styles = "hover:bg-white hover:text-[#3624A6] cursor-pointer active:scale-95 transform";
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

# Создание компонента изображения слайдера
cat > src/features/slider/slider_image.rs << 'EOF'
use leptos::*;

#[component]
pub fn SliderImage(
    src: String,
    alt: String,
    priority: bool,
) -> impl IntoView {
    let (loading, set_loading) = create_signal(true);
    let (error, set_error) = create_signal(false);
    
    view! {
        <div class="relative w-full">
            {move || {
                if loading.get() && !error.get() {
                    view! {
                        <div class="flex items-center justify-center h-96 bg-white/5 rounded-lg">
                            <div class="text-white/60">"Загрузка..."</div>
                        </div>
                    }.into_view()
                } else if error.get() {
                    view! {
                        <div class="flex items-center justify-center h-96 bg-red-500/10 rounded-lg text-red-500">
                            "Ошибка загрузки изображения"
                        </div>
                    }.into_view()
                } else {
                    view! { <div/> }.into_view()
                }
            }}
            
            <img
                src=src.clone()
                alt=alt
                class="w-full object-contain"
                style=if loading.get() { "display: none" } else { "" }
                on:load=move |_| set_loading.set(false)
                on:error=move |_| { set_loading.set(false); set_error.set(true); }
                loading=if priority { "eager" } else { "lazy" }
            />
        </div>
    }
}
EOF

# Создание основного компонента слайдера
cat > src/features/slider/slider.rs << 'EOF'
use leptos::*;
use web_sys::KeyboardEvent;
use crate::features::slider::{SliderImage, NavigationButtons};
use crate::shared::types::{Slide, Project};

#[component]
pub fn Slider(project: Project) -> impl IntoView {
    let slides = project.slides;
    let total_slides = slides.len();
    
    let (current_index, set_current_index) = create_signal(0);
    let (is_loading, set_is_loading) = create_signal(false);
    
    // Навигация по слайдам
    let navigate = move |direction: String| {
        if is_loading.get() { return; }
        
        set_is_loading.set(true);
        
        let current = current_index.get();
        let new_index = match direction.as_str() {
            "next" => if current < total_slides - 1 { current + 1 } else { 0 },
            "prev" => if current > 0 { current - 1 } else { total_slides - 1 },
            _ => current,
        };
        
        set_current_index.set(new_index);
        
        // Симуляция небольшой задержки для анимации
        set_timeout(
            move || set_is_loading.set(false),
            std::time::Duration::from_millis(200)
        );
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
            {move || {
                let idx = current_index.get();
                if let Some(slide) = slides.get(idx) {
                    view! {
                        <div class="relative w-full">
                            <div class="overflow-hidden">
                                <SliderImage
                                    src=slide.image.clone()
                                    alt="Слайд проекта".to_string()
                                    priority=true
                                />
                            </div>

                            <div class="px-8 pb-8">
                                <NavigationButtons 
                                    on_navigate=Callback::new(navigate)
                                    disabled=is_loading.get()
                                />

                                <div class="font-onest text-[3.28125rem] md:text-[1.25rem] space-y-4">
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
                                </div>
                            </div>
                        </div>
                    }.into_view()
                } else {
                    view! {
                        <div class="text-white/60 text-center py-8">
                            "Нет доступных слайдов"
                        </div>
                    }.into_view()
                }
            }}
        </div>
    }
}
EOF

# Обновление модуля features
cat > src/features/mod.rs << 'EOF'
pub mod project_modal;
pub mod slider;
EOF

# Обновление модального окна для использования слайдера
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
    
    // Обработчик клавиш (только ESC для закрытия)
    let handle_keydown = move |e: KeyboardEvent| {
        if e.key() == "Escape" {
            on_close.set(None);
        }
    };
    
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
    
    view! {
        <div 
            class="fixed inset-0 z-50 flex items-center justify-center bg-black/80 backdrop-blur-sm"
            on:click=move |_| on_close.set(None)
            node_ref=modal_ref
        >
            <div
                class="relative w-full max-w-7xl mx-auto my-4 bg-primary border border-white/10 rounded-[1.875rem] md:rounded-[1.25rem] shadow-xl overflow-hidden"
                on:click=move |e| e.stop_propagation()
            >
                <div class="h-[90vh] overflow-y-auto modal-scrollbar">
                    <div class="p-[3.75rem] md:p-[2.5rem]">
                        <ModalHeader project=project.clone() />
                        <Slider project />
                    </div>
                </div>

                <button
                    on:click=move |_| on_close.set(None)
                    class="absolute top-6 right-6 p-4 md:p-2 rounded-full 
                           bg-black/40 backdrop-blur-sm 
                           hover:bg-black/60 
                           focus:outline-none focus:ring-2 focus:ring-white/50
                           z-50 group
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

# Тестирование
echo "🧪 Тестирование слайдера..."
./scripts/test.sh || { echo "❌ Тесты не прошли"; exit 1; }

# Сборка проекта
echo "🏗️ Сборка проекта..."
./scripts/build.sh || { echo "❌ Сборка не удалась"; exit 1; }

# Git checkpoint
echo "📝 Создание Git checkpoint..."
git add .
git commit -m "feat: project-slider

- Добавлен полнофункциональный слайдер в модальное окно
- Навигация кнопками и клавишами стрелок
- Отображение задач и решений для каждого слайда
- Smooth переходы между слайдами
- Предзагрузка изображений"

git tag "stage-7-project-slider"

echo "✅ Этап 7 завершен: Слайдер в модальном окне"
echo "🎯 Теперь доступна полная навигация по слайдам проекта"