use crate::shared::types::PortfolioItem;

pub fn get_portfolio_data() -> Vec<PortfolioItem> {
    vec![
        PortfolioItem {
            id: "project1".to_string(),
            image: "/assets/images/threads.png".to_string(),
            alt: "НИТИ".to_string(),
        },
        PortfolioItem {
            id: "project2".to_string(),
            image: "/assets/images/code.png".to_string(),
            alt: "КОДИИМ".to_string(),
        },
        PortfolioItem {
            id: "project3".to_string(),
            image: "/assets/images/day.png".to_string(),
            alt: "День физики".to_string(),
        },
        PortfolioItem {
            id: "project4".to_string(),
            image: "/assets/images/presentation.png".to_string(),
            alt: "Дизайн презентаций".to_string(),
        },
    ]
}
