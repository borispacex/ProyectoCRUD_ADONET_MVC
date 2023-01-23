using ProyectoCRUD_MVC.Models;
using ProyectoCRUD_MVC.Repositorios.Contrato;
using ProyectoCRUD_MVC.Repositorios.Implementacion;

var builder = WebApplication.CreateBuilder(args);

// Add services to the container.
builder.Services.AddControllersWithViews();

// injectamos
builder.Services.AddScoped<IGenericRepository<Departamento>,DepartamentoRepository>();
builder.Services.AddScoped<IGenericRepository<Empleado>, EmpleadoRepository>();


var app = builder.Build();

// Configure the HTTP request pipeline.
if (!app.Environment.IsDevelopment())
{
    app.UseExceptionHandler("/Home/Error");
}
app.UseStaticFiles();

app.UseRouting();

app.UseAuthorization();

app.MapControllerRoute(
    name: "default",
    pattern: "{controller=Home}/{action=Index}/{id?}");

app.Run();
