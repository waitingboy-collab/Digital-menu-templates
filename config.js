// ============================================================
// CONFIG.JS — Единственият файл, който трябва да пипаш за нов клиент
// ============================================================
// Зареждай ГО ПРЕДИ app.js / admin.js / orders.js във всеки HTML файл:
//   <script src="config.js"></script>
//   <script src="app.js"></script>

window.CLIENT_CONFIG = {

    // --- Supabase проект на КЛИЕНТА (създай нов проект за всеки клиент) ---
    supabase: {
        url: "https://rhqirgmxfaeqsihuvqym.supabase.co",
        anonKey: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InJocWlyZ214ZmFlcXNpaHV2cXltIiwicm9sZSI6ImFub24iLCJpYXQiOjE3ODI5OTUwOTQsImV4cCI6MjA5ODU3MTA5NH0.ua9LKCdXgTP9cp48t_DGmHyixBqk4F0dJf424B20vec"
    },

    // Име на Storage bucket-а за снимки (създава се в новия Supabase проект)
    storageBucket: "menu-images",

    // Дали клиентът има опция за поръчки, или е само витрина/преглед на менюто
    // false = скрива количка, "+" бутони, номер на маса, изпращане на поръчка
    enableOrdering: true,

    // --- Тема / брандиране на клиента ---
    theme: {
        primary: "#155e75",      // основен цвят (сегашен: cyan-800) — навигация, бутони
        primaryDark: "#164e63",  // hover версия (cyan-900)
        accent: "#d97706",       // акцент (сегашен: amber-600) — цени
        accentDark: "#b45309",   // hover версия (amber-700)
        bgGradientFrom: "#e0f2fe", // фон градиент старт (sky-200)
        bgGradientVia: "#cffafe",  // фон градиент среда (cyan-100)
        bgGradientTo: "#fffbeb"    // фон градиент край (amber-50)
    }
};

// Прилага темата като CSS променливи върху :root — извиква се автоматично
(function applyTheme() {
    const t = window.CLIENT_CONFIG.theme;
    const root = document.documentElement;
    root.style.setProperty("--brand-primary", t.primary);
    root.style.setProperty("--brand-primary-dark", t.primaryDark);
    root.style.setProperty("--brand-accent", t.accent);
    root.style.setProperty("--brand-accent-dark", t.accentDark);
    root.style.setProperty("--brand-bg-from", t.bgGradientFrom);
    root.style.setProperty("--brand-bg-via", t.bgGradientVia);
    root.style.setProperty("--brand-bg-to", t.bgGradientTo);
})();
