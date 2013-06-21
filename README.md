Simple Chef recipe to install the ZNC irc bouncer.

1. git clone git@github.com:simonvetter/znc-chef.git
2. edit irc_nick and irc_realname in cookbooks/znc/attributes/default.rb. Put your desired irc nickname and your real name in irc_nick and irc_realname respectively.
3. cd into znc-chef
4. type bash ./deploy.sh root@<yourserver>
5. wait for chef to finish.
6. point your favorite irc client to <yourserver>, port 39221, using SSL
7. login with your irc nickname and "helloWorld" as server password.
8. once connected, type /msg *controlpanel set password $me <yourpassword> to change your password.
9. disconnect and reconnect with your password.
10. join channels, profit! (you're connected on freenode by default)


