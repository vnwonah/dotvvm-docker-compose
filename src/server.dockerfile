FROM mcr.microsoft.com/dotnet/core/sdk:3.1.101 AS build
WORKDIR /app
EXPOSE 64591
EXPOSE 64590

WORKDIR /app/BlazingPizza.Shared
COPY BlazingPizza.Shared/*.csproj .

COPY BlazingPizza.Shared/ .

WORKDIR /app/BlazingPizza.Server
COPY BlazingPizza.Server/*.csproj .
RUN dotnet restore 

COPY BlazingPizza.Server/ .

RUN dotnet publish -c Release -o out


# Build runtime image
FROM mcr.microsoft.com/dotnet/core/sdk:3.1.101
WORKDIR /app
COPY --from=build /app/BlazingPizza.Server/out .
ENTRYPOINT ["dotnet", "BlazingPizza.Server.dll"]
