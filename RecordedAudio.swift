//
//  RecordedAudio.swift
//  PitchPerfectApp
//
//  Created by Sharma, Pooja on 4/5/15.
//  Copyright (c) 2015 Stubhub. All rights reserved.
//

import Foundation

class RecordedAudio: NSObject{
    var filePathUrl: NSURL!
    var title: String!
    
    init(filePathUrl: NSURL, title: String) {
        self.filePathUrl = filePathUrl
        self.title = title
       
    }
    
   
}