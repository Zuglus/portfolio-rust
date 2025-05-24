use leptos::*;

#[component]
pub fn SliderImage(
    src: String,
    alt: String,
    priority: bool,
) -> impl IntoView {
    let (image_state, set_image_state) = create_signal("loading".to_string());
    let src_clone = src.clone(); // Создаем клон для использования в closure
    
    view! {
        <div class="relative w-full min-h-[400px] flex items-center justify-center bg-white/2 rounded-lg">
            // Индикатор загрузки
            {move || {
                let src_for_display = src_clone.clone(); // Клон для отображения в ошибке
                match image_state.get().as_str() {
                    "loading" => view! {
                        <div class="absolute inset-0 flex items-center justify-center">
                            <div class="text-white/60 text-xl animate-pulse">"Загрузка..."</div>
                        </div>
                    }.into_view(),
                    "error" => view! {
                        <div class="absolute inset-0 flex flex-col items-center justify-center bg-red-500/10 rounded-lg text-red-400">
                            <div class="text-lg mb-2">"❌ Изображение не найдено"</div>
                            <div class="text-sm opacity-70 px-4 text-center break-all">{src_for_display}</div>
                        </div>
                    }.into_view(),
                    _ => view! { <div/> }.into_view()
                }
            }}
            
            // Изображение
            <img
                src=src
                alt=alt
                class="w-full h-auto object-contain max-h-[70vh] rounded-lg"
                style=move || {
                    match image_state.get().as_str() {
                        "loaded" => "display: block;",
                        _ => "display: none;"
                    }
                }
                on:load=move |_| set_image_state.set("loaded".to_string())
                on:error=move |_| set_image_state.set("error".to_string())
                loading=if priority { "eager" } else { "lazy" }
            />
        </div>
    }
}
