//
//  SubjectDAO.swift
//  FrenchVoca
//
//  Created by 박인수 on 20/03/2019.
//  Copyright © 2019 inswag. All rights reserved.
//

import Foundation

class SubjectDAO {
    
    typealias SubjectRecord = (Int, String, String, String)
    
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
    
    func find() -> [SubjectRecord] {
        var subjectList = [SubjectRecord]()
        
        do {
            let sql = """
                SELECT subj_cd, subj_koreantitle, subj_frenchtitle, subj_photo
                FROM subject
                ORDER BY subj_cd ASC
            """
        
            let rs = try self.fmdb.executeQuery(sql, values: nil)
            while rs.next() {
                let subjectCd = rs.int(forColumn: "subj_cd")
                let subjectKoreanTitle = rs.string(forColumn: "subj_koreantitle")
                let subjectFrenchTitle = rs.string(forColumn: "subj_frenchtitle")
                let subjectPhoto = rs.string(forColumn: "subj_photo")
                
                subjectList.append( (Int(subjectCd), subjectKoreanTitle!, subjectFrenchTitle!, subjectPhoto!) )
                
            }
        } catch let error as NSError {
            print("failed: \(error.localizedDescription)")
        }
        return subjectList
    }
    
    // 단일 레코드를 가져오는 함수
    func get(subjectCd: Int) -> SubjectRecord? {
        
        let sql = """
                SELECT subj_cd, subj_koreantitle, subj_frenchtitle, subj_sentence
                FROM subject
                WHERE subj_cd = ?
            """
        
        let rs = self.fmdb.executeQuery(sql, withArgumentsIn: [subjectCd])
        
        if let _rs = rs {
            _rs.next()
            let subjectCd = _rs.int(forColumn: "subj_cd")
            let subjectKoreanTitle = _rs.string(forColumn: "subj_koreantitle")
            let subjectFrenchTitle = _rs.string(forColumn: "subj_frenchtitle")
            let subjectSentence = _rs.string(forColumn: "subj_sentence")
            return (Int(subjectCd), subjectKoreanTitle!, subjectFrenchTitle!, subjectSentence!)
        } else {
            return nil
        }
    }
    
}
