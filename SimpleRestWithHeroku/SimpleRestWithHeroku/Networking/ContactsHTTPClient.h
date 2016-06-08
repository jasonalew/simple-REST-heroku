//
//  ContactsHTTPClient.h
//  SimpleRestWithHeroku
//
//  Created by Jason Lew on 6/8/16.
//  Copyright © 2016 Jason Lew. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>
#import "AFHTTPSessionManager.h"
@class Contact;

@protocol ContactsHTTPClientDelegate;

@interface ContactsHTTPClient : AFHTTPSessionManager
@property (weak, nonatomic) id<ContactsHTTPClientDelegate> delegate;
+ (ContactsHTTPClient *)sharedContactsHTTPClient;
- (instancetype)initWithBaseURL:(NSURL *)url;
- (void)getAllContacts;
- (void)addContact:(Contact *)contact;
@end

@protocol ContactsHTTPClientDelegate <NSObject>
@optional
- (void)contactsHTTPClient:(ContactsHTTPClient *)client didUpdateAllContacts:(NSArray *)responseObject;
- (void)contactsHTTPClient:(ContactsHTTPClient *)client didUpdateContact:(Contact *)contact;
- (void)contactHTTPClient:(ContactsHTTPClient *)client didFailWithError:(NSError *)error;


@end
