class Enemy < Character

  attr_accessor :gun, :routine

  def update
    routine.resume if routine and routine.alive?
    super
  end

  def fire
    Game.instance.join(*self.gun.fire)
  end

  def demolish
    self.durability -= 1
    if durability < 1
      vanish
    end
  end

  def hit(*)
    demolish
  end

  alias hit_shot hit

  def shot_player(*)
    vanish
  end

end

class EnemyModel < Struct.new(:image, :collision, :durability, :gun, :routine)
end

class EnemySpawner

  def spawn(x, y, enemy_model)
    Enemy.new(x, y, enemy_model.image).tap{|enemy|
      enemy.family     = :enemy
      enemy.collision  = enemy_model.collision
      enemy.durability = enemy_model.durability
      enemy.routine    = enemy_model.routine[enemy, Game.instance]
      enemy.target     = Game.instance.screen
      enemy.gun        = enemy_model.gun.new(enemy)
    }
  end
end
