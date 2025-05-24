use leptos::*;
use crate::widgets::header::Header;
use crate::widgets::footer::Footer;
use crate::widgets::portfolio_section::PortfolioSection;
use crate::features::project_modal::ProjectModal;
use crate::shared::data::get_project_by_id;

#[component]
pub fn HomePage() -> impl IntoView {
    let (selected_project_id, set_selected_project_id) = create_signal(None::<String>);
    
    let on_card_click = Callback::new(move |id: String| {
        set_selected_project_id.set(Some(id));
    });
    
    view! {
        <div class="bg-primary text-white min-h-screen">
            <Header />
            
            <main>
                <PortfolioSection on_card_click />
            </main>
            
            <Footer />
            
            // Модальное окно
            {move || {
                selected_project_id.get().and_then(|id| {
                    get_project_by_id(&id).map(|project| view! {
                        <ProjectModal 
                            project 
                            on_close=set_selected_project_id
                        />
                    })
                })
            }}
        </div>
    }
}
