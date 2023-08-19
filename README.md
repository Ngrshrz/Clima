# Weather App (Clima) - Android Application

This repository contains the implementation of a weather app for Android. The app allows users to check the current weather conditions and view the weather history. It consists of three main components: backend, frontend, and the Android application itself.

## Backend
The backend is built using ASP.NET Core 6. It acts as a proxy to OpenWeatherMap API, fetching weather data and storing it in a SQL Server database using Entity Framework Core. Users can also retrieve the weather history records by making specific requests to the backend.

## Frontend
The frontend is developed using the Flutter framework. It provides users with an interface to view the current weather conditions and the historical weather data. The frontend communicates with the backend to retrieve and display the weather information.

## Android Output
The `android_output` directory contains output sample of the Android application. Users can explore how the app looks and functions in real-world scenarios.

## Getting Started
To run the Android application, follow these steps:
1. Clone the repository: `git clone [repository_link]`
2. Open the `frontend` directory and follow the Flutter installation instructions.
3. Build and run the Android application using the Flutter commands.

For the backend:
1. Open the `backend` directory and set up the ASP.NET Core 6 environment.
2. Configure the connection to the SQL Server database and the OpenWeatherMap API key.
3. Run the backend application.

Please note that The backend is hosted on Somee.com.

Feel free to explore the code and modify it to suit your needs.

## License
This project is licensed under the [MIT License](LICENSE).
