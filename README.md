Shot Formoz
================

## API

### login
- url: `{baseUrl}/users/login`
- method: `POST`
- body: 

        {
          facebook_id: "facebook id"
          , facebook_token: "the-token"
        }

- 200, set cookie: 

        {
          id: 100
        }

- 409: token and id not matched

### retrieve bands
- url: `{baseUrl}/bands`
- method: `GET`
- returns:

        [
          { id: 1
            ,  name: "Tizzy Bac"
            , start_time: "2013-08-01 12:00:00"
            , end_time: "2013-08-01 12:40:00" 
            , photo_url: "the-url"
          }
        ]


### create user's band 
- url: `{baseUrl}/users/:user_id/bands`
- method: `POST`
- body: 

        {
          band_ids: [ 1, 3, 5 ]
        }

- 401: user not logged in
- 404: band id not found
- 200: 

        [
          { id: 1
            ,  name: "Tizzy Bac"
            , start_time: "2013-08-01 12:00:00"
            , end_time: "2013-08-01 12:40:00" 
            , photo_url: "the-url"
          }
        ]

### retrieve user's band
- url: `{baseUrl}/users/:user_id/bands`
- method: `GET`
- returns:

        [
          { id: 1
            ,  name: "Tizzy Bac"
            , start_time: "2013-08-01 12:00:00"
            , end_time: "2013-08-01 12:40:00" 
            , photo_url: "the-url"
          }
        ]

