## Post messages into MS-Teams Channel with Ruby

> A quick&dirty wrapper.

### Installation

Get ruby up and running, for example on debian-based systems:

~~~bash
apt-get install ruby ruby-bundler rake
~~~

* clone the repo and the run:

~~~bash
cd <reponame>
bundle
~~~

* Create an incoming webhook in the MSTeams-Channel ([learn how-to](https://learn.microsoft.com/de-de/microsoftteams/platform/webhooks-and-connectors/how-to/add-incoming-webhook?tabs=dotnet))

* Create an empty config-file:

~~~bash
./teams_webconnector.rb -n
~~~

* Edit the confguration file:

~~~
channelname:
  name: "a short description"
  secret_uri: "the URI of the webhook"
~~~

* Send a message:

~~~bash
./teams_webconnector.rb -c channelname -m "This is a new testmessage"
~~~



## Synopsis

~~~
Usage: teams_webconnector.rb [options]
    -n, --newconfig                  Write new config file template
    -l, --list                       list configured channels.
    -c, --channel c                  Channel where to post to.
    -m, --message m                  Message text.
~~~

## Special thanks

❤ https://github.com/pedrofurtado/microsoft_teams_incoming_webhook_ruby

.