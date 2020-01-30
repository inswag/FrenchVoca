//
//  SubjectDAO.swift
//  FrenchVoca
//
//  Created by 박인수 on 20/03/2019.
//  Copyright © 2019 inswag. All rights reserved.
//

import Foundation

struct SubjectVO {
    var subjectCd: Int = 0
    var subjectKoreanTitle: String = ""
    var subjectFrenchTitle: String = ""
    var subjectPhoto: String = ""
    var subjectSentence: String = ""
}



class SubjectDAO {
    
    lazy var fmdb: FMDatabase! = {
        let fileMgr = FileManager.default
        let docPath = fileMgr.urls(for: .documentDirectory, in: .userDomainMask).first
        let dbPath = docPath!.appendingPathComponent("FrenchVoca.db").path
        if fileMgr.fileExists(atPath: dbPath) == false {
            let dbSource = Bundle.main.path(forResource: "FrenchVoca", ofType: "db")
            try! fileMgr.copyItem(atPath: dbSource!, toPath: dbPath)
        }
        let db = FMDatabase(path: dbPath)
        return db
    }()
    
    init() {
        self.fmdb.open()
    }
    
    deinit {
        self.fmdb.close()
    }
    
    // MARK:- Find All Subjects To Show Users Our Current Subjects
    func find() -> [SubjectVO] {
        var subjectList = [SubjectVO]()
        
        do {
            let sql = """
                SELECT subj_cd, subj_koreantitle, subj_frenchtitle, subj_photo
                FROM subject
                ORDER BY subj_cd ASC
            """
        
            let rs = try self.fmdb.executeQuery(sql, values: nil)
            
            while rs.next() {
                var record = SubjectVO()
                record.subjectCd = Int(rs.int(forColumn: "subj_cd"))
                record.subjectKoreanTitle = rs.string(forColumn: "subj_koreantitle")!
                record.subjectFrenchTitle = rs.string(forColumn: "subj_frenchtitle")!
                record.subjectPhoto = rs.string(forColumn: "subj_photo")!
                subjectList.append(record)
            }
            
        } catch let error as NSError {
            print("failed: \(error.localizedDescription)")
        }
        
        return subjectList
    }
    
    // MARK:- Pick Up The Single Subject For Next Word List
    func get(subjectCd: Int) -> [SubjectVO]? {
        var subjectList = [SubjectVO]()
        
        do {
            let sql = """
                SELECT subj_cd, subj_koreantitle, subj_frenchtitle, subj_sentence
                FROM subject
                WHERE subj_cd = ?
            """
            
            let rs = try self.fmdb.executeQuery(sql, values: nil)
            
            while rs.next() {
                var record = SubjectVO()
                record.subjectCd = Int(rs.int(forColumn: "subj_cd"))
                record.subjectKoreanTitle = rs.string(forColumn: "subj_koreantitle")!
                record.subjectFrenchTitle = rs.string(forColumn: "subj_frenchtitle")!
                record.subjectSentence = rs.string(forColumn: "subj_sentence")!
                subjectList.append(record)
            }
            
        } catch let error as NSError {
            print("failed: \(error.localizedDescription)")
        }
        
        return subjectList
    }
    
}
