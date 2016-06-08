//
//  Contact.m
//  SimpleRestWithHeroku
//
//  Created by Jason Lew on 6/7/16.
//  Copyright © 2016 Jason Lew. All rights reserved.
//

#import "Contact.h"

@implementation Contact

- (instancetype)init:(NSString *)firstName lastName:(NSString *)lastName email:(NSString *)email {
    if (self = [super init]) {
        _firstName = firstName;
        _lastName = lastName;
        _email = email;
        return self;
    }
    return nil;
}

@end
