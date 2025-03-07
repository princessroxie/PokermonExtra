local anabelsleeve = {
    key = 'virtuoussleeve',
    name = 'Virtuous Sleeve',
    prefix_config = {},
    atlas = "sleeves",
    pos = { x = 1, y = 0 },
    config = {jokers = {"j_pokermon_snorlax"},
    loc_vars = function(self, info_queue, center)
        local key, vars
        if self.get_current_deck_key() == "b_pokermonextra_anabeldeck" then
            key = self.key.."_alt"
            self.config = {jokers = {"j_pokermon_abra"}
            vars = {self.config.jokers}
        else
            key = self.key
            self.config = {jokers = {"j_pokermon_snorlax"}
            vars = {self.config.jokers}
        end
        return {key = key, vars = vars}
    end,
}

local slist = {anabelsleeve}

return {Name = "Sleeve",
            init = init,
            list = slist
}
