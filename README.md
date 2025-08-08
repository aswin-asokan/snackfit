<img width="3188" height="1202" alt="frame (3)" src="https://github.com/user-attachments/assets/517ad8e9-ad22-457d-9538-a9e62d137cd7" />

# SnackFit

## Basic Details

### Team Name: Cluster

### Team Members

- Team Lead: Najiya Nazrin C N - Mar Athanasius College of Engineering Kothamangalam
- Member 2: Aswin Asokan - Mar Athanasius College of Engineering Kothamangalam

### Project Description

An AI-powered app that scans your outfit, figures out which food you look like, roasts you for it, and tells you exactly where you can find that dish nearby — whether you’re at home or on a trip. Because why browse menus when you can just eat what you wear?

### The Problem (that doesn't exist)

People waste precious minutes (sometimes hours) scrolling through endless restaurant menus, forgetting the most obvious option — eating the food they’re already dressed like. Tragic and unnecessary.

### The Solution (that nobody asked for)

We use AI fashion-to-food matching to decide if you’re rocking “Puttu Kadala Power Look” or “Banana Fry Sunshine Fit.” Then we point you to the nearest place serving your edible twin — so you can taste-test your look in real life.

## Technical Details

### Technologies/Components Used

For Software:

- Languages used: Dart, Python
- Framework used: Flutter
- Flutter dependencies: google_fonts, camera, file_picker, http, url_launcher, sqflite, path, intl, shared_preferences, path_provider

```
Python libraries: bcc, blinker, Brlapi, certifi, chardet, chrome-gnome-shell, click, colorama, command-not-found, cryptography, cupshelpers, dbus-python, defer, distro, gyp, hidpidaemon, httplib2, idna, importlib-metadata, jeepney, kernelstub, keyring, language-selector, launchpadlib, lazr.restfulclient, lazr.uri, louis, macaroonbakery, more-itertools, netaddr, netifaces, oauthlib, pop-transition, protobuf, pycairo, pycups, pydbus, Pygments, PyGObject, PyJWT, pymacaroons, PyNaCl, pyparsing, pyRFC3339, python-apt, python-debian, python-gnupg, python-xlib, pytz, pyxdg, PyYAML, repolib, repoman, requests, screen-resolution-extra, SecretStorage, sessioninstaller, six, systemd-python, ubuntu-drivers-common, ufw, urllib3, vboxapi, wadllib, xdg, xkit, zipp
```

- Tools used: VS Code

### Implementation

For Software:

# Installation

**1. Clone the repository**

```
git clone git@github.com:aswin-asokan/snackfit.git
cd snackfit
```

**2. Set up Python backend environment**

```
cd dataset
python3 -m venv venv
source venv/bin/activate    # On Windows use: venv\Scripts\activate
pip install -r requirements.txt
```

> Note: The backend server is not hosted currently, so it is not connected to the frontend app.

**3. Set up Flutter frontend**

```
cd ../frontend
flutter pub get
```

> Make sure you have Flutter SDK installed. See https://flutter.dev/docs/get-started/install

# Run

**Run Backend (locally for testing only)**

```
cd dataset
source venv/bin/activate   # or activate venv on Windows
python app.py
```

- Use this to test the custom dataset, fine-tuned model, and backend APIs locally.
- Since backend is not hosted, frontend does not connect to it by default.

**Run Frontend**

```
cd frontend
flutter run
```

- The frontend currently uses Gemini for generating food suggestions instead of the backend.
- You can run on emulator or connected device.

### Project Documentation

**Overview**
The Dress to Food Suggestion App recommends food items based on the user’s dress style, mood, occasion, and environment. It consists of:

- A Flutter frontend for UI/UX, image capture, and displaying suggestions.
- A Python backend with a PyTorch model trained on a custom food image dataset, using FAISS for similarity search.

**Backend (dataset/ folder)**

