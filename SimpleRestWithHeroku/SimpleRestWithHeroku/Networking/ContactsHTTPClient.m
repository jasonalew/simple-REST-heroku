//
//  ContactsHTTPClient.m
//  SimpleRestWithHeroku
//
//  Created by Jason Lew on 6/8/16.
//  Copyright © 2016 Jason Lew. All rights reserved.
//

#import "ContactsHTTPClient.h"

static NSString *const ContactsBaseURL = @"contactsBaseURL";

@interface ContactsHTTPClient()

@end

@implementation ContactsHTTPClient

+ (ContactsHTTPClient *)sharedContactsHTTPClient
{
    static ContactsHTTPClient *_sharedContactsHTTPClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSString *path = [[NSBundle mainBundle]pathForResource:@"URLAddresses" ofType:@"plist"];
        NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:path];
        NSString *baseURLString = dict[ContactsBaseURL];
        NSLog(@"baseURLString: %@", baseURLString);
        
        _sharedContactsHTTPClient = [[self alloc]initWithBaseURL:[NSURL URLWithString:baseURLString]];
    });
    return _sharedContactsHTTPClient;
}

- (instancetype)initWithBaseURL:(NSURL *)url
{
    self = [super initWithBaseURL:url];
    if (self) {
        self.responseSerializer = [AFJSONResponseSerializer serializer];
        self.requestSerializer = [AFJSONRequestSerializer serializer];
    }
    return self;
}

- (void)getAllContacts
{
    [self GET:@"/contacts" parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        NSLog(@"Progress: %@", downloadProgress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"GetAllContacts ResponseObject: %@)", responseObject);
        if ([self.delegate respondsToSelector:@selector(contactsHTTPClient:didUpdateAllContacts:)]) {
            [self.delegate contactsHTTPClient:self didUpdateAllContacts:responseObject];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"Failed to get all contacts: %@", error.localizedDescription);
    }];
}

- (void)addContact:(Contact *)contact
{
    
}

@end
