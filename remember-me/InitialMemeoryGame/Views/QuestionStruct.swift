//
//  QuestionStruct.swift
//  remember-me
//
//  Created by Mathew Boyd on 2025-03-29.
//

struct Question {
    let text: String
    let options: [String]
}

struct Questions {
    // Round 1: Attention & Visual Search (now 9 questions)
    static let round1: [Question] = [
        Question(text: "How many animals do you see in this Zoo?", options: ["3", "5", "7", "9"]),
        Question(text: "How many students are in this Classroom?", options: ["10", "15", "20", "25"]),
        Question(text: "How many types of animals are at the Farm?", options: ["2", "3", "4", "5"]),
        Question(text: "What type of classroom is shown?", options: ["Modern", "Traditional", "Outdoor", "Virtual"]),
        Question(text: "How many trees are visible in the park?", options: ["5", "7", "9", "11"]),
        Question(text: "How many cars are parked on the street?", options: ["2", "4", "6", "8"]),
        Question(text: "How many flowers do you see in the garden?", options: ["3", "5", "7", "9"]),
        Question(text: "How many benches are in the schoolyard?", options: ["1", "2", "3", "4"]),
        Question(text: "What is the main color of the building in the picture?", options: ["Red", "Blue", "Green", "Yellow"])
    ]
    
    // Round 2: Cognitive Ability (now 11 questions)
    static let round2: [Question] = [
        Question(text: "Working Memory: Alex tells you a sequence: 7, 3, 5, 9. Repeat them in order.", options: ["7,3,5,9", "7,5,3,9", "3,7,5,9", "7,3,9,5"]),
        Question(text: "Narrative Recall: Which animal was wearing a red collar at the zoo?", options: ["Lion", "Elephant", "Giraffe", "Zebra"]),
        Question(text: "Route Planning: What is the most efficient order to visit Library, Grocery Store, and Post Office?", options: ["Library, Grocery, Post Office", "Grocery, Post Office, Library", "Post Office, Library, Grocery", "Library, Post Office, Grocery"]),
        Question(text: "Pattern Recognition: What comes next: 2, 4, 8, 16, ?", options: ["32", "24", "20", "30"]),
        Question(text: "Categorization: Which item does not belong: Apple, Banana, Carrot, Grape?", options: ["Apple", "Banana", "Carrot", "Grape"]),
        Question(text: "Logical Reasoning: If Alex > Ben > Chris, who is the shortest?", options: ["Alex", "Ben", "Chris", "Cannot determine"]),
        Question(text: "Working Memory (Letters): Alex says the letters: B, R, F, T. Repeat them in order.", options: ["B,R,F,T", "B,F,R,T", "T,F,R,B", "B,T,F,R"]),
        Question(text: "Narrative Recall: What was the first animal you saw at the zoo?", options: ["Tiger", "Monkey", "Bear", "Parrot"]),
        Question(text: "Route Planning: Which sequence is most efficient for visiting: Bank, Post Office, Pharmacy?", options: ["Bank, Post Office, Pharmacy", "Pharmacy, Bank, Post Office", "Post Office, Pharmacy, Bank", "Bank, Pharmacy, Post Office"]),
        Question(text: "Pattern Recognition: Complete the series: 3, 6, 12, 24, ?", options: ["48", "36", "30", "42"]),
        Question(text: "Logical Puzzle: If Sara is older than Mia and Mia is older than Zoe, who is the youngest?", options: ["Sara", "Mia", "Zoe", "Cannot determine"])
    ]
    
    // Round 3: Executive Function & Multi-Tasking (now 8 questions)
    static let round3: [Question] = [
        Question(text: "Dual-Task: Solve 8 + 5", options: ["1.2", "1.3", "1.4", "1.5"]),
        Question(text: "Complex Planning: What is the best order for Doctor, Grocery, Lunch?", options: ["Doctor, Grocery, Lunch", "Grocery, Doctor, Lunch", "Lunch, Doctor, Grocery", "Doctor, Lunch, Grocery"]),
        Question(text: "Distraction: What color was the bench Alex sat on?", options: ["Red", "Blue", "Green", "Yellow"]),
        Question(text: "Dual-Task: Solve 7 + 6", options: ["12", "13", "14", "15"]),
        Question(text: "Complex Planning: What is the best order for Meeting, Coffee, Work?", options: ["Meeting, Coffee, Work", "Coffee, Meeting, Work", "Work, Meeting, Coffee", "Meeting, Work, Coffee"]),
        Question(text: "Distraction: Which icon appeared last on the screen?", options: ["Star", "Heart", "Moon", "Sun"]),
        Question(text: "Dual-Task: Solve 9 - 4", options: ["4", "5", "6", "7"]),
        Question(text: "Complex Planning: Choose the best order for Laundry, Dinner, Exercise.", options: ["Laundry, Exercise, Dinner", "Dinner, Laundry, Exercise", "Exercise, Laundry, Dinner", "Laundry, Dinner, Exercise"])
    ]
}
