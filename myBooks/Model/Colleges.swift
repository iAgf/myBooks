//
//  Colleges.swift
//  myBooks
//
//  Created by Alghalya Alhees on 12/12/2022.
//

import Foundation
import Firebase

//MARK: COLLEGES AND MAJORS ARRAYES 
class Collleges : NSObject, ObservableObject{
    static let shared = Collleges()
    var majors  = [Major]()
    @Published var bookcollege = ""
    @Published var major = ""

//    struct Major: Identifiable{
//        var id: Int
//        var name: String
//    }
//    struct college: Identifiable{
//        var id: Int
//        var name: String
//        var image: String
//    }
//    struct book: Identifiable{
//        var id: Int
//        var name: String
//        var image: String
//        var college: String
//        var major: String
//        var edition: String
//        var isForSalae: String
//        var price: String
//    }
    
    @Published var collegeSearchResult : [college] = []
    private let AllColleges :[college] = [
        college(id: 0, name: "كلية علوم حياتية", image: "76212-student-transparent"),
        college(id: 1, name: "كلية الهندسة والبترول", image: "56151-engineer"),
        college(id: 2, name: "كلية الآداب", image: "77792-book"),
        college(id: 3, name: "كلية الشريعة", image: "16330-placeholder-book"),
        college(id: 4, name: "كلية الحقوق", image: "128871-balance"),
        college(id: 5, name: "كلية الطب", image: "107925-doctor")

    ]
    
    
    func getColleges() -> [college] {
        return AllColleges
    }
    enum colleges {
        case lifeScience, eng
    }
    
    func getMajors(college: Int) -> [Major] {
        majors.removeAll()
        if college == 0 {
            //life science
            majors.append(Major(id: 0, name:  "علوم المعلومات"))
            majors.append(Major(id: 1, name: "إدارة التقنية البيئية"))
            majors.append(Major(id: 2, name: "علوم اضطرابات التواصل "))
            majors.append(Major(id: 3, name: "علوم الغذاء و التغذية"))
        } else if college == 1 {
            //engineering
            majors.append(Major(id: 0, name:  "هندسة كهربائية"))
            majors.append(Major(id: 1, name: "هندسية مدنية"))
            majors.append(Major(id: 2, name: "الهندسة الميكانيكية"))
            majors.append(Major(id: 3, name: "هندسة كيميائية"))
            majors.append(Major(id: 4, name: "هندسة البترول"))
            majors.append(Major(id: 5, name: "هندسة الكمبيوتر"))
        }
        else if college == 2 {
            //medicene
            majors.append(Major(id: 0, name:  "لغة عربية"))
            majors.append(Major(id: 1, name: "لغة إنجليزية"))
            majors.append(Major(id: 2, name: "تاريخ"))
            majors.append(Major(id: 3, name: "فلسفة"))
            majors.append(Major(id: 4, name: "إعلام"))
            majors.append(Major(id: 5, name: "لغة فرنسية"))
        }
        else if college == 3 {
            //quran
            majors.append(Major(id: 0, name:  "العقيدة والدعوة"))
            majors.append(Major(id: 1, name: "التفسير و الحديث"))
            majors.append(Major(id: 2, name: "الفقه وأصول الفقه"))
            majors.append(Major(id: 3, name: "الفقه المقارن والسياسة الشرعية"))
        }
        
        else if college == 4 {
            //law
            majors.append(Major(id: 0, name:  "القانوون والشريعة الاسلامية"))
        }
        else if college == 5 {
            //medicene
            majors.append(Major(id: 0, name:  "الطب"))
            majors.append(Major(id: 1, name: "طب الأسنان"))
            majors.append(Major(id: 2, name: "الصيدلة"))
            majors.append(Major(id: 3, name: "الصحة العامة"))
        }
        else {
            return [Major]()
        }
        return majors
    }
}
