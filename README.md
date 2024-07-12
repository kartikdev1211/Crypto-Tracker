#Crypto Tracker App
Overview
The Crypto Tracker App is a mobile application built with Flutter that allows users to track real-time cryptocurrency prices and other related data. It utilizes the CoinGecko API to fetch the latest information on various cryptocurrencies. The app is designed with a focus on simplicity, ease of use, and efficient state management using the Provider package.

##Features
- Real-time Cryptocurrency Prices: View the latest prices of various cryptocurrencies.
- Detailed Cryptocurrency Information: Access detailed information about each cryptocurrency, including market cap, volume, and price changes.
- Favorites: Add cryptocurrencies to a favorites list for quick access.
- Search Functionality: Easily search for specific cryptocurrencies.
- Dark Mode: Toggle between light and dark themes.
##Technologies Used
- Flutter: The main framework for building the app.
- CoinGecko API: Used for fetching cryptocurrency data.
- Provider: State management solution for managing app state efficiently.
- HTTP: For making network requests to the CoinGecko API.
##Installation
###Clone the Repository:

bash
Copy code
git clone https://github.com/yourusername/crypto_tracker_app.git
cd crypto_tracker_app
#Install Dependencies:

bash
Copy code
flutter pub get
#Run the App:

bash
Copy code
flutter run

##Project Structure
bash
Copy code
crypto_tracker_app/
├── android
├── assets
├── ios
├── lib
│   ├── models
│   │   └── cryptocurrency.dart
│   ├── providers
│   │   └── crypto_provider.dart
│   ├── screens
│   │   ├── home_screen.dart
│   │   ├── crypto_detail_screen.dart
│   │   └── favorites_screen.dart
│   ├── services
│   │   └── api_service.dart
│   ├── widgets
│   │   ├── crypto_list_tile.dart
│   │   ├── favorite_button.dart
│   │   └── search_bar.dart
│   ├── main.dart
│   └── utils
│       └── constants.dart
├── test
└── pubspec.yaml
##Usage

###Home Screen:
- Displays a list of cryptocurrencies with their current prices.
- Tap on any cryptocurrency to view detailed information.
- 
##Search:

- Use the search bar to find specific cryptocurrencies.
- Favorites:
  - Tap the star icon to add/remove a cryptocurrency from the favorites list.
  - Access the favorites list from the favorites screen.
  
##Dark Mode:
Toggle between light and dark modes from the app settings.

##API Integration
The app uses the CoinGecko API to fetch data. You can find the official documentation here.

##State Management
The app uses the Provider package for state management. Here's an example of a simple provider:

##Contributing
Contributions are welcome! Please open an issue or submit a pull request for any changes.

##License
This project is licensed under the MIT License. See the LICENSE file for more information.

##Contact
For any inquiries, please contact kartikkysp12@gmail.com.
