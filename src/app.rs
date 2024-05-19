use crate::error_template::{AppError, ErrorTemplate};
use leptos::*;
use leptos_meta::*;
use leptos_router::*;

#[component]
pub fn App() -> impl IntoView {
    provide_meta_context();

    view! {

        <Html lang="en" attr:data-theme="dark" />
        <Title text="Welcome to Teacher's Aide"/>
        <Meta name="description" content="AI powered Teacher's Aide" />
        <Stylesheet id="leptos" href="/pkg/teachers_aide.css"/>


        <Router fallback=|| {
            let mut outside_errors = Errors::default();
            outside_errors.insert_with_default_key(AppError::NotFound);
            view! {
                <ErrorTemplate outside_errors/>
            }
            .into_view()
        }>
            <main>
                <Routes>
                    <Route path="" view=LandingPage/>
                </Routes>
            </main>
        </Router>
    }
}

#[component]
fn LandingPage() -> impl IntoView {
    let (count, set_count) = create_signal(0);
    let increment = move |_| set_count.update(|count| *count += 1);
    let decrement = move |_| set_count.update(|count| *count -= 1);

    view! {
        <div class="m-4">
            <h1 class="font-extrabold text-3xl mb-4">"Welcome to Teacher's Aide!"</h1>
            <h2 class="font-extrabold mb-4">"High Five Counter: " {count}</h2>
            <button class="btn btn-primary btn-sm mr-4" on:click=increment>"Up high!"</button>
            <button class="btn btn-primary btn-sm" on:click=decrement>"Down low!"</button>
        </div>
    }
}
