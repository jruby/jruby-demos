#!/usr/bin/env jruby
# Ported but substantially changed from (example5):
# https://github.com/tutsplus/Introduction-to-JavaFX-for-Game-Development.git
require 'jrubyfx'
require 'matrix'

DELTA, STILL = 300.0, Vector[0.0, 0.0]
MOVES = {LEFT: Vector[-DELTA,0], RIGHT: Vector[DELTA, 0],
         UP: Vector[0,-DELTA], DOWN: Vector[0,DELTA]}
MOVES.default = STILL

class Sprite
  include JRubyFX::DSL, JRubyFX::DSLControl
  attr_accessor :position, :velocity

  def initialize(filename)
    @image, @position, @velocity = image(filename), Vector[0, 0], STILL
  end

  def update(time)
    @position += (@velocity * time)
  end

  def render(gc)
    gc.draw_image @image, *position
  end

  def boundary
    javafx.geometry.Rectangle2D.new *position, @image.width, @image.height
  end

  def intersects?(s)
    s.boundary.intersects boundary
  end
end

class BagGame < JRubyFX::Application
  WIDTH, HEIGHT = 512, 512

  def start(stage)
    input, @bags = {}, []
    setup_bags
    briefcase = sprite("briefcase.png", position: Vector[200, 0])
    gc = nil
    
    with(stage, title: "Collect the Money Bags!") do
      stage.layout_scene(WIDTH, HEIGHT) do
        group do
          canvas(WIDTH, HEIGHT) do            
            gc = graphicsContext2D
            with(gc, fill: Color::GREEN, stroke: Color::BLACK)
          end
        end
      end
    end.show

    stage.scene.on_key_pressed { |event| input[event.code.to_s.to_sym] = true }
    stage.scene.on_key_released { |event| input.delete(event.code.to_s.to_sym) }
    
    ActionTimer.new(self, briefcase, @bags, gc, input).start
  end

  def setup_bags
    15.times do
      @bags << sprite("moneybag.png", position: Vector[rand(350)+50, rand(350)+50])
    end
  end
end

class ActionTimer < javafx.animation.AnimationTimer
  def initialize(game, briefcase, bags, gc, input)
    super()
    @game, @briefcase, @bags, @gc, @input = game, briefcase, bags, gc, input
    @last_time, @score = java.lang.System.nanoTime, 0
  end
  
  def handle(time)
    # game logic (you can press left + up to move diagonal)
    total = @input.keys.map { |move| MOVES[move] }.reduce(:+)
    @briefcase.velocity = total || STILL

    @briefcase.update (time - @last_time) / 1_000_000_000.0
    @last_time = time
                
    bags_count = @bags.size                         # collision detection
    @bags.delete_if { |bag| @briefcase.intersects? bag }
    @score += bags_count - @bags.size

    @gc.clear_rect 0, 0, 512, 512                   # rendering!
    @briefcase.render @gc
    @game.setup_bags if @bags.empty?
    @bags.each { |moneybag| moneybag.render @gc }
    @gc.stroke_text "Cash: $#{100 * @score}", 360, 36
  end
end

BagGame.launch
