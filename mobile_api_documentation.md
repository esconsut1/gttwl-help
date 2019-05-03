# Travel Agency Tribes API Documentation

# Authenticaton Routes

Login

Http Request
POST https://api2.gttwl.net/tat_api/v1/login 

| Method | Route | Parameters | Result |
| ------ | ------ | ------ | ------ |
| POST | /tat_api/v1/loginemail |   | Code will be sent to user’s email address |

Parameters
| Email | String, required, The email address of the user. |

This method accepts a users email address as its only parameter. If the user is found in The system will send an authentication code to the user's email

if the user exists in the system

`{
  content-type: "json", 
  message: "Please check your email for authentication code",  
  token: "4mmwsosbem", 
  state:"ok", 
  status: 200 
}`

Properties

The following table defines the properties that appear in the response

| Name | Description |
| token| String, This is a randomly generated authentication token that needs to be passed in /v1/code in order to authenticate the authentication code that was sent to the user’s email. |
| state | String, the state will be “ok” if the call was successful. If not the state will be “error” |

Error messages

{
    content-type: "json",
    state:"error",
    message:"invalid request",
    status:400
}
