#!/usr/bin/env ruby

require './cim/cim.rb'
require 'pp'
require 'matrix'

# Sets the initial velocity of particles in a Vicsek model simulation.
def set_initial_velocities(state)
	particles = state.particles
	particles.each do |particle|
		particle.phi = rand(0..2*Math::PI)
	end
end

# Moves the particles in a state to the next state in a Vicsek model simulation.
def move(state, speed, l, noise)
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
		
    noise /= 2
    particle.phi = Math.atan2(sin_tot, cos_tot) + rand(-noise..noise)
	end
end

def print_next_state(state, n, speed, mode, second)
    file = File.open("randdynamic.txt", mode)
    file.write("#{n}\n")
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
n = ARGV[3].to_i
times = ARGV[4].to_i
l = ARGV[5].to_f
noise = ARGV[6].to_f

state = state(m, rc)
set_initial_velocities(state)
print_next_state(state, n, v, 'w', 0)

times.times do |t|
  move(state, v, l, noise)

  print_next_state(state, n, v, 'a', t + 1)

  state.grid = {}
  align_grid(state)
  cell_index_method(state, rc, true)
end

# Calculate va
va = Vector[0, 0]
state.particles.each do |particle|
  va += Vector[v * Math.cos(particle.phi), v * Math.sin(particle.phi)]

end

va = va.magnitude / (n * v)
rho = n / l**2

puts "eta: #{noise} rho: #{rho} va: #{va.round(4)}"