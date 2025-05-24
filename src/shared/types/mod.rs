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
