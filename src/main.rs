use actix_web::{get,web,App,HttpServer,HttpResponse,Result};

#[get("/echo/{textref}")]
async fn get(textref: web::Path<String>) -> Result<HttpResponse> {
    let text = textref.into_inner();
    Ok(HttpResponse::Ok().body(format!("server:{}",text)))
}

#[actix_web::main]
async fn main() -> std::io::Result<()> {
    let _svc = HttpServer::new(move|| App::new()
        .service(get)
    )
    .bind("0.0.0.0:8081")?
    .run()
    .await;
    Ok(())
}