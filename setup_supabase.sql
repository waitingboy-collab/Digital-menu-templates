-- ============================================================
-- НАСТРОЙКА НА НОВ SUPABASE ПРОЕКТ ЗА НОВ КЛИЕНТ
-- Изпълни целия скрипт в: Supabase Dashboard → SQL Editor → New query
-- ============================================================

-- 1. Таблица с артикулите в менюто
create table if not exists menu_items (
    id uuid primary key default gen_random_uuid(),
    name text not null,
    category text,
    price numeric(10,2) not null default 0,
    description text,
    image_url text,
    is_available boolean not null default true,
    created_at timestamptz not null default now()
);

-- 2. Настройки на заведението (име, фон и т.н. — key/value)
create table if not exists restaurant_settings (
    key text primary key,
    value text
);

-- 3. Поръчки от клиентите
create table if not exists orders (
    id uuid primary key default gen_random_uuid(),
    table_number text not null,
    items jsonb not null default '[]'::jsonb,
    total numeric(10,2) not null default 0,
    status text not null default 'new', -- new | in_progress | done
    created_at timestamptz not null default now()
);

-- ============================================================
-- ROW LEVEL SECURITY (RLS)
-- ============================================================

alter table menu_items enable row level security;
alter table restaurant_settings enable row level security;
alter table orders enable row level security;

-- --- menu_items: всеки може да чете наличните артикули; само вписан админ пипа всичко ---
create policy "public read available items"
    on menu_items for select
    to anon, authenticated
    using (is_available = true or auth.role() = 'authenticated');

create policy "authenticated manage items"
    on menu_items for all
    to authenticated
    using (true)
    with check (true);

-- --- restaurant_settings: всеки чете, само вписан админ пише ---
create policy "public read settings"
    on restaurant_settings for select
    to anon, authenticated
    using (true);

create policy "authenticated manage settings"
    on restaurant_settings for insert
    to authenticated
    with check (true);

create policy "authenticated update settings"
    on restaurant_settings for update
    to authenticated
    using (true)
    with check (true);

-- --- orders: всеки (клиент на маса) може да ВМЪКВА поръчка, само админ вижда/променя ---
create policy "anon insert orders"
    on orders for insert
    to anon, authenticated
    with check (true);

create policy "authenticated read orders"
    on orders for select
    to authenticated
    using (true);

create policy "authenticated update orders"
    on orders for update
    to authenticated
    using (true)
    with check (true);

-- ============================================================
-- STORAGE (снимки на менюто)
-- ============================================================
-- Bucket-ът "menu-images" се създава РЪЧНО от:
-- Dashboard → Storage → New bucket → име: menu-images → Public bucket: ДА
--
-- След създаването, изпълни и това за политиките на bucket-а:

insert into storage.buckets (id, name, public)
values ('menu-images', 'menu-images', true)
on conflict (id) do nothing;

create policy "public read menu images"
    on storage.objects for select
    to anon, authenticated
    using (bucket_id = 'menu-images');

create policy "authenticated upload menu images"
    on storage.objects for insert
    to authenticated
    with check (bucket_id = 'menu-images');

create policy "authenticated update menu images"
    on storage.objects for update
    to authenticated
    using (bucket_id = 'menu-images');

-- ============================================================
-- (ПО ИЗБОР) АДМИН ПОТРЕБИТЕЛ
-- ============================================================
-- Не се създава от SQL — направи го от:
-- Dashboard → Authentication → Users → Add user (имейл + парола)
-- Това е логин-а, който собственикът на заведението ще ползва
-- в admin.html и orders.html.
