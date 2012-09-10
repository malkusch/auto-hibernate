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
sends the required magic packet. In some situations sending a
magic packet isn't necessary. Some devices support wake up on
a unicast packet. Check out which wake up methods your device
supports:

    # ethtool eth0
    [..]
    Supports Wake-on: pumbg
    Wake-on: ug

Use `ethtool -s eth0 wol ug` to enable Wake on unicast (*u*) and
wake on MagicPacket (*g*).

With wake up on unicast, any direct packet (like a simple ping) would
wake up this machine. Of course this packet can only be routed if
the MAC address is already in your local ARP cache.

For more information about the supported Wake up methods see
`man wol`.
