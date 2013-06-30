-author( 'Godwit' ).
-purpose( "Define records used in game!" ).
-history( [{ 'Godwit', "Create", 20130625}] ).

-include( "version.hrl" ).

%%% 注意：这里定义的都是在游戏里面用到的临时变量
%%% 和数据库没有直接的关系
%%% player
-record( rd_player, {
	  oid,			%%% - object id
	  pid,			%%% - process id 
	  session,		%%% - session
	  nickname,		%%% - Nick name
	  level,		%%% - 
	  gold			%%% - 
	} ).

