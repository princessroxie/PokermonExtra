local anabeldeck = {
	name = "anabeldeck",
	key = "anabeldeck",  
    atlas = "backs",
    pos = { x = 0, y = 0 },
	config = {jokers = {j_pokermon_snorlax},
  loc_vars = function(self, info_queue, center)
    return {vars = {}}
  end
} 

local dList = {anabeldeck}

return {name = "Back",
        list = dList
        
}


