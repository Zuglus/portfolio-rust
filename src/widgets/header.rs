use leptos::*;

#[component]
pub fn Header() -> impl IntoView {
    view! {
        <header class="relative mx-auto px-4 py-[3.75rem] max-w-[75rem]">
            <div class="flex justify-center items-center">
                <div class="flex items-center gap-[2rem]">
                    <div class="h-[12rem] md:h-[8rem] w-auto">
                        <div class="w-[12rem] md:w-[8rem] h-[12rem] md:h-[8rem] bg-secondary/20 rounded-full flex items-center justify-center">
                            <span class="text-2xl font-mv-skifer text-secondary">"П"</span>
                        </div>
                    </div>
                    
                    <div class="flex flex-col text-left whitespace-nowrap">
                        <div class="flex items-center gap-[1.5rem]">
                            <h1 class="font-mv-skifer text-[7.3125rem] md:text-[4.875rem] leading-none">
                                "Полина"
                            </h1>
                            <div class="font-light font-onest text-[2.25rem] md:text-[1.5rem] leading-tight tracking-wider">
                                "графический" <br/> "дизайнер"
                            </div>
                        </div>
                        
                        <h1 class="font-mv-skifer text-[7.3125rem] md:text-[4.875rem] leading-none">
                            "Мигранова"
                        </h1>
                    </div>
                </div>
            </div>
        </header>
    }
}
