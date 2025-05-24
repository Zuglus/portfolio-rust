use crate::shared::types::{PortfolioItem, Experience};

pub fn get_portfolio_mock_data() -> Vec<PortfolioItem> {
    vec![
        PortfolioItem {
            id: "project1".to_string(),
            image: "/mock-project1.jpg".to_string(),
            alt: "НИТИ".to_string(),
        },
        PortfolioItem {
            id: "project2".to_string(),
            image: "/mock-project2.jpg".to_string(),
            alt: "КОДИИМ".to_string(),
        },
        PortfolioItem {
            id: "project3".to_string(),
            image: "/mock-project3.jpg".to_string(),
            alt: "День физики".to_string(),
        },
        PortfolioItem {
            id: "project4".to_string(),
            image: "/mock-project4.jpg".to_string(),
            alt: "Дизайн презентаций".to_string(),
        },
    ]
}

pub fn get_experience_mock_data() -> Vec<Experience> {
    vec![
        Experience {
            year: "2023-2024".to_string(),
            company: "Центр Педагогического Мастерства".to_string(),
            position: "Графический дизайнер".to_string(),
            duties: vec![
                "Фирменный стиль".to_string(),
                "SMM-дизайн (соцсети)".to_string(),
                "Презентации".to_string(),
                "Полиграфия".to_string(),
            ],
            circle_image: Some("/mock-circle.png".to_string()),
        },
        Experience {
            year: "2021-2022".to_string(),
            company: "Банк УБРиР".to_string(),
            position: "Ведущий дизайнер отдела коммуникаций".to_string(),
            duties: vec![
                "Презентации".to_string(),
                "Коммуникационный дизайн".to_string(),
                "Полиграфия".to_string(),
            ],
            circle_image: None,
        },
    ]
}

pub fn get_skills_data() -> (Vec<String>, Vec<String>) {
    let hard_skills = vec![
        "PowerPoint".to_string(),
        "Figma".to_string(),
        "Photoshop, Illustrator, InDesign".to_string(),
    ];
    
    let soft_skills = vec![
        "Системность".to_string(),
        "Креативность".to_string(),
        "Ответственность".to_string(),
    ];
    
    (hard_skills, soft_skills)
}
