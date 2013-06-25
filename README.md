Erlang client for HF propagation widget
=======================================

This widget parses HF propagation info at http://www.g4ilo.com/wwv/webprop.php
and returns it in a list of strings. Using the `ircprop` module, it's possible
to make the information available on your IRC channel as well.

Erlprop usage
-------------

	Eshell V5.10.1  (abort with ^G)
	1> c(erlprop).
	{ok,erlprop}
	2> inets:start().
	ok
	3> erlprop:propagation().
	["<10MHz: Good","10-20MHz: Good","20-30MHz: Normal"]

Ircprop usage
-------------

In shell:

	$ erlc erlprop.erl ircprop.erl

On IRC:

	<dnet> -load erlprop
	<jimm-erlang-bot> module loaded ok
	<dnet> -load ircprop
	<jimm-erlang-bot> module loaded ok
	<dnet> -insmod ircprop
	<jimm-erlang-bot> inserted module ircprop as PID <0.28569.3>
	<dnet> -prop
	<jimm-erlang-bot> <10MHz: Good, 10-20MHz: Good, 20-30MHz: Normal

License
-------

The whole project is available under MIT license.

Dependencies
------------

 - Erlang (tested on R15B and R16B)
 - dnet's fork of erlang-ircbot for IRC bot functionality: https://github.com/dnet/erlang-ircbot
