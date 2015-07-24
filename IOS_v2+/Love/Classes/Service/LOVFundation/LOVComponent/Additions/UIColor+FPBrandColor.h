//
//  UIColor+FPBrandColor.h
//  FPBrandColor
//
//  Created by Melih Buyukbayram on 26.01.2014.
//  Copyright (c) 2014 Faprica LTD. All rights reserved.
//

#import <UIKit/UIKit.h>

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
                                                 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
                                                  blue:((float)(rgbValue & 0xFF))/255.0 \
                                                 alpha:1.0]

@interface UIColor (FPBrandColor)

+ (UIColor *) Fourormat;
+ (UIColor *) FiveHundredPX;
+ (UIColor *) AboutMeBlue;
+ (UIColor *) AboutMeYellow;
+ (UIColor *) Addvocate;
+ (UIColor *) Adobe;
+ (UIColor *) Aim;
+ (UIColor *) Amazon;
+ (UIColor *) Android;
+ (UIColor *) Asana;
+ (UIColor *) Atlassian;
+ (UIColor *) Behance;
+ (UIColor *) bitly;
+ (UIColor *) Blogger;
+ (UIColor *) Carbonmade;
+ (UIColor *) Cheddar;
+ (UIColor *) CocaCola;
+ (UIColor *) CodeSchool;
+ (UIColor *) Delicious;
+ (UIColor *) Dell;
+ (UIColor *) Designmoo;
+ (UIColor *) Deviantart;
+ (UIColor *) DesignerNews;
+ (UIColor *) Dewalt;
+ (UIColor *) DisqusBlue;
+ (UIColor *) DisqusOrange;
+ (UIColor *) Dribbble;
+ (UIColor *) Dropbox;
+ (UIColor *) Drupal;
+ (UIColor *) Dunked;
+ (UIColor *) eBay;
+ (UIColor *) Ember;
+ (UIColor *) Engadget;
+ (UIColor *) Envato;
+ (UIColor *) Etsy;
+ (UIColor *) Evernote;
+ (UIColor *) Fab;
+ (UIColor *) Facebook;
+ (UIColor *) Firefox;
+ (UIColor *) FlickrBlue;
+ (UIColor *) FlickrPink;
+ (UIColor *) Forrst;
+ (UIColor *) Foursquare;
+ (UIColor *) Garmin;
+ (UIColor *) GetGlue;
+ (UIColor *) Gimmebar;
+ (UIColor *) GitHub;
+ (UIColor *) GoogleBlue;
+ (UIColor *) GoogleGreen;
+ (UIColor *) GoogleRed;
+ (UIColor *) googleWhite;
+ (UIColor *) GoogleYellow;
+ (UIColor *) GooglePlus;
+ (UIColor *) Grooveshark;
+ (UIColor *) Groupon;
+ (UIColor *) HackerNews;
+ (UIColor *) HelloWallet;
+ (UIColor *) HerokuLight;
+ (UIColor *) HerokuDark;
+ (UIColor *) HootSuite;
+ (UIColor *) Houzz;
+ (UIColor *) HP;
+ (UIColor *) HTML5;
+ (UIColor *) Hulu;
+ (UIColor *) IBM;
+ (UIColor *) IKEA;
+ (UIColor *) IMDb;
+ (UIColor *) Instagram;
+ (UIColor *) Instapaper;
+ (UIColor *) Intel;
+ (UIColor *) Intuit;
+ (UIColor *) Kickstarter;
+ (UIColor *) kippt;
+ (UIColor *) Kodery;
+ (UIColor *) LastFM;
+ (UIColor *) LinkedIn;
+ (UIColor *) Livestream;
+ (UIColor *) Lumo;
+ (UIColor *) MakitaRed;
+ (UIColor *) MakitaBlue;
+ (UIColor *) Mixpanel;
+ (UIColor *) Meetup;
+ (UIColor *) Netflix;
+ (UIColor *) Nokia;
+ (UIColor *) NVIDIA;
+ (UIColor *) Odnoklassniki;
+ (UIColor *) Opera;
+ (UIColor *) Path;
+ (UIColor *) PayPalDark;
+ (UIColor *) PayPalLight;
+ (UIColor *) Pinboard;
+ (UIColor *) Pinterest;
+ (UIColor *) PlayStation;
+ (UIColor *) Pocket;
+ (UIColor *) Prezi;
+ (UIColor *) Pusha;
+ (UIColor *) Quora;
+ (UIColor *) QuoteFm;
+ (UIColor *) Rdio;
+ (UIColor *) Readability;
+ (UIColor *) RedHat;
+ (UIColor *) RedditBlue;
+ (UIColor *) RedditOrange;
+ (UIColor *) Resource;
+ (UIColor *) Rockpack;
+ (UIColor *) Roon;
+ (UIColor *) RSS;
+ (UIColor *) Salesforce;
+ (UIColor *) Samsung;
+ (UIColor *) Shopify;
+ (UIColor *) Skype;
+ (UIColor *) SmashingMagazine;
+ (UIColor *) Snagajob;
+ (UIColor *) Softonic;
+ (UIColor *) SoundCloud;
+ (UIColor *) SpaceBox;
+ (UIColor *) Spotify;
+ (UIColor *) Sprint;
+ (UIColor *) Squarespace;
+ (UIColor *) StackOverflow;
+ (UIColor *) Staples;
+ (UIColor *) StatusChart;
+ (UIColor *) Stripe;
+ (UIColor *) StudyBlue;
+ (UIColor *) StumbleUpon;
+ (UIColor *) TMobile;
+ (UIColor *) Technorati;
+ (UIColor *) TheNextWeb;
+ (UIColor *) Treehouse;
+ (UIColor *) Trello;
+ (UIColor *) Trulia;
+ (UIColor *) Tumblr;
+ (UIColor *) TwitchTv;
+ (UIColor *) Twitter;
+ (UIColor *) Typekit;
+ (UIColor *) TYPO3;
+ (UIColor *) Ubuntu;
+ (UIColor *) Ustream;
+ (UIColor *) Verizon;
+ (UIColor *) Vimeo;
+ (UIColor *) Vine;
+ (UIColor *) Virb;
+ (UIColor *) VirginMedia;
+ (UIColor *) VKontakte;
+ (UIColor *) Wooga;
+ (UIColor *) WordPressBlue;
+ (UIColor *) WordPressOrange;
+ (UIColor *) WordPressGrey;
+ (UIColor *) Wunderlist;
+ (UIColor *) XBOX;
+ (UIColor *) XING;
+ (UIColor *) Yahoo;
+ (UIColor *) Yandex;
+ (UIColor *) Yelp;
+ (UIColor *) YouTube;
+ (UIColor *) Zalongo;
+ (UIColor *) Zendesk;
+ (UIColor *) Zerply;
+ (UIColor *) Zootool;

@end
