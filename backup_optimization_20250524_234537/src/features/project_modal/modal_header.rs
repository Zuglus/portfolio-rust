use leptos::*;
use crate::shared::types::Project;

#[component]
pub fn ModalHeader(project: Project) -> impl IntoView {
    view! {
        <header class="space-y-[2.8125rem] md:space-y-[1.875rem] mb-8">
            <div>
                {(!project.title.is_empty()).then(|| view! {
                    <h3 class="font-mv-skifer text-[4.6875rem] md:text-[3.125rem]">
                        {&project.title}
                    </h3>
                })}

                {(!project.description.is_empty()).then(|| view! {
                    <h4 class="mb-4 font-extralight text-[3.28125rem] md:text-2xl leading-normal">
                        {&project.description}
                    </h4>
                })}

                {(!project.audience.is_empty()).then(|| view! {
                    <p class="font-onest text-[3.28125rem] md:text-[1.25rem]">
                        <span class="font-semibold">"Целевая аудитория: "</span>
                        <span class="opacity-80">{&project.audience}</span>
                    </p>
                })}
            </div>
        </header>
    }
}
