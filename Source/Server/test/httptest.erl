
-module( httptest ). 
-export([ my_post/0, my_get/0]).

my_post( ) ->
	inets:start(),
	httpc:request( post,
	  { "http://localhost:8080/register.yaws",
	    [],
	    "application/json",
	    "username=Godwit&password=love" },
	    [], []
	),
	inets:stop().


my_get( ) ->
	inets:start(),
	{ok, {{Version, 200, ReasonPhrase}, Headers, Body}} =
	      httpc:request(get, {"http://localhost:8080/login.yaws", []}, [], []),
	io:format( "~n Version:~p~nReasonPhrase:~p~nHeaders:~p~nBody:~p~n", [Version, ReasonPhrase, Headers, Body] ),
	inets:stop().

%%%%%%%%%%%%%%%%%%%%%%%%%
