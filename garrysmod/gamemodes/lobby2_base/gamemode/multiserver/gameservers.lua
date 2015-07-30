--[[-----------------------------------------------------------

	██╗      ██████╗ ██████╗ ██████╗ ██╗   ██╗    ██████╗ 
	██║     ██╔═══██╗██╔══██╗██╔══██╗╚██╗ ██╔╝    ╚════██╗
	██║     ██║   ██║██████╔╝██████╔╝ ╚████╔╝      █████╔╝
	██║     ██║   ██║██╔══██╗██╔══██╗  ╚██╔╝      ██╔═══╝ 
	███████╗╚██████╔╝██████╔╝██████╔╝   ██║       ███████╗
	╚══════╝ ╚═════╝ ╚═════╝ ╚═════╝    ╚═╝       ╚══════╝

	
	Copyright (c) James Swift, 2015
	
-----------------------------------------------------------]]--

GM.Multiserver = GM.Multiserver or { }
GM.Multiserver.GameServers = GM.Multiserver.GameServers or { }
GM.Multiserver.GameServers.Games = GM.Multiserver.GameServers.Games or { }
GM.Multiserver.GameServers.GameMT = GM.Multiserver.GameServers.GameMT or { }
GM.Multiserver.GameServers.GamesDir = "lobby2_base/gamemode/multiserver/games/"

function GM.Multiserver.GameServers.RegisterGame( tbl )

	local GM = GM or gmod.GetGamemode( )

	if ( not tbl.Name ) then return false end
	
	if ( not GM.Multiserver.GameServers.Games[ tbl.Name ] ) then
	
		GM.Multiserver.GameServers.Games[ tbl.Name ] = tbl
	
	end

end

function GM.Multiserver.GameServers.GetGame( Name )

	local GM = GM or gmod.GetGamemode( )

	return GM.Multiserver.GameServers.Games[ Name ] or false

end

function GM:GetServer( Name )

	return self.Multiserver.GameServers.GetGame( Name )

end

function GM.Multiserver.GameServers.LoadGames( )

	local GM = GM or gmod.GetGamemode( )

	local games = file.Find( GM.Multiserver.GameServers.GamesDir .. "*", "LUA" )
	
	PrintTable( games )
	
	for _, gamefile in pairs( games ) do
	
		GAME = { }
		setmetatable( GAME , { __index = GM.Multiserver.GameServers.GameMT } )
		
		include( GM.Multiserver.GameServers.GamesDir .. gamefile )
		GM.Multiserver.GameServers.RegisterGame( GAME )
		
		GAME = nil
		
	end

end

--[[--------------------------------
	Game Meta
--------------------------------]]--

function GM.Multiserver.GameServers.GameMT:Message( ID, Type, Body )

	local GM = GM or gmod.GetGamemode( )

	if ( not self.IP or not self.ProtocolPassword or not self.ServerID ) then return false end
	
	GM.Multiserver.Coms.SendMessage( self.IP, self.ServerID, ID, Type, self.ProtocolPassword, Body, callback )

end