# Нов клиент за ~15 минути

## 1. Създай нов Supabase проект
- [supabase.com/dashboard](https://supabase.com/dashboard) → New project
- Изчакай да се вдигне (1-2 мин)

## 2. Пусни схемата
- SQL Editor → New query → постави съдържанието на `setup_supabase.sql` → Run
- Storage → New bucket → `menu-images` → Public: **да**
  (ако вече не се е създал автоматично от скрипта)

## 3. Създай админ потребител
- Authentication → Users → Add user → имейл + парола на клиента
- Това са данните, с които клиентът влиза в `admin.html` / `orders.html`

## 4. Вземи ключовете на проекта
- Project Settings → API → копирай `Project URL` и `anon public` ключа

## 5. Редактирай `config.js` (единственият файл, който пипаш)
```js
supabase: {
    url: "ТУК project URL",
    anonKey: "ТУК anon ключ"
},
enableOrdering: true,   // false = само преглед на менюто, без поръчки
theme: {
    primary: "#155e75",  // основен брандинг цвят на клиента
    accent: "#d97706",   // цвят за цени/акценти
    ...
}
```

## 6. (По избор) Смени фирмения фон по подразбиране
- Ако клиентът няма собствена снимка, `bgGradientFrom/Via/To` в config.js
  определят фона; или качи снимка от админ панела по-късно.

## 7. Деплойни
- Качи папката (index.html, admin.html, orders.html*, app.js, admin.js,
  orders.js*, config.js, theme.css) във Vercel / Netlify / хостинг по избор
- Тествай: отвори менюто, влез в админ панела, добави артикул, провери QR

  \* orders.html/orders.js се пропускат ако клиентът е само с преглед
    (enableOrdering: false) — не е задължително да ги качваш.

## 8. Генерирай QR код
- Насочи го към адреса на `index.html` (напр. `menyu.клиент.com`)

---

### Чеклист за всеки нов клиент
- [ ] Нов Supabase проект + SQL схема
- [ ] Storage bucket `menu-images`
- [ ] Админ потребител (имейл/парола)
- [ ] `config.js` — url, anonKey, enableOrdering, theme
- [ ] Деплой
- [ ] QR код
