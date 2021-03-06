%%%------------------------------------------------------------------- 
%%% @author Godwit
%%% @copyright (C) 2013, 
%%% @doc
%%%
%%% @end
%%% Created : 12 Jun 2013 by Godwit

%%%------------------------------------------------------------------- 
-module( sn_server_player ).
-behaviour( gen_server ).

-include( "record_def.hrl" ).
%% API 
-export([start/1]).

%% gen_server callbacks
-export([init/1, handle_call/3, handle_cast/2, handle_info/2,
	terminate/2, code_change/3]). 
-export( [ stop/1 ] ).

-define( PLAYER, ?MODULE).
%%%=================================================================== 
%%% API 
%%%===================================================================

%%%=================================================================== 
%%% Functions for internal Use 
%%%===================================================================

%%-------------------------------------------------------------------- 
%% @doc
%% Starts the server %%
%% @spec start_link() -> {ok, Pid} | ignore | {error, Error}
%% @end 
%%-------------------------------------------------------------------- 
start( [AccountID, UserName, Session] )
	when is_integer( AccountID ),
	     is_list( UserName ),
	     is_integer( Session ) ->
	gen_server:start( ?MODULE, [AccountID, UserName, Session], []).


%%%=================================================================== 
%%% gen_server callbacks 
%%%===================================================================

%%-------------------------------------------------------------------- 
%% @private
%% @doc
%% Initializes the server
%%
%% @spec init(Args) -> { ok, State } |
%%		       { ok, State, TimeOut } |
%%		       ignore |
%%		       { stop, Reason }
%% @end 
%%--------------------------------------------------------------------

init([AccountID, UserName, Session]) ->
	process_flag( trap_exit, true ),
	Player = #rd_player{ oid = AccountID, pid = self(), session=Session },
	%%% 注意：这里只做最简单的登陆处理
        %%% TODO
	%%% 1. 往数据库里面纪录些东西
	%%% 2. 其他	
	log4erl:info("~n~p:~p(~p) : ~p ~p ~p ~n",
		[?MODULE, ?LINE, self(), AccountID, UserName, Session ]), 
	{ok, Player }.

stop( PlayerPid ) 
	when is_pid( PlayerPid ) ->
	gen_server:cast( PlayerPid, stop ).


%%-------------------------------------------------------------------- 
%% @private
%% @doc
%% Handling call messages
%%
%% @spec handle_call(Request, From, State) ->
%%					{reply, Reply, State} |
%%					{reply, Reply, State, Timeout} | 
%%					{noreply, State} |
%% 					{noreply, State, Timeout} |
%% 					{stop, Reason, Reply, State} |
%% 					{stop, Reason, State}
%% @end 
%%--------------------------------------------------------------------
handle_call({ test }, _From, State) -> 
	{reply, ok, State}.

%%-------------------------------------------------------------------- 
%% @private
%% @doc
%% Handling cast messages
%%
%% @spec handle_cast( Msg, State ) -> { noreply, State } |
%%				      { noreply, State, TimeOut } |
%%				      { stop, Reason, State }
%% @end 
%%-------------------------------------------------------------------- 
handle_cast(_Msg, State) ->
	{noreply, State}.

%%-------------------------------------------------------------------- 
%% @private
%% @doc
%% Handling all non call/cast messages
%%
%% @spec handle_info( Info, State ) -> { noreply, State } |
%%				       { noreply, State, TimeOut } |
%%				       { stop, Reason, State }
%%
%% @end 
%%-------------------------------------------------------------------- 
handle_info(_Info, State) ->
	{noreply, State}.

%%-------------------------------------------------------------------- 
%% @private
%% @doc
%% This function is called by a gen_server when it is about to
%% terminate. It should be the opposite of Module:init/1 and do any 
%% necessary cleaning up. When it returns, the gen_server terminates 
%% with Reason. The return value is ignored.
%%
%% @spec terminate(Reason, State) -> void()
%% @end 
%%-------------------------------------------------------------------- 
terminate( _Reason, _Data ) ->
	log4erl:info( "~nPlayer is terminating..~p~n", _Reason ),
	%%% TODO 做一些收尾工作,例如设置DB的值
	ok.

%%-------------------------------------------------------------------- 
%% @private
%% @doc
%% Convert process state when code is changed
%%
%% @spec code_change(OldVsn, State, Extra) -> {ok, NewState}
%% @end 
%%-------------------------------------------------------------------- 
code_change(_OldVsn, State, _Extra) ->
	{ok, State}.

%%%=================================================================== 
%%% Internal functions 
%%%===================================================================

