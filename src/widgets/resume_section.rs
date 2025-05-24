use leptos::*;
use crate::shared::data::get_skills_data;

#[component]
pub fn ResumeSection() -> impl IntoView {
    let (hard_skills, soft_skills) = get_skills_data();
    
    view! {
        <section class="relative mx-auto px-4 py-[3.75rem] max-w-[75rem]">
            <div class="absolute left-1/2 top-[40.5rem] md:top-[27rem] w-[48.78125rem] overflow-hidden -translate-x-[16rem] md:-translate-x-[16rem]">
                <img src="/assets/images/portfolio.svg" alt="" class="w-full h-full object-contain" />
            </div>
            
            <div class="relative mb-[1.25rem] text-center">
                <div class="absolute top-[-2.875rem] md:top-[-1.875rem] left-[50%] w-[25.875rem] md:w-[17.25rem] h-[28.0125rem] md:h-[18.675rem] transform -translate-x-[14.7rem] md:-translate-x-[9.8rem]">
                    <img src="/assets/images/rings_with_circle.svg" alt="Декоративные кольца" class="w-full h-full object-contain" />
                </div>
                <h2 class="font-mv-skifer text-[4.6875rem] md:text-[3.125rem] leading-[1.24] tracking-[0.01em] relative">
                    "Резюме"
                </h2>
            </div>

            <div class="flex justify-center items-center gap-[1.875rem] md:gap-[1.25rem] mb-[1.25rem]">
                <div class="rounded-full w-[16.6875rem] md:w-[11.125rem] h-[17.25rem] md:h-[11.55rem]">
                    <img src="/assets/images/foto.png" alt="Полина Мигранова" class="relative w-full h-full object-cover rounded-full" />
                </div>
                <h3 class="font-mv-skifer text-[4.6875rem] md:text-[3.125rem] leading-[1.05] tracking-[0.01em]">
                    "Полина" <br/> "Мигранова"
                </h3>
            </div>

            <div class="ml-[29.8125rem] md:ml-[31.875rem]">
                <div class="mb-[5.5rem] md:mb-[3rem]">
                    <h3 class="mb-[0.84375rem] md:mb-[0.5625rem] font-medium font-onest text-[3.75rem] md:text-[2.5rem]">
                        "Hard skills"
                    </h3>
                    <ul class="font-extralight text-[3.28125rem] md:text-[2.1875rem] list-none relative">
                        {hard_skills.into_iter().map(|skill| view! {
                            <li class="mb-[0.75rem] md:mb-[0.1rem]">
                                <span class="-left-[4.71rem] md:-left-[3.14rem] absolute font-onest font-thin">"→"</span>
                                {skill}
                            </li>
                        }).collect_view()}
                    </ul>
                </div>

                <div>
                    <h3 class="mb-[0.84375rem] md:mb-[0.5625rem] font-medium font-onest text-[3.75rem] md:text-[2.5rem]">
                        "Soft skills"
                    </h3>
                    <ul class="font-extralight text-[3.28125rem] md:text-[2.1875rem] list-none relative">
                        {soft_skills.into_iter().map(|skill| view! {
                            <li class="mb-[0.75rem] md:mb-[0.1rem]">
                                <span class="-left-[4.71rem] md:-left-[3.14rem] absolute font-onest font-thin">"→"</span>
                                {skill}
                            </li>
                        }).collect_view()}
                    </ul>
                </div>
            </div>
        </section>
    }
}
