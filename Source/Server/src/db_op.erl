%%% 提供对数据表的操作
-module( db_op ).
-export( [ insert_account/2, query_account/1] ).
-author( 'Godwit' ).
-purpose( "Initialize the database!" ).
-history( [{ 'Godwit', "Create", 20130612}] ).

-include( "version.hrl" ).
-include( "schema.hrl"  ).

-include_lib( "stdlib/include/qlc.hrl" ).

%%% 插入数据
insert_account( UserName, Password ) ->
	%%% Mnesia没有自增操作
	NewAccountID = counter:bump( tbl_account ),
	Account = #tbl_account{ account_id = NewAccountID, username = UserName, password = Password }, 	

	Fun = fun() ->
		mnesia:write( Account )
	      end,
	mnesia:transaction( Fun ).

%%% 获取数据
query_account( UserName ) ->
	do( qlc:q( [ { X#tbl_account.account_id, X#tbl_account.password } || X <- mnesia:table(tbl_account), X#tbl_account.username =:= UserName] ) ).	

do( Q ) ->
	F = fun() -> qlc:e(Q) end,
	{ atomic, Val } = mnesia:transaction( F ),
	Val.


%%% ============= Test suite ============= 
db_op_test_() ->
	[ ?_assert( ok =:= ok ),
		?_assert( 1  =:= 1  )
	].


