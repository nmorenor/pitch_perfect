//
//  RecordAudio.swift
//  Pitch Perfect
//
//  Created by nacho on 3/11/15.
//  Copyright (c) 2015 Ignacio Moreno. All rights reserved.
//

import Foundation


class RecordAudio: NSObject {
    var filePathUrl: NSURL!
    var title: String!
    
     init!(file filePath:NSURL!, withTitle title: String!) {
        self.filePathUrl = filePath;
        self.title = title;
    }
}
