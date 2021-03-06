%%%------------------------------------------------------------------- 
%%% @author Godwit
%%% @copyright (C) 2013, 
%%% @doc
%%%
%%% @end
%%% Created : 12 Jun 2013 by Godwit

%%%------------------------------------------------------------------- 
-module( sn_session_manager).
-behaviour( gen_server ).

%% API 
-export([start_link/0]).

%% gen_server callbacks
-export([init/1, handle_call/3, handle_cast/2, handle_info/2,
	terminate/2, code_change/3]). 
-export([ new_session/0 ] ).
-define( SESSION_MANAGER, ?MODULE).

%%%=================================================================== 
%%% API 
%%%===================================================================

%%%=================================================================== 
%%% Functions for internal Use 
%%%===================================================================
new_session( ) ->
	gen_server:call( ?MODULE, { new_session } ).

%%-------------------------------------------------------------------- 
%% @doc
%% Starts the server %%
%% @spec start_link() -> {ok, Pid} | ignore | {error, Error}
%% @end 
%%-------------------------------------------------------------------- 
start_link() ->
	gen_server:start_link({local, ?SESSION_MANAGER}, ?MODULE, [], []).

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

init([]) ->
	log4erl:info("~n~p:~p(~p) init(~p)~n",
		[?MODULE, ?LINE, self(), []]), 
	{ok, []};
init(Status) ->
	log4erl:info("~n~p:~p(~p) init(~p)~n",
		[?MODULE, ?LINE, self(), Status]), 
	{ok, Status}.

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
handle_call({ new_session }, _From, State) -> 
	Session = make_ref(),
	log4erl:info( "~nGenerate a new session:~p~n", [Session] ),
	{replay, Session, State };
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
terminate(_Reason, _State) ->
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

