auto-hibernate
==============

Auto-hibernate checks periodically if this machine should hibernate.
You should run auto-hibernate periodically as a cron job.
The conditions are:

* Does a screen process exist?
* Is a network connection established?
* Is a user logged in?

If all these preconditions fail for the last 30 Minutes the machine
hibernates.

Wake on LAN
===========

You can wake up the machine with Wake On LAN. The tool **wol**
sends the required magic packet. In most situations sending a
magic packet isn't necessary. Some devices support wake up on
a unicast packet. Check out which wake up methods your device
supports:

# ethtool eth0
    [..]
    Supports Wake-on: pumbg
    Wake-on: ug

Use `ethtool -s eth0 wol ug` to enable Wake on unicast (u) and
wake on MagicPacket (g).

With wake up on unicast, any direct packet (like a simple ping) would
wake up this machine.

For more information about the supported Wake up methods see
`man wol`.