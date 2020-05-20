FROM mcr.microsoft.com/dotnet/core/sdk:3.1.101 AS build
WORKDIR /app
EXPOSE 8080
EXPOSE 8080

WORKDIR /app/BlazingPizza.Shared
COPY BlazingPizza.Shared/*.csproj .

COPY BlazingPizza.Shared/ .

WORKDIR /app/BlazingPizza.App
COPY BlazingPizza.App/*.csproj .
RUN dotnet restore 

COPY BlazingPizza.App/ .

RUN dotnet publish -c Release -o out


# Build runtime image
FROM mcr.microsoft.com/dotnet/core/sdk:3.1.101
WORKDIR /app
COPY --from=build /app/BlazingPizza.App/out .
ENTRYPOINT ["dotnet", "BlazingPizza.App.dll"]
