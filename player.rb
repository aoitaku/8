class Player < Character

  attr_accessor :equipment

  def initialize(image)
    super(0, 0, image)
    self.durability = 1
    self.equipment = {}
    @diagonal_verocity_max = Math.sqrt(2)
    @diagonal_verocity = @diagonal_verocity_max / 6
    @verocity_max = 2.0
    @verocity = @verocity_max / 6
    @shot_force = 4
  end

  def alive?
    durability > 0
  end

  def update_input
    if Input.x.nonzero? and Input.y.nonzero?
      self.vx += Input.x * @diagonal_verocity if vx.abs < @diagonal_verocity_max
      self.vy += Input.y * @diagonal_verocity if vy.abs < @diagonal_verocity_max
    else
      self.vx += Input.x * @verocity if vx.abs < @verocity_max
      self.vy += Input.y * @verocity if vy.abs < @verocity_max
    end
    if Input.key_push?(K_Z)
      Game.instance.join(*self.fire)
    end
  end

  def fire
    [-4, 4].map do |x|
      Bullet.new(self.x + x, centering_vertical(Assets[:shot][0]), Assets[:shot]).tap{|bullet|
        bullet.family    = :player_bullet
        bullet.collision = [7, 3, 8, 12]
        bullet.target    = self.target
        bullet.vy        = -@shot_force
      }
    end
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

  alias hit_enemy  hit

  alias hit_bullet hit

  def update
    super
    self.vx *= 0.8
    self.vy *= 0.8
    update_input
  end

end
