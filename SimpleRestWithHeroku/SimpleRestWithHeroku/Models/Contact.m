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
        
        _firstName = responseObject[@"firstName"];
        _lastName = responseObject[@"lastName"];
        _email = responseObject[@"email"];
        
        return self;
    }
    return nil;
}

@end
