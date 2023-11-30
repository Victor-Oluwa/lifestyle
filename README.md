# Flutter AR Furniture E-Commerce App

Welcome to my Flutter-based Augmented Reality (AR) Furniture E-Commerce App for furniture shopping. This mobile application seamlessly combines the worlds of furniture shopping and augmented reality to provide users with an immersive and interactive shopping experience.

## Key Features:

- **Node.js Backend with MongoDB:**
  - A robust and scalable backend built on Node.js, ensuring seamless communication with the MongoDB database for efficient data storage and retrieval. Follow the steps below to set up the backend.

    ### Backend Setup:

    1. **Install Node.js:**
       - Make sure you have Node.js installed on your server. If not, download it [here](https://nodejs.org/).

    2. **Install Dependencies:**
       - Navigate to the `backend` directory:
         ```bash
         cd backend
         ```
       - Install dependencies:
         ```bash
         npm install
         ```

    3. **Configure MongoDB:**
       - Set up a MongoDB database and update the connection string in `backend/config/db.config.js`.

    4. **Run the Server:**
       - Start the Node.js server:
         ```bash
         npm start
         ```

- **Firebase Push Notification:**
  - Keep users engaged and informed with Firebase push notifications, delivering real-time updates and personalized messages. Follow the steps below to configure Firebase.

    ### Firebase Configuration:

    1. **Create a Firebase Project:**
       - Go to the [Firebase Console](https://console.firebase.google.com/).
       - Click on "Add Project" and follow the prompts to create a new Firebase project.

    2. **Add Firebase to Your App:**
       - For Android:
         - Download `google-services.json` and place it in `android/app/`.
       - For iOS:
         - Download `GoogleService-Info.plist` and place it in `ios/Runner/`.

    3. **Enable Firebase Services:**
       - Enable services such as Authentication, Cloud Firestore, and Cloud Messaging in the Firebase Console.

- **Augmented Reality Furniture View (Under Development):**
  - Experience the future of furniture shopping with our AR feature, allowing users to visualize furniture in their own space before making a purchase.

- **E-Commerce Functionality:**
  - A comprehensive e-commerce platform that facilitates smooth browsing, selection, and purchase of furniture items.

- **Product Search:**
  - Empower users to find their desired products quickly and effortlessly through an intuitive and powerful search functionality.

- **Order Tracking:**
  - Keep customers in the loop by providing real-time tracking of their orders, enhancing transparency and satisfaction.

- **Admin Side Management:**
  - Efficiently manage products, orders, and user data through the admin side, ensuring seamless control and oversight.

- **Paystack Payment Integration:**
  - Secure and convenient payment processing integrated with Paystack, providing users with a range of payment options.

- **Company Documents View:**
  - Access important company documents effortlessly within the app, offering users valuable insights and information.

## Technologies Used:

- **Frontend:**
  - Flutter

- **Backend:**
  - Node.js

- **Database:**
  - MongoDB

- **Push Notifications:**
  - Firebase Cloud Messaging (FCM)

- **Payment Integration:**
  - Paystack

## How to Use:

1. **Clone the Repository:**
   ```bash
   git clone https://github.com/your-username/your-repo.git
   ```

2. **Setup Backend:**
   - Follow the backend setup instructions above.

3. **Configure Firebase:**
   - Follow the Firebase configuration instructions above.

4. **Run the App:**
   - Open the project in Flutter and run the app on your preferred device or emulator.

Feel free to explore, contribute, and make this AR Furniture E-Commerce App even more amazing!
