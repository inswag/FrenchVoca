//
//  WordDAO.swift
//  FrenchVoca
//
//  Created by 박인수 on 20/03/2019.
//  Copyright © 2019 inswag. All rights reserved.
//

import Foundation

struct WordVO {
    var wordCd = 0
    var wordTitle = ""
    var wordPhonetics = ""
    var wordPartOfSpeech = ""
    var wordGender = ""
    var wordConfused = ""
    var wordNumber = ""
    var wordMeaning = ""
    var wordFrenchExam = ""
    var wordKoreanExam = ""
    var subjectCd = 0
    var subjectKoreanTitle = ""
    var subjectFrenchTitle = ""
    var subjectSentence = ""
}

class WordDAO {

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
    
    // korean title, french title, sentence 는 한번만 필요하지만 모든 로우에서 불려와진다는 단점이 있다.
    // 이를 해결하기 위해 다른 DAO 를 구성하는것이 좋을지 아니면 그냥 다 불러오는게 앱 구조적으로 효율적인지 아라보자.
    // get 함수를 이용하여 해결.
    // 일단 다 불려와지는 것으로 구성하도록 하자.
    func find(subjectCd: Int) -> [WordVO] {
        
        var wordList = [WordVO]()
        do {
            let condition = subjectCd == 0 ? "" : "WHERE w.subj_cd = \(subjectCd)"
            print("DB subjectCd : \(subjectCd)")
            let sql = """
                SELECT word_cd, word_title, word_phonetics, word_partofspeech, word_gender, word_confused, word_number, word_meaning, word_frenchexam, word_koreanexam, s.subj_koreantitle, s.subj_frenchtitle, s.subj_sentence
                FROM word w
                JOIN subject s ON s.subj_cd = w.subj_cd
                \(condition)
                ORDER BY word_title ASC
            """
            
            let rs = try self.fmdb.executeQuery(sql, values: nil)
            
            while rs.next() {
                var record = WordVO()
                record.wordCd = Int(rs.int(forColumn: "word_cd"))
                record.wordTitle = rs.string(forColumn: "word_title")!
                record.wordPhonetics = rs.string(forColumn: "word_phonetics")!
                record.wordPartOfSpeech = rs.string(forColumn: "word_partofspeech")!
                record.wordGender = rs.string(forColumn: "word_gender")!
                record.wordConfused = rs.string(forColumn: "word_confused")!
                record.wordNumber = rs.string(forColumn: "word_number")!
                record.wordMeaning = rs.string(forColumn: "word_meaning")!
                record.wordFrenchExam = rs.string(forColumn: "word_frenchexam")!
                record.wordKoreanExam = rs.string(forColumn: "word_koreanexam")!
                record.subjectKoreanTitle = rs.string(forColumn: "subj_koreantitle")!
                record.subjectFrenchTitle = rs.string(forColumn: "subj_frenchtitle")!
                record.subjectSentence = rs.string(forColumn: "subj_sentence")!
                wordList.append(record)
            }
        } catch let error as NSError {
            print("failed: \(error.localizedDescription)")
        }
        return wordList
        
    }
    
    func findTotalWord() -> [WordVO] {
        var wordList = [WordVO]()
        do {
            let sql = """
            SELECT word_cd
            FROM word
            """
            
            let rs = try self.fmdb.executeQuery(sql, values: nil)
            
            while rs.next() {
                var record = WordVO()
                record.wordCd = Int(rs.int(forColumn: "word_cd"))
                wordList.append(record)
            }
            
        } catch let error as NSError {
            print("failed: \(error.localizedDescription)")
        }
        return wordList
    }
    
    func findForNoti(randomNumber: Int) -> [WordVO] {
        
        var wordList = [WordVO]()
        do {
            let condition = "WHERE word_cd = \(randomNumber)"
            let sql = """
            SELECT word_title, word_partofspeech, word_gender, word_number, word_meaning
            FROM word
            \(condition)
            """
            
            let rs = try self.fmdb.executeQuery(sql, values: nil)
            
            while rs.next() {
                var record = WordVO()
                record.wordTitle = rs.string(forColumn: "word_title")!
                record.wordPartOfSpeech = rs.string(forColumn: "word_partofspeech")!
                record.wordGender = rs.string(forColumn: "word_gender")!
                record.wordNumber = rs.string(forColumn: "word_number")!
                record.wordMeaning = rs.string(forColumn: "word_meaning")!
                wordList.append(record)
            }
        } catch let error as NSError {
            print("failed: \(error.localizedDescription)")
        }
        return wordList
        
    }
    
