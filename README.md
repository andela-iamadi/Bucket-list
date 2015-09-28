# bucketlist-api

**INTRODUCTION**

*Bucketlist* is a simple API allowing consumers to create, view, edit and delete bucketlist items.

A bucketlist can be likened to a todo-list where bucketlist items can have tasks assigned to them.For instance, a bucket list such as 'Going to work' could have tasks like 'Cleaning my shoe', 'brushing my hair', etc.

By default, all responses of this API is in JSON format.

> *Creating a user*

A user can log into the bucketlist app by sending a POST request to https://bucket-lists.herokuapp.com/api/v1/users.
The API expects the following in the incoming JSON request:
>>>
  {
    user: {
      full_name: "John Doe",
      email: "john.doe@gmail.com",
      password: "password",
      password_confirmation: "password"
    }
  }
>>>

The password is expected to be at least 6 characters and the email should be valid.

If successful, this request creates a new user and returns the details of the newly created user in.

The response received is in the following format:
>>>
{
  "id": 2,
  "full_name": "John Doe",
  "email": "john.doe@gmail.com",
  "date_created": "2015-09-28T11:26:08.262Z",
  "date_updated": "2015-09-28T11:26:08.262Z",
  "created_by": "John Doe"
}
>>>


*AUTHENTICATION*

Apart from creating a user and logging in, every other route on *bucketlist-api* requires you to supply a token. This token can be gotten when you log in.

*Logging in a user*

Most operations on the API requires the incoming request comes with a user token. This is the same token gotten when a user logs in.

To log in a user, send the user email and password to https://bucket-lists.herokuapp.com/api/v1/auth/login.

So to log in our infamous user *John Doe*, the JSON request should be similar to:
>>>
  {
    auth: {
      email: "john.doe@gmail.com",
      password: "password",
    }
  }
>>>

The request received would be similar to:

> { "token": "31b7866c82b12a0e63d0718963b3e628"}

*Logging out a user*

To log out a user, send a GET request to https://bucket-lists.herokuapp.com/api/v1/auth/logout.

After logging out, your old token would no longer be valid. To receive a new token, you would have to log in again.


*OTHER USER OPERATIONS*

Once a user has been created, you can show, update or delete the user. In all cases, you are expected to supply a token (in the HTTP request header or as a parameter). This token is the same gotten when the user logs in.




*Show a user information*

To retrieve a user information at any time, send a GET request to https://bucket-lists.herokuapp.com/api/v1/users.

The JSON response is similar to that returned when a user is created.

*Update a user information*

To retrieve a user information at any time, send a PATCH or PUT request to https://bucket-lists.herokuapp.com/api/v1/users.

The JSON response is also similar to that returned when a user is created.

*Delete a user information*

To delete a user information, send a DELETE request to https://bucket-lists.herokuapp.com/api/v1/users.

> **NOTE: All operations henceforth requires you to supply a token**

*List All Bucketlist for a logged in user*

To show all bucketlists a user has created, send a GET request to https://bucket-lists.herokuapp.com/api/v1/lists.

The API returns an array of lists created by the user together with their associated items as shown below:
>>>
{
  "lists": [
    {
      "id": 1,
      "name": "Getting ready for today's work",
      "created_at": "2015-09-28T11:14:17.674Z",
      "updated_at": "2015-09-28T11:15:14.140Z",
      "items": [
        {
          "id": 1,
          "name": "Take my bath",
          "created_at": "2015-09-28T11:16:37.879Z",
          "updated_at": "2015-09-28T11:16:37.879Z",
          "list": "Getting ready for today's work"
        },
        {
          "id": 2,
          "name": "Brush my teeth",
          "created_at": "2015-09-28T11:17:03.863Z",
          "updated_at": "2015-09-28T11:17:03.863Z",
          "list": "Getting ready for today's work"
        }
    {
      "id": 2,
      "name": "Finish API app",
      "created_at": "2015-09-28T13:25:53.625Z",
      "updated_at": "2015-09-28T13:25:53.625Z",
      "created_by": "John Doe"
    }
  ]
}
>>>

*Create a new bucketlist*

To create a new bucketlist, send a POST request to https://bucket-lists.herokuapp.com/api/v1/lists.

If successful, the API returns a single bucket list as shown below:
>>>
{
  "id": 2,
  "name": "Finish API app",
  "created_at": "2015-09-28T13:25:53.625Z",
  "updated_at": "2015-09-28T13:25:53.625Z",
  "created_by": "John Doe"
}
>>>

*Retrieve a single bucketlist*

You can retrieve a single bucketlist, along with its associated items by sending a GET request to
https://bucket-lists.herokuapp.com/api/v1/lists/<:id>
Where *<:id>* represents the id of the list.


*Edit an existing bucketlist*

To edit an existing bucketlist, send a PATCH request to https://bucket-lists.herokuapp.com/api/v1/lists/<:id> where <:id> is the id of the target bucketlist.

The API returns a JSON of the edited bucketlist in similar style with the *create* method.


*Delete an existing bucketlist*

To delete an existing bucketlist, send a DELETE request to https://bucket-lists.herokuapp.com/api/v1/lists/<:id> where <:id> is the id of the target bucketlist.

The API returns a JSON of the edited bucketlist in similar style with the *index* method, but with the deleted bucketlist missing.

*Retrieving only items belonging to a bucketlist*

To retrieve only items in a bucketlist, send a GET request to https://bucket-lists.herokuapp.com/api/v1/lists/<:list_id>/items

where *<:list_id>* represents the id of the bucketlist.

This will return an array of items belonging to the bucketlist as below:

>>>
{
  "items": [
    {
      "id": 1,
      "name": "Fix API bugs",
      "created_at": "2015-09-28T11:16:37.879Z",
      "updated_at": "2015-09-28T11:16:37.879Z",
      "list": "Getting ready for today's work"
    },
    {
      "id": 5,
      "name": "Prepare API documentation",
      "created_at": "2015-09-28T14:59:58.738Z",
      "updated_at": "2015-09-28T14:59:58.738Z",
      "list": "Getting ready for today's work"
    }
  ]
}
>>>

*Adding a new item to a bucket list*

To add a new item to the bucketlist, send a POST request to https://bucket-lists.herokuapp.com/api/v1/lists/<:list_id>/items

where *<:list_id>* represents the id of the bucketlist the item would belong.

This operation will return the single item if successful.

>>>
{
  "id": 5,
  "name": "Prepare API documentation",
  "created_at": "2015-09-28T14:59:58.738Z",
  "updated_at": "2015-09-28T14:59:58.738Z",
  "list": "Getting ready for today's work"
}
>>>

*Editing a bucketlist item*

To edit a bucketlist item, send a PATCH or PUT request to https://bucket-lists.herokuapp.com/api/v1/lists/<:list_id>/items/<:item_id>

where :
> <:list_id> => id of the bucketlist
> <:item_id> => id of the item you wish to edit

The only parameter that can be edited is the name of the item, so your request should be similar to:

> item[name]="New request name"

If successful, the item is returned as JSON with the changes reflecting.

*Deleting a bucketlist item*

To delete a bucketlist item, send a DELETE request to https://bucket-lists.herokuapp.com/api/v1/lists/<:list_id>/items/<:item_id>

If successful, the API returns all items in the bucketlist with the deleted item absent from it.
