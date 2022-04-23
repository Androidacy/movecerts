## Move Certificates
### By Androidacy

<sub>Please note, this module is neither devloped nor sponsored, approved, or otheriwse endorsed by the original authors of the [original Move Certificates module](https://github.com/Magisk-Modules-Repo/movecert)</sub>

This module serves a very simple purpose: to move user certificates to the system store automagically, thereby removing the pesky "Network may be monitored" warning and allowing some apps that do not trust user certificates to trust the installed certificate. This is useful for Adguard or Wireshark users, which both need to install an user certificate to filter HTTPS certificates.

We chose to make this because the maker of the original module seems to have abandoned development, and it non longer works with modern versions of Magisk.

#### Need to copy, not move?

Create a file in /sdcard/Documents/movecerts called `cp-not-mv`

View our other projects at [https://www.androidacy.com/](https://www.androidacy.com/?f=mvcrt%20readme)
