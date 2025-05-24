use leptos::*;

#[component]
pub fn LoadingSpinner() -> impl IntoView {
    view! {
        <div class="flex h-screen w-full items-center justify-center bg-primary">
            <div class="relative">
                <div class="relative h-32 w-32 md:h-24 md:w-24">
                    <svg class="absolute inset-0" viewBox="0 0 100 100">
                        <circle
                            cx="50"
                            cy="50"
                            r="45"
                            fill="none"
                            stroke="currentColor"
                            stroke-width="2"
                            class="stroke-secondary opacity-20"
                        />
                        <circle
                            cx="50"
                            cy="50"
                            r="35"
                            fill="none"
                            stroke="currentColor"
                            stroke-width="2"
                            class="stroke-secondary opacity-15"
                        />
                    </svg>
                    
                    <svg
                        class="absolute inset-0 animate-spin-slow"
                        viewBox="0 0 100 100"
                    >
                        <circle
                            cx="50"
                            cy="50"
                            r="45"
                            fill="none"
                            stroke="currentColor"
                            stroke-width="2"
                            stroke-dasharray="30 10"
                            class="stroke-secondary"
                        />
                    </svg>
                </div>
                
                <div class="absolute -bottom-12 left-1/2 -translate-x-1/2 w-full text-center">
                    <div class="text-secondary text-xl tracking-widest animate-pulse-slow font-mv-skifer">
                        "ЗАГРУЗКА"
                    </div>
                </div>
            </div>
        </div>
    }
}
