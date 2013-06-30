%%%------------------------------------------------------------------- 
%%% @author Godwit
%%% @copyright (C) 2013, 
%%% @doc
%%%
%%% @end
%%% Created : 12 Jun 2013 by Godwit

%%%------------------------------------------------------------------- 
-module( sn_db_inf ).
-behaviour( gen_server ).

%% API 
-export([start_link/0]).

%% gen_server callbacks
-export([init/1, handle_call/3, handle_cast/2, handle_info/2,
	terminate/2, code_change/3]). 
-export( [ account_check/2 ] ).

-include( "schema.hrl" ).

-define( DB_INF, ?MODULE).
%%%=================================================================== 
%%% API 
%%%===================================================================

%%%=================================================================== 
%%% Functions for internal Use 
%%%===================================================================
account_check( UserName, Password ) ->
	gen_server:call( ?MODULE, { account_check, UserName, Password } ).

%%-------------------------------------------------------------------- 
%% @doc
%% Starts the server %%
%% @spec start_link() -> {ok, Pid} | ignore | {error, Error}
%% @end 
%%-------------------------------------------------------------------- 
start_link() ->
	gen_server:start_link({local, ?DB_INF}, ?MODULE, [], []).

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
handle_call({ test }, _From, State) -> 
	{reply, ok, State};
handle_call({account_check, UserName, Password}, _From, State) ->
	Account = #tbl_account{ account_id = none, username = UserName, password = Password, session = none },  
	Result = intf_account_check( Account ),
	{ reply , Result, State }.

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
intf_account_check( Account ) ->
	case db_op:query_account( Account#tbl_account.username ) of
	  [] ->
	      { error, not_exist };
	  [ { AccountID, PassStored }] ->
	      intf_account_check( Account, AccountID, PassStored )
	end.

intf_account_check( Account, AccountID, PassStored ) ->
	case Account#tbl_account.password == PassStored of
	  true ->
		Account1 = Account#tbl_account{account_id = AccountID},
		{ ok, Account1 };
	  false ->
		{ error, bad_password }
	end.