- Contains the training and inference code: train.py, predict.py, and app.py (Flask server).
- Food classification model: food_classifier.pth.
- Dataset folders with categorized food images under Dataset/.
- FAISS index files and metadata stored in data/.
- Backend is not hosted live and currently not connected to frontend.
- Can be run locally to train models, test prediction, and experiment with the custom dataset.

**Frontend (frontend/ folder)**

- Flutter app structured with feature-based folders: camera, home, suggestion, settings, etc.
- Uses Gemini to produce food suggestion results without relying on backend API.
- Key screens:

1. take_picture_screen.dart for capturing dress images.
2. home.dart as main app screen.
3. suggestions.dart to display recommendations.

- Local data persistence handled via database_helper.dart.
  For Software:

**How it works now**

- User captures or inputs dress-related data on frontend.
- Frontend sends data to Gemini for suggestion generation.
- Suggestions are displayed immediately within the app.
- Backend code is provided for developers to run locally and further customize ML models and recommendation algorithms.

# Screenshots (Add at least 3)

### Screenshots

| ![Home Screen](https://github.com/user-attachments/assets/6865ae7b-fbf0-4b2a-a99b-d3f18ca44699) <br> _Home Screen_ | ![Suggestion 1](https://github.com/user-attachments/assets/4c687cc3-a918-40b9-a64a-ee807d042169) <br> _Suggestion 1_ | ![Suggestion 2](https://github.com/user-attachments/assets/ff406f0c-7b84-4159-9055-6f4f54f25079) <br> _Suggestion 2_ |
|----------------------------------------------|-------------------------------------------|---------------------------------------------|
| ![Near by](https://github.com/user-attachments/assets/94f3edd1-749b-4946-8d75-0f722c88848d) <br> _Near by_ | ![Camera](https://github.com/user-attachments/assets/fbf8cfcf-7575-43d4-a9b0-35e79ab941a8) <br> _Camera_ | ![Settings](https://github.com/user-attachments/assets/0eace827-5d95-4980-bc76-37b7cf1b9179) <br> _Settings_ |
| ![FAQ](https://github.com/user-attachments/assets/b54c2548-5270-4b17-a405-9209a79dd79e) <br> _FAQ_ |  |  |


![Backend](https://github.com/user-attachments/assets/0b53fe8b-ae0c-4cac-8a56-3dc8c62cc128) 

_Backend_

# Diagrams

![Workflow](https://github.com/user-attachments/assets/99582592-b9ce-425a-80c3-8a909cbaef21)
_This diagram outlines a dual-path process for image processing. After an image is uploaded, the system either sends it to Gemini, which provides a suggestion to be displayed on a mobile app, or it processes the image using a local backend, with the resulting suggestion shown on a browser._


**Flow Explanation**
The process begins when a user either uploads or captures an image. A decision is then made to use one of two different processing methods:

- **Gemini Flow:** If Gemini is selected, the image is sent to the Gemini service. Gemini provides a suggestion, and the result is then displayed to the user on a mobile app. This pathway is suited for a scenario where the application is deployed on a mobile device and can leverage a cloud-based service for processing.

- **Backend Flow:** Alternatively, the image can be sent to a separate backend, which runs locally. This backend processes the image and generates a suggestion, which is then displayed to the user on a local browser. This flow is ideal for situations where the backend cannot be hosted or needs to run independently on the user's machine, providing a solution for a web-based interface.

## Team Contributions

- Nazjiya Nazrin C N: AI Developer
- Aswin Asokan: App Developer

---

Made with ❤️ at TinkerHub Useless Projects

![Static Badge](https://img.shields.io/badge/TinkerHub-24?color=%23000000&link=https%3A%2F%2Fwww.tinkerhub.org%2F)
![Static Badge](https://img.shields.io/badge/UselessProjects--25-25?link=https%3A%2F%2Fwww.tinkerhub.org%2Fevents%2FQ2Q1TQKX6Q%2FUseless%2520Projects)
