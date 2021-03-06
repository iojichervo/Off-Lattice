#!/usr/bin/env ruby

def random_static(particles_amount, grid_length, particle_radius)
  color = 1
  file = File.open("randstatic.txt", 'w')
  file.write("#{particles_amount}\n")
  file.write("#{grid_length}\n")
  particles_amount.times { file.write("#{format("%.4f", particle_radius)} #{format("%.4f", color)}\n") }
  file.close
end

def random_dynamic(particles_amount, grid_length)
  file = File.open("randdynamic.txt", 'w')
  file.write("0\n") # Only for time zero
  particles_amount.times do
    #velocity = random_velocity(initial_speed)
    file.write("#{rand(0..grid_length)} #{rand(0..grid_length)}\n")
  end
  file.close
end

def random_velocity(speed)
	angle = rand(0..2*Math::PI)
	return [speed * Math.cos(angle), speed * Math.sin(angle)]
end

particles_amount = ARGV[0].to_i
grid_length = ARGV[1].to_f
particle_radius = ARGV[2].to_f
#initial_speed = ARGV[3].to_f
random_static(particles_amount, grid_length, particle_radius)
random_dynamic(particles_amount, grid_length)