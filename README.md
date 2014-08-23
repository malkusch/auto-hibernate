auto-hibernate
==============

Auto-hibernate checks periodically if this machine should hibernate.
You should run `auto-hibernate` periodically as a cron job:

    # try to hibernate every 5 minutes
    */5 *  * * *    root    /usr/sbin/auto-hibernate.sh

The conditions are:

* Does a screen process exist?
* Is a network connection established?
* Is a user logged in?

If all these preconditions fail for the last 30 Minutes the machine
hibernates.

Wake on LAN
===========

You can wake up the machine with Wake On LAN. The tool **wol**
sends the required magic packet. Check out which wake up methods
your device supports:

    # ethtool eth0
    [..]
    Supports Wake-on: pumbg

Use `ethtool -s eth0 wol g` to enable Wake on MagicPacket (*g*):

    # ethtool eth0
    [..]
    Wake-on: g

For more information about the supported Wake up methods see
`man ethtool`.


# License and author

Markus Malkusch <markus@malkusch.de> is the author of this project. This project is free and under the WTFPL.

## Donations

If you like this project and feel generous donate a few Bitcoins here:
[1335STSwu9hST4vcMRppEPgENMHD2r1REK](bitcoin:1335STSwu9hST4vcMRppEPgENMHD2r1REK)
