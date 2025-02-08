//
//  main.swift
//  Grades
//
//  Created by StudentPM on 1/27/25.
//

import Foundation
import CSV


var names: [String] = []
var finalScores: [Double] = []
var scores: [[String]] = []

do{
    let stream = InputStream(fileAtPath:"/Users/studentpm/Desktop/grades.csv")
    let csv = try CSVReader(stream: stream!)
    
    while let row = csv.next(){
        handleData(data: row)
    }
}
catch{
    print("There was an error trying to read the file!")
}


var numb = 0

//function to handle each student data
func handleData(data: [String]){
    
    var tempScores: [String] = [] //temporary array to store the scores for each student
    
    //go one by one inside all the information inside data
    for i in data.indices {
        if i == 0{
            
            names.append(data[i])// if it is the first column, it is the students name, and store in the names array.
        }
        else{
            
            tempScores.append(data[i]) //else, store the score in the tempScores array
        }
    }
    
    scores.append(tempScores) //add the scores of the studentto the scores list
    
    var sum: Double = 0.0 // variable to sum the scores
    var tempFinalScore: Double = 0.0 // variable for the students final score
    
    //look into the scores forthis student
    for score in tempScores{
        if let score = Double(score){
            sum += score //add the score to the sum
        }
    }
    tempFinalScore = sum / Double(tempScores.count) // calculate the final score
    finalScores.append(tempFinalScore)//add the final score to the finalScores array.
}

//Main menu function for the user choose what to do
mainMenu()
func mainMenu(){
    //loop until the user chooses option nine
    while numb != 9{
    
        print("Welcome to the Grade Manager!")
        print("What would you like to do? (Enter the number):")
        print("1. Display grade of a single student")
        print("2. Display all grades for a student")
        print("3. Display all grades of ALL students")
        print("4. Find the average grade of the class")
        print("5. Find the average grade of an assignment")
        print("6. Find the lowest grade in the class")
        print("7. Find the highest grade of the class")
        print("8. Filter students by grade range")
        print("9. Quit")
        
        //for the user choose one of the ptions
        if let userInput = readLine(), let inputNum = Int(userInput){
            numb = inputNum // store the inputNum inside num
            
            //depends which user choose run the following functions
            if numb == 1{
                gradeOfASingleStudent()
            }
            else if numb == 2{
                displayAllGradesForStudent()
            }
            else if numb == 3{
                displayAllGradesoOfAllStudents()
            }
            else if numb == 4{
                findTheAverageGradeOfTheClass()
            }
            else if numb == 5{
                findTheAverageGradeOfAnAssignment()
            }
            else if numb == 6{
                findTheLowestGradeInTheClass()
            }
            else if numb == 7{
                findTheHighestGradeOfTheClass()
            }
            else if numb == 8{
                filterStudentsByGradeRange()
            }
            else if numb == 9{
                print("Have a great rest of your day!") //stop the program
            }
        }
        
    }
}

//function to display the grade of a single student
func gradeOfASingleStudent(){
    var index: Int = -1 //Start with an invalid index value
    
    //print this for the user choose
    print("Which student would you like to choose?")
    
    //let the user choose the student
    if let studentName = readLine(){
        
        for i in names.indices{ //go inside all the things inside name
            //if the name that the user choose is inside of names do this
            if studentName == names[i] {
                index = i //if we find the student, update the index
            }
            else{
                print("Student do not found") //print this if the student does not exist.
            }
        }
        //show the students final grade and the name.
        print("\(names[index])'s grade for this class is: \(finalScores[index])")
    
    }
}

//funtion to display all grades for a student
func displayAllGradesForStudent(){
    var index: Int = -1 //start with invalid index value
   
    //ask the user which student
    print("Which student would you like to choose?")
    
    //let the user write
    if let studentName = readLine(){
        //go inside the names array
        for i in names.indices{
            //if the name that the user choose is in names
            if studentName == names[i]{
                index = i // If find the student update the index
            }
        }
        //print the name that the user choose and the mensaje
        print("\(names[index]) grades for this class are:")
        
        //if the index is not equal -1 run the following
        if index != -1{
            //loop for go inside the scores index
            for score in scores[index]{
                print(score + " ", terminator: "")//print all the grades for that student and separate the code
            }
        }
        //espace for separe the mensajes
        print()
        print()
        
    }
    
}

//function to display all grades for all students
func displayAllGradesoOfAllStudents(){
   
    //go inside name array one by one
    for i in names.indices{
        //print all the names inside name array
        print ("\(names[i]) grades are: ", terminator: "")
        //go inside grades array one by one
        for score in scores[i]{
            print(score + " ", terminator: "") // print all the grades of each student
        }
        //empty espace
        print("")
    }
    
    
}

