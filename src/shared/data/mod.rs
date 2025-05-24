pub mod portfolio;
pub mod projects;
pub mod experience;

pub use portfolio::get_portfolio_data;
pub use projects::{get_projects_data, get_project_by_id};
pub use experience::get_experience_data;

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
