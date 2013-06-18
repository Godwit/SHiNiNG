%%%------------------------------------------------------------------- 
%%% @author Gowit
%%% @copyright (C) 2013, Godwit
%%% @doc
%%%
%%% @end
%%% Created : 12 Jun 2013 by Godwit
%%%------------------------------------------------------------------- 
-module( sn_server_login ).
-behaviour(gen_server).
%% API 
-export([start_link/0]).

%% gen_server callbacks
-export([init/1, handle_call/3, handle_cast/2, handle_info/2,
	terminate/2, code_change/3]). 
-export([register_account/4, make_json/0]). 
-define(SERVER, ?MODULE).

-include( "tools.hrl" ).

register_account( UserName, Password, NickName, Gender ) ->
	gen_server:call( ?MODULE, { register_account, UserName, Password, NickName, Gender } ).

make_json() ->
	Data = [ { "Godwit", "Love" } ],
	Json = rfc4627:encode( convert_to_json( Data ) ),
	io:format( "~n~p~n ", [ Json ] ),
	Json.


%%%=================================================================== 
%%% API 
%%%===================================================================

%%-------------------------------------------------------------------- 
%% @doc
%% Starts the server 
%% %%
%% @spec start_link() -> {ok, Pid} | ignore | {error, Error}
%% @end 
%% -------------------------------------------------------------------- 
start_link() ->
	gen_server:start_link({local, ?SERVER}, ?MODULE, [], []).

%%%=================================================================== 
%%% gen_server callbacks 
%%%===================================================================
init([]) ->
	log4erl:info("~n~p:~p(~p) init(~p)~n",
		[?MODULE, ?LINE, self(), []]),
	{ ok, [] }.

handle_call({ register_account, UserName, Password, NickName, Gender}, _From, State) -> 
	log4erl:info( "~n~p:~p:~p:~p~n",
		[ UserName, Password, NickName, Gender ]),
	%%% do some register thing.
	Reply = "HelloTesting",
	{reply, Reply, State}.

handle_cast(_Msg, State) -> 
	{noreply, State}.
handle_info(_Info, State) -> 
	{noreply, State}.
terminate(_Reason, _State) -> 
	ok.

code_change(_OldVsn, State, _Extra) -> 
	{ok, State}.

