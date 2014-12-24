class Unit < Sprite

  extend Forwardable

  def_delegators :image, :width, :height

  attr_accessor :vx, :vy, :family

  def initialize(x, y)
    super(x, y)
    self.vx = 0
    self.vy = 0
  end

  def update
    self.x += self.vx
    self.y += self.vy
  end

  def centering_vertical(image)
    y + (height - height) / 2
  end

  def centering_horizontal(image)
    x + (width - width) / 2
  end

  def rad2deg(r)
    r * 180 / Math::PI
  end

  def angle(x, y)
    rad2deg(Math.atan2(y - self.y, x - self.x))
  end

end

class Bullet < Unit

  include Animative

  def initialize(x, y, animation_images)
    super(x, y)
    init_animation(animation_images)
  end

  def shot_player(*)
    vanish
  end

  def shot_enemy(*)
    vanish
  end

  def update
    super
    update_animation
  end

end

class Character < Unit

  include Animative

  attr_accessor :durability

  def initialize(x, y, animation_images)
    super(x, y)
    init_animation(animation_images)
  end

  def update
    super
    update_animation
  end

end
