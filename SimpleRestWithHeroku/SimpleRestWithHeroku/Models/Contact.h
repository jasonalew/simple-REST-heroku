//
//  Contact.h
//  SimpleRestWithHeroku
//
//  Created by Jason Lew on 6/7/16.
//  Copyright © 2016 Jason Lew. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Contact : NSObject

@property (strong, nonatomic) NSString *_id;
@property (strong, nonatomic) NSString *firstName;
@property (strong, nonatomic) NSString *lastName;
@property (strong, nonatomic) NSString *email;

- (instancetype)init:(NSDictionary *)responseObject;
- (NSDictionary *)dictionaryFromContact;

@end
