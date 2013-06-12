%%%------------------------------------------------------------------- 
%%% @author Godwit
%%% @copyright (C) 2013, Godwit
%%% @doc
%%%
%%% @end
%%% Created : 12 Jun 2013 by Godwit
%%%------------------------------------------------------------------- 
-module( sn_server_sup ).
-behaviour( supervisor ).

%% API 
-export([start_link/0]).
%% Supervisor callbacks 
-export([init/1]).
-define(SERVER, ?MODULE).

%%%=================================================================== 
%%% API functions 
%%%===================================================================

%%-------------------------------------------------------------------- 
%% @doc
%% Starts the supervisor 
%%-------------------------------------------------------------------- 
start_link() ->
	supervisor:start_link({local, ?SERVER}, ?MODULE, []).

%%%=================================================================== 
%%% Supervisor callbacks 
%%%===================================================================
%%-------------------------------------------------------------------- 
%% @private
%% @doc
%% Whenever a supervisor is started using supervisor:start_link/[2,3], 
%% this function is called by the new process to find out about
%% restart strategy, maximum restart frequency and child 
%% specifications.
%%
%% @spec init(Args) -> {ok, {SupFlags, [ChildSpec]}} | 
%% 			ignore |
%% 			{error, Reason}
%% @end 
%%--------------------------------------------------------------------
init([]) ->
       io:format("~n~p:~p (~p) init([]) ~n",
		[?MODULE, ?LINE, self()]),	
	RestartStrategy		  = one_for_one,
	MaxRestarts    		  = 1000,
	MaxSecondsBetweenRestarts = 3600,

	ServerName 		  = sn_server_game, 
	ServerFrontName 	  = sn_server_login, 
	SupFlags 		  = {RestartStrategy,
			MaxRestarts, 
			MaxSecondsBetweenRestarts},

	Restart 		  = permanent, 
	Shutdown 		  = 2000,
	Type 			  = worker,

	Server 			  = {'sn_server_game', 
				     {ServerName, start_link, []},
				     Restart, 
				     Shutdown, 
				     Type, 
				     [ServerName]},
	Front 			   = {'sn_server_login', 
				      {ServerFrontName, start_link, []},
				      Restart,
				      Shutdown,
				      Type, 
				      [ServerFrontName]},
	{ok, {SupFlags, [Server, Front]}}.

%%%=================================================================== 
%%% Internal functions 
%%%===================================================================