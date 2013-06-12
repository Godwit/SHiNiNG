-author( 'Godwit' ).
-purpose( "Database defination!" ).
-history( [{ 'Godwit', "Create", 20130612}] ).

-include( "version.hrl" ).

%%% 计数器
-record( tbl_counter, {
	  type,
	  value	
	} ).

%%% 用户帐户表
-record( tbl_account, {
	account_id,		%%% --- Primary Key: Account ID
	username,		%%% --- Username
	password		%%% --- Password
	} ).

%%% 用户信息表
-record( tbl_character, {
	account_id,		%%% --- Primary Key: 与tbl_account主键一致
	nickname,		%%% --- Nickname
	gender,			%%% --- Gender
	level			%%% --- Player Level
	} ).



