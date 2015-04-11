-- Blue halo Item

ITEM.ShopID 		= 1

ITEM.Name 			= "Blue Halo"
ITEM.UniqueName 	= "BlueHalo"
ITEM.Description 	= "Adds a blue halo to your player model"
ITEM.Price			= 20000

ITEM.Hooks			= {"PreDrawHalos"}
ITEM.Color			= Color( 75, 150, 245 )
ITEM.Player			= false

function ITEM:OnEquip( _Player )
	self.Equiped = true
	self.Player = _Player
end

function ITEM:PreDrawHalos( ply, model, skin )
	if self.Equiped and self.Player then
		halo.Add( {self.Player}, self.Color, 5,5 )
	end
end

function ITEM:OnHolister( _Player )
	self.Equiped = false
	self.Player = false
end