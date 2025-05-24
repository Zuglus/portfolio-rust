use leptos::*;
use crate::shared::types::PortfolioItem;

#[component]
pub fn ProjectCard(item: PortfolioItem) -> impl IntoView {
    view! {
        <div class="bg-white/5 hover:shadow-lg rounded-[1.875rem] md:rounded-[1.25rem] transition-all hover:-translate-y-2 duration-300 cursor-pointer overflow-hidden focus:outline-none focus:ring-2 focus:ring-blue-500 group">
            <img 
                src=&item.image
                alt=&item.alt
                class="group-hover:scale-105 w-full transition-transform duration-300 object-cover"
            />
        </div>
    }
}
