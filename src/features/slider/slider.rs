use leptos::*;
use web_sys::KeyboardEvent;
use crate::features::slider::{SliderImage, NavigationButtons};
use crate::shared::types::Project;

#[derive(Clone, Copy, PartialEq)]
enum SlideDirection {
    None,
    Forward,
    Backward,
}

#[derive(Clone, Copy, PartialEq)]
enum SliderState {
    Idle,
    Transitioning,
    // Removed unused Loading variant
}

#[component]
pub fn Slider(project: Project) -> impl IntoView {
    let slides = create_memo(move |_| project.slides.clone());
    let total_slides = slides.get().len();
    
    let (current_index, set_current_index) = create_signal(0);
    let (slider_state, set_slider_state) = create_signal(SliderState::Idle);
    let (_slide_direction, set_slide_direction) = create_signal(SlideDirection::None); // Fixed: prefixed with underscore
    let (content_visible, set_content_visible) = create_signal(true);
    
    let image_key = move || {
        format!("slide-{}-{}", current_index.get(), 
            slides.get().get(current_index.get()).map(|s| s.image.as_str()).unwrap_or(""))
    };
    
    // Modern prefetching strategy for better performance
    create_effect(move |_| {
        let current = current_index.get();
        let slides_vec = slides.get();
        
        let next_index = if current < total_slides - 1 { current + 1 } else { 0 };
        let prev_index = if current > 0 { current - 1 } else { total_slides - 1 };
        
        // Prefetch adjacent images for smoother transitions
        for &idx in &[next_index, prev_index] {
            if let Some(slide) = slides_vec.get(idx) {
                if let Some(document) = web_sys::window().unwrap().document() {
                    if let Ok(link) = document.create_element("link") {
                        let _ = link.set_attribute("rel", "prefetch");
                        let _ = link.set_attribute("href", &slide.image);
                        let _ = document.head().unwrap().append_child(&link);
                    }
                }
            }
        }
    });
    
    // Optimized navigation with modern timing
    let navigate = move |direction: String| {
        if slider_state.get() != SliderState::Idle { return; }
        
        let current = current_index.get();
        let (new_index, nav_direction) = match direction.as_str() {
            "next" => {
                let next = if current < total_slides - 1 { current + 1 } else { 0 };
                (next, SlideDirection::Forward)
            },
            "prev" => {
                let prev = if current > 0 { current - 1 } else { total_slides - 1 };
                (prev, SlideDirection::Backward)
            },
            _ => return,
        };
        
        if new_index == current { return; }
        
        set_slider_state.set(SliderState::Transitioning);
        set_slide_direction.set(nav_direction);
        
        // Modern transition timing for better UX
        set_content_visible.set(false);
        
        set_timeout(
            move || {
                set_current_index.set(new_index);
                
                set_timeout(
                    move || {
                        set_content_visible.set(true);
                        
                        set_timeout(
                            move || {
                                set_slider_state.set(SliderState::Idle);
                                set_slide_direction.set(SlideDirection::None);
                            },
                            std::time::Duration::from_millis(250)
                        );
                    },
                    std::time::Duration::from_millis(100)
                );
            },
            std::time::Duration::from_millis(150)
        );
    };
    
    let handle_keydown = move |e: KeyboardEvent| {
        match e.key().as_str() {
            "ArrowRight" => navigate("next".to_string()),
            "ArrowLeft" => navigate("prev".to_string()),
            _ => {}
        }
    };
    
    create_effect(move |_| {
        let listener = window_event_listener(ev::keydown, handle_keydown);
        on_cleanup(move || drop(listener));
    });
    
    view! {
        <div class="w-full max-w-[93.75rem] mx-auto">
            <div class="slide-viewport relative min-h-[400px] mb-6">
                {move || {
                    let slides_vec = slides.get();
                    let idx = current_index.get();
                    let key = image_key();
                    
                    if let Some(slide) = slides_vec.get(idx) {
                        view! {
                            <div class="slide-item entered" key=key.clone()>
                                <div class="image-container overflow-hidden rounded-lg">
                                    <SliderImage
                                        src=slide.image.clone()
                                        alt=format!("Слайд {} проекта {}", idx + 1, project.title)
                                        priority={idx == 0}
                                    />
                                </div>
                            </div>
                        }.into_view()
                    } else {
                        view! {
                            <div class="slide-item entered">
                                <div class="skeleton w-full h-[400px] flex items-center justify-center">
                                    <div class="loading-spinner"></div>
                                </div>
                            </div>
                        }.into_view()
                    }
                }}
            </div>
            
            <div class="px-8 pb-8">
                <NavigationButtons 
                    on_navigate=Callback::new(navigate)
                    disabled={slider_state.get() != SliderState::Idle}
                />

                <div class=move || {
                    if content_visible.get() {
                        "slide-content space-y-4 font-onest text-[3.28125rem] md:text-[1.25rem]"
                    } else {
                        "slide-content hidden space-y-4 font-onest text-[3.28125rem] md:text-[1.25rem]"
                    }
                }>
                    {move || {
                        let slides_vec = slides.get();
                        let idx = current_index.get();
                        
                        if let Some(slide) = slides_vec.get(idx) {
                            view! {
                                <div class="space-y-4">
                                    {slide.task.as_ref().map(|task| view! {
                                        <p class="animate-slide-up">
                                            <span class="font-semibold">"Задача: "</span>
                                            <span class="opacity-80">{task}</span>
                                        </p>
                                    })}
                                    
                                    {slide.solution.as_ref().map(|solution| view! {
                                        <p class="animate-slide-up" style="animation-delay: 50ms">
                                            <span class="font-semibold">"Решение: "</span>
                                            <span class="opacity-80">{solution}</span>
                                        </p>
                                    })}
                                </div>
                            }.into_view()
                        } else {
                            view! {
                                <div class="text-center py-8 text-white/60">
                                    "Содержимое недоступно"
                                </div>
                            }.into_view()
                        }
                    }}
                </div>
            </div>
        </div>
    }
}
