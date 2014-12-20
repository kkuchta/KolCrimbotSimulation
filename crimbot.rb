require 'pry'
require 'active_support'
require './adventure'
require './bot'

# Pre-sort the actions by order of preferrability
#
# Actions look like:
# [:actions_required] = [damage_taken, items_gained]
#
# items_gained is 0 when you get a schematic.
# damage_taken can be a range
#
# In cases where two options have the same requirements, the worse option has
# been removed
FIGHTS = [
  {
    name: 'Bot Your Shields',
    actions: {
      [:blam, :blam] => [0, 1],
      [] => [2, 0]
    }
  },
  {
    name: 'Festively Armed',
    actions: {
      [:lube] => [0, 0],
      [] => [1, 0]
    }
  },
  {
    name: 'Compugilist',
    actions: {
      [:pow, :pow] => [0, 0],
      [] => [2, 0]
    }
  },
  {
    name: 'I See You',
    actions: {
      [:light] => [0, 0],
      [] => [1, 0]
    }
  },
  {
    name: 'Whatcha Thinkin\'?',
    actions: {
      [:zap, :zap] => [0, 0],
      [] => [2, 0]
    }
  }
]
UP_REWARDS = [
  {
    name: 'Still Life With Despair',
    actions: {
      [:pinch] => [0, 1],
      [:zap, :zap] => [0, 0]
    }
  },
  {
    name: 'Hope You Have A Beretta',
    actions: {
      [:blam, :blam] => [0, 1],
      [:pinch] => [0, 0]
    }
  },
  {
    name: 'This Gym Is Much Nicer',
    actions: {
      [:pinch] => [0, 1],
    }
  }
  
]
DOWN_REWARDS = [
  {
    name: 'Pants in High Places',
    actions: {
      [:blam, :blam] => [0, 0],
      [] => [2..3, 0]
    }
  },
  {
    name: 'Cage Match',
    actions: {
      [:zap, :zap] => [0, 0],
      [] => [2..3, 0]
    }
  },
  {
    name: 'Birdbot is the Wordbot',
    actions: {
      [:blam, :blam] => [0, 1],
      [] => [2, 0]
    }
  },
  {
    name: 'Humpster Dumpster',
    actions: {
      [:lube] => [0, 1],
      [] => [2..3, 0]
    }
  },
]

CHALLENGES = [
  {
    name: 'The Floor is Like Lava',
    actions: {
      [:hover] => [2, 0],
      [] => [2..4, 0]
    }
  },
  {
    name: 'Off The Rails',
    actions: {
      [:roll, :roll] => [2, 0],
      [] => [3..4, 0]
    }
  },
  {
    name: 'A Pressing Concern',
    actions: {
      [:run, :run] => [2, 0],
      [] => [3..4, 0]
    }
  },
  {
    name: 'A Vent Horizon',
    actions: {
      [:freeze] => [2, 0],
      [] => [3..4, 0]
    }
  }
  
  
]
#stages = {
  #fight: fights,
  #ladder:[],
  #up_reward:[],
  #down_reward:[],
  #hard_challenge:[]
#}

# Note: I'm skipping any part that has a completely superiour, non-rare alternative.
PARTS = {
  left: {
    bug_zapper: {
      health: 1,
      abilities: [:zap]
    },
    rodent_gun: {
      health: 0,
      abilities: [:blam]
    },
    mega_vice: {
      health: 0,
      abilities: [:pow, :pow]
    },
    mobile_girder: {
      health: 3,
      abilities: []
    },
    rivet_shocker: {
      health: 0,
      abilities: [:pow, :zap],
    },
    swiss_arm: {
      health: 0,
      abilities: [:blam, :pow, :zap]
    }
  },

  right: {
    grease_regular_gun: {
      health: 0,
      abilities: [:blam, :lube],
    },
    power_stapler: {
      health: 0,
      abilities: [:zap, :pinch]
    },
    snow_blower: {
      health: 0,
      abilities: [:freeze]
    },
    wrecking_ball: {
      health: 1,
      abilities: [:pow]
    }
  },

  torso: {
    crab_core: {
      health: 4,
      abilities: [:pinch]
    },
    cyclopean_torso: {
      health: 4,
      abilities: [:light]
    },
    dynamo_head: {
      health: 4,
      abilities: [:zap]
    },
    military_chassis: {
      health: 3,
      abilities: [:blam, :light]
    }
  },

  legs: {
    big_wheel: {
      health: 0,
      abilities: [:roll, :roll]
    },
    heavy_duty: {
      health: 1,
      abilities: [:run]
    },
    high_speed_fan: {
      health: 1,
      abilities: [:hover]
    },
    hoverjack: {
      health: 2,
      abilities: [:hover]
    },
    rollerfeet: {
      health: 0,
      abilities: [:roll, :run]
    },
    sim_simian: {
      health: 0,
      abilities: [:run, :pinch]
    },
    tripod: {
      health: 0,
      abilities: [:run, :run]
    }
  }

}

# Disable logging the lazy way
#def log(_)
#end

def log(s)
  #puts s
end

bot = Bot.new({right: :power_stapler, left: :swiss_arm, torso: :military_chassis, legs: :hoverjack})

total = 0.0
runs = 1000000

runs.times do
  adventure = Adventure.new(bot, true)
  total += adventure.run
end

puts "Avg items: #{total/runs}"
