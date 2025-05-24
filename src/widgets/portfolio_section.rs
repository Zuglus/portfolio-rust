use leptos::*;
use crate::entities::project_card::ProjectCard;
use crate::shared::data::get_portfolio_data;

#[component]
pub fn PortfolioSection(
    on_card_click: Callback<String>,
) -> impl IntoView {
    let portfolio_data = get_portfolio_data();
    
    view! {
        <section class="relative mx-auto px-4 py-[7.75rem] max-w-[75rem]">
            <div class="relative mb-[4.1875rem] text-center z-0">
                <div class="absolute top-[-2.875rem] md:top-[-1.875rem] left-[50%] w-[25.875rem] md:w-[17.25rem] h-[28.0125rem] md:h-[18.675rem] transform -translate-x-[20.6rem] md:-translate-x-[13.625rem] z-0">
                    <img 
                        src="/assets/images/rings_with_circle.svg" 
                        alt="Декоративные кольца" 
                        class="w-full h-full object-contain"
                    />
                </div>
                <h2 class="font-mv-skifer text-[4.6875rem] md:text-[3.125rem] leading-[1.24] tracking-[0.01em] relative z-10">
                    "Портфолио"
                </h2>
            </div>

            <div class="relative z-10 gap-[2.71875rem] md:gap-[1.8125rem] grid grid-cols-1 md:grid-cols-2 mx-auto max-w-[70.65625rem] md:max-w-full">
                {portfolio_data.into_iter().map(|item| {
                    let on_click = on_card_click.clone();
                    view! {
                        <ProjectCard item on_click />
                    }
                }).collect_view()}
            </div>
        </section>
    }
}
