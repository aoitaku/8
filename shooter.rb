module Shooter
  extend self

  def single_gun(shooter, target:Game.instance.player)
    Bullet.new(shooter.x,
               shooter.centering_vertical(Assets[:bullet][0]),
               Assets[:bullet]).tap{|bullet|
      bullet.family    = :enemy_bullet
      bullet.collision = [3, 3, 12, 12]
      bullet.target = shooter.target
      shooter.angle(target.x, target.y).tap do |deg|
        bullet.vx = 1.2 * Math.cos(deg/180*Math::PI)
        bullet.vy = 1.2 * Math.sin(deg/180*Math::PI)
      end
    }
  end

  def two_way_gun(shooter, target:Game.instance.player)
    [-1, 1].map{|i|
      Bullet.new(shooter.x,
                 shooter.centering_vertical(Assets[:bullet][0]),
                 Assets[:bullet]).tap{|bullet|
        bullet.family    = :enemy_bullet
        bullet.collision = [3, 3, 12, 12]
        bullet.target = shooter.target
        shooter.angle(target.x, target.y).tap do |deg|
          bullet.vx = 1.2 * Math.cos((deg+30*i)/180*Math::PI)
          bullet.vy = 1.2 * Math.sin((deg+30*i)/180*Math::PI)
        end
      }
    }
  end

end
