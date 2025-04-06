# Remember Me

- Supporting Alzheimer's care with personalized digital assistance.
- A group project for BearHacks 2025.

---
  
## 💡 What it does

**Remember Me** is an iOS and watchOS companion app designed to support individuals living with Alzheimer's and those who care for them. It features:

- ✅ **Personalized daily planner** with tasks and reminders  
- 💊 **Medication tracking**  
- ❤️ **Health data monitoring** (heart rate, sleep, hydration, etc.)  
- 👨👩👧 **Memory games** like “Faces I Love” to support recognition and recall  
- 🆘 **SOS emergency feature** with medical info, location, and quick contact buttons  
- ⌚ **Apple Watch connectivity** for health and fall detection

## 🛠 How we built it
- **SwiftUI** for clean, modular iOS UI  
- **Firebase Authentication & Firestore** for secure login and personalized data storage  
- **watchOS Target** with WatchConnectivity setup to simulate health data sync  
- **Modular Swift files** for different features like SignUpView, MemoryGamesView, SOSView, etc.  
- **HealthView** using mock data to simulate a real Apple Watch connection

## ⚠️ Challenges we ran into
- Creating mini games that are both fun and scientifically valid for detecting early signs of Alzheimer's 
- Capturing accurate and Granular Metrics within the game like speed to answer time between answering etc 
- Building a Real-Time Analytics Pipeline
     -Implementing logging for each response with timestamps and metadata
- Machine Learning Overfitting
     -Early versions of synthetic data led to models way overfitting due to the poor quality of our synthetic     data 
- I think one of the hardest task that we ran into was Synthetic Data Engineering
      -Out dataset is still not very good which leads to our ML algorithm to not being the most accurate  

## 🏆 Accomplishments we're proud of
- I feel that we are proud of the ML algorithm that we created as well as the amount of nice looking UI we created in such a small time span
- Successfully created and connected an Apple Watch companion app (pending physical device testing)  
- Created meaningful features like “Faces I Love” and emergency assistance that address real problems

## 📚 What we learned
- We feel one of the biggest lessons we learned as a team was not to bite off more then we can chew, we feel if we kept our scope much smaller we would have been able to deliver an even better project. However we suffered from scope creep and wanted to do so much all at once which lead to a lot of features not being fully developed or polished out  

## 🔮 What's next for Remember Me
- If we have time as a team i would really like to go back and retrain the ML algorithm so it can be more accurate, as well as fully fleshing out all the features 
