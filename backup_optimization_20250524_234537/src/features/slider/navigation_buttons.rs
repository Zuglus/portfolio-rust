use leptos::*;

#[component]
pub fn NavigationButtons(
    on_navigate: Callback<String>,
    disabled: bool,
) -> impl IntoView {
    let button_class = if disabled {
        "nav-button interactive-element opacity-38 cursor-not-allowed border border-white/20 rounded-full flex items-center justify-center text-7xl w-[5rem] h-[5rem] md:w-[3rem] md:h-[3rem] md:text-5xl transition-all duration-medium2 ease-standard"
    } else {
        "nav-button interactive-element hover:text-secondary cursor-pointer border border-white/20 rounded-full flex items-center justify-center text-7xl w-[5rem] h-[5rem] md:w-[3rem] md:h-[3rem] md:text-5xl transition-all duration-medium2 ease-emphasized"
    };
    
    view! {
        <div class="flex justify-center space-x-6 my-6">
            <button
                on:click=move |_| if !disabled { on_navigate.call("prev".to_string()) }
                class=button_class
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
