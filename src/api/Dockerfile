# --- build stage ---
FROM mcr.microsoft.com/dotnet/sdk:10.0 AS build
WORKDIR /src

# Restore first (better layer caching); respect the committed lock file
COPY Platform.Api.csproj packages.lock.json ./
RUN dotnet restore --locked-mode

# Then build + publish
COPY . ./
RUN dotnet publish Platform.Api.csproj -c Release -o /app /p:UseAppHost=false

# --- runtime stage ---
FROM mcr.microsoft.com/dotnet/aspnet:10.0 AS runtime
WORKDIR /app
ENV ASPNETCORE_URLS=http://+:8080
COPY --from=build /app ./
USER $APP_UID          # non-root user baked into the .NET runtime image
EXPOSE 8080
ENTRYPOINT ["dotnet", "Platform.Api.dll"]
