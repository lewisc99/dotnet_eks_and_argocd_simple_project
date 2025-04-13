# Stage 1: Build
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /src

COPY ["api/api.csproj", "api/"]
RUN dotnet restore "api/api.csproj"

COPY . .
WORKDIR "/src/api"
RUN dotnet publish "api.csproj" -c Release -o /app/publish

# Stage 2: Runtime
FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS runtime
WORKDIR /app

# Tell ASP.NET Core to listen on port 5255
ENV ASPNETCORE_URLS=http://+:5255

COPY --from=build /app/publish .

EXPOSE 5255
ENTRYPOINT ["dotnet", "api.dll"]
