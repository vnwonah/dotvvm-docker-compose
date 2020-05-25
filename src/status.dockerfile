FROM mcr.microsoft.com/dotnet/core/sdk:3.1.101 AS build
WORKDIR /app
EXPOSE 9000
EXPOSE 9001

WORKDIR /app/BlazingPizza.Status
COPY BlazingPizza.Status/*.csproj .
RUN dotnet restore 

COPY BlazingPizza.Status/ .

RUN dotnet publish -c Release -o out


# Build runtime image
FROM mcr.microsoft.com/dotnet/core/sdk:3.1.101
WORKDIR /app
COPY --from=build /app/BlazingPizza.Status/out .
ENTRYPOINT ["dotnet", "BlazingPizza.Status.dll"]
