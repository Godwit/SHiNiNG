{
 application, 
 %%% sn_server is short for shining_server
 sn_server, 
 [
  {description, "A Simple Game Server Framework"}, 
  {vsn, "0.1.0"},
  {modules,
  [
   sn_server_app,
   sn_server_sup,
   sn_server_register,
   sn_server_login,
   sn_session_manager,
   sn_server_game,
   sn_db_inf
  ]},
  {registered, 
	[sn_server_app, 
	 sn_server_sup, 
   	 sn_server_register,
	 sn_server_login,
	 sn_session_manager,
	 sn_server_game, 
   	 sn_db_inf
	]},
  {applications, [kernel, stdlib]},
  {mod, {sn_server_app,[]}},
  {start_phases, []}
 ]
}.
