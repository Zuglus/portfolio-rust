use leptos::*;
use portfolio_rust::app::App;

fn main() {
    // Настройка panic hook для лучшей отладки в браузере
    console_error_panic_hook::set_once();
    
    // Монтируем приложение
    mount_to_body(App);
}
