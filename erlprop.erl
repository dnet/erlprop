-module(erlprop).
-export([propagation/0]).
-include_lib("xmerl/include/xmerl.hrl").

propagation() ->
	HTML = get_html(),
	extract_prop_from_html(HTML).

get_html() ->
	URL = "http://www.g4ilo.com/wwv/webprop.php",
	{ok, {_, _, HTML}} = httpc:request(get,
		{URL, [{"User-Agent", "erlprop"}]}, [], []),
	HTML.

extract_prop_from_html(HTML) ->
	{match, [ConditionsLine]} = re:run(HTML, "<p><b>Conditions:</b>(.*)$",
		[multiline, {capture, all_but_first, list}]),
	{match, Bands} = re:run(ConditionsLine, "(<b>[^:]+:</b>) (<span[^>]*>[^<]+</span>)",
		[{capture, all_but_first, list}, global]),
	[string:join(lists:map(fun inner_text/1, Band), " ") || Band <- Bands].

inner_text(XML) ->
	{Element, _} = xmerl_scan:string(XML),
	string:join(lists:map(fun node2text/1, Element#xmlElement.content), "").

node2text(Node) -> Node#xmlText.value.
