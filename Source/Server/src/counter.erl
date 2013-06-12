%%% Mnesia没有自增操作，所以必须自己找个方法老实现。
-module( counter ).
-export( [bump/1, bump/2, reset/1] ).
-author( 'Godwit' ).
-purpose( "Counter" ).
-history( [{ 'Godwit', "Create", 20130612}] ).

-include( "version.hrl" ).
-include( "schema.hrl"  ).

bump( Type ) ->
	bump( Type, 1 ).

bump( Type, Inc ) ->
	mnesia:dirty_update_counter( tbl_counter, Type, Inc ).

reset( Type ) ->
	Counter = #tbl_counter{
	  type  = Type,
	  value = 0		
	},
	mnesia:transaction( fun() ->
				mnesia:write( Counter ) 
			    end ).



