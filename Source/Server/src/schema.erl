%%% 该文件用于创建数据库表
-module( schema ).
-export( [install_db/1, init_db/1] ).
-author( 'Godwit' ).
-purpose( "Initialize the database!" ).
-history( [{ 'Godwit', "Create", 20130612 }] ).

-include( "version.hrl" ).
-include( "schema.hrl"  ).

-include_lib( "stdlib/include/qlc.hrl" ).

%%% 安装数据库
install_db( Nodes ) when is_list( Nodes ) ->
	init_db( Nodes ),
	init_tables( Nodes ).


%%% 初始化数据库
init_db( Nodes ) ->
	mnesia:stop(),
	%%% delete the database that already existed
	mnesia:delete_schema( Nodes ),
	log4erl:info( "Delete old schema scussefully!" ),
	%%% create a new database on disc
	catch( mnesia:create_schema( Nodes ) ),
	mnesia:start(),
	mnesia:info(),
	ok.

%%% 初始化数据库中的表
init_tables( Nodes ) when is_list( Nodes) ->
	%%% tbl_counter
	case mnesia:create_table( tbl_counter, [
		  { disc_copies, Nodes},
		  { type, set },
	 	  { attributes, record_info(fields, tbl_counter) }
		]) of
	     { atomic, ok } ->
		ok;
	     Any0 ->
		error_logger:error_report( [
		   { message, "Cannot create tbl_counter" },
		   { table, tbl_counter },
		   { error, Any0 },
		   { nodes, Nodes }			
		 ])
	end,
	%%% tbl_account
	case mnesia:create_table( tbl_account, [
                   { disc_copies, Nodes },
		   { type, set },
		   { attributes, record_info( fields, tbl_account ) }
		]) of
	     { atomic, ok } ->
		ok;
	     Any1 ->
		error_logger:error_report( [
		   { message, "Cannot create tbl_account" },
		   { table, tbl_account },
		   { error, Any1 },
		   { nodes, Nodes }		
		 ])
	end,
	%%% tbl_character
	case mnesia:create_table( tbl_character, [
                   { disc_copies, Nodes },
		   { type, set },
		   { attributes, record_info( fields, tbl_character ) }
		]) of
	     { atomic, ok } ->
		ok;
	     Any2 ->
		error_logger:error_report( [
		   { message, "Cannot create tbl_character" },
		   { table, tbl_character },
		   { error, Any2 },
		   { nodes, Nodes }		
		 ])
	end,

	ok.

%%% ============= Test suite ============= 
schema_test_() ->
	[ ?_assert( ok =:= ok ),
	  ?_assert( 1  =:= 1  )
	].


