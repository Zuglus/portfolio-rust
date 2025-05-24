use leptos::*;
use crate::widgets::header::Header;
use crate::widgets::footer::Footer;

#[component]
pub fn HomePage() -> impl IntoView {
    view! {
        <div class="bg-primary text-white min-h-screen">
            <Header />
            
            <main>
                <section class="relative mx-auto px-4 py-[7.75rem] max-w-[75rem]">
                    <div class="relative mb-[4.1875rem] text-center z-0">
                        <h2 class="font-mv-skifer text-[4.6875rem] md:text-[3.125rem] leading-[1.24] tracking-[0.01em] relative z-10">
                            "Портфолио"
                        </h2>
                    </div>
                    
                    <div class="relative z-10 gap-[2.71875rem] md:gap-[1.8125rem] grid grid-cols-1 md:grid-cols-2 mx-auto max-w-[70.65625rem] md:max-w-full">
                        {(0..4).map(|i| view! {
                            <div class="bg-white/5 hover:shadow-lg rounded-[1.875rem] md:rounded-[1.25rem] transition-all hover:-translate-y-2 duration-300 cursor-pointer overflow-hidden focus:outline-none focus:ring-2 focus:ring-blue-500 group">
                                <div class="w-full h-64 bg-secondary/20 flex items-center justify-center">
                                    <span class="text-white/60 font-onest">"Проект " {i + 1}</span>
                                </div>
                            </div>
                        }).collect_view()}
                    </div>
                </section>
                
                <section class="relative mx-auto px-4 py-[3.75rem] max-w-[75rem]">
                    <div class="relative mb-[1.25rem] text-center">
                        <h2 class="font-mv-skifer text-[4.6875rem] md:text-[3.125rem] leading-[1.24] tracking-[0.01em] relative">
                            "Резюме"
                        </h2>
                    </div>
                    
                    <div class="flex justify-center items-center gap-[1.875rem] md:gap-[1.25rem] mb-[1.25rem]">
                        <div class="rounded-full w-[16.6875rem] md:w-[11.125rem] h-[17.25rem] md:h-[11.55rem] bg-secondary/20"></div>
                        <h3 class="font-mv-skifer text-[4.6875rem] md:text-[3.125rem] leading-[1.05] tracking-[0.01em]">
                            "Полина" <br/> "Мигранова"
                        </h3>
                    </div>
                </section>
            </main>
            
            <Footer />
        </div>
    }
}
