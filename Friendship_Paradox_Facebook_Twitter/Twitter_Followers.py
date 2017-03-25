#Import the necessary methods from tweepy library
import tweepy
import json
import re as regex
import requests
from sys import argv

#Variables that contains the user credentials to access Twitter API 
access_token = "YOUR ACCESS TOKEN"
access_token_secret = "YOUR SECRET TOKEN"
consumer_key = "YOUR CONSUMER KEY"
consumer_secret = "YOUR SECRET"





if __name__ == '__main__':
    outfile=argv[1]
    screenname=argv[2]
    #creates authentication object using pasted tokens and keys
    auth = tweepy.OAuthHandler(consumer_key, consumer_secret)
    auth.set_access_token(access_token, access_token_secret)
    #I added the wait_on_rate_limit and notify flags. this keeps the program from
    #crashing when Twitter raises the rate_limit_exceeded flag. Wish I'd known about
    #that last time!
    api=tweepy.API(auth, wait_on_rate_limit=True, wait_on_rate_limit_notify=True)
    
    with open(outfile, 'w') as out:
        print('screen_name', 'followers', sep='\t', file=out)
        #iterable object c pulls followers from a particular user
        c=tweepy.Cursor(api.followers, screen_name=screenname).items()
        while True:
            try:
                user= c.next()
                #using the tweepy API you can pull screen_name and followers_count
                #from a particular user
                print(user.screen_name, user.followers_count, sep='\t', file=out)
                #I added this error catch before I found the flags above.
            except tweepy.TweepError:
                continue
            except StopIteration:
                break
        
    
