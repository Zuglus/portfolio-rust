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
