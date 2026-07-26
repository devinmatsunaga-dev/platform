#:package Aspire.Hosting.JavaScript@13.4.6
#:package Aspire.Hosting.Nats@13.4.6
#:package Aspire.Hosting.PostgreSQL@13.4.6
#:package Aspire.Hosting.Python@13.4.6
#:package Aspire.Hosting.Redis@13.4.6
#:sdk Aspire.AppHost.Sdk@13.4.6

var builder = DistributedApplication.CreateBuilder(args);

// Infra as Aspire-managed containers (Timescale image for Postgres)
var postgres = builder.AddPostgres("postgres")
                      .WithImage("timescale/timescaledb", "2.17.2-pg17");
var db    = postgres.AddDatabase("platform");
var redis = builder.AddRedis("redis");
var nats  = builder.AddNats("nats");

// The three service skeletons
var api = builder.AddProject("api", "../api/Platform.Api.csproj")
                 .WithReference(db).WithReference(redis).WithReference(nats);

builder.AddViteApp("web", "../web")
       .WithPnpm()
       .WithReference(api);

builder.AddPythonApp("workers", "../workers", "main.py")
       .WithUv()
       .WithReference(db)
       .WithReference(nats);

builder.Build().Run();
