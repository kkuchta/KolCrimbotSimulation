class Bot
  attr_reader :items, :health

  # parts = {left_arm: :tiny_fist, right_arm...}
  def initialize(parts)
    log "Creating bot"
    if parts.keys.sort != [:left, :legs, :right, :torso]
      raise "Missing or extra parts:" + parts.to_s
    end

    @items = 0
    @max_health = 0
    @abilities = []
    parts.each do |slot, part|
      log "  #{slot}: #{part}"
      unless PARTS[slot] && PARTS[slot].keys.include?( part)
        raise "invalid part: #{slot} / #{part}"
      end
      part_data = PARTS[slot][part]
      @abilities.concat part_data[:abilities]
      @max_health += part_data[:health]
    end

    @health = @max_health

    log "  abilities: #{@abilities}"
    log "  max_health: #{@health}"

    @parts = parts
  end

  # Do we have the abilities needed to pass this challenge?
  def meets_requirements(requirements)

    requirements = requirements.clone.sort

    @abilities.each do |ability|
      if requirements.first == ability
        requirements.shift
      end
      if requirements.length == 0
        return true
      end
    end
    return false
  end

  def dead?
    @health <= 0
  end

  def reset
    @health = @max_health
    @items = 0
  end

  def run(damage, items)
    if damage.is_a? Range
      damage = damage.to_a.sample
    end

    if damage > 0
      log "    Took #{damage} damage"
    end
    if items > 0
      log "    Got #{items} items"
    end

    @health -= damage
    @items += items
  end
end
