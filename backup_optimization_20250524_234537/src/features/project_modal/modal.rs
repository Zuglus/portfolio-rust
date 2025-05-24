use leptos::*;
use leptos::html::Div;
use web_sys::KeyboardEvent;
use crate::features::project_modal::ModalHeader;
use crate::features::slider::Slider;
use crate::shared::types::Project;

#[derive(Clone, Copy, PartialEq)]
enum ModalState {
    Hidden,
    Entering,
    Visible,
    Exiting,
}

#[component]
pub fn ProjectModal(
    project: Project,
    on_close: WriteSignal<Option<String>>,
) -> impl IntoView {
    let modal_ref = create_node_ref::<Div>();
    let (modal_state, set_modal_state) = create_signal(ModalState::Entering);
    
    // Плавное открытие
    create_effect(move |_| {
        if modal_state.get() == ModalState::Entering {
            set_timeout(
                move || set_modal_state.set(ModalState::Visible),
                std::time::Duration::from_millis(50)
            );
        }
    });
    
    // Современный обработчик закрытия с предварительной анимацией
    let handle_close = move || {
        set_modal_state.set(ModalState::Exiting);
        set_timeout(
            move || on_close.set(None),
            std::time::Duration::from_millis(200)
        );
    };
    
    // Обработчик клавиш
    let handle_keydown = move |e: KeyboardEvent| {
        if e.key() == "Escape" {
            handle_close();
        }
    };
    
    // Блокировка скролла с плавным переходом
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
    
    // Глобальный слушатель клавиш
    create_effect(move |_| {
        let listener = window_event_listener(ev::keydown, handle_keydown);
        on_cleanup(move || drop(listener));
    });
    
    // Динамические классы для анимаций
    let backdrop_class = move || {
        match modal_state.get() {
            ModalState::Entering => "modal-backdrop fixed inset-0 z-50 flex items-center justify-center",
            ModalState::Visible => "modal-backdrop modal-backdrop enter-active fixed inset-0 z-50 flex items-center justify-center",
            ModalState::Exiting => "modal-backdrop modal-backdrop exit-active fixed inset-0 z-50 flex items-center justify-center",
            ModalState::Hidden => "modal-backdrop fixed inset-0 z-50 flex items-center justify-center opacity-0",
        }
    };
    
    let container_class = move || {
        let base = "modal-container relative w-full max-w-7xl mx-auto my-4 bg-primary border border-white/10 rounded-[1.875rem] md:rounded-[1.25rem] shadow-xl overflow-hidden";
        match modal_state.get() {
            ModalState::Entering => format!("{} enter", base),
            ModalState::Visible => format!("{} enter-active", base),
            ModalState::Exiting => format!("{} exit-active", base),
            ModalState::Hidden => format!("{} opacity-0", base),
        }
    };
    
    view! {
        <div 
            class=backdrop_class
            on:click=move |_| handle_close()
            node_ref=modal_ref
        >
            <div
                class=container_class
                on:click=move |e| e.stop_propagation()
            >
                <div class="h-[90vh] overflow-y-auto modal-scrollbar">
                    <div class="p-[3.75rem] md:p-[2.5rem]">
                        <ModalHeader project=project.clone() />
                        <Slider project />
                    </div>
                </div>

                // Современная кнопка закрытия с state layer
                <button
                    on:click=move |_| handle_close()
                    class="interactive-element nav-button absolute top-6 right-6 p-4 md:p-2 rounded-full 
                           bg-black/40 backdrop-blur-sm 
                           hover:bg-black/60 
                           focus-visible:outline-2 focus-visible:outline-white/50
                           z-50 group
                           shadow-lg"
                    aria-label="Закрыть"
                >
                    <svg
                        class="w-12 h-12 md:w-6 md:h-6 text-white/80 group-hover:text-white
                             transition-colors duration-short2 ease-standard"
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
