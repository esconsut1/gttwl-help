# Travel Savers Agency Search
This API allows for a Canadian Postal Code/ American zip code to be passed as a parameter and have the 10 closest agencies and their respective data be returned. 

## Endpoints
Below are the available endpoints and their descriptions.

| Endpoint | Description |
| ------ | ------ |
| /travelsavers-agency-search/close-by/ | Accepts a post code / Area code and returns the 10 closest agencies and their information. It is Case insensitive and for the Canadian 6 character postcode, The postcode can be specified with or without a space between the first and last 3 characters  |
| /travelsavers-agency-search/agency/ | Accepts an agency id and reuturns Data for that specific agency  |

## Parameters
Below are the parameters accepted by the API and their descriptions.

| Parameter | description |
|------|------|
|post_code| This is the current Post/Zip code of the user making the call. Both Canadian an American Post/Zip codes can be passed through this parameter.|
|agency_id| This is the id of an Agency as returned by the /close-by/ endpoint. This can be used to in the /agency/ endpoint to return information on a particular agency. |


## Request Examples

Below are some examples of request calls and the format that that they should adhere to. You can run the following urls as examples.

```sh
# With American zip code.
https://api2.gttwl.net/travelsavers-agency-search/close-by/?post_code=10001

# With 6 character Canadian post code.
https://api2.gttwl.net/travelsavers-agency-search/close-by/?post_code=m4c1b5

# With 3 character Canadian post code.
https://api2.gttwl.net/travelsavers-agency-search/close-by/?post_code=t2p

# With an Agency Id
https://api2.gttwl.net/travelsavers-agency-search/?agency_id=18162
```
