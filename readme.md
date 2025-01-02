# SimpleCallAdmin

### Version 1.0.0

## About SimpleCallAdmin:

1. _SimpleCallAdmin is a simple script for your server that pretty much has one main function, and that's to allow players to call for a member of your staff team via /calladmin sending staff a message!_

2. _SimpleCallAdmin comes with the ability for logging within the server to keep of players that call for an admin._

## Configuration:

1. Logging:

   - SimpleCallAdmin comes with a logging system built into the script, you can configure the options that are listed below in the config.lua.

   1. Webhook Name: _You can change the name of the webhook that appears in discord._
   2. Webhook PFP: _You can change the profile picture of the webhook._
   3. Webhook Color: _You can change the color of the webhook._ (Use: [This](https://www.mathsisfun.com/hexadecimal-decimal-colors.html))
   4. Footer Icon: _You can change the icon that appears for the footer message in the embed._
   5. Webhook Link: _You can change the URL of where the embed is sent to._

2. Usage of Ace Permissions:
   - You can change the permission required for the script in the config.lua. By default the script uses `simple.staff` but you can change this to be whatever you want!

## Custom Notification System:

   - SimpleCallAdmin comes with the ability for you to configure how the messages will be sent to the staff team! Now there are preset systems, however, you have the option to create your own! In the server.lua you can configure the "custom" response however you want to have it!

   `elseif Config.Settings.chatSetting == "custom" then`
   `   -- Your code `
   `end`
## Notice:

- For support using this script, join our discord and open a ticket!
