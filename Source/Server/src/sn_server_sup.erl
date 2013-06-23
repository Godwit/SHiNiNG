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
       log4erl:info("~n~p:~p (~p) init([]) ~n",
		[?MODULE, ?LINE, self()]),	
	RestartStrategy		  = one_for_one,
	MaxRestarts    		  = 1000,
	MaxSecondsBetweenRestarts = 3600,

	SupFlags 		  = {RestartStrategy,
			MaxRestarts, 
			MaxSecondsBetweenRestarts},

	Restart 		  = permanent, 
	Shutdown 		  = 2000,
	Type 			  = worker,

	%%% ------------------------------------

	%%% sn_server_login
	NameServerLogin 	  = sn_server_login, 
	ServerLogin		  = {'sn_server_login', 
				      {NameServerLogin, start_link, []},
				      Restart,
				      Shutdown,
				      Type, 
				      [NameServerLogin]},


	%%% sn_server_game
	NameServerGame 		  = sn_server_game, 
	ServerGame		  = {'sn_server_game', 
				     {NameServerGame, start_link, []},
				     Restart, 
				     Shutdown, 
				     Type, 
				     [NameServerGame]},
	

	%%% sn_server_player
	NameServerPlayer	  = sn_server_player, 
	ServerPlayer		  = {'sn_server_player', 
				     {NameServerPlayer, start_link, []},
				     Restart, 
				     Shutdown, 
				     Type, 
				     [NameServerPlayer]},
	

	%%% sn_db_inf
	NameDBInf 		  = sn_db_inf, 
	DBInf			  = {'sn_db_inf', 
				     {NameDBInf, start_link, []},
				     Restart, 
				     Shutdown, 
				     Type, 
				     [NameDBInf]},
	

	
	%%% ------------------------------------
	{ok, {SupFlags, [ServerGame, ServerLogin,ServerPlayer,DBInf ]}}.

%%%=================================================================== 
%%% Internal functions 
%%%===================================================================
