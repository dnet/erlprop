-module(ircprop).
-export([ircmain/1, ircproc/1, reload/2]).

ircprop() ->
	string:join(erlprop:propagation(), ", ").

ircmain(Contact) ->
	Pid = spawn(?MODULE, ircproc, [Contact]),
	Contact ! {subscribe, Pid},
	Pid.

reload(Contact, Pid) ->
	Pid ! reloaded,
	ircproc(Contact).

ircproc(Contact) ->
	receive
		quit -> quit;
		{incoming, Data} ->
			S = binary_to_list(Data),
			case string:str(S, ":-prop") of
				0 -> nop;
				_ -> spawn(fun() ->
					Contact ! {announce, ircprop()} end)
			end,
			ircproc(Contact);
		{ident, Pid} ->
			Pid ! {ident, "ircprop"},
			ircproc(Contact);
		{reload, Pid} ->
			?MODULE:reload(Contact, Pid);
		_ -> ircproc(Contact)
	end.
