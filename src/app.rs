use leptos::*;

/// Корневой компонент приложения
#[component]
pub fn App() -> impl IntoView {
    view! {
        <div class="min-h-screen bg-primary text-white">
            <div class="flex h-screen items-center justify-center">
                <div class="text-center">
                    <h1 class="font-mv-skifer text-7xl mb-4">
                        "Hello, Leptos!"
                    </h1>
                    <p class="font-onest text-xl text-white/80">
                        "Миграция портфолио на Rust"
                    </p>
                </div>
            </div>
        </div>
    }
}
