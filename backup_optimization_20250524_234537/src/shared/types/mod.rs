pub type Id = String;

#[derive(Clone, Debug, PartialEq)]
pub struct PortfolioItem {
    pub id: Id,
    pub image: String,
    pub alt: String,
}

#[derive(Clone, Debug, PartialEq)]
pub struct Project {
    pub id: Id,
    pub title: String,
    pub description: String,
    pub audience: String,
    pub slides: Vec<Slide>,
}

#[derive(Clone, Debug, PartialEq)]
pub struct Slide {
    pub image: String,
    pub task: Option<String>,
    pub solution: Option<String>,
}
