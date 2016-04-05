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
def move(state, speed, n)
	particles = state.particles
	updated_phis = []
	particles.each_with_index do |particle, index|
		sin_tot = Math.sin(particle.phi)
		cos_tot = Math.cos(particle.phi)
		count = particle.neighbors.count + 1
		particle.neighbors.each do |neighbor|
			sin_tot += Math.sin(neighbor.phi)
         	cos_tot += Math.cos(neighbor.phi)
		end
		updated_phis[index] = Math.atan2(sin_tot/count, cos_tot/count) + n/2 * rand(-1..1)
	end

	particles.each_with_index do |particle, index|
		particle.x += speed * Math.sin(particle.phi)
		particle.y += speed * Math.cos(particle.phi)
		particle.phi = updated_phis[index]
	end

	pp updated_phis
end

m = ARGV[0].to_i
rc = ARGV[1].to_f
v = ARGV[2].to_f
n = ARGV[3].to_f

state = state(m, rc)
set_initial_velocities(state)

pp state

move(state, v, n)

pp state