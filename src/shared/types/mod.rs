pub type Id = String;

#[derive(Clone, Debug)]
pub struct PortfolioItem {
    pub id: Id,
    pub image: String,
    pub alt: String,
}

#[derive(Clone, Debug)]
pub struct Experience {
    pub year: String,
    pub company: String,
    pub position: String,
    pub duties: Vec<String>,
    pub circle_image: Option<String>,
}

#[derive(Clone, Debug)]
pub struct Project {
    pub id: Id,
    pub title: String,
    pub description: String,
    pub audience: String,
    pub slides: Vec<Slide>,
}

#[derive(Clone, Debug)]
pub struct Slide {
    pub image: String,
    pub task: Option<String>,
    pub solution: Option<String>,
}