    func findForFiveWords() -> [WordVO] {
        
        var wordList = [WordVO]()
        do {
            let sql = """
            SELECT word_cd, word_title, word_partofspeech, word_gender, word_number, word_meaning, word_frenchexam, word_koreanexam
            FROM word
            ORDER BY word_cd ASC
            """
            
            let rs = try self.fmdb.executeQuery(sql, values: nil)
            
            while rs.next() {
                var record = WordVO()
                record.wordCd = Int(rs.int(forColumn: "word_cd"))
                record.wordTitle = rs.string(forColumn: "word_title")!
                record.wordPartOfSpeech = rs.string(forColumn: "word_partofspeech")!
                record.wordGender = rs.string(forColumn: "word_gender")!
                record.wordNumber = rs.string(forColumn: "word_number")!
                record.wordMeaning = rs.string(forColumn: "word_meaning")!
                record.wordFrenchExam = rs.string(forColumn: "word_frenchexam")!
                record.wordKoreanExam = rs.string(forColumn: "word_koreanexam")!
                wordList.append(record)
            }
        } catch let error as NSError {
            print("failed: \(error.localizedDescription)")
        }
        return wordList
        
    }
    
    
    
//    INSERT INTO subject
//    (subj_koreantitle, subj_frenchtitle, subj_explanation, sub_photo)
//    VALUES
//    ('가족', 'La famile', 'La famille, c'est l'amour sans regrets et sans amertume.', 'mini_famile')
//    ('건강', 'La santé', 'Une lecture amusante est aussi utile à la santé que l'exercice du corps.', 'mini_santé')
//    ('교통', 'Les transports', 'Bus, train, moto, voiture…', 'mini_transport')
//    ('기상', 'Le météo', 'Qui trop écoute la météo, passe sa vie au bistrot.', 'mini_météo')
//    ('기술', 'La technologie', 'La science, c'est ce que le père enseigne à son fils. La technologie, c'est ce que le fils enseigne à son papa.', 'mini_technologie')
//    ('마을', 'La ville', 'La ville a une figure, la campagne a une âme.', 'mini_ville')
//    ('동물', 'Les animaux', 'Un homme cruel avec les animaux ne peut être un homme bon.', 'mini_animaux')
//    ('사랑', 'L'amour', 'La plus belle phrase d'amour est dite dans le silence d'un regard.', 'mini_amour')
//    ('시간', 'Le temps', 'Avec du temps et de la patience, on vient à bout de tout.', 'mini_temps')
//    ('신체', 'Le corps', 'Lire, c'est boire et manger. L'esprit qui ne lit pas maigrit comme le corps qui ne mange pas.', 'mini_corps')
//    ('여가', 'Les loisirs', 'Les vacances : des loisirs qui se répètent.', 'mini_loisirs')
//    ('여행', 'Le tourisme', 'Le tourisme est l'industrie qui consiste à transporter des gens qui seraient mieux chez eux, dans des endroits qui seraient mieux sans eux.', 'mini_tourisme')
//    ('예술', 'Les arts', 'Tous les arts sont frères, chacun apporte une lumière aux autres.', 'mini_arts')
//    ('우정', 'L'amitié', 'Offrir l'amitié à qui veut l'amour, c'est donner du pain à qui meurt de soif.', 'mini_amitié')
//    ('우편', 'La poste', 'Chaque poste où un homme peut servir son pays est honorable.', 'mini_poste')
//    ('음식', 'Les produits alimentaires', 'Manger, boire, dormir', 'mini_produits')
//    ('의류', 'Les vêtements', 'Le plus beau vêtement qui puisse habiller une femme, ce sont les bras de l'homme qu'elle aime.', 'mini_vêtements')
//    ('일상 활동', 'Les activités quotidiennes', 'Il est toujours bon d'avoir une activité lente avant de prendre une décision importante.', 'mini_activités')
//    ('주거', 'Le logement', 'Le ménage du monde est comme celui d'un logement. Il faut recommencer tous les jours.', 'mini_logement')
//    ('주방', 'La cuisine', 'Il n'y a pas de bonne cuisine si au départ elle n'est pas faite par amitié pour celui ou celle à qui elle est destinée.', 'mini_cuisine')
//    ('지리', 'La géographie', 'La Géographie, cela ne sert pas seulement à faire la guerre.', 'mini_géographie')
//    ('직업', 'Les professions', 'Homme politique, c'est une profession où il est plus utile d'avoir des relations que des remords.', 'mini_professions')
//    ('학교', 'L'école', 'Celui qui ouvre une porte d'école, ferme une prison.', 'mini_école')
//    ('화폐', 'L'argent', 'L'argent ne fait pas le bonheur, mais il y contribue.', 'mini_argent')

}

