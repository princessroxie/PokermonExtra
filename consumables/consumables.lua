local timerball = {
  name = "timerball",
  key = "timerball",
  set = "Item",
  config = {extra = {round_on_add = 1, legendary = 21, rare = 12, uncommon = 6, common = 2}},
  loc_vars = function(self, info_queue, center)
    info_queue[#info_queue+1] = {set = 'Other', key = 'timer'}
    -- don't know the localization code for rarities
    -- it should be localize('k_common') or something like that
    local rarities = {'Common', 'Uncommon', 'Rare', 'Legendary'}
    local rarity = rarities[1]
    local round = G.GAME.round - center.ability.extra.round_on_add
    local colors = {G.C.BLUE, G.C.GREEN, G.C.RED, G.C.PURPLE}
    local color = colors[1]
    local key

    if round >= center.ability.extra.legendary then
      round = 999
      rarity = rarities[4]
      color = colors[4]
      key = self.key.."_max"      
    elseif round >= center.ability.extra.rare then
      round = center.ability.extra.legendary - round
      rarity = rarities[3]
      color = colors[3]
    elseif round >= center.ability.extra.uncommon then
      round = center.ability.extra.rare - round
      rarity = rarities[2]
      color = colors[2]
    elseif round >= center.ability.extra.common then
      round = center.ability.extra.uncommon - round
      rarity = rarities[1]
      color = colors[1]
    elseif round < center.ability.extra.common and round > 0 then
      round = center.ability.extra.common - round
      rarity = rarities[1]
      color = colors[1]
      key = self.key.."_start"
    else 
      key = self.key.."_deck"
    end
    return {vars = {rarity, round, colours = {color}}, key = key}
    
  end,
  pos = { x = 0, y = 0 },
  atlas = "consumables",
  cost = 3,
  unlocked = true,
  discovered = true,
  can_use = function(self, card)
    if (#G.jokers.cards < G.jokers.config.card_limit or self.area == G.jokers) and (G.GAME.round - card.ability.extra.round_on_add) >= 2 then
      return true
    else
      return false
    end
  end,
  
  use = function(self, card, area, copier)
    set_spoon_item(card)
    if (G.GAME.round - card.ability.extra.round_on_add) < self.config.extra.uncommon then
      G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
        play_sound('timpani')
        local _card = create_random_poke_joker("timerball", nil, "common", nil, nil)
        _card:add_to_deck()
        G.jokers:emplace(_card)
        return true end }))
    elseif self.config.extra.uncommon <= (G.GAME.round - card.ability.extra.round_on_add) and (G.GAME.round - card.ability.extra.round_on_add) < self.config.extra.rare then
      G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
        play_sound('timpani')
        local _card = create_random_poke_joker("timerball", nil, "uncommon", nil, nil)
        _card:add_to_deck()
        G.jokers:emplace(_card)
        return true end }))
    elseif self.config.extra.rare <= (G.GAME.round - card.ability.extra.round_on_add) and (G.GAME.round - card.ability.extra.round_on_add) < self.config.extra.legendary then
      G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
        play_sound('timpani')
        local _card = create_random_poke_joker("timerball", nil, "rare", nil, nil)
        _card:add_to_deck()
        G.jokers:emplace(_card)
        return true end }))
    elseif self.config.extra.legendary <= (G.GAME.round - card.ability.extra.round_on_add)  then
      G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
        play_sound('timpani')
        local _card = create_random_poke_joker("timerball", "Legendary")
        _card:add_to_deck()
        G.jokers:emplace(_card)
        return true end }))

    end
  delay(0.6)
  end,
  set_ability = function(self, card, initial, delay_sprites)
    if initial then
      card.ability.extra.round_on_add = G.GAME.round
    end
  end,

}

local berryjuice = {
name = "berryjuice",
key = "berryjuice",
set = "Item",
config = {},
loc_vars = function(self, info_queue, center)
  return {vars = {}}
end,
pos = { x = 1, y = 0 },
atlas = "consumables",
cost = 6,
unlocked = true,
discovered = true,
can_use = function(self, card)
  if #G.jokers.highlighted == 1 then
    return true
  else
    return false
  end
end,
use = function(self, card, area, copier)
  set_spoon_item(card)
  if G.jokers.highlighted[1].ability.perishable then 
    G.jokers.highlighted[1].ability.perish_tally = (G.jokers.highlighted[1].ability.perish_tally + 1)
    G.jokers.highlighted[1]:set_debuff(false)
  end
  G.jokers.highlighted[1]:set_debuff(false)
delay(0.6)
end,
in_pool = function(self)
  return false
end

}

return {name = "Items",
      list = {timerball, berryjuice}
}