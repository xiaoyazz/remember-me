//
//  QuestionStruct.swift
//  remember-me
//
//  Created by Mathew Boyd on 2025-03-29.
//

struct Question {
    let text: String
    let options: [String]
    let answer: Int
    let picture: String?
    
    init(text: String, options: [String], answer: Int, picture: String? = nil) {
            self.text = text
            self.options = options
            self.answer = answer
            self.picture = picture
        }
    var shouldBeSpoken: Bool {
            return text.hasPrefix("Working Memory")
        }
}

struct Questions {
    // Round 1: Attention & Visual Search (9 questions)
    static let round1: [Question] = [
        Question(text: "How many animals do you see in this Zoo?", options: ["3", "12", "7", "9"], answer: 1, picture: "ZooAnimals"),
        Question(text: "How many students are in this Classroom?", options: ["10", "15", "9", "25"], answer: 2, picture: "ClassRoomStudents"),
        Question(text: "How many types of animals are at the Farm?", options: ["8", "10", "6", "11"], answer: 1, picture: "FarmAnimals"),
        Question(text: "What type of classroom is shown?", options: ["Modern", "Traditional", "Outdoor", "Virtual"], answer: 2, picture: "ClassroomOutdoor"),
        Question(text: "How many trees are visible in the park?", options: ["4", "2", "1", "5"], answer: 1, picture: "ParkTrees"),
        Question(text: "How many cars are currently parked", options: ["2", "7", "6", "5"], answer: 3, picture: "Cars"),
        Question(text: "How many flowers do you see in the garden?", options: ["10", "15", "12", "13"], answer: 1, picture: "Flowers"),
        Question(text: "How many benches are in the schoolyard?", options: ["1", "2", "3", "4"], answer: 2, picture: "Benches"),
        Question(text: "What are the main colors of the buildings in the picture? (Match the closet colors to the ones in the picture)", options: ["Red", "Blue", "Green", "Yellow"], answer: 1, picture: "Building")
    ]
    
    // Round 2: Cognitive Ability (11 questions)
    static let round2: [Question] = [
        Question(text: "Narrative Recall: Were there Giraffes in the zoo picture", options: ["Yes" , "No"], answer: 0),
        Question(text: "Working Memory: Mathew tells you a sequence: 7, 3, 5, 9. Select the correct order.", options: ["7,3,5,9", "7,5,3,9", "3,7,5,9", "7,3,9,5"], answer: 0),
        Question(
            text: "Route Planning: Mathew's house is at the center of town. The library is 0.5 miles to the north, the grocery store is 1 mile to the east, and the post office is 0.75 miles to the south. What is the most efficient order to visit all three locations?",
            options: ["Library, Grocery Store, Post Office", "Grocery Store, Post Office, Library", "Post Office, Library, Grocery", "Library, Post Office, Grocery"],
            answer: 0
        ),
        Question(text: "Pattern Recognition: What comes next: 2, 4, 8, 16, ?", options: ["32", "24", "20", "30"], answer: 0),
        Question(text: "Categorization: Which item does not belong: Apple, Banana, Carrot, Grape?", options: ["Apple", "Banana", "Carrot", "Grape"], answer: 2),
        Question(text: "Working Memory: Mathew tells you a sequence: 5, 1, 8, 3, 7. Select the correct order.", options: ["5,1,8,3,7", "5,8,1,7,3", "1,5,7,8,3", "5,1,3,7,8"], answer: 0),
        Question(text: "Logical Reasoning: If Mathew > Ben > Chris, who is the shortest?", options: ["Mathew", "Ben", "Chris", "Cannot determine"], answer: 2),
        Question(text: "Working Memory: (Letters): Mathew says the letters: B, R, F, T. Select the correct order.", options: ["B,R,F,T", "B,F,R,T", "T,F,R,B", "B,T,F,R"], answer: 0),
        Question(text: "Narrative Recall: Did it look cold in photo of the buildings", options: ["Yes", "No"], answer: 0),
        Question(
            text: "Route Planning: Mathew’s house is at the center of town. The bank is located 0.3 miles to the north, the post office is 0.5 miles to the east, and the pharmacy is 0.4 miles to the north-east. Which sequence is most efficient for visiting all three locations and returning home?",
            options: ["Bank, Post Office, Pharmacy", "Pharmacy, Bank, Post Office", "Post Office, Pharmacy, Bank", "Bank, Pharmacy, Post Office"],
            answer: 0
        ),
        Question(text: "Pattern Recognition: Complete the series: 3, 6, 12, 24, ?", options: ["48", "36", "30", "42"], answer: 0),
        Question(text: "Working Memory: Mathew tells you a sequence: 10, 20, 30. Select the correct order.", options: ["10,20,30", "20,30,10", "30,20,10", "10,30,20"], answer: 0),
        Question(text: "Logical Puzzle: If Sara is older than Mia and Mia is older than Zoe, who is the youngest?", options: ["Sara", "Mia", "Zoe", "Cannot determine"], answer: 2),
        Question(text: "Narrative Recall: How were the students feeling in the picture of the classroom of students", options: ["Happy", "Sad", "Angry" , "Suprised"], answer: 0),
        Question(text: "Working Memory: Mathew tells you a sequence: 2, 9, 4, 6, 9, 10. Select the correct order.", options: ["2,9,4,6,9,10", "2,4,9,6,10, 9", "4,2,6,9,10,9", "9,2,4,6,10,9", "2,6,9,4,9 10"], answer: 0),
    ]
    
    // Round 3: Advanced Cognitive Ability (8 questions)
    static let round3: [Question] = [
        Question(text: "Math: Solve 8 / 5", options: ["1.2", "1.6", "1.4", "1.5"], answer: 1),
        Question(text: "Complex Planning: What is the best order for Doctor, Grocery, Lunch?", options: ["Doctor, Grocery, Lunch", "Grocery, Doctor, Lunch", "Lunch, Doctor, Grocery", "Doctor, Lunch, Grocery"], answer: 0),
        Question(text: "Distraction: What color was the benches in the photo of the schoolyard", options: ["Red", "Brown", "Green", "Yellow"], answer: 1),
        Question(text: "Math: Solve 7 + 6", options: ["12", "13", "14", "15"], answer: 1),
        Question(text: "Complex Planning: What is the best order for Meeting, Coffee, Work?", options: ["Meeting, Coffee, Work", "Coffee, Meeting, Work", "Work, Meeting, Coffee", "Meeting, Work, Coffee"], answer: 0),
        Question(text: "Math: Solve 9 - 4", options: ["4", "5", "6", "7"], answer: 1),
        Question(text: "Complex Planning: Choose the best order for Laundry, Dinner, Exercise.", options: ["Laundry, Exercise, Dinner", "Dinner, Laundry, Exercise", "Exercise, Laundry, Dinner", "Laundry, Dinner, Exercise"], answer: 3)
    ]
}
