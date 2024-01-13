![](https://github.com/martinville/esp4ha/blob/main/logo.png)

# EskomSePush Integration for Homeassistant

## What it does
This integration is used to download daily loadshedding schedules and loadshedding stages from the eskomsepush API.

Before you can use this integration you need to obtain an API key by subscribing to the following link.
https://eskomsepush.gumroad.com/l/api

### Add this respository to your Home Assistant add-on store
From the "Settings" menu item in Home Asstant's UI go to "Add-ons". In the bottom right-hand corner click "ADD-ON STORE". The in the right-hand top corner click the three dots and select "Repositories".
Paste the following repository link and click add then close https://github.com/martinville/esp4ha
![](https://github.com/martinville/solarsynkv2/blob/main/addrepo.png)


Simply populate the configuration tab with your homeassistant details after installing this integration.

![](https://github.com/martinville/esp4ha/blob/main/config.png)


### Setting up a long-lived access token.
Click your profile picture situated in the bottom left of your HA user-interface. Scroll all the way to the bottom and create a long-lived token. The token name is not important for the solarsynk add-on but obviously the token key is. Make sure you copy it and keep it for use later on.

![](https://github.com/martinville/solarsynkv2/blob/main/longlivetoken.png)



