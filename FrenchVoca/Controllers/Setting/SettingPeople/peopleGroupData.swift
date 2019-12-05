//
//  peopleGroupData.swift
//  FrenchVoca
//
//  Created by 박인수 on 21/04/2019.
//  Copyright © 2019 inswag. All rights reserved.
//

extension PeopleGroup {
    
    public static func allGroups() -> [PeopleGroup] {
        return [development(), design(), database(), contents()]
    }
    
    public static func development() -> PeopleGroup {
        let peoples = [
            People(name: "Insu", insta: "@inswag_", image: "Insu")
        ]
        return PeopleGroup(peoples: peoples, title: "Développement")
    }
    
    public static func design() -> PeopleGroup {
        let peoples = [
            People(name: "Insu", insta: "@inswag_", image: "Insu"),
            People(name: "Wonil", insta: "@veddi_", image: "Wonil"),
            People(name: "Yeongeun", insta: "@20eun_", image: "Yeongeun"),
            People(name: "JeongWoo", insta: "@9224_jat", image: "JW")
        ]
        return PeopleGroup(peoples: peoples, title: "Design")
    }
    
    public static func database() -> PeopleGroup {
        let peoples = [
            People(name: "Insu", insta: "@inswag_", image: "Insu"),
            People(name: "Youngmin", insta: "-", image: "Youngmin"),
            People(name: "Yeongeun", insta: "@20eun_", image: "Yeongeun")
            
        ]
        return PeopleGroup(peoples: peoples, title: "Base de données")
    }
    
    public static func contents() -> PeopleGroup {
        let peoples = [
            People(name: "Insu", insta: "@inswag_", image: "Insu"),
            People(name: "Yeongeun", insta: "@20eun_", image: "Yeongeun")
        ]
        return PeopleGroup(peoples: peoples, title: "Mots et exemples")
    }
}
