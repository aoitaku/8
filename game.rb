class Game

  attr_accessor :screen, :player, :enemies, :shots, :bullets, :stage
  attr_accessor :prelude, :finale

  def initialize(stage_data)
    @screen = RenderTarget.new(Window.width/2, Window.height/2)
    @stage  = Stage.new(self, stage_data)
    @player = Player.new(Assets[:player])
    @player.target    = self.screen
    @player.collision = [5, 3, 10, 12]
    setup
  end

  def setup
    @player.x = (@screen.width - @player.width) / 2
    @player.y = @screen.height
    @enemies  = []
    @shots    = []
    @bullets  = []

    @prelude = Fiber.new{
      Fiber.yield
      v = 5
      while v > 0.9
        v *= 0.9
        @player.y -= v
        Fiber.yield
      end
      @player.vy = -0.9
    }
    @finale = Fiber.new{}
  end

  def update
    stage.update
    if player.alive?
      player.update_input
      shots.push(*player.fire) if Input.key_push?(K_Z)
      player.update
      Sprite.update(shots)
      Sprite.update(enemies)
      Sprite.update(bullets)
      Sprite.check(enemies, player)
      Sprite.check(bullets, player)
      Sprite.check(shots, enemies)
      true
    else
      false
    end
  end

  def cleanup
    shots.each do |shot|
      shot.vanish unless self.stage === shot
    end
    enemies.each do |enemy|
      enemy.vanish unless self.stage === enemy
    end
    bullets.each do |bullet|
      bullet.vanish unless self.stage === bullet
    end
    Sprite.clean(shots)
    Sprite.clean(enemies)
    Sprite.clean(bullets)
  end

  def draw
    Sprite.draw(bullets)
    Sprite.draw(enemies)
    Sprite.draw(shots)
    player.draw
    Window.draw_scale(Window.width/4, Window.height/4, screen, 2, 2)
  end

end
