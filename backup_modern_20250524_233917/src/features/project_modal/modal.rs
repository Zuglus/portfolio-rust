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
