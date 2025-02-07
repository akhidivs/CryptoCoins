# Crypto Tracker

This app lists out the different cryto coins available in the market along with it's current price. The user can navigate to coin detail page where they can see it's overview and other details along with price chart for last 7 days.

There is a user portfolio section where all the coins which user currently holds, are listed out. User can add, update or remove coins from his portfolio. This app uses CoreData for storing coin details which user currently holds.

This app uses CoinGecko API, which provides free API to fetch the list of crypto coins. As we're currently using free API, the price for crypto coins are slightly delayed.

## Architecture
This app uses MVVM architecture, and extend it further to provide separate files for network handling.

## Tech Stack
The UI is completely developed using SwiftUI. Core Data is used for local storage and Combine is used for network calls and subscription to data models.

## Screenshots/Recordings

<img width="296" alt="Settings" src="https://github.com/user-attachments/assets/11d7a970-1bdf-4f58-aa7e-31fb650508cb" />
<img width="296" alt="EditPortfolio" src="https://github.com/user-attachments/assets/e5560fd5-24fc-4feb-950a-de531ea660ca" />
<img width="296" alt="AddCoin" src="https://github.com/user-attachments/assets/16b6ef8d-045a-47dd-8e09-f89a6e6289c0" />
<img width="296" alt="Detail" src="https://github.com/user-attachments/assets/8ed27f11-c5a3-4648-8984-c889cb0c696c" />
<img width="296" alt="Portfolio" src="https://github.com/user-attachments/assets/475eab94-c22d-4911-9dd8-a62a14c54e50" />
<img width="296" alt="Dashboard" src="https://github.com/user-attachments/assets/ac834706-8016-4340-8cfd-ad8d6744c0e1" />


## Useful Links

This project follows the SwiftfulThinking course on advanced SwiftUI learning.
https://www.youtube.com/@SwiftfulThinking

This project uses CoinGecko free API to fetch coins and market data.
https://www.coingecko.com

Follow me on linked in to see my other projects:
https://www.linkedin.com/in/akhilesh-mishra-9510b073/






