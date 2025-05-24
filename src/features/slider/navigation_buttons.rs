use leptos::*;

#[component]
pub fn NavigationButtons(
    on_navigate: Callback<String>,
    disabled: bool,
) -> impl IntoView {
    let base_button_style = "border transition-all duration-300 rounded-full flex items-center justify-center text-7xl w-[5rem] h-[5rem] border-white/20 md:w-[3rem] md:h-[3rem] md:text-5xl";
    
    let enabled_styles = "hover:bg-white hover:text-[#3624A6] cursor-pointer active:scale-95 transform";
    let disabled_styles = "opacity-50 cursor-not-allowed";
    
    let button_class = if disabled {
        format!("{} {}", base_button_style, disabled_styles)
    } else {
        format!("{} {}", base_button_style, enabled_styles)
    };
    
    view! {
        <div class="flex justify-center space-x-6 my-6">
            <button
                on:click=move |_| if !disabled { on_navigate.call("prev".to_string()) }
                class=button_class.clone()
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
