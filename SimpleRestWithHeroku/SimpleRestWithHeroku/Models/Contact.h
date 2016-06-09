//
//  Contact.h
//  SimpleRestWithHeroku
//
//  Created by Jason Lew on 6/7/16.
//  Copyright © 2016 Jason Lew. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Contact : NSObject

@property (strong, nonatomic, nullable) NSString *_id;
@property (strong, nonatomic, nonnull) NSString *firstName;
@property (strong, nonatomic, nonnull) NSString *lastName;
@property (strong, nonatomic, nonnull) NSString *email;

- (nullable instancetype)init:(nonnull NSDictionary *)responseObject;
- (nonnull NSDictionary *)dictionaryFromContact;

@end
