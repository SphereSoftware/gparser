# Gparser (Gmail parser)

![gmail parser](https://www1-lw.xda-cdn.com/files/2018/03/gmail-logo.png)

## Intro

Say we had access to someone’s gmail account and we wanted to know the full transaction history (what they bought, when and where) of a user based on their emails. Build a system that allows for Gmail Oauth, and after you get an API key you parse their transactional history. Choose one/two marketplace service of which you have at least a couple of transactions in your mailbox (eBay, Amazon, Airbnb), parse the emails in the mailbox and output what the user has bought, from who, price and when.

—

The goal should be building nice scalable code. Think how to separate the different components of your code and build all your code with specs. Think about overall architecture and the different components and models to complete the task.

## Installation

```ruby
$ git clone https://github.com/SphereSoftware/gparser && cd gparser && bundle
```

## Usage

Default rake task will run an example of `Airbnb` email parser, but make sure
you configure your repository first. In order to do it you should add your
`email` and `oauth` token to `.env` file, what you should place in root of the project

```sh
$ rake
```

as result you will have something like this

```
We are going to parse your email feed, plz be patient that can take a minute or two  👷‍
[
  {
    "gparser::airbnb": [
      {
        "check_in": "Friday, Mar 23, 2015",
        "check_out": "Friday, Mar 30, 2015",
        "address": "3114 West 1124th unit, Inglewood, CA 90303, United States",
        "amount": "$280.65"
      },
      {
        "check_in": "Friday, Mar 30, 2015",
        "check_out": "Thursday, Apr 05, 2015",
        "address": "7415 Chrome Street, Las Vegas, NV 7115, United States",
        "amount": "446.80"
      },
      {
        "check_in": "Friday, Mar 23, 2016",
        "check_out": "Friday, Mar 30, 2016",
        "address": "3114 West 1124th Place Front unit, Inglewood, CA 90303, United States",
        "amount": "$780.65"
      },
      {
        "check_in": "Friday, Mar 23, 2016",
        "check_out": "Friday, Mar 30, 2016",
        "address": "3514 West 1124th Place Front unit, Inglewood, CA 90303, United States",
        "amount": "$180.65"
      },
      {
        "check_in": "Friday, Mar 30, 2017",
        "check_out": "Thursday, Apr 05, 2017",
        "address": "7415 Hill Street, Las Vegas, NV 7115, United States",
        "amount": "$386.80"
      }
    ]
  }
]
```

### Configuration

Make sure you change `.env` file, it should looks like

```sh
GKEY=ya29.Glu_BUb8cazF7SDuXxonMvT3LG7edhTG9DCKmjY_vPllBwFPYi-z7vStI_RDDo4SmdxFpUe5TdEh
EMAIL=some@gmail.com
```

You will be able to generate temp token in google [oauthplayground](https://developers.google.com/oauthplayground/)

### Test

Specs cover basic data extraction, for performance and consistency purpose we
use `camcorder` it allows us to record `IMAP` and replay it in future tests

```
$ rspec
```

## Conclusion

You can easily extend this solution by adding new parsers to `lib/gparser`, it
will be more or less the same for any email template you want to parse.

This structure allows us to embrace decoupling and incapsulate source specific
logic into single class.
