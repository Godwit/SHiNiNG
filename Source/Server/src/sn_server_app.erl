%%%------------------------------------------------------------------- 
%%% @author Godwit
%%% @copyright (C) 2012 SHiNiNG
%%% @doc
%%%
%%% @end
%%% Created : 12 June 2013 by Godwit
%%%------------------------------------------------------------------- 
-module( sn_server_app ).

-behaviour( application ).

%-include( "def.hrl" ).
%%% Application callbacks
-export( [start/2, stop/1] ).

%%%=================================================================== 
%%% Application callbacks
%%%===================================================================

%%-------------------------------------------------------------------- 
%% @private
%% @doc
%% This function is called whenever an application is started using 
%% application:start/[1,2], and should start the processes of the 
%% application. If the application is structured according to the OTP 
%% design principles as a supervision tree, this means starting the 
%% top supervisor of the tree.
%%
%% @spec start(StartType, StartArgs) -> {ok, Pid} |
%%					{ok, Pid, State} |
%%					{error, Reason} 
%%	StartType = normal | {takeover, Node} | {failover, Node}
%%	StartArgs = term()
%% @end
%%-------------------------------------------------------------------- 
start(_StartType, _StartArgs) ->
	init_logger(),	
	log4erl:info("~n~p:~p (~p) start(~p, ~p) ~n",
		[?MODULE, ?LINE, self(), _StartType, _StartArgs]),
	init_db(),
	case sn_server_sup:start_link() of 
	  {ok, Pid} ->
	     {ok, Pid}; 
	  Error ->
	     log4erl:error( "~nSome disaster happened here~n" ),
	     Error 
		end.

%%-------------------------------------------------------------------- 
%% @private
%% @doc
%% This function is called whenever an application has stopped. It
%% is intended to be the opposite of Module:start/2 and should do 
%% any necessary cleaning up. The return value is ignored.
%%
%% @spec stop(State) -> void()
%% @end 
%% -------------------------------------------------------------------- 
stop(_State) ->
  ok.

%%%=================================================================== 
%%% Internal functions 
%%%===================================================================
init_logger() ->
	%%% Initialize log4erl
	application:start( log4erl ),
	log4erl:conf( "../priv/log4erl.conf" ),
	log4erl:info( "Log4erl initialize sucessfully!" ),
	ok.

init_db() ->
	schema:install_db( [node()] ),
	log4erl:info( "Database initialize sucessfully!" ),
	ok.
