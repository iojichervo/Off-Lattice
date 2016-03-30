#!/usr/bin/env ruby

Shoes.app title: "Off Lattice" do
  background white
  stack(margin: 8) do
    stack do
      para "Particles amount (N)"
      @n = edit_line
      @n.text = 100
    end

    stack do
      para "Grid length (L)"
      @l = edit_line
      @l.text = 30      
    end

    stack do
      para "Particles radius (r)"
      @r = edit_line
      @r.text = 1
    end

    stack do
      para "Initial speed (v)"
      @v = edit_line
      @v.text = 0.03
    end

    stack(margin_top: 8) do
      button("Submit") do
        `ruby cim/randomstate.rb #{@n.text} #{@l.text} #{@r.text} #{@v.text}`
      end
    end
  end
end