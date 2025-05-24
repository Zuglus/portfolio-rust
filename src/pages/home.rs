use leptos::*;
use crate::widgets::header::Header;
use crate::widgets::footer::Footer;
use crate::widgets::portfolio_section::PortfolioSection;
use crate::widgets::resume_section::ResumeSection;
use crate::widgets::experience_section::ExperienceSection;

#[component]
pub fn HomePage() -> impl IntoView {
    view! {
        <div class="bg-primary text-white min-h-screen">
            <Header />
            
            <main>
                <PortfolioSection />
                <ResumeSection />
                <ExperienceSection />
            </main>
            
            <Footer />
        </div>
    }
}
