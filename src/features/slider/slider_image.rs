use leptos::*;

#[derive(Clone, Copy, PartialEq)]
enum ImageState {
    Loading,
    Loaded,
    Error,
}

#[component]
pub fn SliderImage(
    src: String,
    alt: String,
    priority: bool,
) -> impl IntoView {
    let (image_state, set_image_state) = create_signal(ImageState::Loading);
    let src_clone = src.clone();
    let src_clone2 = src.clone();
    // Fixed: removed unused src_clone3
    
    // Modern image loading with better error handling
    create_effect(move |prev_src: Option<String>| {
        let current_src = src_clone.clone();
        
        if let Some(prev) = prev_src {
            if prev != current_src {
                set_image_state.set(ImageState::Loading);
            }
        }
        
        current_src
    });
    
    view! {
        <div class="image-container relative w-full min-h-[400px] bg-white/2 rounded-lg overflow-hidden">
            {move || {
                match image_state.get() {
                    ImageState::Loading => view! {
                        <div class="skeleton absolute inset-0 flex items-center justify-center">
                            <div class="loading-spinner"></div>
                        </div>
                    }.into_view(),
                    ImageState::Error => {
                        let error_src = src_clone2.clone();
                        view! {
                            <div class="absolute inset-0 flex flex-col items-center justify-center bg-red-500/10 text-red-400 p-8 animate-fade-in">
                                <div class="text-lg mb-2">"🚫 Изображение недоступно"</div>
                                <div class="text-sm opacity-70 text-center break-all max-w-sm mb-4">
                                    {error_src}
                                </div>
                                <button 
                                    class="interactive-element px-4 py-2 bg-red-500/20 hover:bg-red-500/30 rounded-lg text-sm"
                                    on:click=move |_| {
                                        set_image_state.set(ImageState::Loading);
                                    }
                                >
                                    "Повторить загрузку"
                                </button>
                            </div>
                        }.into_view()
                    },
                    ImageState::Loaded => view! { <div/> }.into_view(),
                }
            }}
            
            <img
                src=src
                alt=alt
                class=move || {
                    match image_state.get() {
                        ImageState::Loaded => "image-loaded visible w-full h-auto object-contain max-h-[70vh] rounded-lg",
                        _ => "image-loaded w-full h-auto object-contain max-h-[70vh] rounded-lg"
                    }
                }
                style=move || {
                    match image_state.get() {
                        ImageState::Loaded => "display: block;",
                        _ => "display: none;"
                    }
                }
                on:load=move |_| {
                    set_image_state.set(ImageState::Loaded);
                }
                on:error=move |_| {
                    set_image_state.set(ImageState::Error);
                }
                loading=if priority { "eager" } else { "lazy" }
                decoding="async"
            />
        </div>
    }
}
