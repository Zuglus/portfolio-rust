use leptos::*;
use leptos::html::Div;
use web_sys::KeyboardEvent;
use crate::features::project_modal::ModalHeader;
use crate::shared::types::Project;

#[component]
pub fn ProjectModal(
    project: Project,
    on_close: WriteSignal<Option<String>>,
) -> impl IntoView {
    let modal_ref = create_node_ref::<Div>();
    
    // Обработчик клавиш
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
                        
                        // Показываем первый слайд
                        {project.slides.first().map(|slide| view! {
                            <div class="w-full">
                                <img 
                                    src=&slide.image
                                    alt="Слайд проекта"
                                    class="w-full object-contain"
                                />
                                
                                <div class="mt-6 font-onest text-[3.28125rem] md:text-[1.25rem] space-y-4">
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
                        })}
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
