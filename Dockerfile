# Use the official .NET SDK image to build the app
FROM mcr.microsoft.com/dotnet/sdk:9.0 AS build

# Set the working directory in the container
WORKDIR /app

# Copy the csproj file and restore the dependencies
COPY *.csproj ./
RUN dotnet restore

# Copy the rest of the application code
COPY . ./

# Build the application
RUN dotnet publish -c Release -o /app/publish

# Use the official .NET runtime image to run the app
FROM mcr.microsoft.com/dotnet/aspnet:9.0 AS final

# Set the working directory in the container
WORKDIR /app

# Copy the published app from the build stage
COPY --from=build /app/publish .

ENV ASPNETCORE_URLS=http://+:5000
# Expose the port the app will run on
EXPOSE 7015

# Set the entry point for the application
ENTRYPOINT ["dotnet", "TodoAppBackend.dll"]