//function to calculate the average grade of the class
func findTheAverageGradeOfTheClass(){
    
    var totalGrades: Double = 0.0 //a variable to store the final grade
    var totalScoreCount: Int = 0 //varia to estore scores
    
    //go inside the scores
    for studentScores in scores{
        //go inside a score
        for score in studentScores{
            //if the scorevslue is equal to score
            if let scoreValue = Double(score){
                totalGrades += scoreValue//add each score to the total
                totalScoreCount += 1 // increase the score count
            }
        }
    }
    //if 0 is bigger that total the total score
    if totalScoreCount > 0{
        //calculate the class average
        let averageGrade = totalGrades / Double(totalScoreCount)
        //print the average grade
        print("The class average is: \(averageGrade)")
    }
    else{
        print("Not grades avilable")//if there no grades, print this
    }
}

//function to calculate the average grade of a specific assigment
func findTheAverageGradeOfAnAssignment(){
    //ask the user what assigment they want to check
    print("Which assignent would you like to get the average of (1-10):")
    
    //if the user choose an assigment aviable
    if let userInput = readLine(), let assigmentIndex = Int (userInput){
        
        var totalGrades: Double = 0.0 // variable to store the total grade
        var totalScoreCount: Int = 0 //variable to store the total score count
        
        //go inside each escore
        for studetScore in scores{
            if let scoreValue = Double (studetScore[assigmentIndex - 1]){
                totalGrades += scoreValue//add the score to the total for this assigment
                totalScoreCount += 1 // Increase the score count
            }
        }
        //if total score is less 0
        if totalScoreCount > 0{
            let averageGrade = totalGrades / Double(totalScoreCount) //calculate the averagefor the assigment
            print("The average for assignment #\(assigmentIndex) is \(averageGrade)")//print the number of the assigment and the average grade
        }
        else{
            print("Not grades aviable is this assigment") //If it is nit grades in a assigment
        }
    }
    else{
        print("Assigment do not found") // if the assingment does not exist.
    }
}

//function to find the student with le lower final grade
func findTheLowestGradeInTheClass(){
    
    var lowerGrade: Double = 100.0 //the max grade is 100.0
    var studentWithLowerG: String = "" //store the name of the student here
    
     //go inside the name array
    for i in names.indices{
        var totalScore: Double = 0.0 //variable to store the total score
        
        //go inside each score in the array scores
        for score in scores[i]{
            //if the score of the students is equal to the lower
            if let scoreValue = Double(score){
                totalScore = scoreValue //sum up the scores for this student
            }
        }
        
        //if the total grade is bigger that lower grade
        if totalScore < lowerGrade{
            
            lowerGrade = totalScore//update the lowest grade if we find a lower one
            studentWithLowerG = names[i] //store the name of the student with the lowest grade
        }
    }
    //print the student and the lowest grade.
    print("\(studentWithLowerG) is the student with the lowest grade: \(lowerGrade)")
    
}

//
func findTheHighestGradeOfTheClass(){
    
    var highestGrade: Double = 100.0
    var studentWithHighestG: String = ""
    
        
    for i in names.indices{
        var totalScore: Double = 0.0
        
        for score in scores[i]{
            if let scoreV = Double(score){
                totalScore += scoreV
                
            }
        }
        if totalScore > highestGrade{
            highestGrade = totalScore //update the highest grade if we find a higer one
            studentWithHighestG = names[i]//store the name of the student with the hugest grade
        }
    }

    print("\(studentWithHighestG)  is the student with the highest grade: \(highestGrade)")
    
}

func filterStudentsByGradeRange(){
    //The user choose the low range
    print("Enter the low range you would like to use:")
    
    var lowRange: Double = 0.0 //for store the low range that the user choose
    var highRange: Double = 0.0 //for store the high range that the user choose
    var studentCount: Int = 0 //count the number of students that match the range
    
    //get the user input and try to convert it to a double
    if let lowInput = readLine(), let lowValue = Double(lowInput){
        
        lowRange = lowValue//set the low range to the inputvalue
    }
    else{
        //if the user input is not a valid number show an error.
        print("Invalid input for low range")
    }
    
    //the user choose the high range
    print("Enter the high range you would like to use:")
    
    //get the user input and convert in to a doble
    if let highInput = readLine(), let highValue = Double(highInput){
        highRange = highValue // set the high range to the input value
    }
    
    var index: Int = 0
    
    //loop through all the students.
    for i in names.indices{
        //Check if the student's is within the low and high range
        if finalScores[i] >= lowRange && finalScores[i] <= highRange{
            //print the student and their final grade that mach with the range.
            print("\(names[i]): \(finalScores[i])")
            studentCount += 1 //add to the count of students in the range
        }
        
        index += 1 // move to the next student in the list
    }
}

