Overview
===
Allows you to manage or reference your Trello board through commits to Github. Tag a commit with "Closes 1234" to have a card automatically archived, or "Card 1234" to have the commit sent to the card.

Commands
-
Commit messages are searched for `(case|card|close|archive|fix)e?s? \D?([0-9]+)` to find the card short id. Case/card resolve to on_start configuration, close/fix resolve to on_close, and archive will just archive the card regardless.

The commit message is added as a comment to the card as well.

Usage
-

See `trello-web --help` for a list of arguments for starting the server. If your domain name is foobar.com and the server is listening on port 4000, then set the posthook URL on Github to __http://foobar.com:4000/posthook__

On the first run, it will create an empty configuration file for you that you will need to configure based on how you want it to manage.

You will need to get your api key and OAuth token with read/write access that won't expire for this to work. You can either use your own account, or create a separate deployment one for this.

Go to https://trello.com/1/appKey/generate to get your key, then go to _https://trello.com/1/authorize?response_type=token&name=Trello+Github+Integration&scope=read,write&expiration=never&key=[Your Key Here]_ replacing __[Your Key Here]__ with the key Trello gave you. Authorize the request and then add the token and key to your trello.yml file.

You can get the board id from the URL, for example https://trello.com/board/trello-development/4d5ea62fd76aa1136000000c the board id is _4d5ea62fd76aa1136000000ca_.

There are 3 actions you can configure to decide what happens to a card. Currently due to a bug in Trello's API, you cannot move a card to another list through the API, so only __archive__ will work. The code is already in, just waiting on Trello to fix the bug.

To do
-
Once Trello fixes the list API bug, I'll be implementing an on deploy action for people who want to be able to move cards from list A to B, such as moving from a "Pending Deployment" to "Live" or just archiving the cards.