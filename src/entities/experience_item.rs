use leptos::*;
use crate::shared::types::Experience;

#[component]
pub fn ExperienceItem(experience: Experience) -> impl IntoView {
    view! {
        <div class="ml-[30.1025rem] md:ml-[31.875rem] mb-[7.21875rem] md:mb-[4.8125rem]">
            <div class="relative">
                {experience.circle_image.map(|_| view! {
                    <div class="absolute -top-[1.40625rem] md:-top-[0.9375rem] -left-[12.375rem] md:-left-[8.25rem] w-[7.875rem] md:w-[5.25rem] h-[7.875rem] md:h-[5.25rem]">
                        <div class="w-full h-full bg-secondary/20 rounded-full flex items-center justify-center">
                            <span class="text-secondary text-xs">"●"</span>
                        </div>
                    </div>
                })}
                
                <div>
                    <p class="mb-[0.1875rem] md:mb-[0.125rem] font-extralight font-onest text-[3.28125rem] md:text-[2.1875rem] leading-[1.33] tracking-[0.01em]">
                        {&experience.year}
                    </p>
                    <h3 class="mb-[0.65625rem] md:mb-[0.4375rem] font-medium font-onest text-[3.28125rem] md:text-[2.1875rem] leading-[1.25] tracking-[0.01em]">
                        {&experience.company}
                    </h3>
                    <h3 class="mb-[0.65625rem] md:mb-[0.4375rem] font-medium font-onest text-[3.28125rem] md:text-[2.1875rem] leading-[1.33] tracking-[0.01em]">
                        {&experience.position}
                    </h3>
                    <ul class="font-extralight text-[3.28125rem] md:text-[2.1875rem] list-none relative">
                        {experience.duties.into_iter().map(|duty| view! {
                            <li class="mb-[0.75rem] md:mb-[0.5rem]">
                                <span class="-left-[4.71rem] md:-left-[3.14rem] absolute font-onest font-thin">
                                    "→"
                                </span>
                                {duty}
                            </li>
                        }).collect_view()}
                    </ul>
                </div>
            </div>
        </div>
    }
}
