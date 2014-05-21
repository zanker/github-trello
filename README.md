Overview
===
Allows you to manage or reference your Trello board through commits to Github.
Tag a commit with "Closes 1234" to have a card automatically archived,
or "Card 1234" to have the commit sent to the card.

Commands
-
Commit messages are searched for `(case|card|close|archive|fix)e?s? \D?([0-9]+)`
to find the card short id. Case/card resolve to `on_start` configuration,
close/fix resolve to `on_close`, and `archive` will just archive the card regardless.

The commit message is added as a comment to the card as well.

Usage
-

See `trello-web --help` for a list of arguments for starting the server. If your domain name is foobar.com and the server is listening on port 4000, then set the posthook URL on Github to __http://foobar.com:4000/posthook__

On the first run, it will create an empty configuration file for you that you will need to configure based on how you want it to manage.

You will need to get your api key and OAuth token with read/write access that won't expire for this to work. You can either use your own account, or create a separate deployment one for this.

Go to `https://trello.com/1/appKey/generate` to get your key, then go to
`https://trello.com/1/authorize?response_type=token&name=Trello+Github+Integration&scope=read,write&expiration=never&key=[your-key-here]`
replacing `[your-key-here]` with the key Trello gave you.
Authorize the request and then add the token and key to your trello.yml file.

You can get the board id from the URL, for example in
`https://trello.com/board/trello-development/4d5ea62fd76aa1136000000c` the
board id is `4d5ea62fd76aa1136000000ca`.

There are 3 actions you can configure to decide what happens to a card,`on_start`
for case/card, `on_close` for close/fix. `on_deploy` requires an additional hookin
to your deployment that you can read below.

You can find out list ids at the following url : `https://api.trello.com/1/board/your_board_id/lists?key=your_key&token=your_token`

Deployment
-

If you are moving your cards to a new list (such as "Live") after deployment,
then you must use the `move_to` option in `on_close`. Unlike `on_start` or `on_close`, you must also specify the repo name for `move_to`.

You indicate a deploy happened through sending a POST request to `http://foobar.com:4000/deployed/[repo-name]`. An example of a Capistrano deployment script:

    require "net/https"
    Capistrano::Configuration.instance(:must_exist).load do
      after "deploy:update" do
        uri = URI("https://foobar.com:4000/deployed/foo-bar")

        http = Net::HTTP.new(uri.host, uri.port)
        http.use_ssl = uri.scheme == "https"
        http.verify_mode = OpenSSL::SSL::VERIFY_NONE
        http.request_post(uri.path, "")
      end
    end
