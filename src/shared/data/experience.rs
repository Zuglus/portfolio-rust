use crate::shared::types::Experience;

pub fn get_experience_data() -> Vec<Experience> {
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
            circle_image: Some("/assets/images/kruzhok_opyt_raboty.svg".to_string()),
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
