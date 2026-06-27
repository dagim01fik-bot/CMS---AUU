FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /src

COPY ["CmsAau.sln", "./"]
COPY ["src/CmsAau.Api/CmsAau.Api.csproj", "src/CmsAau.Api/"]
COPY ["src/CmsAau.Application/CmsAau.Application.csproj", "src/CmsAau.Application/"]
COPY ["src/CmsAau.Domain/CmsAau.Domain.csproj", "src/CmsAau.Domain/"]
COPY ["src/CmsAau.Infrastructure/CmsAau.Infrastructure.csproj", "src/CmsAau.Infrastructure/"]

RUN dotnet restore "src/CmsAau.Api/CmsAau.Api.csproj"

COPY . .
RUN dotnet publish "src/CmsAau.Api/CmsAau.Api.csproj" -c Release -o /app/publish /p:UseAppHost=false

FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS final
WORKDIR /app

ENV ASPNETCORE_URLS=http://+:8080
EXPOSE 8080

COPY --from=build /app/publish .
ENTRYPOINT ["dotnet", "CmsAau.Api.dll"]
