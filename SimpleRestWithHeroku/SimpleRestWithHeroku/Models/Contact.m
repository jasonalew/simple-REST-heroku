//
//  Contact.m
//  SimpleRestWithHeroku
//
//  Created by Jason Lew on 6/7/16.
//  Copyright © 2016 Jason Lew. All rights reserved.
//

#import "Contact.h"

@implementation Contact

- (instancetype)init:(NSDictionary *)responseObject {
    if (self = [super init]) {
        __id = responseObject[@"_id"];
        _firstName = responseObject[@"firstName"];
        _lastName = responseObject[@"lastName"];
        _email = responseObject[@"email"];
        
        return self;
    }
    return nil;
}

- (NSDictionary *)dictionaryFromContact {
    NSDictionary *dict = @{
                           @"_id": self._id,
                           @"firstName": self.firstName,
                           @"lastName": self.lastName,
                           @"email": self.email
                           };
    return dict;
}

@end
