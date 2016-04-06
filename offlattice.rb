#!/usr/bin/env ruby

require './cim/cim.rb'
require 'pp'

# Sets the initial velocity of particles in a Vicsek model simulation.
def set_initial_velocities(state)
	particles = state.particles
	particles.each do |particle|
		particle.phi = rand(0..2*Math::PI)
	end
end

# Moves the particles in a state to the next state in a Vicsek model simulation.
def move(state, speed, n, l)
	particles = state.particles
	
  particles.each_with_index do |particle, index|
    sin_tot = 0
    cos_tot = 0

    particle.neighbors.each do |neighbor|
			sin_tot += Math.sin(neighbor.phi)
      cos_tot += Math.cos(neighbor.phi)
		end

    particle.x += speed * Math.cos(particle.phi)
    particle.y += speed * Math.sin(particle.phi)
    
    particle.x -= l if particle.x > l
    particle.y -= l if particle.y > l
    
    particle.x += l if particle.x < 0
    particle.y += l if particle.y < 0
		
    particle.phi = Math.atan2(sin_tot, cos_tot) + rand(-0.5..0.5)
	end
end

def print_next_state(state, speed, mode, second)
    file = File.open("randdynamic.txt", mode)
    file.write("100\n")
    file.write("#{second}\n")
    state.particles.each do |particle|
      vx = speed * Math.cos(particle.phi)
      vy = speed * Math.sin(particle.phi)
      file.write("#{particle.x} #{particle.y} #{vx} #{vy}\n")
    end
    file.close
end

m = ARGV[0].to_i
rc = ARGV[1].to_f
v = ARGV[2].to_f
n = ARGV[3].to_f
times = ARGV[4].to_i
l = ARGV[5].to_f

state = state(m, rc)
set_initial_velocities(state)
print_next_state(state, v, 'w', 0)

times.times do |t|
  move(state, v, n, l)

  print_next_state(state, v, 'a', t + 1)

  state.grid = {}
  align_grid(state)
  cell_index_method(state, rc, true)
end