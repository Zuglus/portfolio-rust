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
