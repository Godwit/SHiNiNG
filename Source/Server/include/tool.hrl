-author( 'Godwit' ).
-purpose( "Create some tools" ).
-history( [{ 'Godwit', "Create", 20130612}] ).

-include( "version.hrl" ).

%%%=================================================================== 
%%% Internal functions 
%%% ===================================================================
convert_to_json(Data) ->  
	Content = [{obj, [
                {name, list_to_binary(Name)},
                {status, list_to_binary(Status)}]} ||  
                         {Name, Status} <-Data],
       {obj, [{data, Content}]}.

