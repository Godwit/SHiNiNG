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
-export([ make_json/0]). 

-include( "schema.hrl" ).
-include( "tools.hrl" ).

-define(SERVER, ?MODULE).

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

handle_call( { login, UserName, Password }, _From, State )
	when is_list( UserName ),
	     is_list( Password ) ->
	check_account( UserName, Password ),
	log4erl:info( "~n~p:~p:~n",
		[ UserName, Password ]),
	Reply = ok,
	{ reply, Reply, State };
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

%%%===================================================================
check_account( UserName, Password ) ->
	Result = sn_db_inf:account_check( UserName, Password ),
	case Result of 
	   { error, _ } ->
		Result;
	   %%% 如果帐号验证成功，那么要进行登入的相关操作。
	   { ok, Account } ->
		account_login( Account )
	end.


%%% 帐号验证成功的处理
account_login( Account ) ->
	%%% 1. 生成Session
	Session = sn_seesion_manager:new_session(),	
	Account1 = Account#tbl_account{session=Session},
	%%% 2. 创建player进程
	_PID= sn_server_player:start( [Account1#tbl_account.account_id, 
				Account1#tbl_account.username,
				Account1#tbl_account.session ] ),

	%%% 3. 在Game里面注册
	%%% 4. 返回正确的数据
		
	{ ok, loginok }.

