# Flehr: a Chat API and RealTime Chat Client
A REST API for a chat application built in Rails & a front end chat client built in React, using real-time chat communications with ActionCable/WebSockets 

### Features

* RESTful JSON API
* Front end client built in React
* Real Time communications using ActionCable/WebSockets

## Getting Started
### System dependencies
	Ruby ~> 2.3.3
	Rails ~> 5.1.4
	Redis ~> 3.0

### Setup

	git clone git@github.com:davidkurutz/flehr.git
	cd flehr
	bundle install
	rake db:migrate
	rails s

# API Documentation

## Resources

### User
##### Methods
| Verb | Route | Action | Parameters|
| ---- | ----- | ------ |----------- |
| GET  | /api/v1/users | returns list of all users ||
| POST | /api/v1/users | creates new user, returns new user |:username| 
| GET  | /api/v1/users/:id | returns single user by :id ||

##### Example Response
	GET /api/v1/users

	{
	  "data": [
	    {
	      "id": 1,
	      "username": "Ric",
	      "created_at": "2017-10-05T21:10:36.666Z",
	      "updated_at": "2017-10-05T21:10:36.666Z"
	    },
	    {
	      "id": 2,
	      "username": "Arn",
	      "created_at": "2017-10-06T06:17:05.618Z",
	      "updated_at": "2017-10-06T06:17:05.618Z"
	    },
	    {
	      "id": 3,
	      "username": "Tully",
	      "created_at": "2017-10-07T14:07:09.790Z",
	      "updated_at": "2017-10-07T14:07:09.790Z"
	    },
	    {
	      "id": 4,
	      "username": "JJ",
	      "created_at": "2017-10-08T01:34:20.458Z",
	      "updated_at": "2017-10-08T01:34:20.458Z"
	    }
	  ]
	}

### Conversation
##### Methods
| Verb | Route | Action | Parameters|
| ---- | ----- | ------ |----------- |
| GET  | /api/v1/users/:user_id/conversations | returns conversations for a single user ||
| POST | /api/v1/users/:user_id/conversations | creates new conversation between user and recipient user, returns new conversation |:recipient_id|
| GET  | /api/v1/users/:user_id/conversations/:id | returns conversation by :id with associated messages ||  

##### Example Response
	GET /api/v1/users/1/conversations/126

	{
	  "data": {
	    "id": 126,
	    "sender_id": 1,
	    "recipient_id": 2,
	    "created_at": "2017-10-08T18:28:59.810Z",
	    "updated_at": "2017-10-08T18:28:59.810Z",
	    "guid": "1-2",
	    "messages": [
	      {
	        "id": 132,
	        "body": "To be the Man, you've got to beat the man!!",
	        "conversation_id": 126,
	        "sender_id": 1,
	        "created_at": "2017-10-08T19:27:35.604Z",
	        "updated_at": "2017-10-08T19:27:35.604Z"
	      },
	      {
	        "id": 133,
	        "body": "Wooooooo",
	        "conversation_id": 126,
	        "sender_id": 1,
	        "created_at": "2017-10-08T19:27:40.604Z",
	        "updated_at": "2017-10-08T19:27:40.604Z"
	      }
	    ],
	    "recipient": {
	      "id": 2,
	      "username": "Arn",
	      "created_at": "2017-10-06T06:17:05.618Z",
	      "updated_at": "2017-10-06T06:17:05.618Z"
	    },
	    "sender": {
	      "id": 1,
	      "username": "Ric",
	      "created_at": "2017-10-05T21:10:36.666Z",
	      "updated_at": "2017-10-05T21:10:36.666Z"
	    }
	  }
	}

      
### Message
##### Methods


| Verb | Route | Action | Parameters|
| ---- | ----- | ------ |----------- |                                
| POST | /api/v1/users/:user_id/conversations/:conversation\_id/messages | creates new message from :user\_id in :conversation\_id |:body|

##### Example Response
	POST /api/v1/users/1/conversations/126   {'body': "Whether you like it or not, learn to love it"}

	{
	    "data": {
	        "id": 135,
	        "body": "Whether you like it or not, learn to love it",
	        "conversation_id": 126,
	        "sender_id": 1,
	        "created_at": "2017-10-08T19:27:40.604Z",
	        "updated_at": "2017-10-08T19:27:40.604Z"
	      }
	}
--


# Web UI Routes
| Verb | Route | Action |
| ---- | ----- | ------ |
| GET  | / | Loads Chat SPA if logged in, otherwise redirect to /login |
| GET | /login | login page |
| POST | /login | if username exists, user is logged in, otherwise, user is created and logged in, session and cookies created. No password required (yet). |
| GET | /logout | session and cookies are destroyed, redirect to /login |                                                   


#### Testing
	bundle exec rspec
