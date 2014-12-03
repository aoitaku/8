class Unit < Sprite

  extend Forwardable

  def_delegators :image, :width, :height

  include Animative

  attr_accessor :vx, :vy

  def initialize(x, y, animation_images)
    self.x = x
    self.y = y
    @vx = 0
    @vy = 0
    init_animation(animation_images)
  end

  def update
    update_animation
    self.x += @vx
    self.y += @vy
  end

  def centering_vertical(image)
    y + (height - height) / 2
  end

  def centering_horizontal(image)
    x + (width - width) / 2
  end

  def angle(ax, ay)
    (Math.atan2(ay - y, ax - x)) * 180 / Math::PI
  end

end

class Bullet < Unit
end

class Character < Unit

  attr_accessor :durability

end
