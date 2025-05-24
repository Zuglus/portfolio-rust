pub mod portfolio;
pub mod projects;

pub use portfolio::get_portfolio_data;
pub use projects::{get_projects_data, get_project_by_id};
