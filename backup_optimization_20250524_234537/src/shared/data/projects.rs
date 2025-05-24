use crate::shared::types::{Project, Slide};

pub fn get_projects_data() -> Vec<Project> {
    vec![
        Project {
            id: "project1".to_string(),
            title: "НИТИ".to_string(),
            description: "Кластер проектов по управлению современным образованием".to_string(),
            audience: "менеджеры образования, управленцы, преимущественно женщины старше 40".to_string(),
            slides: vec![
                Slide {
                    image: "/assets/images/niti/niti1.png".to_string(),
                    task: Some("ребрендинг образовательного продукта, создание айдентики, гармонично сочетающей эстетику с глубоким смысловым содержанием. Основной акцент на женственность, лидерство и стремление к профессиональному росту".to_string()),
                    solution: Some("цветовая палитра создает ощущение серьезного подхода к вызовам современного образования. Возраст целевой аудитории определяет использование цветов с более короткой длиной волны (выбран синий, использовался и ранее, но изменены оттенки и градиенты). Новые элементы айдентики подчеркивают глубину образовательного материала".to_string()),
                },
                Slide {
                    image: "/assets/images/niti/niti2.png".to_string(),
                    task: Some("ребрендинг образовательного продукта, создание айдентики, гармонично сочетающей эстетику с глубоким смысловым содержанием. Основной акцент на женственность, лидерство и стремление к профессиональному росту".to_string()),
                    solution: Some("цветовая палитра создает ощущение серьезного подхода к вызовам современного образования. Возраст целевой аудитории определяет использование цветов с более короткой длиной волны (выбран синий, использовался и ранее, но изменены оттенки и градиенты). Новые элементы айдентики подчеркивают глубину образовательного материала".to_string()),
                },
                Slide {
                    image: "/assets/images/niti/niti3.png".to_string(),
                    task: Some("разработка мерча для мероприятия".to_string()),
                    solution: Some("цветовая палитра создает ощущение серьезного подхода к вызовам современного образования. Возраст целевой аудитории определяет использование цветов с более короткой длиной волны (выбран синий, использовался и ранее, но изменены оттенки и градиенты). Новые элементы айдентики подчеркивают глубину образовательного материала".to_string()),
                },
                Slide {
                    image: "/assets/images/niti/niti4.png".to_string(),
                    task: Some("создание smm-материалов (карточек)".to_string()),
                    solution: Some("разработка основных элементов фирменного стиля (сохранение общих моментов и введение разнообразия для привлечения внимания), расстановка акцентов для выделения существенной информации".to_string()),
                },
                Slide {
                    image: "/assets/images/niti/niti5.png".to_string(),
                    task: Some("создание smm-материалов (карточек)".to_string()),
                    solution: Some("разработка основных элементов фирменного стиля (сохранение общих моментов и введение разнообразия для привлечения внимания), расстановка акцентов для выделения существенной информации".to_string()),
                },
            ],
        },
        Project {
            id: "project2".to_string(),
            title: "КОДИИМ".to_string(),
            description: "Проект по искусственному интеллекту, обучению программированию и созданию нейронных сетей".to_string(),
            audience: "учащиеся 6-11 классов, интересующиеся программированием и ИИ".to_string(),
            slides: vec![
                Slide {
                    image: "/assets/images/code/code1.png".to_string(),
                    task: Some("оформление ивента — Московского городского конкурса для школьников в области ИИ (мерча для подарков победителям и призерам)".to_string()),
                    solution: Some("современная подача, цветовые отличия в бейджах, палитра отражает технологичность бренда".to_string()),
                },
                Slide {
                    image: "/assets/images/code/code2.png".to_string(),
                    task: Some("создать уникальный и запоминающийся мерч для буткемпа по ИИ".to_string()),
                    solution: Some("в разработке мерча реализован уникальный подход: смыслы мероприятия представлены как код в программировании".to_string()),
                },
                Slide {
                    image: "/assets/images/code/code3.png".to_string(),
                    task: Some("редизайн smm-материалов".to_string()),
                    solution: Some("разнообразие цветов, активное использование нейросетей для генерации иллюстраций и персонажей".to_string()),
                },
                Slide {
                    image: "/assets/images/code/code4.png".to_string(),
                    task: Some("редизайн smm-материалов".to_string()),
                    solution: Some("разнообразие цветов, активное использование нейросетей для генерации иллюстраций и персонажей".to_string()),
                },
            ],
        },
        Project {
            id: "project3".to_string(),
            title: "День физики".to_string(),
            description: "Мероприятие состоялось 17 сентября 2023 года в день рождения Циолковского на базе вузов в 22 городах страны".to_string(),
            audience: "старшеклассники, интересующиеся наукой, выбирают будущую профессию".to_string(),
            slides: vec![
                Slide {
                    image: "/assets/images/fizics/fizics1.png".to_string(),
                    task: Some("разработать карточки для игры «Технообмен» в айдентике бренда, но с указанными новыми цветами. Участники получали карточки в обмен на выполнение заданий".to_string()),
                    solution: Some("изучить биографии российских и советских учёных. Было важно показать, что теоретические открытия не самоцель, наука призвана решать конкретные практические задачи. Так родилась идея написать тексты об открытиях на обороте и добавлять надпись «НАУКА=ТЕОРИЯ+ПРАКТИКА». Цитаты учёных были подобраны для трансляции ценностей об отношении к профессии, труду и обществу".to_string()),
                },
                Slide {
                    image: "/assets/images/fizics/fizics2.png".to_string(),
                    task: Some("разработать макет открыток с российскими физиками, используя айдентику мероприятия".to_string()),
                    solution: Some("изучить биографии российских и советских учёных. Было важно показать, что теоретические открытия не самоцель, наука призвана решать конкретные практические задачи. Так родилась идея написать тексты об открытиях на обороте и добавлять надпись «НАУКА=ТЕОРИЯ+ПРАКТИКА». Цитаты учёных были подобраны для трансляции ценностей об отношении к профессии, труду и обществу".to_string()),
                },
                Slide {
                    image: "/assets/images/fizics/fizics3.png".to_string(),
                    task: Some("разработать карточки для игры «Технообмен» в айдентике бренда, но с указанными новыми цветами. Участники получали карточки в обмен на выполнение заданий".to_string()),
                    solution: Some("создание легко читаемых макетов с указанием темы, года, ранжирования и категории по цвету".to_string()),
                },
            ],
        },
        Project {
            id: "project4".to_string(),
            title: "Презентации".to_string(),
            description: "".to_string(),
            audience: "".to_string(),
            slides: vec![
                Slide {
                    image: "/assets/images/presentations/0.png".to_string(),
                    task: None,
                    solution: None,
                },
                Slide {
                    image: "/assets/images/presentations/1.png".to_string(),
                    task: None,
                    solution: None,
                },
                Slide {
                    image: "/assets/images/presentations/2.png".to_string(),
                    task: None,
                    solution: None,
                },
                Slide {
                    image: "/assets/images/presentations/3.png".to_string(),
                    task: None,
                    solution: None,
                },
                Slide {
                    image: "/assets/images/presentations/4.png".to_string(),
                    task: None,
                    solution: None,
                },
                Slide {
                    image: "/assets/images/presentations/5.png".to_string(),
                    task: None,
                    solution: None,
                },
                Slide {
                    image: "/assets/images/presentations/6.png".to_string(),
                    task: None,
                    solution: None,
                },
                Slide {
                    image: "/assets/images/presentations/7.png".to_string(),
                    task: None,
                    solution: None,
                },
                Slide {
                    image: "/assets/images/presentations/8.png".to_string(),
                    task: None,
                    solution: None,
                },
            ],
        },
    ]
}

pub fn get_project_by_id(id: &str) -> Option<Project> {
    get_projects_data().into_iter().find(|p| p.id == id)
}
