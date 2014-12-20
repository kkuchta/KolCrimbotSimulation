class Adventure
  def initialize(bot, go_up)
    @bot = bot
    unless bot.meets_requirements([:pinch])
      #raise "Bot needs pinch"
    end
    @go_up = go_up
  end

  def run
    @bot.reset
    log "Running bot /w #{@bot.health} hp"
    @next_round = :fight
    until @bot.dead?
      round
    end
    log "Dead /w #{@bot.items} items"
    return @bot.items
  end

  private

  def round
    log "  Round #{@next_round}, #{@bot.health} hp"
    @next_round = case @next_round
    when :fight
      trial FIGHTS
      :ladder
    when :ladder
      if @go_up
        :up_reward
      else
        :down_reward
      end
    when :up_reward
      trial UP_REWARDS
      :challenge
    when :down_reward
      trial DOWN_REWARDS
      :challenge
    when :challenge
      trial CHALLENGES
      :fight
    end
  end

  def trial(battle_options)
    battle = battle_options.sample
    log "    #{battle[:name]}"
    battle[:actions].each do |requirements, action|
      if @bot.meets_requirements(requirements)
        log "    running #{requirements}"
        @bot.run *action
        return
      end
    end
  end
end
