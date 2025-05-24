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
