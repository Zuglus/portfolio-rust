use leptos::*;
use crate::entities::experience_item::ExperienceItem;
use crate::shared::data::get_experience_data;

#[component]
pub fn ExperienceSection() -> impl IntoView {
    let experience_data = get_experience_data();
    
    view! {
        <section class="relative mx-auto px-4 py-[0.75rem] max-w-[75rem]">
            <div class="absolute top-3/4 left-1/2 w-[56rem] md:w-auto -translate-x-[35.7rem] md:-translate-x-[23rem] overflow-hidden">
            </div>

            {experience_data.into_iter().map(|item| view! {
                <ExperienceItem experience=item />
            }).collect_view()}
        </section>
    }
}
